package com.redxun.bpm.core.manager.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.dao.BpmJumpRuleDao;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmJumpRule;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.IJumpRuleService;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;

@Service
public class JumpRuleService implements IJumpRuleService {
	
	@Resource
	BpmJumpRuleDao bpmJumpRuleDao;
	@Resource
	RuntimeService runtimeService;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	BpmSolutionManager bpmSolutionManager;

	@Override
	public String getTargetNode(BpmInst bpmInst, String nodeId) {
		List<BpmJumpRule> jumpRules= bpmJumpRuleDao.getBySolNodeId(bpmInst.getSolId(),bpmInst.getActDefId(),nodeId);
		if(BeanUtil.isEmpty(jumpRules)) return "";
		ProcessNextCmd cmd=(ProcessNextCmd)ProcessHandleHelper.getProcessCmd();
		Map<String,Object> model=new HashMap<String,Object>();
		Map<String,Object> vars=runtimeService.getVariables(bpmInst.getActInstId());
		String json=cmd.getJsonData();
		if(StringUtil.isNotEmpty(json)){
			JSONObject jsonData=JSONObject.parseObject(json);
			model.put("json", jsonData);
		}
		if(BeanUtil.isNotEmpty(cmd)) {
			//获取表单数据
			BpmSolution bpmSolution = bpmSolutionManager.get(bpmInst.getSolId());
			JSONObject data = JSONObject.parseObject(cmd.getJsonData());
			Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsonsBoIds(data,bpmSolution.getBoDefId());
			vars.put("jsonData", modelFieldMap);
			vars.putAll(cmd.getVars());
		}
		model.put("vars", vars);
		model.put("cmd", cmd);
		
		for(BpmJumpRule rule:jumpRules){
			String script=rule.getRule();
			Boolean rtn= (Boolean) groovyEngine.executeScripts(script, model);
			if(rtn) return rule.getTarget();
		}
		
		return "";
	}

}
