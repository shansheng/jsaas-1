package com.redxun.bpm.core.entity.config;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.redxun.bpm.activiti.entity.ActNodeDef;

/**
 * 用于存储目标节点Id,及其后续执行任务的可能对应的处理人员
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class DestNodeUsers implements Serializable{
	//节点ID
	private String nodeId;
	//节点文本
	private String nodeText;
	//节点类型
	private String nodeType;
	//若目标只有一个节点时，即需要把目标节点的用户填写于此属性即可
	private TaskNodeUser taskNodeUser;
	
	
	public DestNodeUsers() {
	
	}
	
	public DestNodeUsers(ActNodeDef nodeDef){
		this.nodeId=nodeDef.getNodeId();
		this.nodeText=nodeDef.getNodeName();
		this.nodeType=nodeDef.getNodeType();
	}
	
	//当前节点后续的任务节点的人员
	private Map<String,TaskNodeUser> fllowNodeUserMap=new HashMap<String, TaskNodeUser>();

	public String getNodeId() {
		return nodeId;
	}
	
	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}


	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getNodeText() {
		return nodeText;
	}

	public void setNodeText(String nodeText) {
		this.nodeText = nodeText;
	}

	public Map<String, TaskNodeUser> getFllowNodeUserMap() {
		return fllowNodeUserMap;
	}

	public void setFllowNodeUserMap(Map<String, TaskNodeUser> fllowNodeUserMap) {
		this.fllowNodeUserMap = fllowNodeUserMap;
	}

	public TaskNodeUser getTaskNodeUser() {
		return taskNodeUser;
	}

	public void setTaskNodeUser(TaskNodeUser taskNodeUser) {
		this.taskNodeUser = taskNodeUser;
	}
	

}
