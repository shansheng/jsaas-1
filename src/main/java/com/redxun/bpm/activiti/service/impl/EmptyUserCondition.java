package com.redxun.bpm.activiti.service.impl;

import java.util.Set;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.task.IdentityLink;

import com.redxun.bpm.activiti.service.ITaskSkipCondition;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;

public class EmptyUserCondition implements ITaskSkipCondition {

	@Override
	public String getName() {
		return "审批人为空则跳过";
	}

	@Override
	public String getType() {
		return "emptyUser";
	}

	@Override
	public Boolean canSkip(TaskEntity taskEntity) {
		String assignee=taskEntity.getAssignee();
		Set<IdentityLink> set = taskEntity.getCandidates();
		if(StringUtil.isEmpty(assignee) && BeanUtil.isEmpty(set)){
			return true;
		}
		
		return false;
	}

}
