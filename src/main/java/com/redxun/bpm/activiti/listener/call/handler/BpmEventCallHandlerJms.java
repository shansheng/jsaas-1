package com.redxun.bpm.activiti.listener.call.handler;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.activiti.listener.call.BpmEventCallHandler;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.util.StringUtil;

/**
 * 发送消息到队列。
 * @author ray
 *
 */
public class BpmEventCallHandlerJms extends AbstractBpmEventCallHandler{
	
	protected Logger logger=LogManager.getLogger(BpmEventCallHandlerJms.class);



	@Override
	public String getHandlerType() {
		return BpmEventCallHandler.HANDLER_TYPE_JMS;
	}

	@Override
	public void handle(BpmEventCallMessage callMessage) {
		Map<String, Object> map=callMessage.getVars();
		if(!map.containsKey("fromSys")){
			logger.debug("没有配置源系统!");
			return;
		}
		String fromSys=(String) map.get("fromSys");
		if(StringUtil.isEmpty(fromSys)) return ;
		//task,execution 对象不能序列化
		map.remove("task");
		map.remove("execution");
		
		
		IExecutionCmd cmd= callMessage.getExecutionCmd();
		cmd.cleanTasks();
		cmd.clearTransientVars();
		cmd.getBoDataMaps().clear();
		
		String json=JSONObject.toJSONString(callMessage);
		
		logger.debug("发送消息队列到:" + fromSys);
		logger.debug(json);
		//发送到队列。
		MessageUtil.getProducer().send(fromSys, json);
		
	}

}
