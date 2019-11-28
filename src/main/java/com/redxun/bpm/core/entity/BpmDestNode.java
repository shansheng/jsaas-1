package com.redxun.bpm.core.entity;

import java.io.Serializable;

/**
 * 目标节点的配置
 * 
 * @author mansan
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmDestNode implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2887413572996656331L;
	/**
	 * 节点Id
	 */
	private String nodeId;
	/**
	 * 用户Id
	 */
	private String userIds;
	/**
	 * 用户分组
	 */
	private String groupIds;
	
	
	public BpmDestNode() {
	
	}

	public BpmDestNode(String nodeId,String userIds){
		this.nodeId=nodeId;
		this.userIds=userIds;
	}
	
	
	public BpmDestNode(String nodeId,String userIds,String groupIds){
		this.nodeId=nodeId;
		this.userIds=userIds;
		this.groupIds=groupIds;
	}
	

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

	public String getGroupIds() {
		return groupIds;
	}

	public void setGroupIds(String groupIds) {
		this.groupIds = groupIds;
	}

	
	
}
