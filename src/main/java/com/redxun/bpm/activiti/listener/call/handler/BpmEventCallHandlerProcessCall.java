package com.redxun.bpm.activiti.listener.call.handler;

import org.apache.commons.lang3.StringUtils;

import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.activiti.listener.call.BpmEventCallHandler;
import com.redxun.bpm.activiti.listener.call.BpmEventCallSetting;
import com.redxun.bpm.activiti.listener.call.ProcessCall;
import com.redxun.core.util.AppBeanUtil;

public class BpmEventCallHandlerProcessCall extends AbstractBpmEventCallHandler{

	@Override
	public void handle(BpmEventCallMessage callMessage){
		BpmEventCallSetting eventSetting= callMessage.getBpmEventCallSetting();
		String script=eventSetting.getScript();
		logger.debug("===============enter BpmEventCallHandlerProcessCall handle method===============");
		if(StringUtils.isEmpty(script)) return;
		ProcessCall processCall=(ProcessCall)AppBeanUtil.getBean(eventSetting.getScript());
		if(processCall!=null){
			processCall.process(callMessage);
		}
	}

	@Override
	public String getHandlerType() {
		return BpmEventCallHandler.HANDLER_TYPE_PROCESSCALL;
	}
}
