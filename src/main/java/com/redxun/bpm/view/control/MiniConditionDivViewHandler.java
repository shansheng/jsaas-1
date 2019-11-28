package com.redxun.bpm.view.control;

import java.util.Map;



import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
/**
 * 
 * @author mansan
 *
 */
public class MiniConditionDivViewHandler implements MiniViewHanlder{

	@Override
	public String getPluginName() {
		return "mini-condition-div";
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,JSONObject jsonObj) {
		
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		convertToReadOnly(el,params,jsonObj);
	}

}
