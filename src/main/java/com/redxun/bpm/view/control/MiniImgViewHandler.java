package com.redxun.bpm.view.control;

import java.util.Map;

import javax.annotation.Resource;

import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 图片选择控件
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniImgViewHandler implements MiniViewHanlder{
	
	@Resource
	private OsUserManager osUserManager;
	@Override
	public String getPluginName() {
		return "mini-img";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name = el.attr("name");
		String val=FastjsonUtil.getString(jsonObj, name);
		el.attr("value",val);
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
			JSONObject jsonObj) {
		el.attr("readOnly","true");
	}


}
