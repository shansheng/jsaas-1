package com.redxun.microsvc.bpm.entity;

import java.io.Serializable;

/**
 * 变量对象
 * 
 * @author ray
 *
 */
public class VarModel implements Serializable {
	/**
	 * 数据类型。
	 */
	public static String NUMBER="Number";
	public static String DATE="Date";
	public static String STRING="String";
	
	//{name:\'a\',type:\'String\',value:\'abc\'}
	private String name="";
	private String type="";
	private String value="";
	
	public VarModel() {
		
	}
	
	
	public VarModel(String name, String type, String value) {
		
		this.name = name;
		this.type = type;
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	

}
