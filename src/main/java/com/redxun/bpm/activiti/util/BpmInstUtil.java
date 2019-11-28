package com.redxun.bpm.activiti.util;

import com.redxun.bpm.activiti.service.StartProcessModel;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.util.AppBeanUtil;

public class BpmInstUtil {
	
	
	/**
	 * 通过队列启动流程。
	 * @param model
	 */
	public static void startFlow(StartProcessModel model){
		IMessageProducer producer=AppBeanUtil.getBean(IMessageProducer.class);
		producer.send("startFlowMessageQueue", model);
	}

}
