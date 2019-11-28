package com.redxun.microsvc.bpm.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 流程节点对象。
 * @author ray
 *
 */
public class ActivitiNode implements Serializable{
	/**
	 * 节点ID
	 */
	private String nodeId="";
	
	/**
	 * 节点名称。
	 */
	private String nodeName="";
	
	/**
	 * 节点类型。
	 */
	private String nodeType="";
	
	/**
	 * 实例
	 */
	private String multiInstance="";
	
	private List<ActivitiNode> outcomeNodes=new ArrayList<ActivitiNode>();

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

	public String getMultiInstance() {
		return multiInstance;
	}

	public void setMultiInstance(String multiInstance) {
		this.multiInstance = multiInstance;
	}

	public List<ActivitiNode> getOutcomeNodes() {
		return outcomeNodes;
	}

	public void setOutcomeNodes(List<ActivitiNode> outcomeNodes) {
		this.outcomeNodes = outcomeNodes;
	}
	
	

}
