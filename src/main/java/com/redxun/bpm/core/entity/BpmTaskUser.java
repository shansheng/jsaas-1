package com.redxun.bpm.core.entity;


/**
 * 任务执行人员
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmTaskUser {
	private String taskId;
	/**
	 * 节点Id
	 */
	private String nodeId;
	/**
	 * 节点名称
	 */
	private String taskName;
	/**
	 * 执行人员IDS
	 */
	private String userIds;
	/**
	 * 执行姓名
	 */
	private String fullnames;
	
	/**
	 * 用户jsons
	 */
	private String userJsons;
	
	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

	public String getFullnames() {
		return fullnames;
	}

	public void setFullnames(String fullnames) {
		this.fullnames = fullnames;
	}

	public String getUserJsons() {
		return userJsons;
	}

	public void setUserJsons(String userJsons) {
		this.userJsons = userJsons;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

}
