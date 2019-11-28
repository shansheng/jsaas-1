package com.redxun.bpm.activiti.handler;

import com.redxun.bpm.core.entity.ProcessStartCmd;


/**
 * 流程的前置事件执行处理
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface ProcessStartPreHandler {
	/**
	 * ProcessStartCmd 
	 * @param cmd
	 */
	void processStartPreHandle(ProcessStartCmd cmd);
}
