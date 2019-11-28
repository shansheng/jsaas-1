package com.redxun.bpm.form.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.core.util.StringUtil;

/**
 * 长度范围限制。
 * @author ray
 *
 */
public class LenRangeValidRule implements IValidRule {
	
	//{min:1,max:100}
	private String conf="";

	@Override
	public String getName() {
		return "长度验证";
	}

	@Override
	public String getAlias() {
		return "length";
	}
	
	

	/**
	 * 
	 */
	@Override
	public boolean valid(JSONObject obj, JSONObject row) {
		/*String field = obj.getString("field");
		String boDefId = obj.getString("boDefId");*/
		Object val = obj.get("val");
		if(StringUtil.isEmpty(conf)) return true;
		if(val==null) return false;
		JSONObject config=JSONObject.parseObject(conf);
		int len=val.toString().length();
		if(config.containsKey("min")){
			Integer min=config.getInteger("min");
			if(len<min) return false;
		}
		
		if(config.containsKey("max")){
			Integer max=config.getInteger("max");
			if(len>max) return false;
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
