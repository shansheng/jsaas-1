package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;



/**
 * 处理mini-relatedsolution的元素解析
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 *
 */
public class MiniRelatedSolutionHandler implements MiniViewHanlder{

	
	@Override
	public String getPluginName() {
		return "mini-relatedsolution";
	}
	
	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		
		String name=el.attr("name");
	
		String val=FastjsonUtil.getString(jsonObj, name);
		
		if(StringUtils.isNotEmpty(val)){
			el.attr("value",val);
		}
		
	}
	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		el.attr("readOnly", "true");
	}

	
}
