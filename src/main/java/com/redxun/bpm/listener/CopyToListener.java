package com.redxun.bpm.listener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.context.ApplicationListener;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.event.TaskCreateApplicationEvent;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.dao.BpmSolUserDao;
import com.redxun.bpm.core.dao.BpmSolUsergroupDao;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.AbstractExecutionCmd;
import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.ProcessStartCmd;
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
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;

/**
 * 抄送监听器
 * @author ray
 *
 */
@Service
public class CopyToListener implements ApplicationListener<TaskCreateApplicationEvent>,Ordered {
	
	@Resource
	BpmSolUsergroupDao bpmSolUsergroupDao;
	@Resource
	BpmSolUserDao bpmSolUserDao;
	@Resource
	BpmSolutionDao bpmSolutionDao;
	@Resource
	BpmIdentityCalService bpmIdentityCalService;
	@Resource
	BpmInstCpManager bpmInstCpManager;
	
	@Resource
	private BpmInstCcManager bpmInstCcManager;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	
	@Override
	public void onApplicationEvent(TaskCreateApplicationEvent event) {
		TaskEntity ent=(TaskEntity)event.getSource();
		String actDefId=ent.getProcessDefinitionId();
		List<BpmSolUsergroup> list= bpmSolUsergroupDao.getBySolNode( ent.getSolId(),actDefId, ent.getTaskDefinitionKey(), BpmSolUsergroup.GROUP_TYPE_COPY);
		if(BeanUtil.isEmpty(list)) return;
		
		Map<String,Object> vars=ent.getVariables();
		
		String solId=(String) vars.get("solId");
		
		BpmSolution solution=bpmSolutionDao.get(solId);
		
		String treeId=solution.getTreeId();
		
		for(BpmSolUsergroup usergroup:list){
			copyto(usergroup,ent,vars,solId,treeId);
		}
	}
	
	private void copyto(BpmSolUsergroup usergroup,TaskEntity ent,Map<String,Object> vars,String solId,String treeId){
		String groupId=usergroup.getId();
		List<BpmSolUser> userList= bpmSolUserDao.getByGroupId(groupId);
		
		
		String instId=(String) vars.get("instId");
		String subject=(String) vars.get("processSubject");
		
		Map<String,Object> model=new HashMap<>();
		AbstractExecutionCmd cmd= (AbstractExecutionCmd) ProcessHandleHelper.getProcessCmd();
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

		Set<TaskExecutor>  identityInfos= bpmIdentityCalService.calNodeUsersOrGroups(ent.getProcessDefinitionId(),ent.getTaskDefinitionKey(),userList, vars);
		
		//Set<IdentityInfo>  identityInfos= bpmIdentityCalService.calNodeUsersOrGroups(userList, vars);
		
		IUser user=ContextUtil.getCurrentUser();
		
		BpmInstCc instCc=new BpmInstCc();
		instCc.setCcId(IdUtil.getId());
		instCc.setSubject(subject);
		instCc.setNodeId(ent.getTaskDefinitionKey());
		instCc.setNodeName(ent.getName());
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
