package com.redxun.bpm.core.entity.config;

import java.io.Serializable;

/**
 * 流程表单的配置
 * @author mansan
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmFormConfig implements Serializable{
	/**
	 * 表单类型，URL表单还是ONLINE表单
	 */
	private String formType;
	/**
	 * 表单地址
	 */
	private String formUrl;
	/**
	 * 表单HTML
	 */
	private String formHtml;
	
	private String title="";
	
	/**
	 * 表单ID
	 */
	private String formViewId;
	
	
	public String getFormType() {
		return formType;
	}
	
	public void setFormType(String formType) {
		this.formType = formType;
	}
	
	public String getFormUrl() {
		return formUrl;
	}
	
	public void setFormUrl(String formUrl) {
		this.formUrl = formUrl;
	}
	
	public String getFormHtml() {
		return formHtml;
	}
	
	public void setFormHtml(String formHtml) {
		this.formHtml = formHtml;
	}

	public String getFormViewId() {
		return formViewId;
	}

	public void setFormViewId(String formViewId) {
		this.formViewId = formViewId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}


}
