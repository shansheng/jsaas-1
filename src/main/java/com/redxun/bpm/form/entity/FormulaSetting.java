package com.redxun.bpm.form.entity;

import java.util.HashMap;
import java.util.Map;

public class FormulaSetting {
	
	/**
	 * 流程
	 */
	public static String FLOW="flow";
	
	/**
	 * 表单方案
	 */
	public static String FORM="form";
	
	
	/**
	 * 扩展参数。
	 */
	private Map<String,Object> extParams=new HashMap<>(); 
	
	
	
	
	/**
	 * form,
	 * flow
	 */
	private String mode="";
	
	/**
	 * 表单方案ID
	 */
	private String formSolId="";
	
	/**
	 * 解决方案ID
	 */
	private String solId="";
	
	/**
	 * 流程定义ID
	 */
	private String actDefId="";
	
	/**
	 * 节点ID
	 */
	private String nodeId="";
	
	
	public FormulaSetting(){
		
	}
	
	/**
	 * 表间公式设定，表单方案构造方法。
	 * @param formSolId
	 */
	public FormulaSetting(String formSolId){
		this.formSolId=formSolId;
		this.mode=FORM;
		this.addExtParams("mode", FORM);
	}

	/**
	 * 表间公式设定，流程构造方法。
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 */
	public FormulaSetting(String solId,String actDefId,String nodeId){
		this.solId=solId;
		this.actDefId=actDefId;
		this.nodeId=nodeId;
		this.mode=FLOW;
		this.addExtParams("mode", FLOW);
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getFormSolId() {
		return formSolId;
	}

	public void setFormSolId(String formSolId) {
		this.formSolId = formSolId;
	}

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

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public Map<String, Object> getExtParams() {
		return extParams;
	}

	public void setExtParams(Map<String, Object> extParams) {
		this.extParams = extParams;
	}
	
	/**
	 * 添加参数。
	 * @param key
	 * @param val
	 */
	public void addExtParams(String key,String val){
		this.extParams.put(key, val);
	}
	
	

}
