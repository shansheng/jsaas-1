package com.redxun.bpm.view.control;

import java.util.Map;

import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.StringUtil;

/**
 * mini-checkbox的视图解析器
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 *
 */
public class MiniCheckboxViewHandler implements MiniViewHanlder{
	@Override
	public String getPluginName() {
		return "mini-checkbox";
	}
	
	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		//如果没有选中的值，那么直接返回
		String val=FastjsonUtil.getString(jsonObj, name);
		if(StringUtil.isEmpty(val)) return ;
		//判断选中的值和true值比较决定是否选中。
		String truevalue=el.attr("truevalue");
		if(val.equals(truevalue)){
			el.attr("checked","true");
		}
		else{
			el.attr("checked","false");
		}
	}
	
	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		if(StringUtil.isEmpty(val)) {
			val=el.attr("falsevalue");
		}
		el.replaceWith(new Element(Tag.valueOf("span"), "").text(val));
	}

}
