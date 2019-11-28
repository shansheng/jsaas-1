package com.redxun.sys.bo.manager.parse.impl;

import org.jsoup.nodes.Element;

import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.manager.parse.AbstractBoAttrParse;
import com.redxun.sys.bo.manager.parse.ParseUtil;
import com.redxun.core.database.api.model.Column;

public class HiddenAttrParse extends AbstractBoAttrParse {

	@Override
	public String getPluginName() {
		return "mini-hidden";
	}

	@Override
	protected void parseExt(SysBoAttr field, Element el) {
		if(el.hasAttr("datatype")){
			String datatype=el.attr("datatype");
			String strLen=el.attr("length");
			field.setDataType(datatype);
			field.setLength(Integer.parseInt(strLen));
			if(Column.COLUMN_TYPE_NUMBER.equals(datatype)){
				String decimal=el.attr("decimal");
				field.setDecimalLength(Integer.parseInt(decimal));
			}
		}
		else{
			ParseUtil.setStringLen(field,el);
		}

	}
	
	@Override
	public String getDescription() {
		return "隐藏域";
	}

	@Override
	public boolean isSingleAttr() {
		return true;
	}

}
