package com.redxun.bpm.form.service.impl;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 主表主键字段值(新建表单时使用)
 * @author think
 *
 */
public class TableFieldValueMainPk implements ITableFieldValueHandler{
	
	@Override
	public String getMapType() {
		return TYPE_MAIN_PK;
	}

	@Override
	public String getMapTypeName() {
		return "主表主键字段值(新建表单时使用)";
	}


	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType,  String newPkId, DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		return newPkId;
	}

}
