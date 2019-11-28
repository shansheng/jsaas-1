package com.redxun.bpm.view.control;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.script.GroovyEngine;

public class MiniHiddenViewHandler implements MiniViewHanlder {
	@Resource
	GroovyEngine groovyEngine;
	
	@Override
	public String getPluginName() {
		return "mini-hidden";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		
		el.attr("type","hidden");
		String val=FastjsonUtil.getString(jsonObj, name);
		if(StringUtils.isNotEmpty(val)){
			el.attr("value",val);
			return;
		}
		String initScriptVal=el.attr("intscriptvalue");

		//当前值不为空，并且初始化值不为空，则通过它来获得值
		if(StringUtils.isEmpty(initScriptVal)){
			return;
		}
		Object returnVal=groovyEngine.executeScripts(initScriptVal, new HashMap<String,Object>());
		if(returnVal!=null){
			el.attr("value",returnVal.toString());
		}
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,JSONObject jsonObj) {
		//FormViewUtil.addHidden(el, val);
	}

}
