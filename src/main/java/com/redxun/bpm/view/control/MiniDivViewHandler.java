package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.impl.formhandler.FormUtil;

public class MiniDivViewHandler implements MiniViewHanlder{

	@Override
	public String getPluginName() {
		return "mini-div";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String dataOptions=el.attr("data-options");
		if(StringUtils.isNotEmpty(dataOptions)){
			FormUtil.convertFieldToReadOnly(el, params, jsonObj, el.html());
		}
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		
	}
}
