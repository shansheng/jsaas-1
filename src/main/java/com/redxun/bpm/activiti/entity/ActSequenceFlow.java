package com.redxun.bpm.activiti.entity;
/**
 * Activiti的跳转线实体
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActSequenceFlow {
	/**
	 * 源节点Id
	 */
	private String sourceNodeId;
	/**
	 * 源节点名称
	 */
	private String sourceNodeName;
	/**
	 * 目标节点Id
	 */
	private String destNodeId;
	/**
	 * 目标节点名称
	 */
	private String destNodeName;
	
	/**
	 * 条件表达式
	 */
	private String conditionExpression;
	

	public String getSourceNodeId() {
		return sourceNodeId;
	}

	public void setSourceNodeId(String sourceNodeId) {
		this.sourceNodeId = sourceNodeId;
	}

	public String getSourceNodeName() {
		return sourceNodeName;
	}

	public void setSourceNodeName(String sourceNodeName) {
		this.sourceNodeName = sourceNodeName;
	}

	public String getDestNodeId() {
		return destNodeId;
	}

	public void setDestNodeId(String destNodeId) {
		this.destNodeId = destNodeId;
	}

	public String getDestNodeName() {
		return destNodeName;
	}

	public void setDestNodeName(String destNodeName) {
		this.destNodeName = destNodeName;
	}

	public String getConditionExpression() {
		return conditionExpression;
	}

	public void setConditionExpression(String conditionExpression) {
		this.conditionExpression = conditionExpression;
	}

}
