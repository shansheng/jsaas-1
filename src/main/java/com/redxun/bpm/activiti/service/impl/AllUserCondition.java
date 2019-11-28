package com.redxun.bpm.activiti.service.impl;

import org.activiti.engine.impl.persistence.entity.TaskEntity;

import com.redxun.bpm.activiti.service.ITaskSkipCondition;

public class AllUserCondition implements ITaskSkipCondition {

	@Override
	public String getName() {
		return "不需要条件直接跳过";
	}

	@Override
	public String getType() {
		return "all";
	}

	@Override
	public Boolean canSkip(TaskEntity taskEntity) {
		return true;
	}

}
