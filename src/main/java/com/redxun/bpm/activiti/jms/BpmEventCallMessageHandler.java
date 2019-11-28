package com.redxun.bpm.activiti.jms;

import javax.annotation.Resource;

import com.redxun.bpm.activiti.listener.call.BpmEventCallConfig;
import com.redxun.core.jms.IMessageHandler;

/**
 * 处理流程事件外部调用的异步调用
 * @author mansan
 *
 */
public class BpmEventCallMessageHandler implements IMessageHandler{
	@Resource
	BpmEventCallConfig bpmEventCallConfig;
	
	@Override
	public void handMessage(Object messageObj) {
		BpmEventCallMessage bpmEventCallMessage=(BpmEventCallMessage)messageObj;
		if(bpmEventCallMessage!=null){
			try{
				bpmEventCallConfig.handleBpmEventCallMessage(bpmEventCallMessage);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
}
