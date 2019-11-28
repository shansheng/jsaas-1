package com.redxun.microsvc.bpm.entity;

import java.io.Serializable;

import com.alibaba.fastjson.JSONObject;

/**
 * 审批参数对象。
 * @author ray
 *
 */
public class ApproveModel implements Serializable{

	/**
	 * 任务ID
	 */
	private String taskId="";
	/**
	 * 表单数据
	 */
	private String jsonData="";
	
	/**
	 * 意见类型。
	 */
	private String jumpType="";
	/**
	 * 审批意见。
	 */
	private String opinion="";
	
	/**
	 * 目标节点。
	 */
	private String destNodeId="";
	/**
	 * 目标用户
	 */
	private String destNodeUsers="";
	/**
	 * 当前审批人。
	 */
	private String userAccount="";
	
	
	
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getJsonData() {
		return jsonData;
	}
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}
	public String getJumpType() {
		return jumpType;
	}
	public void setJumpType(String jumpType) {
		this.jumpType = jumpType;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	public String getDestNodeId() {
		return destNodeId;
	}
	public void setDestNodeId(String destNodeId) {
		this.destNodeId = destNodeId;
	}
	public String getDestNodeUsers() {
		return destNodeUsers;
	}
	public void setDestNodeUsers(String destNodeUsers) {
		this.destNodeUsers = destNodeUsers;
	}
	public String getUserAccount() {
		return userAccount;
	}
	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}
	@Override
	public String toString() {
		return JSONObject.toJSONString(this);
	}
	
	
	
	
}
