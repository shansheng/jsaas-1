package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.core.json.FastjsonUtil;
/**
 *  @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * @author mansan
 *
 */
public class MiniTreeSelectViewHandler implements MiniViewHanlder {

	@Override
	public String getPluginName() {
		return "mini-treeselect";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String from=el.attr("from");
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		if("custom".equals(from)){
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
		String val=FastjsonUtil.getString(jsonObj, name+"_name");
		el.replaceWith(new Element(Tag.valueOf("span"), "").text(val));
	}

	

}
