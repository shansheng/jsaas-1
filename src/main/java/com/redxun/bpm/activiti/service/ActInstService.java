package com.redxun.bpm.activiti.service;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.ProcessEngineImpl;
import org.activiti.engine.impl.interceptor.CommandExecutor;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.cmd.ProcessInstanceEndCmd;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.core.json.JsonResult;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;

/**
 * Activiti原生的流程实例服务类
 * @author X230
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Service
public class ActInstService {
	@Resource
	ProcessEngine processEngine;
	@Resource
	RepositoryService repositoryService;
	@Resource
	BpmRuPathManager bpmRuPathManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	RuntimeService runtimeService;
	@Resource
	UserService userService;
	
	public void endProcessInstance(String bpmnInstanceId) {
		ProcessEngineImpl engine = (ProcessEngineImpl)processEngine;
		CommandExecutor cmdExecutor=engine.getProcessEngineConfiguration().getCommandExecutor();
		cmdExecutor.execute(new ProcessInstanceEndCmd(bpmnInstanceId));
	}
	
	
	/**
	 * 通过流程实例ID获得流程已经走过的跳转线Id
	 * @param actInstId
	 * @return
	 */
	public Collection<String> getJumpFlowsByActInstId(String actInstId){
		Set<String> flowIds=new HashSet<String>();
		Map<String,BpmRuPath> pathMap=new HashMap<String, BpmRuPath>();
		List<BpmRuPath> paths=bpmRuPathManager.getByActInstId(actInstId);
		for(BpmRuPath path:paths){
			pathMap.put(path.getPathId(), path);
		}
		BpmInst inst=bpmInstManager.getByActInstId(actInstId);
		ProcessDefinitionEntity processDefEntity=(ProcessDefinitionEntity)repositoryService.getProcessDefinition(inst.getActDefId());
		for(BpmRuPath path:paths){
			if("0".equals(path.getParentId())){
				continue;
			}
			BpmRuPath parent=pathMap.get(path.getParentId());
			if(parent==null){
				continue;
			}
			PvmActivity pvmActivity= processDefEntity.findActivity(path.getNodeId());
			for(PvmTransition tran: pvmActivity.getIncomingTransitions()){
				if(tran.getSource().getId().equals(parent.getNodeId())){
					flowIds.add(tran.getId());
				}
			}
		}
		return flowIds;
	}
	
	/**
	 * 让流程继续往下执行。
	 * @param executionId
	 */
	public void signal(String executionId,String jumpType,String opinion){
		ProcessNextCmd cmd=new ProcessNextCmd();
		cmd.setJumpType(jumpType);
		cmd.setOpinion(opinion);
		ProcessHandleHelper.setProcessCmd(cmd);
		runtimeService.signal(executionId);
	}
	
	
	/**
	 * 启动流程。
	 * @param solId				流程方案ID
	 * @param jsonData			流程JSON数据。
	 * @param businessKey		业务主键
	 * @param userAccount		启动人帐号
	 * @param vars				流程变量
	 */
	public JsonResult startProcess(StartProcessModel model){
		IUser user=userService.getByUsername(model.getUserAccount());
    	String msg=null;
    	try{
    		ContextUtil.setCurUser(user);
			ProcessStartCmd startCmd=new ProcessStartCmd();
			startCmd.setSolId(model.getSolId());
			startCmd.setJsonData(model.getJsonData());
			startCmd.setBusinessKey(model.getBusinessKey());
			startCmd.setVars(model.getVars());
			startCmd.setFrom(model.getFrom());
			startCmd.setCallModel(model.getCallModel());
			startCmd.setNodeUserMap(model.getNodeUsers());
			BpmInst inst= bpmInstManager.doStartProcess(startCmd);
			return new JsonResult(true,"成功启动流程！",inst);
    	}catch(Exception ex){
    		msg=ex.getMessage();
    		ex.printStackTrace();
    	}finally{
    		ContextUtil.clearCurLocal();
    	}
		return new JsonResult(false,msg);
	}
	
	
	
}
