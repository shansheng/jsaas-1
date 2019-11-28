package com.redxun.bpm.activiti.listener.call.handler;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.activiti.listener.call.BpmEventCallHandler;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.core.json.FastjsonUtil;
/**
 * 事件调用处理器抽象类
 * @author mansan
 *
 */
public abstract class AbstractBpmEventCallHandler implements BpmEventCallHandler{
	
	protected Logger logger=LogManager.getLogger(AbstractBpmEventCallHandler.class);
	

	
	/**
	 * 根据BpmEventCallMessage 获取流程变量。
	 * @param callMessage
	 * @return
	 */
	protected Map<String,Object> getVariables(BpmEventCallMessage callMessage){
		Map<String,Object> vars=getRunVariables(callMessage);
		vars.put("variables", vars);
		vars.put("cmd",callMessage.getExecutionCmd());
		return vars;
	} 
	
	
	@SuppressWarnings("unchecked")
	protected Map<String,Object> getRunVariables(BpmEventCallMessage eventCallMessage){
		
		Map<String,Object> vars=eventCallMessage.getVars();
		
		IExecutionCmd cmd= eventCallMessage.getExecutionCmd();
		String actInstId=eventCallMessage.getActInstId();
		String executionId=eventCallMessage.getExecutionId();
		String actDefId=eventCallMessage.getActDefId();
		String activityId=eventCallMessage.getNodeId();
		
//		Map<String,Object> vars=runtimeService.getVariables(actInstId);
		
		if(cmd!=null) {
			vars.putAll(FastjsonUtil.mapJson2MapProperties(cmd.getBoDataMaps()));
		}
		
		vars.put("processInstanceId",actInstId);
		vars.put("executionId",executionId);
		vars.put("processDefinitionId",actDefId);
		vars.put("activityId",activityId);
		
		return vars;
	}
}
