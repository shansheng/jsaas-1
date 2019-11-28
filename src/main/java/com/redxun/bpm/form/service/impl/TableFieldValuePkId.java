package com.redxun.bpm.form.service.impl;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 由系统产生的主键字段值
 * @author think
 *
 */
public class TableFieldValuePkId implements ITableFieldValueHandler{
	
	@Override
	public String getMapType() {
		return TYPE_PK_ID;
	}

	@Override
	public String getMapTypeName() {
		return "由系统产生的主键字段值";
	}

	

	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType, String srcPkId,DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		return IdUtil.getId();
	}

}
