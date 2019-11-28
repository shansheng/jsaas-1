package com.redxun.bpm.view.control;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.StringUtil;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;

import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniAreaViewHandler extends MiniBoxListViewHandler{
	@Override
	public String getPluginName() {
		return "mini-area";
	}
	
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		super.parse(el, params, jsonObj);
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		if(StringUtils.isEmpty(val)){
			return;
		}
		el.attr("value",val);
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		FormViewUtil.addHidden(el, val);
		if(jsonObj.containsKey(name+"_name")){
			 val=FastjsonUtil.getString(jsonObj, name+"_name");
			 FormViewUtil.addHidden( el, name+"_name", val);
		}
		if(StringUtil.isEmpty(val)){
			String value=FastjsonUtil.getString(jsonObj, name);
			String from=el.attr("from");
			if("self".equals(from)){
				String json=el.attr("data");
				JSONArray jsonData=JSONArray.parseArray(json);
				for (int i = 0; i < jsonData.size(); i++) {
					JSONObject object=(JSONObject) jsonData.get(i);
					String key=object.getString("key");
					if(key.equals(value)){
						val=object.getString("name");
						break;
					}
				}
			}
		}
		
		FormUtil.convertFieldToReadOnly(el, params, jsonObj,val);
	}

	
}
