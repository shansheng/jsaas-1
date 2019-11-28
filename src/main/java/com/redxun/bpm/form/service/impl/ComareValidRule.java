package com.redxun.bpm.form.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.core.util.StringUtil;

/**
 * 比较验证规则。
 * <pre>
 * 	这个值比较是配置和某个字段进行比较。
 * </pre>
 * @author ray
 *
 */
public class ComareValidRule implements IValidRule {
	
	/**
	 * gt:大于
	 * eq:等于
	 * neq:不等于
	 * lt:小于
	 * gte:大于等于
	 * lte:小于等于
	 * {field:"",type:"gt"}
	 */
	private String conf="";

	@Override
	public String getName() {
		return "数值比较";
	}

	@Override
	public String getAlias() {
		return "compare";
	}

	@Override
	public boolean valid(JSONObject obj, JSONObject row) {
		/*String field = obj.getString("field");
		String boDefId = obj.getString("boDefId");*/
		Object val = obj.get("val");
		if(StringUtil.isEmpty(conf))return true;
		if(val==null) return false;
		JSONObject json=JSONObject.parseObject(this.conf);
		//需要比较的字段
		String compareField=json.getString("field");
		String op=json.getString("type");
		
		float v=Float.parseFloat(val.toString());
		float to=row.getFloatValue(compareField);
		
		boolean rtn=compare(v, to, op);
		
		return rtn;
	}
	
	private boolean compare(float c,float to,String op){
		switch(op){
			case "gt":
				return (c>to);
			case "gte":
				return (c>=to);
			case "lt":
				return (c<to);
			case "lte":
				return (c<=to);
			case "eq":
				return (c==to);
			case "neq":
				return (c!=to);
		}
		return false;
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
