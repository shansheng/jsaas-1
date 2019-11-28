package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;

/**
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * @author mansan
 *
 */
public class MiniTextBoxListViewHandler implements MiniViewHanlder{
	@Override
	public String getPluginName() {
		return "mini-textboxlist";
	}
	
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		if(jsonObj!=null){
			String name=el.attr("name");
			String label=FastjsonUtil.getString(jsonObj,name+"_name");
			String val=FastjsonUtil.getString(jsonObj,name);
			if(StringUtils.isNotEmpty(val) && StringUtils.isNotEmpty(label)){
				el.attr("value",val);
				el.attr("text",label);
			}
		}
	}
	
	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		if(jsonObj!=null){
			String name=el.attr("name");
			String label=FastjsonUtil.getString(jsonObj,name+"_name");
			el.replaceWith(new Element(Tag.valueOf("span"), "").text(label));
		}
	}

	
}
