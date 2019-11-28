package com.redxun.bpm.activiti.handler;

import org.activiti.engine.task.Task;

import com.redxun.bpm.core.entity.IExecutionCmd;

/**
 * 任务审批前执行的前置处理器
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface TaskPreHandler {
	/**
	 * 当前任务处理
	 * @param cmd 当前任务执行的
	 * @param nodeId
	 * @param busKey
	 */
	public void taskPreHandle(IExecutionCmd cmd,Task task,String busKey);
}
