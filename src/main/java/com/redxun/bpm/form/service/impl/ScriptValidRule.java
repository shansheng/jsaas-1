package com.redxun.bpm.form.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.core.script.GroovyEngine;

public class ScriptValidRule implements IValidRule {
	
	private String script="";
	
	@Resource
	private GroovyEngine groovyEngine;

	@Override
	public String getName() {
		return "脚本验证";
	}

	@Override
	public String getAlias() {
		return "script";
	}

	@Override
	public boolean valid(JSONObject obj, JSONObject row) {
		/*String field = obj.getString("field");
		String boDefId = obj.getString("boDefId");
		Object val = obj.get("val");*/
		Map<String, Object> params=new HashMap<>();
		params.put("row", row);
		params.putAll(row);
		boolean rtn= (boolean) groovyEngine.executeScripts(script, params);
		return rtn;
	}

	@Override
	public void setConf(String conf) {
		this.script=conf;
	}
	
}
