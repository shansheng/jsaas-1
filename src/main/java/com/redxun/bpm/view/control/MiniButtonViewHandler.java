package com.redxun.bpm.view.control;

import java.util.Map;

import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 *
 */
public class MiniButtonViewHandler implements MiniViewHanlder{

	@Override
	public String getPluginName() {
		return "mini-button";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		//去掉连接
		el.removeAttr("href");

		String ckselfdlg=el.attr("ckselfdlg");
		//String dialogalias=el.attr("dialogalias");
		if("true".equals(ckselfdlg)){
			el.attr("onclick","_OnSelDialogShow");
		}
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		el.remove();
	}

	
	
}
