package com.redxun.bpm.form.service.impl;

import java.util.Date;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 当前时间
 * @author think
 *
 */
public class TableFieldValueCurDate implements ITableFieldValueHandler{
	
	@Override
	public String getMapType() {
		return TYPE_CUR_DATE;
	}

	@Override
	public String getMapTypeName() {
		return "当前时间";
	}

	


	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType,String srcPkId, DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		return new Date();
	}

}
