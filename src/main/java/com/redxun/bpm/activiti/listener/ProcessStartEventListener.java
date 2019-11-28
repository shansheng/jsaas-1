package com.redxun.bpm.activiti.listener;

import javax.annotation.Resource;

import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.impl.ActivitiProcessStartedEventImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.enums.ProcessEventType;
/**
 * 流程实例启动时执行的事件监听
 * 
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn） 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessStartEventListener  implements EventHandler {
	
	protected Logger logger=LogManager.getLogger(ProcessStartEventListener.class);
	
	@Resource
	BpmNodeSetManager bpmNodeSetManager;

	@Override
	public void handle(ActivitiEvent event) throws BpmRunException {
		logger.debug("event listener is:" + event.getType());

		ActivitiProcessStartedEventImpl eventImpl = (ActivitiProcessStartedEventImpl) event;

		logger.debug("bpmInst subject:" + eventImpl.getProcessInstanceId());
		
		String solId = (String) eventImpl.getVariables().get("solId");
		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(solId,eventImpl.getProcessDefinitionId());
		
		// 执行流程实例完成的事件 
		EventUtil.executeScript(eventImpl,processConfig,ProcessEventType.PROCESS_STARTED);

	}
	
}
