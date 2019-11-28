package com.redxun.bpm.activiti.listener.call;

import com.redxun.bpm.activiti.jms.BpmEventCallMessage;

public interface ProcessCall {
	/**
	 * 处理流程事件的调用
	 * @param executionCmd
	 * @param eventSetting
	 * @param activitiEvent
	 * @return
	 * @throws Exception
	 */
	boolean process(BpmEventCallMessage eventCallMessage);
}
