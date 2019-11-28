package com.redxun.bpm.activiti.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 流程节点定义
 * 
 * @author mansan
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActNodeDef  implements Serializable {
	
	// 节点Id
	private String nodeId;
	// 节点名称
	private String nodeName;
	// 节点类型
	private String nodeType;

	//为多实例
	private String multiInstance;
	// 跳入的节点
	private List<ActNodeDef> incomeNodes = new ArrayList<ActNodeDef>();
	

	// 跳出的节点
	private List<ActNodeDef> outcomeNodes = new ArrayList<ActNodeDef>();
	
	
	public ActNodeDef() {
		
	}
	
	public String getIconCls(){
		return "icon-"+nodeType;
	}
	
	public ActNodeDef(String nodeId,String nodeName,String nodeType){
		this.nodeId=nodeId;
		this.nodeName=nodeName;
		this.nodeType=nodeType;
	}
	
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

	public String getNodeType() {
		return nodeType;
	}

	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}



	public List<ActNodeDef> getOutcomeNodes() {
		return outcomeNodes;
	}

	public void setOutcomeNodes(List<ActNodeDef> outcomeNodes) {
		this.outcomeNodes = outcomeNodes;
	}

	public String getMultiInstance() {
		return multiInstance;
	}

	public void setMultiInstance(String multiInstance) {
		this.multiInstance = multiInstance;
	}

	
	public List<ActNodeDef> getIncomeNodes() {
		return incomeNodes;
	}

	public void setIncomeNodes(List<ActNodeDef> incomeNodes) {
		this.incomeNodes = incomeNodes;
	}

	@Override
	public int hashCode() {
		return this.getNodeId().hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if(obj==null) return false;
		ActNodeDef o=(ActNodeDef)obj;
		return this.getNodeId().equals(o.getNodeId());
	}
	
	@Override
	public String toString() {
		return "[nodeId=" + nodeId + ", nodeName=" + nodeName + ", nodeType=" + nodeType + "]";
	}

}
