package com.redxun.bpm.activiti.listener;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.impl.ActivitiActivityEventImpl;
import org.activiti.engine.delegate.event.impl.ActivitiEntityEventImpl;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.listener.call.BpmEventCallConfig;
import com.redxun.bpm.activiti.listener.call.BpmEventCallSetting;
import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.activiti.listener.call.handler.AbstractBpmEventCallHandler;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmExecution;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.config.ActivityConfig;
import com.redxun.bpm.core.entity.config.BpmEventConfig;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.enums.ProcessEventType;
import com.redxun.bpm.enums.TaskEventType;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
/**
 * 流程事件执行处理工具类
 * @author think
 *
 */
public class EventUtil {

	protected Logger logger=LogManager.getLogger(AbstractBpmEventCallHandler.class);
	
	/**
	 * 启动或结束时执行脚本。
	 * @param eventImpl
	 * @param processConfig
	 * @param eventType
	 */
	@SuppressWarnings("unchecked")
	public static void executeScript(ActivitiEntityEventImpl eventImpl,ProcessConfig processConfig,ProcessEventType eventType)throws BpmRunException{
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		BpmEventConfig bpmEventConfig= getEventConfig( processConfig, eventType);
		if(bpmEventConfig==null || StringUtil.isEmpty(bpmEventConfig.getScript()) ) return;
		//按新的配置执行
		if(!bpmEventConfig.getScript().startsWith("[")) return;
		
		BpmEventCallConfig bpmEventCallConfig=AppBeanUtil.getBean(BpmEventCallConfig.class);
		List<BpmEventCallSetting> eventCallSettins=JSONArray.parseArray(bpmEventConfig.getScript(), BpmEventCallSetting.class);
		for(BpmEventCallSetting setting:eventCallSettins){
			if(StringUtil.isEmpty(setting.getCallType())) continue;
			//若不为空，则判断是否满足条件
			if(StringUtils.isEmpty(setting.getJumpType())//若不设置跳转条件则表示满足可执行
					|| setting.getJumpType().indexOf(cmd.getJumpType())>-1){//若设置跳转条件不为空，并且当前设置的条件与审批的动作相同
					bpmEventCallConfig.handleEventCall(cmd,setting,eventImpl);
			}
		}
	}
	
	/**
	 * 执行任务处理脚本。
	 * @param taskEntity
	 * @param userTaskConfig
	 * @param eventType
	 */
	public static void executeTaskScript(TaskEntity taskEntity, UserTaskConfig userTaskConfig, TaskEventType eventType,ActivitiEvent event ){
		if(userTaskConfig==null ) return; 
		// 处理事件
		if(userTaskConfig.getEvents().size()==0) return;
		BpmEventConfig bpmEventConfig = getEventConfig(eventType.name(), userTaskConfig.getEvents());
		if(bpmEventConfig==null || StringUtil.isEmpty(bpmEventConfig.getScript())) return;
		//按新的配置执行
		if(!bpmEventConfig.getScript().startsWith("[")) return;
		//加入表单属必变量
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		BpmEventCallConfig bpmEventCallConfig=AppBeanUtil.getBean(BpmEventCallConfig.class);
		List<BpmEventCallSetting> eventCallSettins=JSONArray.parseArray(bpmEventConfig.getScript(), BpmEventCallSetting.class);
		for(BpmEventCallSetting setting:eventCallSettins){
			if(StringUtil.isEmpty(setting.getCallType())){
				continue;
			}
			String jumpType= setting.getJumpType();
			if(StringUtils.isEmpty(jumpType)//若不设置跳转条件则表示满足可执行
					|| jumpType.indexOf(cmd.getJumpType())>-1){//若设置跳转条件不为空，并且当前设置的条件与审批的动作相同
					bpmEventCallConfig.handleEventCall(cmd,setting,event);
			}
		}
	}
	
	
	
	/**
	 * 执行全局脚本。
	 * @param taskEntity
	 * @param obj
	 * @param isStart
	 * @param eventType
	 * @param event
	 */
	public static void executeGlobalScript(TaskEntity taskEntity, String json,boolean isStart,ActivitiEvent event ){
		String key=isStart?"startIds":"endIds";
		JSONObject obj=JSONObject.parseObject(json);
		if(obj==null || !obj.containsKey(key)) return;
		String nodeId=taskEntity.getTaskDefinitionKey();
		String nodes=obj.getString(key);
		String[] nodeAry=nodes.split(",");
		List<String> list= Arrays.asList(nodeAry);
		if(!list.contains(nodeId)) return;
		
		String eventKey=isStart?"startEvent":"endEvent";
		
		String settings=obj.getString(eventKey);
		//加入表单属必变量
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		BpmEventCallConfig bpmEventCallConfig=AppBeanUtil.getBean(BpmEventCallConfig.class);
		List<BpmEventCallSetting> eventCallSettins=JSONArray.parseArray(settings, BpmEventCallSetting.class);
		for(BpmEventCallSetting setting:eventCallSettins){
			if(StringUtil.isEmpty(setting.getCallType())){
				continue;
			}
			String jumpType= setting.getJumpType(); 
			if(StringUtils.isEmpty(jumpType)//若不设置跳转条件则表示满足可执行
					|| jumpType.indexOf(cmd.getJumpType())>-1){//若设置跳转条件不为空，并且当前设置的条件与审批的动作相同
					bpmEventCallConfig.handleEventCall(cmd,setting,event);
			}
		}
	}
	
	/**
	 * 获得流程级别的事件配置
	 * @param processConfig
	 * @param eventType
	 * @return
	 */
	private static BpmEventConfig getEventConfig(ProcessConfig processConfig, ProcessEventType eventType){
		if(BeanUtil.isEmpty(processConfig)) return null;
		if(BeanUtil.isEmpty(processConfig.getEvents())) return null;
		BpmEventConfig bpmEventConfig = null;
		for (BpmEventConfig eventConfig : processConfig.getEvents()) {
			if (eventType.name().equals(eventConfig.getEventKey())) {
				bpmEventConfig = eventConfig;
				break;
			}
		}
		return bpmEventConfig;
	}
	
	
	
	/**
	 * 执行脚本事件
	 * @param eventImpl
	 * @param eventType
	 */
	public static void executeEventScript(BpmExecution eventImpl, TaskEventType eventType){
		RuntimeService runtimeService=AppBeanUtil.getBean(RuntimeService.class);
		BpmNodeSetManager bpmNodeSetManager=AppBeanUtil.getBean(BpmNodeSetManager.class);
		
		String solId=(String)runtimeService.getVariable(eventImpl.getProcessInstanceId(), "solId");
		//处理事件
		UserTaskConfig userTaskConfig = bpmNodeSetManager.getTaskConfig(solId,eventImpl.getProcessDefinitionId(),eventImpl.getActivityId());

		if(userTaskConfig==null || userTaskConfig.getEvents()==null 
				|| userTaskConfig.getEvents().size()==0) return; 
		
		BpmEventConfig bpmEventConfig = getEventConfig(eventType.name(), userTaskConfig.getEvents());
		if(bpmEventConfig==null || StringUtils.isEmpty(bpmEventConfig.getScript())) return;
		if(!bpmEventConfig.getScript().startsWith("[")) return;
		
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		Map<String,Object> vars=runtimeService.getVariables(eventImpl.getId());
		vars.put("executionId",eventImpl.getId());
		if(cmd!=null) {
			vars.putAll(BoDataUtil.getModelFieldsFromBoJsons(cmd.getJsonDataObject()));
			vars.put("jumpType",cmd.getJumpType());
			vars.put("opinion", cmd.getOpinion());
			vars.put("jsonData", cmd.getJsonData());
		}
		BpmEventCallConfig bpmEventCallConfig=AppBeanUtil.getBean(BpmEventCallConfig.class);
		//按新的配置执行
		List<BpmEventCallSetting> eventCallSettins=JSONArray.parseArray(bpmEventConfig.getScript(), BpmEventCallSetting.class);
		for(BpmEventCallSetting setting:eventCallSettins){
			if(StringUtil.isEmpty(setting.getCallType())){
				continue;
			}
			if(StringUtils.isEmpty(setting.getJumpType())//若不设置跳转条件则表示满足可执行
				|| setting.getJumpType().equalsIgnoreCase(cmd.getJumpType())){//若设置跳转条件不为空，并且当前设置的条件与审批的动作相同
				bpmEventCallConfig.handleEventCall(cmd,setting,eventImpl,vars,eventType.name());
			}
		}
	}

	private static BpmEventConfig getEventConfig(String eventName, List<BpmEventConfig> events) {
		BpmEventConfig bpmEventConfig = null;
		for (BpmEventConfig eventConfig : events) {
			if (eventName.equals(eventConfig.getEventKey())) {
				bpmEventConfig = eventConfig;
				break;
			}
		}
		return bpmEventConfig;
	}
	
	/**
	 * 当会签完成时执行事件。
	 * @param execution
	 * @param userTaskConfig
	 */
	public static void executeSignScript( ActivityExecution execution, UserTaskConfig userTaskConfig ){
		if(userTaskConfig==null ) return; 
		// 处理事件
		if(userTaskConfig.getEvents().size()==0) return;
		BpmEventConfig bpmEventConfig = getEventConfig(TaskEventType.SIGN_COMPLETED.name(), userTaskConfig.getEvents());
		if(bpmEventConfig==null || StringUtil.isEmpty(bpmEventConfig.getScript())) return;
		//按新的配置执行
		if(!bpmEventConfig.getScript().startsWith("[")) return;
		//加入表单属必变量
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		BpmEventCallConfig bpmEventCallConfig=AppBeanUtil.getBean(BpmEventCallConfig.class);
		List<BpmEventCallSetting> eventCallSettins=JSONArray.parseArray(bpmEventConfig.getScript(), BpmEventCallSetting.class);
		for(BpmEventCallSetting setting:eventCallSettins){
			if(StringUtil.isEmpty(setting.getCallType())){
				continue;
			}
			String jumpType= setting.getJumpType();
			if(StringUtils.isEmpty(jumpType)//若不设置跳转条件则表示满足可执行
					|| jumpType.indexOf(cmd.getJumpType())>-1){//若设置跳转条件不为空，并且当前设置的条件与审批的动作相同
					bpmEventCallConfig.handleEventCall(cmd,setting,execution);
			}
		}
	}
}
