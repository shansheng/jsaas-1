package com.redxun.bpm.form.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.core.util.StringUtil;

/**
 * 数据必填。
 * @author ray
 *
 */
public class RequiredValidRule implements IValidRule{

	@Override
	public String getName() {
		return "必填";
	}

	@Override
	public String getAlias() {
		return "required";
	}

	@Override
	public boolean valid(JSONObject obj, JSONObject row) {
		/*String field = obj.getString("field");
		String boDefId = obj.getString("boDefId");*/
		Object val = obj.get("val");
		if(val==null) return false;
		if(StringUtil.isNotEmpty((String)val)){
			return true;
		}
		return false;
	}

	@Override
	public void setConf(String conf) {
	}

	

}
