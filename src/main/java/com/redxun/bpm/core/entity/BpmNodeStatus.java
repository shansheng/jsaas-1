package com.redxun.bpm.core.entity;

/**
 * 流程节点状态
 * @author mansan
 *
 */
public class BpmNodeStatus {
	
	private String nodeId;
	
	private String jumpType;
	
	private String timeoutStatus;
	
	public String getNodeId() {
		return nodeId;
	}
	
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	
	public String getJumpType() {
		return jumpType;
	}
	
	public void setJumpType(String jumpType) {
		this.jumpType = jumpType;
	}
	
	public String getTimeoutStatus() {
		return timeoutStatus;
	}
	
	public void setTimeoutStatus(String timeoutStatus) {
		this.timeoutStatus = timeoutStatus;
	}
}
