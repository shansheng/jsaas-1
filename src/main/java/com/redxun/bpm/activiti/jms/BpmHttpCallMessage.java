package com.redxun.bpm.activiti.jms;

import java.io.Serializable;
import java.util.Map;

import com.redxun.bpm.core.entity.IExecutionCmd;

/**
 * BPM启动http请求调用消息
 * @author mansan
 *
 */
public class BpmHttpCallMessage implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private IExecutionCmd executionCmd;
	
	private String setting;
	
	private Map<String,Object> variables;
	
	public BpmHttpCallMessage() {
		
	}
	
	public BpmHttpCallMessage(IExecutionCmd executionCmd,
			String setting,Map<String,Object> variables) {
		this.executionCmd=executionCmd;
		this.setting=setting;
		this.variables=variables;
	}

	public IExecutionCmd getExecutionCmd() {
		return executionCmd;
	}

	public void setExecutionCmd(IExecutionCmd executionCmd) {
		this.executionCmd = executionCmd;
	}

	public String getSetting() {
		return setting;
	}
	
	public void setSetting(String setting) {
		this.setting = setting;
	}
	
	public Map<String, Object> getVariables() {
		return variables;
	}
	
	public void setVariables(Map<String, Object> variables) {
		this.variables = variables;
	}

}
