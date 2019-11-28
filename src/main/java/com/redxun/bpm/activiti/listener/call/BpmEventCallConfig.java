package com.redxun.bpm.activiti.listener.call;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.impl.ActivitiEntityEventImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;

import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.core.entity.BpmExecution;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.enums.TaskEventType;
import com.redxun.core.jms.IMessageProducer;

/**
 * 流程事件调用统一配置入口
 * @author mansan
 *
 */
public class BpmEventCallConfig  {
	
	@Resource
	RuntimeService runtimeService;
	
	private Map<String,BpmEventCallHandler> handlerMap=new HashMap<String,BpmEventCallHandler>();
	
	@Resource
	private IMessageProducer messageProducer;
	
	public void setHandlers(List<BpmEventCallHandler> handlers) {
		for(BpmEventCallHandler handler:handlers){
			handlerMap.put(handler.getHandlerType(), handler);
		}
	}
	
	/**
	 * 处理事件的外部调用
	 * @param executionCmd
	 * @param bpmEventCallSetting
	 * @param activitiEvent
	 */
	public void handleEventCall(IExecutionCmd executionCmd,BpmEventCallSetting bpmEventCallSetting,
			BpmExecution execution,Map<String,Object>vars,String eventType){
		
		BpmEventCallMessage callMessage=getCallMessage(executionCmd,bpmEventCallSetting,execution,eventType,vars);
		try{
			//异步调用
			if("YES".equals(bpmEventCallSetting.getAsync())){
				//放置BpmEventCallMessageHandler
				messageProducer.send(callMessage);
			}else{//同步调用
				handleBpmEventCallMessage(callMessage);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException("执行节点上("+callMessage.getNodeId()+")执行配置出现异常:"+e.getMessage());
		}
	}
	
	/**
	 * 处理事件的外部调用
	 * @param executionCmd
	 * @param bpmEventCallSetting
	 * @param activitiEvent
	 */
	public void handleEventCall(IExecutionCmd executionCmd,BpmEventCallSetting bpmEventCallSetting,ActivitiEvent activitiEvent){
		
		BpmEventCallMessage callMessage=getCallMessage(executionCmd,bpmEventCallSetting,activitiEvent);
		try{
			//异步调用
			if("YES".equals(bpmEventCallSetting.getAsync())){//放置BpmEventCallMessageHandler
				messageProducer.send(callMessage);
			}else{//同步调用
				handleBpmEventCallMessage(callMessage);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException("执行节点上("+callMessage.getNodeId()+")执行配置出现异常:"+e.getMessage());
		}
	}
	
	public void handleEventCall(IExecutionCmd executionCmd,BpmEventCallSetting bpmEventCallSetting,ActivityExecution execution){
		
		BpmEventCallMessage callMessage=getCallMessage(executionCmd,bpmEventCallSetting,execution);
		try{
			//异步调用
			if("YES".equals(bpmEventCallSetting.getAsync())){//放置BpmEventCallMessageHandler
				messageProducer.send(callMessage);
			}else{//同步调用
				handleBpmEventCallMessage(callMessage);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException("执行节点上("+callMessage.getNodeId()+")执行配置出现异常:"+e.getMessage());
		}
	}
	
	protected Map<String, Object> getRunVariables(ActivitiEvent activitiEvent) {
		Map<String, Object> vars = null;
		if (activitiEvent instanceof ActivitiEntityEventImpl) {
			ActivitiEntityEventImpl eventImpl = (ActivitiEntityEventImpl) activitiEvent;

			if (eventImpl.getEntity() != null && eventImpl.getEntity() instanceof TaskEntity) {
				TaskEntity entity = (TaskEntity) eventImpl.getEntity();
				vars = entity.getVariables();
				vars.put("activityId", entity.getTaskDefinitionKey());
				vars.put("task", entity);

			} else {
				ExecutionEntity entity = (ExecutionEntity) eventImpl.getEntity();
				vars = entity.getVariables();
				vars.put("activityId", entity.getActivityId());
				vars.put("execution", entity);
			}
		} else {
			vars = runtimeService.getVariables(activitiEvent.getExecutionId());
		}
		return vars;
	}
	
	protected Map<String, Object> getRunVariables(ActivityExecution execution) {
		Map<String, Object> vars  = execution.getVariables();
		vars.put("activityId", execution.getCurrentActivityId());
		vars.put("execution", execution);
		
		return vars;
	}
	
	private BpmEventCallMessage getCallMessage(IExecutionCmd executionCmd,BpmEventCallSetting bpmEventCallSetting,
			BpmExecution bpmExecution,String eventType,Map<String,Object>vars){

		BpmEventCallMessage callMessage=null;

		//是否异步调用
		if("YES".equals(bpmEventCallSetting.getAsync())){
			 vars.remove("task");
			 vars.remove("execution");
		}
		callMessage=new BpmEventCallMessage(executionCmd,bpmEventCallSetting,vars);
		
		callMessage.setExecutionId(bpmExecution.getId());
		callMessage.setActInstId(bpmExecution.getProcessInstanceId());
		callMessage.setNodeId(bpmExecution.getActivityId());
		callMessage.setType(eventType);
		callMessage.setActDefId(bpmExecution.getProcessDefinitionId());
		
		return callMessage;
	}

	/**
	 * 获取调用消息。
	 * @param executionCmd
	 * @param bpmEventCallSetting
	 * @param activitiEvent
	 * @return
	 */
	private BpmEventCallMessage getCallMessage(IExecutionCmd executionCmd,BpmEventCallSetting bpmEventCallSetting,ActivitiEvent activitiEvent){
		//需要优先取得当前变量，以使得异步还可以使用该 变量
		Map<String,Object> vars=getRunVariables(activitiEvent);
		
		//是否异步调用
		if("YES".equals(bpmEventCallSetting.getAsync())){
			vars.remove("task");
			vars.remove("execution");
		}
		BpmEventCallMessage callMessage=new BpmEventCallMessage(executionCmd,bpmEventCallSetting,vars);
		callMessage.setExecutionId(activitiEvent.getExecutionId());
		callMessage.setActInstId(activitiEvent.getProcessInstanceId());
		callMessage.setType(activitiEvent.getType().name());
		callMessage.setActDefId(activitiEvent.getProcessDefinitionId());
		
		//设置节点ID
		if(activitiEvent instanceof ActivitiEntityEventImpl){
			ActivitiEntityEventImpl eventImpl=(ActivitiEntityEventImpl)activitiEvent;
			Object ent= eventImpl.getEntity();
			if(ent!=null ){
				if(ent instanceof TaskEntity){
					TaskEntity taskEnt=(TaskEntity) ent;
					callMessage.setTaskId(taskEnt.getId());
					callMessage.setNodeId(taskEnt.getTaskDefinitionKey());
					callMessage.setNodeName(taskEnt.getName());
				}
				else{
					ExecutionEntity entity= (ExecutionEntity) ent;
					callMessage.setNodeId(entity.getActivityId());
					callMessage.setNodeName(entity.getName());
				}
			}
		}
		
		return callMessage;
	}
	
	private BpmEventCallMessage getCallMessage(IExecutionCmd executionCmd,BpmEventCallSetting bpmEventCallSetting,ActivityExecution execution){
		//需要优先取得当前变量，以使得异步还可以使用该 变量
		Map<String,Object> vars=getRunVariables(execution);
		
		//是否异步调用
		if("YES".equals(bpmEventCallSetting.getAsync())){
			vars.remove("execution");
		}
		BpmEventCallMessage callMessage=new BpmEventCallMessage(executionCmd,bpmEventCallSetting,vars);
		callMessage.setExecutionId(execution.getId());
		callMessage.setActInstId(execution.getProcessInstanceId());
		callMessage.setType(TaskEventType.SIGN_COMPLETED.name());
		callMessage.setActDefId(execution.getProcessDefinitionId());
		callMessage.setNodeId(execution.getCurrentActivityId());
		callMessage.setNodeName(execution.getCurrentActivityName());
		return callMessage;
	}
	
	/**
	 * 处理流程事件的外部的调用
	 * @param bpmEventCallMessage
	 */
	public void handleBpmEventCallMessage(BpmEventCallMessage bpmEventCallMessage){
		BpmEventCallHandler handler=handlerMap.get(bpmEventCallMessage.getBpmEventCallSetting().getCallType());
		if(handler==null) return;
		try{
			handler.handle(bpmEventCallMessage);
		}catch(Exception e){
			e.printStackTrace();
			throw new BpmRunException("流程事件("+bpmEventCallMessage.getType()+")触发调用有异常："+e.getMessage());
		}
	}

}
