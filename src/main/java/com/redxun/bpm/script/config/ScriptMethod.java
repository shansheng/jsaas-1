package com.redxun.bpm.script.config;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.redxun.core.util.StringUtil;
/**
 * 脚本服务类中的方法
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@JsonIgnoreProperties(value={"scriptClass","inputParams"})
public class ScriptMethod implements ScriptLabel{
	/**
	 * 脚本类
	 */
	private ScriptServiceClass scriptClass;  
	/**
	 * 脚本方法名
	 */
	private String methodName;
	/**
	 * 脚本方法描述
	 */
	private String title;
	
	/**
	 * 返回参数
	 */
	private String returnType;
	/**
	 * 当前标签ID
	 */
	private String id;

	/**
	 * 输入参数
	 */
	private List<ScriptParam> inputParams=new ArrayList<ScriptParam>();

	/**
	 * 脚本方法分类
	 */
	private String category;

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public ScriptServiceClass getScriptClass() {
		return scriptClass;
	}
	
	public void setScriptClass(ScriptServiceClass scriptClass) {
		this.scriptClass = scriptClass;
	}
	
	public String getMethodName() {
		return methodName;
	}
	
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	
	public List<ScriptParam> getInputParams() {
		return inputParams;
	}
	
	public void setInputParams(List<ScriptParam> inputParams) {
		this.inputParams = inputParams;
	}

	public String getReturnType() {
		return returnType;
	}

	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String getName() {
		//return this.methodName;
		StringBuffer sb=new StringBuffer();
		
		sb.append(this.methodName).append("(");
		int i=0;
		for(ScriptParam param:inputParams){
			if(i>0){
				sb.append(",");
			}
			sb.append(param.getParamType()).append(" ").append(param.getParamName());
			i++;
		}
		sb.append(")");
		return sb.toString();
	}

	@Override
	public String getExample() {
		StringBuffer sb=new StringBuffer("//").append(this.title);
		for(ScriptParam param:inputParams){
			sb.append("\r\n//").append(param.getParamName()).append(" ").append(param.getTitle());
		}
		sb.append("\r\n");
		if(!"void".equals(this.returnType)){
			sb.append(this.returnType).append(" var=");
		}
		sb.append(StringUtil.makeFirstLetterLowerCase(scriptClass.getShortClsName())).append(".");
		sb.append(this.methodName).append("(");
		int i=0;
		for(ScriptParam param:inputParams){
			if(i>0){
				sb.append(",");
			}
			//sb.append(param.getParamType()).append(" ").append(param.getParamName());
			sb.append(param.getParamName());
			i++;
		}
		sb.append(");");
		return sb.toString();
	}

	@Override
	public String getType() {
		return "method";
	}
	
	@Override
	public String getId() {
		return id;
	}
	
	@Override
	public String getParentId() {
		return scriptClass.getId();
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String getIconCls() {
		return "icon-method";
	}
	
}
