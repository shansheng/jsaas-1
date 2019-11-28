package com.redxun.bpm.form.service;

import com.alibaba.fastjson.JSONObject;

public interface IValidRule {

	String getName();
	
	String getAlias();
	
	boolean valid(JSONObject obj,JSONObject row);
	
	
	void setConf(String conf);
	
}
