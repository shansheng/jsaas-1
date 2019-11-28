package com.redxun.bpm.activiti.service;

import org.activiti.engine.delegate.DelegateExecution;

import com.alibaba.fastjson.JSONObject;

public interface IServiceTask {
	
	String getType();
	
	String getTitle();
	
	void handle(JSONObject setting,DelegateExecution execution);


}
