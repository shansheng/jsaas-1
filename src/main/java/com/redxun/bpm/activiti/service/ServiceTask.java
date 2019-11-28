package com.redxun.bpm.activiti.service;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;

/**
 * 流程服务任务。
 * @author ray
 *
 */
public class ServiceTask implements JavaDelegate {
	
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	ServiceTaskFactory serviceFactory;

	@Override
	public void execute(DelegateExecution execution) throws Exception {
		
		String nodeId=execution.getCurrentActivityId();
		String actDefId=execution.getProcessDefinitionId();
		String solId= (String) execution.getVariable("solId");
		
		BpmNodeSet nodeSet= bpmNodeSetManager.getBySolIdActDefIdNodeId(solId, actDefId, nodeId);
		if(BeanUtil.isEmpty(nodeSet)) return;
		
		String setting=nodeSet.getSettings();
		if(StringUtil.isEmpty(setting)) return;
		
		JSONObject json=JSONObject.parseObject(setting);
		String type=json.getString("type");
		if(StringUtil.isEmpty(type)) return;
		
		IServiceTask task= serviceFactory.getServiceTask(type);
		task.handle(json,execution);
	}

}
