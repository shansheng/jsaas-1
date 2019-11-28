package com.redxun.bpm.core.entity;

import com.thoughtworks.xstream.annotations.XStreamAlias;
/**
 * 流程定义扩展实体类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@XStreamAlias("bpmDefExt")
public class BpmDefExt {
	/**
	 * 流程定义实体
	 */
	private BpmDef bpmDef;
	/**
	 * model的设计JSON
	 */
	private String modelJson;
	

	public BpmDefExt() {
	
	}
	
	public BpmDefExt(BpmDef bpmDef){
		this.bpmDef=bpmDef;
	}
	
	public BpmDef getBpmDef() {
		return bpmDef;
	}
	
	public void setBpmDef(BpmDef bpmDef) {
		this.bpmDef = bpmDef;
	}
	
	public String getModelJson() {
		return modelJson;
	}
	
	public void setModelJson(String modelJson) {
		this.modelJson = modelJson;
	}
	
	
}
