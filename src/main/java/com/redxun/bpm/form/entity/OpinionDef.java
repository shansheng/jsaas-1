package com.redxun.bpm.form.entity;

/**
 * 意见定义对象。
 * @author ray
 *
 */
public class OpinionDef {
	
	/**
	 * 意见框名称。
	 */
	private String name="";
	
	/**
	 * 意见框备注。
	 */
	private String label="";
	
	
	
	
	public OpinionDef(String name, String label) {
		this.name = name;
		this.label = label;
	}

	public OpinionDef() {
		super();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

}
