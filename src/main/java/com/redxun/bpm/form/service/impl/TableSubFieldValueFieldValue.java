package com.redxun.bpm.form.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.bo.manager.SysBoEntManager;

public class TableSubFieldValueFieldValue  implements ITableFieldValueHandler{
	
	@Resource
	private SysBoEntManager sysBoEntManager;

	@Override
	public String getMapType() {
		return ITableFieldValueHandler.TYPE_SUB_FIELD;
	}

	@Override
	public String getMapTypeName() {
		return "从子表字段获取";
	}

	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType, String newPkId, DataHolder dataHolder, JSONObject rowData,
			JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		String filterSql = (String) extParams.get("filterSql");
		String userSubTable = (String) extParams.get("userSubTable");
		Integer index = (Integer) extParams.get("index");
		if(StringUtil.isEmpty(userSubTable)) return null;
		SysBoEnt ent = sysBoEntManager.get(userSubTable);
		JSONArray array = dataHolder.getCurMain().getJSONArray("SUB_"+ent.getName());
		String val = getArrayByFilterSql(array,filterSql,mapValue,index);
		if("string".equals(dataType)){
			return val;
		}else if("number".equals(dataType)){
			return new Double(val);
		}else if("date".equals(dataType)){
			return DateUtil.parseDate(val);
		}else{
			return val;
		}
	}
	
	/**
	 * 此条件逻辑还未实现
	 * @param array
	 * @param filterSql  条件
	 * @param mapValue
	 * @param index
	 * @return
	 */
	private String getArrayByFilterSql(JSONArray array,String filterSql,String mapValue,Integer index) {
		if(BeanUtil.isNotEmpty(array)) {
			return array.getJSONObject(index).getString(mapValue);
		}
		return null;
	}

}
