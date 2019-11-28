package com.redxun.bpm.bm.service;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.junit.Test;

import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmExecutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.test.BaseTestCase;

public class BpmExecutionManagerTest  extends BaseTestCase{
	
	@Resource
	BpmExecutionManager bpmExecutionManager;
	@Resource
	RuntimeService runtimeService;
	@Resource
	BpmTaskManager bpmTaskManager;
	
	
	//@Test
	public void getByProcInstId(){
		/*BpmExecution exe= bpmExecutionManager.getByProcInstId("240000002478022");
		System.out.println("ok");*/
	}
	
	//@Test
	public void delActRelationByProcInstId(){
//		System.out.println("start------------------------");
//		BpmExecution exe= bpmExecutionManager.getByProcInstId("240000002478022");
//		bpmExecutionManager.delActRelationByExecution(exe);
//		System.out.println("end------------------------");
//		System.out.println("ok");
	}
	
	
	//@Test
	public void getVariable(){
//		System.out.println("start------------------------");
//		BpmExecution exe= bpmExecutionManager.getByProcInstId("240000002478022");
//		bpmExecutionManager.delActRelationByExecution(exe);
//		System.out.println("end------------------------");
//		System.out.println("ok");
		String start= (String) runtimeService.getVariable("240000002478022", "startUserId");
		System.out.println(start);
	}
	
	
	//@Test
	public void rejectFromInset(){
		String taskId="2410000001830034";
		
		BpmTask task= bpmTaskManager.get(taskId);
		
//		bpmExecutionManager.handFromInset(task);
	}
	
	//@Test
	public void rejectFromOutset(){
		String taskId="2410000002000120";
		
		BpmTask task= bpmTaskManager.get(taskId);
		
//		bpmExecutionManager.handFromOutset(task);
	}
	
	@Test
	public void getPreTaskNode(){
//		ActNodeDef def= bpmExecutionManager.getPreTask("2410000002560005", "gateway1");
//		System.out.println(def.getNodeId());
	}

}
