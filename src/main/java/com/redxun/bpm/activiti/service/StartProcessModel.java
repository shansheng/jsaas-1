package com.redxun.bpm.activiti.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.redxun.bpm.core.entity.BpmDestNode;

public class StartProcessModel implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6597964546669844667L;
	/**
	 * 解决方案ID
	 */
	private String solId="";
	/**
	 * 业务主键
	 */
	private String businessKey="";
	/**
	 * 表单数据
	 */
	private String jsonData="";
	
	/**
	 * 如果为BO。
	 */
	private String from="";
	
	
	private CallModel callModel;
	
	

	/**
	 * 流程遍历
	 */
	private Map<String,Object> vars=new HashMap<>();
	
	private Map<String,BpmDestNode> nodeUsers=new HashMap<String,BpmDestNode>();;
	
	/**
	 * 用户帐号。
	 */
	private String userAccount="";
	
	public String getSolId() {
		return solId;
	}
	
	public void setSolId(String solId) {
		this.solId = solId;
	}
	
	public String getBusinessKey() {
		return businessKey;
	}
	
	public void setBusinessKey(String businessKey) {
		this.businessKey = businessKey;
	}
	
	public String getJsonData() {
		return jsonData;
	}
	
	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
	}
	
	public Map<String, Object> getVars() {
		return vars;
	}
	
	public void setVars(Map<String, Object> vars) {
		this.vars = vars;
	}
	
	public void addVar(String name,Object val){
		this.vars.put(name, val);
	}
	
	public String getUserAccount() {
		return userAccount;
	}
	
	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}
	
	
	public CallModel getCallModel() {
		return callModel;
	}

	public void setCallModel(CallModel callModel) {
		this.callModel = callModel;
	}

	public Map<String,BpmDestNode> getNodeUsers(){
		return nodeUsers;
	}
	
	public void addNodeUsers(String nodeId,String users){
		this.nodeUsers.put(nodeId, new BpmDestNode(nodeId,users));
	}
}
