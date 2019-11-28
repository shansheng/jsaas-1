package com.redxun.bpm.form.service.impl;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.core.util.BeanUtil;

/**
 * 唯一验证。
 * @author ray
 *
 */
public class UniqueValidRule implements IValidRule{
	
	@Override
	public String getName() {
		return "唯一验证";
	}

	@Override
	public String getAlias() {
		return "unique";
	}

	@Override
	public boolean valid(JSONObject  obj, JSONObject row) {
		String field = obj.getString("field");
		String boDefId = obj.getString("boDefId");
		Object val = obj.get("val");
		
		if(val==null) return false;
		IFormDataHandler handler= BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_DB);
		Map<String,Object> params = new HashMap<String,Object>();
		params.put(field, val);
		JSONObject jsonObj= handler.getData(boDefId, params);
		if(BeanUtil.isEmpty(jsonObj)){
			return true;
		}
		return false;
	}


	@Override
	public void setConf(String conf) {
	}

	

}
