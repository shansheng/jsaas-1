package com.redxun.bpm.form.service.impl;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.core.util.StringUtil;

public class RegExValidRule implements IValidRule {
	
	
	String regStr="";
	

	@Override
	public String getName() {
		return "正则表达式";
	}

	@Override
	public String getAlias() {
		return "reg";
	}

	@Override
	public boolean valid(JSONObject obj, JSONObject row) {
		/*String field = obj.getString("field");
		String boDefId = obj.getString("boDefId");*/
		Object val = obj.get("val");
		if(StringUtil.isEmpty(this.regStr)) return true;
		Pattern pattern = Pattern.compile(regStr, Pattern.CASE_INSENSITIVE );
		Matcher matcher= pattern.matcher(val.toString());
		return matcher.find();
	}

	
	@Override
	public void setConf(String conf) {
		this.regStr=conf;
	}

}
