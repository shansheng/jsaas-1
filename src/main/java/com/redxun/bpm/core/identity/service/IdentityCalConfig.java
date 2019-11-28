package com.redxun.bpm.core.identity.service;

import java.util.Map;

/**
 * 实体计算配置类
 * 
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class IdentityCalConfig {
	// 流程实例Id
	private String processInstId;
	// Activiti的流程定义Id
	private String processDefId;
	// 节点Id
	private String nodeId;
	// 是否计算用户
	private String calcMode;

	// 流程变量
	private Map<String, Object> vars = null;
	// 配置的Json
	private String jsonConfig;
	//计算中的用户配置的令牌
	private String token;
	
	

	public String getProcessInstId() {
		return processInstId;
	}

	public void setProcessInstId(String processInstId) {
		this.processInstId = processInstId;
	}

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public String getCalcMode() {
		return calcMode;
	}

	public void setCalcMode(String calcMode) {
		this.calcMode = calcMode;
	}

	public Map<String, Object> getVars() {
		return vars;
	}

	public void setVars(Map<String, Object> vars) {
		this.vars = vars;
	}

	public String getJsonConfig() {
		return jsonConfig;
	}

	public void setJsonConfig(String jsonConfig) {
		this.jsonConfig = jsonConfig;
	}

	public String getProcessDefId() {
		return processDefId;
	}

	public void setProcessDefId(String processDefId) {
		this.processDefId = processDefId;
	}

	

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}


}
