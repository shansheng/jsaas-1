package com.redxun.sys.bo.manager.parse.impl;

import org.jsoup.nodes.Element;

import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.manager.parse.AbstractBoAttrParse;

public class CommonFieldAttrParse extends AbstractBoAttrParse{

	@Override
	public String getPluginName() {
		return "mini-commonfield";
	}

	@Override
	public String getDescription() {
		return "标准字段";
	}

	@Override
	public boolean isSingleAttr() {
		return true;
	}

	@Override
	protected void parseExt(SysBoAttr field, Element el) {
	}

}
