package com.redxun.bpm.form.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FormHandlerFactory {
	
	private Map<String,IFormHandler> handlerMap=new HashMap<String, IFormHandler>();
	
	
	public void setHandlers(List<IFormHandler> list){
		for(IFormHandler handler:list){
			handlerMap.put(handler.getType(), handler);
		}
	}
	
	public IFormHandler getByType(String type){
		return handlerMap.get(type);
	}
	
}
