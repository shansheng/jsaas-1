package com.redxun.bpm.activiti.listener;

import org.activiti.engine.delegate.event.ActivitiEvent;

import com.redxun.bpm.activiti.listener.call.BpmRunException;

/**
 *  Activiti的事件处理器
 * @author csx
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface EventHandler {
	/**
	 * 事件处理器
	 * @param event
	 */
	public void handle(ActivitiEvent event) throws BpmRunException;
}
