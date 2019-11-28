package com.redxun.bpm.activiti.listener;

import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.ActivitiEventListener;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.saweb.util.WebAppUtil;

/**
 * Activiti的全局事件监听器，即所有事件均需要在这里统一分发处理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class GlobalEventListener implements ActivitiEventListener{
	/**
	 * 日志处理器
	 */
	protected Logger logger=LogManager.getLogger(GlobalEventListener.class);
	
	//事件及事件的处理器
	//private Map<String,EventHandler> handlers=new HashMap<String, EventHandler>();
	//更换为以下模式，可以防止Spring容器启动时，ProcessEngine尚未创建，而业务类中又使用了这个引用
	private Map<String,String> handlers=new HashMap<String, String>();
	
	@Override
	public void onEvent(ActivitiEvent event) {
		String eventType=event.getType().name();
		logger.debug("envent type is =========================>" + eventType);
		//根据事件的类型ID,找到对应的事件处理器
		String eventHandlerBeanId=handlers.get(eventType);
		if(eventHandlerBeanId==null) return;

		EventHandler handler=(EventHandler)WebAppUtil.getBean(eventHandlerBeanId);
		
//		try{
			handler.handle(event);
//		}catch(Exception e){
//			ProcessHandleHelper.getProcessMessage().addErrorMsg(e.getMessage());
//		}
		

	}

	@Override
	public boolean isFailOnException() {
		return false;
	}

	public Map<String, String> getHandlers() {
		return handlers;
	}

	public void setHandlers(Map<String, String> handlers) {
		this.handlers = handlers;
	}

	
}
