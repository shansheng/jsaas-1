package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.json.FastjsonUtil;
/**
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * @author mansan
 *
 */
public class MiniRadioButtonListViewHandler extends MiniBoxListViewHandler{
	@Override
	public String getPluginName() {
		return "mini-radiobuttonlist";
	}
	
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		super.parse(el, params, jsonObj);
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		String from=el.attr("from");
		
		//固化其URL
		if("sql".equals(from)){
			String sqlKey=el.attr("sql");
			if(StringUtils.isNotEmpty(sqlKey)){
				String url=(String)params.get(FormViewConsts.PARAM_CTX_PATH)+"/sys/db/sysSqlCustomQuery/queryForJson_"+ sqlKey +".do";
				el.attr("url",url);
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
			 FormViewUtil.addHidden(el, name+"_name",val);
		}
		el.replaceWith(new Element(Tag.valueOf("span"), "").text(val));
		
	}

}
