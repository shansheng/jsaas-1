package com.redxun.bpm.form.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
/**
 * 表字段获值处理器集中入口配置类
 * @author think
 *
 */
public class TableFieldValueHandlerConfig {
	
	Map<String,ITableFieldValueHandler> handlersMap=new HashMap<String,ITableFieldValueHandler>();
	

	public void setHandlerList(List<ITableFieldValueHandler> handlerList) {
		for(ITableFieldValueHandler handler:handlerList){
			handlersMap.put(handler.getMapType(),handler);
		}
	}

	/**
	 * 根据mapType获取处理器。
	 * @param mapType
	 * @return
	 */
	public ITableFieldValueHandler getByMapType(String mapType){
		if(!handlersMap.containsKey(mapType)) return null;
		return handlersMap.get(mapType);
	}
	


	
}
