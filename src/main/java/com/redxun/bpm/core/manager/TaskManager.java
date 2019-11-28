package com.redxun.bpm.core.manager;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.service.ITaskSkipCondition;
import com.redxun.bpm.activiti.service.SkipConditionFactory;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;

@Service
public class TaskManager {
	
	@Resource
	private SkipConditionFactory skipConditionFactory;
	@Resource
	private BpmNodeJumpManager bpmNodeJumpManager;
	
	@Resource
	private BpmTaskManager bpmTaskManager;
	
	/**
	 * 流程跳过。
	 * @param processConfig
	 * @param cmd
	 * @throws Exception
	 */
	public void handJump(ProcessConfig processConfig) throws Exception{
		String jumpSetting=processConfig.getJumpSetting();
		if(StringUtil.isEmpty(jumpSetting)) return;
		String[] arySeting=jumpSetting.split(",");
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		List<TaskEntity> taskEntities= cmd.getNewTasks();
		
		Iterator<TaskEntity> iter = taskEntities.iterator();
        while (iter.hasNext()) {
        	TaskEntity taskEnt = iter.next();
            iter.remove();
            boolean canSkip=canSkip(taskEnt, arySeting);
			if(!canSkip) continue;
			skipTask(taskEnt);
        }
		
	}
	
	
	/**
	 * 是否可以跳过。
	 * @param taskEntity
	 * @param arySeting
	 * @return
	 */
	private boolean canSkip(TaskEntity taskEntity,String[] arySeting){
		boolean canSkip=false;
		IExecutionCmd cmd= ProcessHandleHelper.getProcessCmd();
		String jumpType=cmd.getJumpType();
		
		if(TaskOptionType.BACK.name().equals(jumpType) ||
				TaskOptionType.BACK_TO_STARTOR.name().equals(jumpType)) return canSkip;
		for(String type:arySeting){
			ITaskSkipCondition condition= skipConditionFactory.getCondition(type);
			canSkip= condition.canSkip(taskEntity);
			if(canSkip) break;
		}
		return canSkip;
	}
	
	private void skipTask(TaskEntity task) throws Exception{
		String taskId=task.getId();
		IExecutionCmd taskCmd=ProcessHandleHelper.getProcessCmd();
		ProcessNextCmd cmd= new ProcessNextCmd();
		cmd.setTaskId(taskId);
		cmd.setOpinion("");
		cmd.setJumpType(TaskOptionType.SKIP.name());
		cmd.setJsonData(taskCmd.getJsonData());
		
		
		bpmTaskManager.doNext(cmd);
		
		String userId=ContextUtil.getCurrentUserId();
		
		BpmNodeJump nodeJump = bpmNodeJumpManager.getByTaskId(taskId);
		if (nodeJump != null) {
			nodeJump.setCheckStatus(TaskOptionType.SKIP.name());
			nodeJump.setJumpType(TaskOptionType.SKIP.name());
			nodeJump.setCompleteTime(new Date());
			nodeJump.setHandlerId(userId);
			bpmNodeJumpManager.update(nodeJump);
		}
		
	}
	
	

}
