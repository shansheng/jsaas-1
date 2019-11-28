package com.redxun.sys.bo.manager.parse.impl;

import org.jsoup.nodes.Element;

import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.manager.parse.AbstractBoAttrParse;

public class RefAttrParse extends AbstractBoAttrParse{

	@Override
	public String getPluginName() {
		return "mini-ref";
	}

	@Override
	public String getDescription() {
		return "引用控件";
	}

	@Override
	public boolean isSingleAttr() {
		return true;
	}

	@Override
	protected void parseExt(SysBoAttr field, Element el) {
	}

}
