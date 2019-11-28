package com.redxun.bpm.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.springframework.context.ApplicationListener;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.entity.ActivityNode;
import com.redxun.bpm.activiti.event.ProcessEndedEvent;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.dao.BpmSolUserDao;
import com.redxun.bpm.core.dao.BpmSolUsergroupDao;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.AbstractExecutionCmd;
import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmInstCcManager;
import com.redxun.bpm.core.manager.BpmInstCpManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 在流程结束时抄送监听器
 * @author ray
 *
 */
@Service
public class CopyToEndListener implements ApplicationListener<ProcessEndedEvent>,Ordered {
	
	@Resource
	BpmSolUsergroupDao bpmSolUsergroupDao;
	@Resource
	BpmSolUserDao bpmSolUserDao;
	@Resource
	BpmSolutionDao bpmSolutionDao;
	@Resource
	BpmIdentityCalService bpmIdentityCalService;
	@Resource
	OsUserManager osUserManager;
	@Resource
	private BpmInstCcManager bpmInstCcManager;
	@Resource
	BpmInstCpManager bpmInstCpManager;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	BpmSolutionManager bpmSolutionManager;

	@Override
	public void onApplicationEvent(ProcessEndedEvent event) {
		
		ExecutionEntity ent=(ExecutionEntity)event.getSource();
		String solId=(String) ent.getVariable("solId");
		String actDefId=ent.getProcessDefinitionId();
		String tenantId=ContextUtil.getCurrentTenantId();
		
		List<BpmSolUsergroup> list= bpmSolUsergroupDao.getBySolNode( solId,actDefId, ActivityNode.PROCESS_NODE_ID, BpmSolUsergroup.GROUP_TYPE_COPY);
		
		if(BeanUtil.isEmpty(list)) return;
		
		BpmSolution solution=bpmSolutionDao.get(solId);
		
		String treeId=solution.getTreeId();
		
		for(BpmSolUsergroup usergroup:list){
			copyto(usergroup,ent,solId,treeId);
		}
	}
	
	private void copyto(BpmSolUsergroup usergroup,ExecutionEntity ent,String solId,String treeId){
		String groupId=usergroup.getId();
		List<BpmSolUser> userList= bpmSolUserDao.getByGroupId(groupId);

		Map<String,Object> vars=ent.getVariables();
		
		String instId=(String) vars.get("instId");
		String subject=(String) vars.get("processSubject");

		Map<String,Object> model=new HashMap<>();
		AbstractExecutionCmd cmd=(AbstractExecutionCmd) ProcessHandleHelper.getProcessCmd();
		if(cmd!=null) {
			model.put("cmd", cmd);
			//获取表单数据
			BpmSolution bpmSolution = bpmSolutionManager.get(solId);
			JSONObject data = JSONObject.parseObject(cmd.getJsonData());
			Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsonsBoIds(data,bpmSolution.getBoDefId());
			vars.put("jsonData", modelFieldMap);
			vars.putAll(cmd.getVars());
		}
		model.put("vars", vars);
		String setting = usergroup.getSetting();
		if(StringUtil.isNotEmpty(setting)) {
			Object flag = groovyEngine.executeScripts(setting, model);
			if(flag instanceof Boolean && !(Boolean)flag) {
				return;
			}
		}
		
		Set<TaskExecutor>  identityInfos= bpmIdentityCalService.calNodeUsersOrGroups(ent.getProcessDefinitionId(),ent.getActivityId(),userList, vars);
		
		IUser user=ContextUtil.getCurrentUser();
		
		BpmInstCc instCc=new BpmInstCc();
		instCc.setCcId(IdUtil.getId());
		instCc.setSubject(subject);
		instCc.setNodeId(ent.getActivityId());
		instCc.setNodeName("流程结束");
		instCc.setFromUserId(user.getUserId());
		instCc.setFromUser(user.getFullname());
		instCc.setSolId(solId);
		instCc.setTreeId(treeId);
		instCc.setInstId(instId);
		
		ListenerUtil.setCopyUsers(instCc,identityInfos,subject,usergroup.getNotifyType());

		bpmInstCcManager.create(instCc);

	}
	
	

	@Override
	public int getOrder() {
		return 1;
	}

}
