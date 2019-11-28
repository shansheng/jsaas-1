package com.redxun.bpm.view.control;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.org.manager.OsGroupManager;

/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 *
 */
public class MiniDepViewHandler implements MiniViewHanlder{
	@Resource
	OsGroupManager osGroupManager;
	
	@Override
	public String getPluginName() {
		return "mini-dep";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		
		String name=el.attr("name");
		String textname=el.attr("textname");
		String val=FastjsonUtil.getString(jsonObj, name);
		
		String text="";
		if(StringUtil.isNotEmpty(textname)){
			text=FastjsonUtil.getString(jsonObj, textname);
		}
	
		if(StringUtils.isNotEmpty(val)){
			el.attr("value",val);
			el.attr("text",text);
		}
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		FormViewUtil.addHidden(el, jsonObj, true,true);
	}

	
}
