package com.redxun.bpm.core.entity;


/**
 * 流程执行下一步的
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessNextCmd extends AbstractExecutionCmd{

	/**
	 * 任务ID,必传
	 */
	private String taskId;
	/**
	 * 任务的代理用户,不需要传
	 */
	private String agentToUserId;
	/**
	 * 下一步的跳转方式，在回退时才需要传入
	 */
	private String nextJumpType;
	
	/**
	 * 沟通用户Id
	 */
	private String communicateUserId;
	
	
	public ProcessNextCmd() {
	
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getAgentToUserId() {
		return agentToUserId;
	}

	public void setAgentToUserId(String agentToUserId) {
		this.agentToUserId = agentToUserId;
	}

	public String getNextJumpType() {
		return nextJumpType;
	}

	public void setNextJumpType(String nextJumpType) {
		this.nextJumpType = nextJumpType;
	}

	public String getCommunicateUserId() {
		return communicateUserId;
	}

	public void setCommunicateUserId(String communicateUserId) {
		this.communicateUserId = communicateUserId;
	}


}
