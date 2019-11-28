package com.redxun.bpm.activiti.service;

import org.activiti.engine.impl.persistence.entity.TaskEntity;

public interface ITaskSkipCondition {
	
	/**
	 * 条件名称
	 * @return
	 */
	String getName();
	
	/**
	 * 条件类型
	 * @return
	 */
	String getType();
	
	/**
	 * 条件判断如果返回true表示这个任务会被执行跳过。
	 * @param taskEntity
	 * @return
	 */
	Boolean canSkip(TaskEntity taskEntity);

}
