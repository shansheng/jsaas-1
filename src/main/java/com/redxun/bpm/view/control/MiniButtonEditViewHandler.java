package com.redxun.bpm.view.control;

import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.json.FastjsonUtil;

/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 *            本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniButtonEditViewHandler implements MiniViewHanlder {

	@Override
	public String getPluginName() {
		return "mini-buttonedit";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name = el.attr("name");

		String val = FastjsonUtil.getString(jsonObj, name);
		String val_name=FastjsonUtil.getString(jsonObj, name+"_name");

		if (StringUtils.isNotEmpty(val)) {
			el.attr("value", val);
			el.attr("text", val_name);
		}

		String ckselfdlg = el.attr("ckselfdlg");
		
		if ("true".equals(ckselfdlg)) {
			//定义在uedtior-ext.js中
			el.attr("onbuttonclick", "_OnEditSelDialogShow");
		}
		el.attr("showClose", "true");
		el.attr("oncloseclick", "_OnButtonEditClear(e)");
		 

	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
			JSONObject jsonObj) {
		FormViewUtil.addHidden(el, jsonObj, true,false);
		FormUtil.convertFieldToReadOnly(el, params, jsonObj, el.attr("text"));
		
	}

}
