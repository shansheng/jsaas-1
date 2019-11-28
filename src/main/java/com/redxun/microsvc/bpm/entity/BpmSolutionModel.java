package com.redxun.microsvc.bpm.entity;

import java.io.Serializable;

/**
 * 流程方案对象。
 * @author ray
 *
 */
public class BpmSolutionModel implements Serializable{
	
	/**
	 * 方案ID
	 */
	protected String solId="";

	/**
	 * 流程定义ID
	 */
	protected String actDefId="";
	
	/**
	 * 方案名称
	 */
	protected String name="";
	
	/**
	 * 流程定义KEY
	 */
	protected String key="";
	/**
	 * 流程描述
	 */
	protected String descp="";
	/**
	 * 状态
	 */
	protected String status="";
	/**
	 * 是否正式
	 */
	protected String formal="";
	
	/**
	 * bodefID
	 */
	protected String boDefId="";
	
	public String getSolId() {
		return solId;
	}

	public void setSolId(String solId) {
		this.solId = solId;
	}

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getDescp() {
		return descp;
	}

	public void setDescp(String descp) {
		this.descp = descp;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFormal() {
		return formal;
	}

	public void setFormal(String formal) {
		this.formal = formal;
	}

	public String getBoDefId() {
		return boDefId;
	}

	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}

	
}
