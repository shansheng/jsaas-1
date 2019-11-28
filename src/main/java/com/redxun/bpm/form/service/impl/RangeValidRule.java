package com.redxun.bpm.form.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.core.util.StringUtil;

/**
 * 数字范围验证。
 * @author ray
 *
 */
public class RangeValidRule implements IValidRule{
	
	//{min:1,max:100}
	String conf="";

	@Override
	public String getName() {
		return "范围验证";
	}

	@Override
	public String getAlias() {
		return "range";
	}

	@Override
	public boolean valid(JSONObject obj, JSONObject row) {
		String field = obj.getString("field");
		String boDefId = obj.getString("boDefId");
		Object val = obj.get("val");
		if(StringUtil.isEmpty(conf)) return true;
		if(val==null) return false;
		float v=Float.parseFloat(val.toString());
		
		JSONObject config=JSONObject.parseObject(conf);
		if(config.containsKey("min")){
			Integer min=config.getInteger("min");
			if(v<min) return false;
		}
		
		if(config.containsKey("max")){
			Integer max=config.getInteger("max");
			if(v>max) return false;
		}
		return true;
	}


	@Override
	public void setConf(String conf) {
		if(StringUtil.isEmpty(conf)){
			this.conf="{}";
		}
		else{
			this.conf=conf;
		}
		
	}

	

}
