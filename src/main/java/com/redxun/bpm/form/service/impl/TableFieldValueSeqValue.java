package com.redxun.bpm.form.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.core.manager.SysSeqIdManager;
/**
 * 从流水号获值
 * @author think
 *
 */
public class TableFieldValueSeqValue implements ITableFieldValueHandler{
	@Resource
	SysSeqIdManager sysSeqIdManager;
	@Override
	public String getMapType() {
		return TYPE_SEQ_VALUE;
	}

	@Override
	public String getMapTypeName() {
		return "从流水号获值";
	}

	

	@Override
	public boolean isParameterize() {
		return true;
	}

	@Override
	public Object getFieldValue(String dataType, String srcPkId,DataHolder dataHolder,
			JSONObject rowData, JSONObject oldRow, String mapValue,Map<String,Object> extParams) {
		if(StringUtils.isEmpty(mapValue)){
			return null;
		}
		return sysSeqIdManager.genSequenceNo(mapValue, ContextUtil.getCurrentTenantId());
	}

}
