package com.redxun.bpm.form.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.util.BeanUtil;

public class ValidRuleFactory {
	
	private Map<String,IValidRule> ruleMap=new HashMap<String,IValidRule>();
	
	public Map<String, IValidRule> getRuleMap() {
		return ruleMap;
	}
	
	public void setRuleMap(List<IValidRule> rules) {
		for (IValidRule rule : rules) {
			ruleMap.put(rule.getAlias(), rule);
		}
	}



	/**
	 * 处理流程事件的外部的异步调用
	 * @param bpmEventCallMessage
	 */
	public boolean handleValidRule(JSONObject field,JSONObject jsonData,JSONObject obj){
		if(BeanUtil.isEmpty(obj)) return false;
		IValidRule rule = ruleMap.get(obj.get("alias"));
		if(rule==null)return false;
		rule.setConf(obj.getString("conf"));
		return rule.valid(field, jsonData);
	}
	 
}
