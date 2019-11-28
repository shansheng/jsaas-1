package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;

/**
 * 富文本展示
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniRichTextViewHandler implements MiniViewHanlder {

	@Override
	public String getPluginName() {
		return "mini-ueditor";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		if(StringUtils.isEmpty(val)){ 
			return;
		}	
		el.tagName("div");
		if(StringUtils.isNotEmpty(val)){
			el.html(val);
			return;
		}
		
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		el.replaceWith(new Element(Tag.valueOf("div"), "").html(el.html()));
		
	}

	

}
