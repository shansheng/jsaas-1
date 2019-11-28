package com.redxun.bpm.view.control;

import java.util.Map;

import javax.annotation.Resource;

import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.bo.entity.SysBoEnt;


/**
 * mini grid 进行解析处理
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniGridViewHandler implements MiniViewHanlder{

	@Resource
	MiniControlParseConfig miniControlParseConfig;
	
	@Override
	public String getPluginName() {
		return "rx-grid";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		if(BeanUtil.isEmpty(el)) return;
		
		Elements eles = el.getAllElements();
		for(Element ele:eles){
			String plugins = ele.attr("plugins");
			if(StringUtil.isNotEmpty(plugins)&&!"rx-grid".equals(plugins)){
				MiniViewHanlder handler=miniControlParseConfig.getElementViewHandler(plugins);
				handler.parse(ele, params, jsonObj);
			}
		}
		
		String tableName=el.attr("name");
		//获得初始数据的标签，进行标签的解析及处理
		Element dataEl=el.select("._initdata").first();
		
		if(BeanUtil.isEmpty(dataEl)) return;
		
		JSONArray jsonData=new JSONArray();
		if(jsonObj.containsKey(SysBoEnt.SUB_PRE + tableName)){
			jsonData=jsonObj.getJSONArray(SysBoEnt.SUB_PRE + tableName);
		}
		JSONObject jsonInit=new JSONObject();
		JSONObject initJson= jsonObj.getJSONObject("initData");
		if(BeanUtil.isNotEmpty(initJson)){
			if(initJson.containsKey(tableName)){
				jsonInit=initJson.getJSONObject(tableName);
			}
		}
			
		JSONObject obj=new JSONObject();
		
		obj.put("initData", jsonInit);
		obj.put("data", jsonData);
		
		
		dataEl.attr("style","display:none");
		dataEl.html(obj.toString());
		
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		
	}

	
}
