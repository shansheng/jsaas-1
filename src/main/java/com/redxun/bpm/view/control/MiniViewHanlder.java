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
public interface MiniViewHanlder {
	
	/**
	 * 获得插件的名称
	 * @return
	 */
	String getPluginName();
	
	/**
	 * 解析HTML页中的元素element，并且根据参数进行过滤处理
	 * @param el
	 * @param params 解析的参数
	 * @param jsonObj
	 */
	void parse(Element el,Map<String,Object> params,JSONObject jsonObj);
	
	/**
	 * 转化为只读
	 * @param el
	 * @param params
	 * @param jsonObj
	 */
	void convertToReadOnly(Element el,Map<String, Object> params,JSONObject jsonObj);
	
}
