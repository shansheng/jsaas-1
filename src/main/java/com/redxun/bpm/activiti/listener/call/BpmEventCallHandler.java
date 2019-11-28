package com.redxun.bpm.activiti.listener.call;

import com.redxun.bpm.activiti.jms.BpmEventCallMessage;

/**
 * 流程节点事件调用接口
 * @author mansan
 */
public interface BpmEventCallHandler {
	/**
	 * 脚本处理=Script
	 */
	final static String HANDLER_TYPE_SCRIPT="Script";
	/**
	 * Sql处理=Sql
	 */
	final static String HANDLER_TYPE_SQL="Sql";
	/**
	 * RestfulAPI处理=RestfulApi
	 */
	final static String HANDLER_TYPE_RESTFULAPI="RestfulApi";
	/**
	 * WebService处理=WebService
	 */
	final static String HANDLER_TYPE_WEBSERVICE="WebService";
	/**
	 * 流程接口处理=ProcessCall
	 */
	final static String HANDLER_TYPE_PROCESSCALL="ProcessCall";
	/**
	 * HTTP请求服务调用=HttpInvoke
	 */
	final static String HANDLER_TYPE_HTTPINVOKE="HttpInvoke";
	
	final static String HANDLER_TYPE_JMS="jms";
	
	final static String HANDLER_TYPE_SUBPROCESS="subProcess";
	
	/**
	 * 处理器类型
	 * @return
	 */
	String getHandlerType();
	/**
	 * 处理事件调用
	 * @param executionCmd 流程执行的命令参数对象
	 * @param eventSetting 事件配置
	 * @param activitiEvent activiti事件对象
	 */
	void handle(BpmEventCallMessage callMessage);
}
