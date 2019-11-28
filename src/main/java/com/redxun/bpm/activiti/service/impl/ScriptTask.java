package com.redxun.bpm.activiti.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateExecution;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.service.IServiceTask;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.StringUtil;

public class ScriptTask implements IServiceTask {
	
	@Resource
	GroovyEngine groovyEngine;

	@Override
	public String getType() {
		return "Script";
	}

	@Override
	public String getTitle() {
		return "脚本任务";
	}

	/**
	 * 脚本任务
	 * setting:
	 * {type:"script",script:""}
	 */
	@Override
	public void handle(JSONObject setting, DelegateExecution execution) {
		String script=setting.getString("script");
		if(StringUtil.isEmpty(script)) return;
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		Map<String,Object> params=new HashMap<>();
		params.put("execution", execution);
		params.putAll(execution.getVariables());
		
		params.put("cmd", cmd);
		groovyEngine.executeScripts(script, params);
	}

	

}
