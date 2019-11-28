package com.redxun.bpm.activiti.service.impl;

import org.activiti.engine.impl.persistence.entity.TaskEntity;

import com.redxun.bpm.activiti.service.ITaskSkipCondition;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;

public class SameUserCondition implements ITaskSkipCondition {

	@Override
	public String getName() {
		return "相邻节点相同用户审批";
	}

	@Override
	public String getType() {
		return "sameUser";
	}

	@Override
	public Boolean canSkip(TaskEntity taskEntity) {
		String assignee=taskEntity.getAssignee();
		if(StringUtil.isEmpty(assignee)){
			return false;
		}
		String curUserId=ContextUtil.getCurrentUserId();
		
		Boolean rtn=curUserId.equals(assignee);
		
		return rtn;
	}

}
