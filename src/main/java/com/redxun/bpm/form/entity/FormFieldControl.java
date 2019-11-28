package com.redxun.bpm.form.entity;

import java.io.Serializable;


/**
 * 表单字段控件
 * 
 * @author mansan
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class FormFieldControl implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 控件名称
	 */
	protected String fieldName;
	/**
	 * 控件描述
	 */
	protected String fieldLabel;
	
	/**
	 * 控件html
	 */
	protected String controlHtml;
	
	public FormFieldControl() {
	
	}
	
	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getFieldLabel() {
		return fieldLabel;
	}

	public void setFieldLabel(String fieldLabel) {
		this.fieldLabel = fieldLabel;
	}

	public String getControlHtml() {
		return controlHtml;
	}

	public void setControlHtml(String controlHtml) {
		this.controlHtml = controlHtml;
	}

}
