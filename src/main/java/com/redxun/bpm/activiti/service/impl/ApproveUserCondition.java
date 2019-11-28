package com.redxun.bpm.activiti.service.impl;

import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.TaskEntity;

import com.redxun.bpm.activiti.service.ITaskSkipCondition;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.core.util.StringUtil;

public class ApproveUserCondition implements ITaskSkipCondition{
	
	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;

	@Override
	public String getName() {
		return "当前用户曾审批";
	}

	@Override
	public String getType() {
		return "approve";
	}

	@Override
	public Boolean canSkip(TaskEntity taskEntity) {
		Set<String> userIds = bpmNodeJumpManager.getLatestHadCheckedUserIds(taskEntity.getProcessInstanceId());
		String assignee=taskEntity.getAssignee();
		if(StringUtil.isEmpty(assignee)){
			return false;
		}
		Boolean isContain=userIds.contains(assignee);
		return isContain;
	}

}
