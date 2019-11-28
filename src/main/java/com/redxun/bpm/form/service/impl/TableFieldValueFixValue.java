package com.redxun.bpm.form.service.impl;

import java.util.Map;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.core.util.DateUtil;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 固定值
 * @author think
 *
 */
public class TableFieldValueFixValue implements ITableFieldValueHandler{

	@Override
	public String getMapType() {
		return TYPE_FIX_VALUE;
	}

	@Override
	public String getMapTypeName() {
		return "固定值";
	}

	

	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType, String srcPkId, DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		if(StringUtils.isEmpty(mapValue)){
			return null;
		}
		if("string".equals(dataType)){
			return mapValue;
		}else if("number".equals(dataType)){
			return new Double(mapValue);
		}else if("date".equals(dataType)){
			return DateUtil.parseDate(mapValue);
		}else{
			return mapValue;
		}
	}

}
