package com.redxun.bpm.activiti.cfg;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.impl.persistence.deploy.DeploymentCache;
import org.activiti.spring.SpringProcessEngineConfiguration;

public class SpringProcessEngineConfigurationExt extends SpringProcessEngineConfiguration{
	
	public SpringProcessEngineConfigurationExt() {
		super();
	}
	
	public SpringProcessEngineConfigurationExt setBpmnModelCache(DeploymentCache<BpmnModel> bpmnModelCache) {
		this.bpmnModelCache=bpmnModelCache;
		return this;
	}
}
