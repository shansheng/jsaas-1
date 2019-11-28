package com.redxun.bpm.activiti.jms;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import com.redxun.bpm.activiti.listener.call.BpmEventCallSetting;
import com.redxun.bpm.core.entity.IExecutionCmd;

/**
 * BPM事件调用消息
 * @author mansan
 *
 */
public class BpmEventCallMessage implements Serializable{
	
	//序列化变量
	protected Map<String,Object> vars=new HashMap<String,Object>();
	
	protected IExecutionCmd executionCmd;
	
	protected BpmEventCallSetting bpmEventCallSetting;
	
	/**
	 * 线程ID。
	 */
	protected String executionId="";
	
	/**
	 * 流程实例ID。
	 */
	protected String actInstId="";
	
	/**
	 * 类型
	 */
	protected String type="";
	
	/**
	 * 流程定义ID
	 */
	protected String actDefId="";
	
	/**
	 * 流程节点ID
	 */
	protected String nodeId="";
	
	/**
	 * 节点ID
	 */
	protected String nodeName="";
	
	/**
	 * 审批任务ID
	 */
	protected String taskId="";
	


	public String getExecutionId() {
		return executionId;
	}

	public void setExecutionId(String executionId) {
		this.executionId = executionId;
	}

	public String getActInstId() {
		return actInstId;
	}

	public void setActInstId(String actInstId) {
		this.actInstId = actInstId;
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	public BpmEventCallMessage() {
		
	}
	
//	public BpmEventCallMessage(IExecutionCmd executionCmd,
//			BpmEventCallSetting bpmEventCallSetting) {
//		this.executionCmd=executionCmd;
//		this.bpmEventCallSetting=bpmEventCallSetting;
//	}
	
	public BpmEventCallMessage(IExecutionCmd executionCmd,
			BpmEventCallSetting bpmEventCallSetting,Map<String,Object> vars) {
		this.executionCmd=executionCmd;
		this.bpmEventCallSetting=bpmEventCallSetting;
		this.vars=vars;
	}

	public IExecutionCmd getExecutionCmd() {
		return executionCmd;
	}

	public void setExecutionCmd(IExecutionCmd executionCmd) {
		this.executionCmd = executionCmd;
	}

	public BpmEventCallSetting getBpmEventCallSetting() {
		return bpmEventCallSetting;
	}

	public void setBpmEventCallSetting(BpmEventCallSetting bpmEventCallSetting) {
		this.bpmEventCallSetting = bpmEventCallSetting;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public Map<String, Object> getVars() {
		return vars;
	}

	public void setVars(Map<String, Object> vars) {
		this.vars = vars;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	
}
