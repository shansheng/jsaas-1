package com.redxun.bpm.activiti.service;

import java.io.Serializable;

/**
 * 调用者对象
 * @author ray
 *
 */
public class CallModel implements Serializable{

	private String instId="";
	
	private String nodeId="";
	
	private String nodeName="";
	
	public CallModel(){
		
	}

	public CallModel(String instId,String nodeId){
		this.instId=instId;
		this.nodeId=nodeId;
	}
	
	public String getInstId() {
		return instId;
	}

	public void setInstId(String instId) {
		this.instId = instId;
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
	
	
}
