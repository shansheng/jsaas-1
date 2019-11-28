package com.redxun.bpm.core.entity.config;

import java.io.Serializable;

/**
 *  任务按钮配置
 *  @author X230
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ButtonConfig implements Serializable{
	private String id="";
	//按钮的Key
	private String name="";
	//按钮的名称展示
	private String alias="";
	//按钮图标栏式
	private String iconCls="";
	//按钮的描述
	private Integer defaultBtn=1;
	//按钮的执行前调用的JS
	private String script="";
	
	private String type="";
	
	public ButtonConfig() {
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public Integer getDefaultBtn() {
		return defaultBtn;
	}

	public void setDefaultBtn(Integer defaultBtn) {
		this.defaultBtn = defaultBtn;
	}

	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
