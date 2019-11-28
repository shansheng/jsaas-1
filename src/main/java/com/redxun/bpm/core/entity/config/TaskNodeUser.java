package com.redxun.bpm.core.entity.config;


import java.io.Serializable;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.entity.ActNodeDef;

/**
 * 任务节点的人员
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class TaskNodeUser implements Serializable{
	private String taskId;
	//节点ID
	private String nodeId;
	//节点名称
	private String nodeText;
	//节点类型
	private String nodeType;
	//并行还是串行
	private String multiInstance=null;
	
	//用户 IDs,通过','分割开的字符串
	private String userIds;
	//用户姓名,通过','分割开的字符串
	private String userFullnames;
	//构建用于checkBox的数据结构
	private String userIdsAndText;
	//用户组Ids
	private String groupIds;
	//用户组名
	private String groupNames;
	//系统配置参考用户
	private String refUserIds;
	//系统配置参考用户值
	private String refUserFullnames;
	//正在执行用户Id
	private String exeUserIds;
	//正在执行用户名称
	private String exeUserFullnames;
	/**
	 * 正在运行
	 */
	private boolean isRunning=false;
	/**
	 * 为当前用户的任务
	 */
	private boolean isCurUserTask=false;
	
	public TaskNodeUser() {
		
	}
	
	public String getUserJsons(){
		
		if(StringUtils.isEmpty(userIds) || StringUtils.isEmpty(userFullnames)){
			return "[]";
		}
		
		String[] uIds=userIds.split("[,]");
		String[] uNames=userFullnames.split("[,]");
		
		JSONArray arr=JSONArray.parseArray("[]");
		
		for(int i=0;i<uIds.length;i++){
			JSONObject jsonObj=JSONObject.parseObject("{}");
			jsonObj.put("id", uIds[i]);
			jsonObj.put("text", uNames[i]);
			arr.add(jsonObj);
		}
		return arr.toJSONString().replace("\"", "'");
	}
	
	public TaskNodeUser(ActNodeDef actNodeDef){
		this.nodeId=actNodeDef.getNodeId();
		this.nodeText=actNodeDef.getNodeName();
		this.nodeType=actNodeDef.getNodeType();
	}
	
	public String getNodeId() {
		return nodeId;
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
	public String getUserIds() {
		return userIds;
	}
	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	public String getUserFullnames() {
		return userFullnames;
	}
	public void setUserFullnames(String userFullnames) {
		this.userFullnames = userFullnames;
	}
	public String getUserIdsAndText() {
		return userIdsAndText;
	}

	public void setUserIdsAndText(String userIdsAndText) {
		this.userIdsAndText = userIdsAndText;
	}

	public String getGroupIds() {
		return groupIds;
	}
	public void setGroupIds(String groupIds) {
		this.groupIds = groupIds;
	}
	public String getGroupNames() {
		return groupNames;
	}
	public void setGroupNames(String groupNames) {
		this.groupNames = groupNames;
	}
	public String getNodeType() {
		return nodeType;
	}
	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}

	public String getMultiInstance() {
		return multiInstance;
	}

	public void setMultiInstance(String multiInstance) {
		this.multiInstance = multiInstance;
	}

	public String getRefUserIds() {
		return refUserIds;
	}

	public void setRefUserIds(String refUserIds) {
		this.refUserIds = refUserIds;
	}

	public String getRefUserFullnames() {
		return refUserFullnames;
	}

	public void setRefUserFullnames(String refUserFullnames) {
		this.refUserFullnames = refUserFullnames;
	}

	public String getExeUserIds() {
		return exeUserIds;
	}

	public void setExeUserIds(String exeUserIds) {
		this.exeUserIds = exeUserIds;
	}

	public String getExeUserFullnames() {
		return exeUserFullnames;
	}

	public void setExeUserFullnames(String exeUserFullnames) {
		this.exeUserFullnames = exeUserFullnames;
	}

	public boolean isRunning() {
		return isRunning;
	}

	public void setRunning(boolean isRunning) {
		this.isRunning = isRunning;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public boolean isCurUserTask() {
		return isCurUserTask;
	}

	public void setCurUserTask(boolean isCurUserTask) {
		this.isCurUserTask = isCurUserTask;
	}

}
