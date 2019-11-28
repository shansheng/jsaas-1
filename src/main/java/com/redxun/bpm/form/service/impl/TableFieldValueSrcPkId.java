package com.redxun.bpm.form.service.impl;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.DataHolder;
/**
 * 源表主键字段值,表示从源表数据中获取主键。
 * @author think
 *
 */
public class TableFieldValueSrcPkId implements ITableFieldValueHandler{
	
	@Override
	public String getMapType() {
		return TYPE_SRC_PK_ID;
	}

	@Override
	public String getMapTypeName() {
		return "源表主键字段值";
	}

	

	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType, String srcPkId,DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		return rowData.getString(SysBoEnt.SQL_PK);
	}

}
