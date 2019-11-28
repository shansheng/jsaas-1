package com.redxun.bpm.form.entity;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;

/**
 * 表单返回对象。
 * @author ray
 *
 */
public class FormModel {
	
	/**
	 * 结果。
	 */
	private boolean result=true;
	
	/**
	 * 消息。
	 */
	private String msg="";
	
	/**
	 * url : URL表单
	 * form: 在线表单
	 */
	private String type="";
	/**
	 * formKey
	 */
	private String formKey="";
	
	/**
	 * 表单内容。
	 */
	private String content="";
	
	/**
	 * 权限。
	 */
	private String permission="";
	
	/**
	 * 表单数据。
	 */
	private JSONObject jsonData;
	
	/**
	 * 表单描述。
	 */
	private String description="";
	
	/**
	 * viewId
	 */
	private String viewId="";
	
	/**
	 * 设置表单BO定义。
	 */
	private String boDefId="";
	
	/**
	 * 表单时间戳
	 */
	private String timeStamp="";
	
	private Map<String,Object> params=new HashMap<String, Object>();

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public JSONObject getJsonData() {
		return jsonData;
	}

	public void setJsonData(JSONObject jsonData) {
		this.jsonData = jsonData;
	}

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getViewId() {
		return viewId;
	}

	public void setViewId(String viewId) {
		this.viewId = viewId;
	}

	public Map<String, Object> getParams() {
		return params;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}
	
	/**
	 * 构建URL.
	 * @param key
	 * @param val
	 */
	public void addParams(String key,Object val){
		this.params.put(key, val);
	}

	public String getBoDefId() {
		return boDefId;
	}

	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}

	public String getFormKey() {
		return formKey;
	}

	public void setFormKey(String formKey) {
		this.formKey = formKey;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	
}
