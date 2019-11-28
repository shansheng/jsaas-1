package com.redxun.bpm.activiti.service;

import javax.annotation.Resource;

import com.redxun.core.jms.IMessageHandler;

public class StartProcessHandler implements IMessageHandler {

	@Resource
	ActInstService actInstService;  
	
	@Override
	public void handMessage(Object messageObj) {
		if(!(messageObj instanceof StartProcessModel)) return;
		
		StartProcessModel model=(StartProcessModel)messageObj;
		actInstService.startProcess(model);
	}

}
