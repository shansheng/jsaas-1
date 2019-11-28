package com.redxun.bpm.activiti.listener;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.redxun.saweb.util.IdUtil;
import org.activiti.engine.delegate.event.ActivitiEntityEvent;
import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmSignData;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmSignDataManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.enums.TaskEventType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;

/**
 * 任务完成监听器
 * 
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn） 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Service
public class TaskCompleteListener  implements EventHandler {
	@Resource
	private BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmSignDataManager bpmSignDataManager;
	@Resource
	BpmTaskManager bpmTaskManager;

	/**
	 * 处理多实例任务
	 * 
	 * @param taskEntity
	 */
	public void handleMultiTask(TaskEntity taskEntity) {
		BpmSignData signData = new BpmSignData();
		signData.setDataId(IdUtil.getId());
		signData.setActDefId(taskEntity.getProcessDefinitionId());
		signData.setActInstId(taskEntity.getProcessInstanceId());
		signData.setNodeId(taskEntity.getTaskDefinitionKey());
		signData.setUserId(ContextUtil.getCurrentUserId());
		ProcessNextCmd nextCmd = (ProcessNextCmd) ProcessHandleHelper.getProcessCmd();
		signData.setVoteStatus(nextCmd.getJumpType());
		bpmSignDataManager.create(signData);
	}

	@Override
	public void handle(ActivitiEvent event)throws BpmRunException{
		ActivitiEntityEvent actEvent = (ActivitiEntityEvent) event;
		TaskEntity taskEntity = (TaskEntity) actEvent.getEntity();
		
		
		String solId = (String) taskEntity.getVariable("solId");
		UserTaskConfig userTaskConfig = bpmNodeSetManager.getTaskConfig(solId,taskEntity.getProcessDefinitionId(),taskEntity.getTaskDefinitionKey());
		//执行全局脚本。
		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(solId,taskEntity.getProcessDefinitionId());
		
		//执行脚本。
		EventUtil.executeTaskScript(taskEntity, userTaskConfig,TaskEventType.TASK_COMPLETED,event);
		//执行全局配置脚本
		EventUtil.executeGlobalScript(taskEntity,processConfig.getGlobalEvent(),false,event);
		
		IExecutionCmd nextCmd =  ProcessHandleHelper.getProcessCmd();
		//优先
		if(StringUtil.isNotEmpty(nextCmd.getToken())){
			nextCmd.setToken(taskEntity.getToken());
		}
		//把执行路径设置至线程变量中，为后续更新执行路径提供方便
		nextCmd.setRunPathId(taskEntity.getRunPathId());
		//更新意见。
		bpmNodeJumpManager.updateNodeJump(taskEntity.getId());
		
		// 检查是否为会签任务，若是，则先从变量中获得执行人员
		String multiInstance = (String) taskEntity.getExecution().getActivity().getProperty("multiInstance");
		// 加上会签的数据
		if (StringUtil.isNotEmpty(multiInstance)) {
			handleMultiTask(taskEntity);
			//处理会签驳回的情况，处理没有完成任务的意见状态。
			handMultiBack( taskEntity);
		}
	}
	
	/**
	 * 处理任务驳回时意见。
	 * @param taskEntity
	 */
	private void handMultiBack(TaskEntity taskEntity){
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		String jumpType=cmd.getJumpType();
		//驳回直接完成
		if(!TaskOptionType.BACK.name().equals(jumpType) && 
				!TaskOptionType.BACK_SPEC.name().equals(jumpType)
				&& !TaskOptionType.RECOVER.name().equals(jumpType)) return;
		
		String parentId=taskEntity.getExecution().getParentId();
		List<BpmTask> list=bpmTaskManager.getByParentExecutionId(parentId);
		IUser user=ContextUtil.getCurrentUser();
		for(BpmTask task:list){
			//是当前任务则跳过。
			if(task.getId().equals(taskEntity.getId())) continue;
			BpmNodeJump nodeJump =bpmNodeJumpManager. getByTaskId(task.getId());
			if (nodeJump == null) continue;
			nodeJump.setRemark("任务被【" + user.getFullname() + "】撤销了,撤销原因:" + cmd.getOpinion());
			nodeJump.setCompleteTime(new Date());
			Long duration = nodeJump.getCompleteTime().getTime()- nodeJump.getCreateTime().getTime();
			nodeJump.setDuration(duration);
			nodeJump.setHandlerId(user.getUserId());
			nodeJump.setJumpType(cmd.getJumpType() +"_CANCEL");
			nodeJump.setCheckStatus(cmd.getJumpType()+"_CANCEL");
			
			bpmNodeJumpManager.update(nodeJump);
		}
	}

	
	
}
