package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.core.json.FastjsonUtil;


/**
 * mini-boxlist
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public abstract class MiniBoxListViewHandler implements MiniViewHanlder{
	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		String text=FastjsonUtil.getString(jsonObj, name+"_name");
		String from=el.attr("from");
		
		//固化其URL
		if("dic".equals(from)){
			String key=el.attr("dickey");
			if(StringUtils.isNotEmpty(key)){
				String dicUrl=(String)params.get(FormViewConsts.PARAM_CTX_PATH)+"/sys/core/sysDic/listByKey.do?key="+key;
				el.attr("url",dicUrl);
			}
		}
		String plugins =el.attr("plugins");

		
		if(StringUtils.isEmpty(val) || "mini-combobox".equals(plugins)){
			return;
		}
		el.attr("value",val);
		el.attr("text",text);
		//在表单加入旧的值，可以允许在表单中加载时进行值的恢复显示
		JSONObject dataOp=new JSONObject();
		dataOp.put("oval", val);
		dataOp.put("otext", text);
		el.attr("data-options",dataOp.toJSONString());
	}
}
