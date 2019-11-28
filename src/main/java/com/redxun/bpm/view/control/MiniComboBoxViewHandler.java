package com.redxun.bpm.view.control;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.StringUtil;
/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniComboBoxViewHandler extends MiniBoxListViewHandler{
	@Override
	public String getPluginName() {
		return "mini-combobox";
	}
	
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		super.parse(el, params, jsonObj);
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		String from=el.attr("from");
		
		//固化其URL
		if("sql".equals(from)){
			String sqlKey=el.attr("sql");
			String sqlParent=el.attr("sql_parent");
			String sqlParams=el.attr("sql_params");
			String parentVal=jsonObj.getString(sqlParent);
			if(StringUtils.isNotEmpty(sqlKey)){
				String url=(String)params.get(FormViewConsts.PARAM_CTX_PATH)+"/sys/db/sysSqlCustomQuery/queryForJson_"+ sqlKey +".do";
				if(StringUtil.isNotEmpty(sqlParent)){
					if(StringUtil.isNotEmpty(parentVal)){
						try {
							String tmp="{" +sqlParams+ ":\""+parentVal+ "\"}";
							parentVal=java.net.URLEncoder.encode(tmp,"utf-8");
							String queryStr="params="+parentVal;
							url=url+"?" +queryStr;
							el.attr("url",url);
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
					else{
						String options=el.attr("data-options");
						JSONObject json=JSONObject.parseObject(options);
						json.put("url_customSql", url);
						el.attr("data-options",json.toJSONString());
					}
				}
				else{
					el.attr("url",url);
				}
			}
		}
		if(StringUtils.isEmpty(val)) return;
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
		
//		el.replaceWith(new Element(Tag.valueOf("span"), "").text(val));
		FormUtil.convertFieldToReadOnly(el, params, jsonObj,val);
	}

	
}
