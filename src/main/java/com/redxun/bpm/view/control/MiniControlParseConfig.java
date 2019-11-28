package com.redxun.bpm.view.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.InitializingBean;

/**
 * miniui的控件解析配置器
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniControlParseConfig implements InitializingBean{

	private Map<String, MiniViewHanlder> viewHandlersMap = new HashMap<String, MiniViewHanlder>();
	
	private List<MiniViewHanlder> viewHandlers = new ArrayList<MiniViewHanlder>();

	private DefaultViewHandler defaulViewHandler = new DefaultViewHandler();

	
	public MiniControlParseConfig() {
	
	}
	
	/**
	 * 获得元素的视图元素处理器
	 * 
	 * @param pluginName
	 *            元素的插件名称
	 * @return
	 */
	public MiniViewHanlder getElementViewHandler(String pluginName) {

		MiniViewHanlder viewHandler = viewHandlersMap.get(pluginName);
		// 找到注册的处理器
		if (viewHandler != null) {
			return viewHandler;
		}
		// 返回缺省的处理器
		return defaulViewHandler;
	}

	public DefaultViewHandler getDefaulViewHandler() {
		return defaulViewHandler;
	}

	public void setDefaulViewHandler(DefaultViewHandler defaulViewHandler) {
		this.defaulViewHandler = defaulViewHandler;
	}

	public Map<String, MiniViewHanlder> getViewHandlersMap() {
		return viewHandlersMap;
	}

	public void setViewHandlersMap(Map<String, MiniViewHanlder> viewHandlersMap) {
		this.viewHandlersMap = viewHandlersMap;
	}

	public List<MiniViewHanlder> getViewHandlers() {
		return viewHandlers;
	}

	public void setViewHandlers(List<MiniViewHanlder> viewHandlers) {
		this.viewHandlers = viewHandlers;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		for(MiniViewHanlder handler:viewHandlers){
			viewHandlersMap.put(handler.getPluginName(), handler);
		}
	}

}
