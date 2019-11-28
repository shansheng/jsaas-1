package com.redxun.bpm.activiti.entity;

/**
 * 运行的流程
 * @author mansan
 *
 */
public class ActivityNodeInst {
	/**
	 * 节点Id
	 */
	protected String nodeId;
	/**
	 * 节点名称
	 */
	protected String nodeName;
	/**
	 * 原执行人Id
	 */
	protected String orginalUserIds;
	/**
	 * 原执行人全名
	 */
	protected String orginalFullNames;
	/**
	 * 实际执行人Ids
	 */
	protected String exeUserIds;
	/**
	 * 实际上执行人名
	 */
	protected String exeFullNames;
	/**
	 * 下一步节点Ids
	 */
	protected String toNodeIds;
	/**
	 * 下一步节点名
	 */
	protected String toNodeNames;
	/**
	 * 执行状态
	 */
	protected String exeStatus;
	
	/**
	 * 串行或并行会签
	 */
	protected String multipleType;
	/**
	 * 状态
	 */
	protected String status;
	
	
	public String getNodeId() {
		return nodeId;
	}
	
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	
	public String getNodeName() {
		return nodeName;
	}
	
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	
	public String getOrginalUserIds() {
		return orginalUserIds;
	}
	
	public void setOrginalUserIds(String orginalUserIds) {
		this.orginalUserIds = orginalUserIds;
	}
	
	public String getOrginalFullNames() {
		return orginalFullNames;
	}
	
	public void setOrginalFullNames(String orginalFullNames) {
		this.orginalFullNames = orginalFullNames;
	}
	
	public String getExeUserIds() {
		return exeUserIds;
	}
	
	public void setExeUserIds(String exeUserIds) {
		this.exeUserIds = exeUserIds;
	}
	
	public String getExeFullNames() {
		return exeFullNames;
	}
	
	public void setExeFullNames(String exeFullNames) {
		this.exeFullNames = exeFullNames;
	}
	
	public String getToNodeIds() {
		return toNodeIds;
	}
	public void setToNodeIds(String toNodeIds) {
		this.toNodeIds = toNodeIds;
	}
	
	public String getToNodeNames() {
		return toNodeNames;
	}
	
	public void setToNodeNames(String toNodeNames) {
		this.toNodeNames = toNodeNames;
	}
	
	public String getExeStatus() {
		return exeStatus;
	}
	
	public void setExeStatus(String exeStatus) {
		this.exeStatus = exeStatus;
	}

	public String getMultipleType() {
		return multipleType;
	}

	public void setMultipleType(String multipleType) {
		this.multipleType = multipleType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
