package com.redxun.bpm.script.config;


/**
 * 脚本参数
 * 
 * @author mansan
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ScriptParam {
	/**
	 * 类型
	 */
	private String paramType;
	/**
	 * 变量名称
	 */
	private String paramName;
	/**
	 * 变量标题
	 */
	private String title;
	
	public ScriptParam() {
		
	}
	
	public ScriptParam(String paramType,String paramName,String title){
		this.paramType=paramType;
		this.paramName=paramName;
		this.title=title;
	}
	

	public String getParamType() {
		return paramType;
	}

	public void setParamType(String paramType) {
		this.paramType = paramType;
	}

	public String getParamName() {
		return paramName;
	}

	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
