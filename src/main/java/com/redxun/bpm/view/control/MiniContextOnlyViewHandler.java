package com.redxun.bpm.view.control;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.sys.api.ContextHandlerFactory;
/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniContextOnlyViewHandler implements MiniViewHanlder {
	@Resource
    ContextHandlerFactory contextHandlerFactory;
	
	@Override
	public String getPluginName() {
		return "mini-contextonly";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String constantitem=el.attr("constantitem");
		String name = el.attr("name");
		
		Object val = jsonObj.get(name);
		if(BeanUtil.isEmpty(val) ) {
			val= contextHandlerFactory.getValByKey(constantitem,params);
			if(BeanUtil.isEmpty(val)) val = "";
			if(val instanceof Date) {
				val = DateUtil.formatDate((Date)val);
			}
			el.text(val.toString());
		}else {
			if(val instanceof Date) {
				val = DateUtil.formatDate((Date)val);
			}
			el.text(val.toString());
		}
	}
		

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
			JSONObject jsonObj) {
		el.attr("readonly", "true");
	}


}
