package com.redxun.bpm.form.service.impl;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.core.util.DateUtil;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 从字段获取
 * @author think
 *
 */
public class TableFieldValueFieldValue implements ITableFieldValueHandler{

	@Override
	public String getMapType() {
		return TYPE_FIELD;
	}

	@Override
	public String getMapTypeName() {
		return "从字段获取";
	}

	

	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType,String srcPkId, DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		String val=rowData.getString(mapValue);
		if("string".equals(dataType)){
			return val;
		}else if("number".equals(dataType)){
			return new Double(val.toString());
		}else if("date".equals(dataType)){
			return DateUtil.parseDate(val);
		}else{
			return val;
		}
	}

}
