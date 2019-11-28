package com.redxun.bpm.form.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.core.script.GroovyEngine;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 从脚本获取值
 * @author think
 *
 */
public class TableFieldValueScriptValue implements ITableFieldValueHandler{
	@Resource
	GroovyEngine groovyEngine;
	
	@Override
	public String getMapType() {
		return TYPE_SCRIPT_VALUE;
	}

	@Override
	public String getMapTypeName() {
		return "从脚本获取值";
	}

	
	

	@Override
	public boolean isParameterize() {
		return false;
	}

	@Override
	public Object getFieldValue(String dataType, String srcPkId, DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		if(StringUtils.isEmpty(mapValue)){
			return null;
		}
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("cur", rowData);
		params.put("old", oldRow);
		params.put("mainCur", dataHolder.getCurMain());
		params.put("mainOld", dataHolder.getOriginMain());
		params.putAll(extParams);
		
		
		Object val=groovyEngine.executeScripts(mapValue, params);
		
		return val;
	}

}
