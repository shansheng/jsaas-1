package com.redxun.bpm.core.entity;

import com.alibaba.fastjson.JSONObject;

/**
 * 
 * 对象获取授权json。
 * @author ray
 *
 */
public interface IRightModel {
	
	void setRightJson(JSONObject rightJson);

	JSONObject getRightJson();
	
	String getSolId();

}
