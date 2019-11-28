package com.redxun.bpm.activiti.handler;

import com.redxun.bpm.core.entity.IExecutionCmd;

/**
 * 后置任务处理器
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface TaskAfterHandler {
	/**
	 * 当前任务处理
	 * @param cmd 当前任务执行的
	 * @param nodeId
	 * @param busKey
	 */
	public void taskAfterHandle(IExecutionCmd cmd,String nodeId,String busKey);
}
