package com.redxun.bpm.activiti.listener.call;

import java.io.Serializable;

/**
 * 流程节点事件调用配置
 * @author mansan
 *
 */
public class BpmEventCallSetting implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8972996465770767520L;

	public BpmEventCallSetting() {
		
	}
	
	public BpmEventCallSetting(String jumpType,String callType,String callTypeName,String script,String async){
		this.jumpType=jumpType;
		this.callType=callType;
		this.callTypeName=callTypeName;
		this.script=script;
		this.async=async;
	}
	
	
	/**
	 * 审批动作
	 */
	private String jumpType;
	/**
	 * 调用的接口类型
	 */
	private String callType;
	/**
	 * 接口调用名称
	 */
	private String callTypeName;
	/**
	 * 调用的脚本或调用配置
	 */
	private String script;
	
	/**
	 * 是否为异步调用
	 */
	private String async;
	
	public String getCallType() {
		return callType;
	}
	
	public void setCallType(String callType) {
		this.callType = callType;
	}
	
	public String getCallTypeName() {
		return callTypeName;
	}
	
	public void setCallTypeName(String callTypeName) {
		this.callTypeName = callTypeName;
	}
	
	public String getScript() {
		return script;
	}
	
	public void setScript(String script) {
		this.script = script;
	}

	public String getAsync() {
		return async;
	}

	public void setAsync(String async) {
		this.async = async;
	}

	public String getJumpType() {
		return jumpType;
	}

	public void setJumpType(String jumpType) {
		this.jumpType = jumpType;
	}

	

}
