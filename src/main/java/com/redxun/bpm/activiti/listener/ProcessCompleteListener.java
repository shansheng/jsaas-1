package com.redxun.bpm.activiti.listener;

import java.util.Date;

import javax.annotation.Resource;

import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.impl.ActivitiEntityEventImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;

import com.redxun.bpm.activiti.event.ProcessEndedEvent;
import com.redxun.bpm.activiti.handler.ProcessEndHandler;
import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmInstUserManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.enums.ProcessEventType;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.bo.entity.SysBoEnt;

/**
 * 流程实例完成监听器，监控事件 PROCESS_COMPLETED
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessCompleteListener implements EventHandler{
	@Resource
	private BpmInstManager bpmInstManager;
	
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmInstDataManager bpmInstDataManager;
	@Resource
	BpmInstUserManager bpmInstUserManager ; 
	

	
	@Override
	public void handle(ActivitiEvent event)throws BpmRunException{
	
		String actInstId=event.getProcessInstanceId();
		BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
		bpmInst.setStatus(BpmInst.STATUS_SUCCESS_END);
		bpmInst.setEndTime(new Date());
		bpmInstManager.update(bpmInst);
		
		bpmInstUserManager.delByInstId(bpmInst.getInstId()); 
		
		ActivitiEntityEventImpl ev=(ActivitiEntityEventImpl)event;
		
		ExecutionEntity execution=(ExecutionEntity)ev.getEntity();
		
		String solId=(String) execution.getVariable("solId");
		//处理事件
		ProcessConfig processConfig=bpmNodeSetManager.getProcessConfig(solId,execution.getProcessDefinitionId());
		//执行后置处理器
		executeHandler( processConfig, bpmInst);
		//执行脚本
		EventUtil.executeScript(ev,processConfig,ProcessEventType.PROCESS_COMPLETED);
		
		//更新数据状态。
		bpmInstDataManager.updFormDataStatus(bpmInst.getInstId(), BpmInst.STATUS_SUCCESS_END);
		//流程结束时发布事件。
		WebAppUtil.publishEvent(new ProcessEndedEvent((ExecutionEntity)ev.getEntity()));
	}
	
	/**
	 * 执行后置处理器。
	 * @param processConfig
	 * @param bpmInst
	 */
	private  void executeHandler(ProcessConfig processConfig,BpmInst bpmInst){
		if(StringUtil.isEmpty(processConfig.getProcessEndHandle())) return;
		Object beanObj=AppBeanUtil.getBean(processConfig.getProcessEndHandle());
		if(!(beanObj instanceof ProcessEndHandler)) return;
		
		ProcessEndHandler handler=(ProcessEndHandler)beanObj;
		//回写业务键至流程引擎中
		handler.endHandle(bpmInst);
	}
	
	
	

}
