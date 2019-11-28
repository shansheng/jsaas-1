package com.redxun.bpm.form.service.impl;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 来源表单主表主键字段值
 * @author think
 *
 */
public class TableFieldValueMainPkId implements ITableFieldValueHandler{
	
	@Override
	public String getMapType() {
		return TYPE_MAIN_PK_ID;
	}

	@Override
	public String getMapTypeName() {
		return "来源表单主表主键字段值";
	}


	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType,  String srcPkId, DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		return dataHolder.getCurMain().getString(SysBoEnt.SQL_PK);
	}

}
