package com.redxun.bpm.activiti.listener;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.ActivitiEventType;
import org.activiti.engine.delegate.event.impl.ActivitiEntityEventImpl;
import org.activiti.engine.delegate.event.impl.ActivitiEventBuilder;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.apache.commons.lang.StringUtils;

import com.redxun.bpm.activiti.event.NoAssignEvent;
import com.redxun.bpm.activiti.event.TaskCreateApplicationEvent;
import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmDestNode;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.bpm.enums.TaskEventType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.enums.TaskVarType;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.calendar.manager.CalendarService;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 任务创建监听器 主要用来执行人员分配，事件执行等
 * 
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn） 
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class TaskCreateListener  implements EventHandler {
	
	@Resource
	BpmIdentityCalService bpmIdentityCalService;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmRuPathManager bpmRuPathManager;
	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;

	// add by zyg 2016/12/6
	@Resource
	BpmSolFvManager bpmSolFvManager;
	@Resource
	UserService userService;  
	@Resource 
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	CalendarService calendarService;
	@Resource
	OsUserManager osUserManager;
	@Resource
	BpmTaskManager bpmTaskManager;
	
	@Override
	public void handle(ActivitiEvent event) throws BpmRunException{
	
		ActivitiEntityEventImpl eventImpl = (ActivitiEntityEventImpl) event;
		TaskEntity taskEntity = (TaskEntity) eventImpl.getEntity();
		String nodeId=taskEntity.getTaskDefinitionKey();
		String solId = (String) taskEntity.getVariable("solId");
		BpmInst bpmInst=bpmInstManager.getByActInstId(taskEntity.getProcessInstanceId());
		
		ProcessConfig processConfig=bpmNodeSetManager.getProcessConfig(solId,taskEntity.getProcessDefinitionId());
		
		// 获得任务配置
		UserTaskConfig userTaskConfig = bpmNodeSetManager.getTaskConfig(solId,taskEntity.getProcessDefinitionId(),nodeId);

		//设置是否支持手机表单
		setTaskEnt(taskEntity, bpmInst);
		// 执行事件的处理
		EventUtil. executeTaskScript(taskEntity, userTaskConfig,TaskEventType.TASK_CREATED,event);
		//执行全局配置脚本
		EventUtil.executeGlobalScript(taskEntity,processConfig.getGlobalEvent(),true,event);
		//设置用户
		boolean allowEmpty=userTaskConfig.getAllowEmptyExecutor().equals("true");
		setAssignee( taskEntity,allowEmpty );
		
		//发布事件
		TaskCreateApplicationEvent ev=new TaskCreateApplicationEvent(taskEntity,userTaskConfig);
		ev.setBpmInst(bpmInst);
		WebAppUtil.publishEvent(ev);
			
		
	}
	
	/**
	 * 设置任务。
	 * @param taskEntity
	 */
	private void setTaskEnt(TaskEntity taskEntity,BpmInst bpmInst){
		
		IExecutionCmd cmd= ProcessHandleHelper.getProcessCmd();
		//处理令牌
		issueToUpdateToken(taskEntity);

		if(cmd!=null && StringUtils.isNotEmpty(cmd.getToken())){
			taskEntity.setToken(cmd.getToken());
		}
		
		taskEntity.setRunPathId(cmd.getRunPathId());
		
		String solId = (String) taskEntity.getVariable(ProcessVarType.SOL_ID.getKey());
		String solKey = (String) taskEntity.getVariable(ProcessVarType.SOL_KEY.getKey());
		String instId = (String) taskEntity.getVariable(ProcessVarType.INST_ID.getKey());
		
		taskEntity.setSolId(solId);
		taskEntity.setSolKey(solKey);
		//兼容旧的代码中没有InstId的情况
		if(StringUtils.isEmpty(instId)){
			instId=bpmInst!=null ?bpmInst.getInstId():"";
		}
		taskEntity.setInstId(instId);
		
		String processSubject = (String) taskEntity.getVariable("processSubject");
		taskEntity.setDescription(processSubject);
		String tenantId=ContextUtil.getCurrentTenantId();
		if(StringUtil.isEmpty(tenantId)){
			tenantId=bpmInst.getTenantId();
		}
		taskEntity.setTenantId(tenantId);

		//判断是否支持手机表单
		BpmFormViewManager.FormConfig config=bpmFormViewManager.getFormAlias(solId, taskEntity.getProcessDefinitionId(), 
				taskEntity.getTaskDefinitionKey(), BpmFormView.TYPE_MOBILE,instId);
		
		if(BeanUtil.isNotEmpty(config.getFormKeys())){
			taskEntity.setEnableMobile(1);
		}

	}
	
	
	
	/**
	 * 创建会签时创建或更新token
	 */
	private void issueToUpdateToken(TaskEntity taskEntity){
		//当前的counter
		Integer loopCounter = (Integer) taskEntity.getExecution().getVariableLocal("loopCounter");
		if(loopCounter==null) return;

		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		
		
		String token=cmd.getToken();
		if(StringUtils.isEmpty(token)){
			token="T_0";
		}
		String[] tokens=token.split("_");
		int lastIndex=tokens.length-1;
		String newToken="";
		for(int i=0;i<lastIndex;i++){
			newToken=newToken+tokens[i]+"_";
		}
		newToken=newToken+(loopCounter+1);
		cmd.setToken(newToken);
	}
	
	/**
	 * 处理会签或子流程的情况。
	 * @param taskEntity
	 * @param nodeJump
	 */
	private void handMultiTaskAssignee(TaskEntity taskEntity,BpmNodeJump nodeJump){
		List<TaskExecutor> executors =(List<TaskExecutor>)taskEntity.getVariable(TaskVarType.SIGN_USER_IDS_.getKey()+taskEntity.getTaskDefinitionKey());
		Integer loopCounter = (Integer) taskEntity.getExecution().getVariable("loopCounter");
		
		TaskExecutor executor=executors.get(loopCounter);
		//人员是用户
		if(TaskExecutor.IDENTIFY_TYPE_USER.equals(executor.getType())){
			taskEntity.setAssignee(executor.getId());
		}
		else{
			//用户组
			if(TaskExecutor.CALC_MODE_NO.equals(executor.getCalcMode())){
				taskEntity.addCandidateGroup(executor.getId());
			}
			//延迟计算。
			else if(TaskExecutor.CALC_MODE_DELAY.equals(executor.getCalcMode())){
				List<IUser> users=userService.getByGroupId(executor.getId());
				users.forEach(item->{
					taskEntity.addCandidateUser(item.getUserId());
				});
			}
		}
		
		handNodeJump(taskEntity,nodeJump);
	}

	/**
	 * 处理驳回
	 * @param cmd
	 * @param taskEntity
	 * @param nodeJump
	 * @return
	 */
	private boolean handReject(IExecutionCmd cmd,TaskEntity taskEntity,BpmNodeJump nodeJump){
		boolean isAssigned=false;
		BpmRuPath backRuPath = ProcessHandleHelper.getBackPath();
		String jumpType=cmd.getJumpType();
		if (backRuPath != null   && (TaskOptionType.BACK.name().equals(jumpType) || TaskOptionType.BACK_SPEC.name().equals(jumpType))) {
			if ("userTask".equals(backRuPath.getNodeType())) {
				IUser osUser= userService.getByUserId(backRuPath.getAssignee());
				if(osUser.getStatus().equals(OsUser.STATUS_IN_JOB)){
					taskEntity.setAssignee(backRuPath.getAssignee());
					isAssigned = true;
				}
			} else {// 查找其子结点上的执行人员
				BpmRuPath nodePath = bpmRuPathManager.getByParentIdNodeId(backRuPath.getPathId(), taskEntity.getTaskDefinitionKey());
				if (nodePath != null && StringUtils.isNotEmpty(nodePath.getAssignee())) {
					IUser osUser=userService.getByUserId(nodePath.getAssignee());
					if(osUser.getStatus().equals(OsUser.STATUS_IN_JOB)){
						taskEntity.setAssignee(backRuPath.getAssignee());
						isAssigned = true;
					}
				}
			}
		}
		if(isAssigned){
			handNodeJump(taskEntity, nodeJump);
		}
	
		return isAssigned;
	}
	
	
	/**
	 * 设置用户任务。
	 * @param taskEntity
	 * @throws Throwable
	 */
	void setAssignee(TaskEntity taskEntity ,boolean allowEmpty) {
		// 记录跳转的信息
		BpmNodeJump nodeJump = bpmNodeJumpManager.createNodeJump(taskEntity);
		
		Map<String,Object> properties= taskEntity.getExecution().getActivity().getProperties();
		boolean isMulti=  properties.containsKey("multiInstance");
		
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		
		
		//会签或者子流程多实例处理。
		if(isMulti || cmd.getTransientVars().containsKey("subMulti")){
			handMultiTaskAssignee(taskEntity,nodeJump);
		}
		else{
			handTaskAssignee( taskEntity, nodeJump,allowEmpty);
		}
			
		
		
	} 
	
	private void handTaskAssignee(TaskEntity taskEntity,BpmNodeJump nodeJump,boolean allowEmpty){
		//1.从驳回读取人员
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();	
		boolean isAssigned=handReject( cmd, taskEntity,nodeJump);
		if(isAssigned) return;
		
		//2.从上下文读取人员
		isAssigned=setAssigneeFromContext( taskEntity, nodeJump);
		if(isAssigned) return;
		//3.从数据库读取。
		isAssigned=handFromDb(taskEntity,nodeJump,allowEmpty);
		//没有分配人员
		if(!isAssigned){
			WebAppUtil.publishEvent(new NoAssignEvent(taskEntity));
		}
	}
	
	/**
	 * 从数据库配置读取人员。
	 * @param taskEntity
	 * @param nodeJump
	 * @return
	 */
	private boolean handFromDb(TaskEntity taskEntity,BpmNodeJump nodeJump,boolean allowEmpty){
		boolean isAssigned=false;
		taskEntity.getVariables().put("solId", taskEntity.getSolId());
		Collection<TaskExecutor> idInfoList = bpmIdentityCalService.calNodeUsersOrGroups(taskEntity.getProcessDefinitionId(), taskEntity.getTaskDefinitionKey(), taskEntity.getVariables());
		if(BeanUtil.isEmpty(idInfoList) && !allowEmpty){
			ProcessHandleHelper.addErrorMsg("任务节点（"+taskEntity.getName()+"）执行人为空,请联系管理员在流程方案中配置执行人员!");
			throw new RuntimeException("任务节点（"+taskEntity.getName()+"）执行人为空,请联系管理员在流程方案中配置执行人员!");
		}
		
		if (idInfoList.size() == 1) {
			TaskExecutor identityInfo = idInfoList.iterator().next();
			if(identityInfo!=null){
				if (TaskExecutor.IDENTIFY_TYPE_USER.equals(identityInfo.getType())) {
					taskEntity.setAssignee(identityInfo.getId());
					taskEntity.setOwner(identityInfo.getId());
				} else {
					taskEntity.addCandidateGroup(identityInfo.getId());
				}
				isAssigned=true;
			}
		} else {
			for (TaskExecutor info : idInfoList) {
				if(info==null) continue;

				if (TaskExecutor.IDENTIFY_TYPE_USER.equals(info.getType())) {
					taskEntity.addCandidateUser(info.getId());
				} else {
					taskEntity.addCandidateGroup(info.getId());
				}
				isAssigned=true;
			}
		}
		if(isAssigned){
			handNodeJump(taskEntity, nodeJump);
		}else {
			IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
			cmd.addTask(taskEntity);
		}
		
		return isAssigned;
	}
	
	/**
	 * 从上下文指定人员获取。
	 * @param taskEntity
	 * @param nodeJump
	 * @return
	 */
	private boolean setAssigneeFromContext(TaskEntity taskEntity,BpmNodeJump nodeJump){
		String nodeId=taskEntity.getTaskDefinitionKey();
		IExecutionCmd processNextCmd = ProcessHandleHelper.getProcessCmd();
		if (processNextCmd == null) return false;

		BpmDestNode bpmDestNode = processNextCmd.getNodeUserMap().get(nodeId);
		if(bpmDestNode == null) return false;
		//没有分组,没有用户
		if(StringUtils.isEmpty(bpmDestNode.getUserIds()) && StringUtils.isEmpty(bpmDestNode.getGroupIds())) return false;
		
		String userIds=bpmDestNode.getUserIds();
		String groupIds=bpmDestNode.getGroupIds();
		//没有分组
		if(StringUtil.isNotEmpty(userIds) && StringUtil.isEmpty(groupIds)){
			String[] uIds = userIds.split(",");
			if (uIds.length == 1) {
				taskEntity.setAssignee(uIds[0]);
				taskEntity.setOwner(uIds[0]);
			} else {
				taskEntity.addCandidateUsers(Arrays.asList(uIds));
			}
		}
		//只有组
		else if(StringUtil.isEmpty(userIds) && StringUtil.isNotEmpty(groupIds)){
			String[] groupsIds =groupIds.split(",");
			taskEntity.addCandidateGroups(Arrays.asList(groupsIds));
		}
		//指定了 用户组和用户。
		else{
			String[] uIds = userIds.split(",");
			taskEntity.addCandidateUsers(Arrays.asList(uIds));
			
			String[] groupsIds =groupIds.split(",");
			taskEntity.addCandidateGroups(Arrays.asList(groupsIds));
		}
		
		handNodeJump(taskEntity, nodeJump);
		
		return true;
	}
	
	
	/**
	 * 如果任务执行人确定，更行nodejump
	 * 
	 * @param taskEntity
	 */
	private void handNodeJump(TaskEntity taskEntity, BpmNodeJump nodeJump) {
		IExecutionCmd processNextCmd = ProcessHandleHelper.getProcessCmd();
		processNextCmd.addTask(taskEntity);

		if(StringUtil.isEmpty(taskEntity.getAssignee())) return;
		
		if (StringUtils.isNotEmpty(taskEntity.getAssignee())) {
			Context.getProcessEngineConfiguration().getEventDispatcher().dispatchEvent(ActivitiEventBuilder.createEntityEvent(ActivitiEventType.TASK_ASSIGNED, taskEntity));
		}
		
		if (StringUtils.isEmpty(taskEntity.getOwner())) {
			taskEntity.setOwner(taskEntity.getAssignee());
		}
		// 更新原所属人
		nodeJump.setOwnerId(taskEntity.getAssignee());
		bpmNodeJumpManager.update(nodeJump);
	}
	

	
	
}
