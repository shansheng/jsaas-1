package com.redxun.bpm.activiti.service.impl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateExecution;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.jms.BpmHttpCallMessage;
import com.redxun.bpm.activiti.service.IServiceTask;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.webreq.manager.SysWebReqDefManager;

public class HttpInvokeServiceTask implements IServiceTask {
	
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	SysWebReqDefManager sysWebReqDefManager;
	@Resource
	private IMessageProducer messageProducer;
	
	@Override
	public String getType() {
		
		return "HttpInvoke";
	}

	@Override
	public String getTitle() {
		return "HTTP请求服务调用";
	}

	@Override
	public void handle(JSONObject setting, DelegateExecution execution) {
		String script=setting.getString("script");
		String key=setting.getString("key");
		String paramsData=setting.getString("paramsData");
		String async=setting.getString("async");
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		Map<String,Object> params=new HashMap<>();
		params.put("bpmParam",execution.getVariables());
		Map<String,Object> map = JSONUtil.json2Map(cmd.getJsonData());
		if(BeanUtil.isNotEmpty(map)) {
			JSONArray ary = JSONArray.parseArray((map.get("bos").toString()));
			Map<String,Object> tmpMap = new HashMap<String,Object>();
			Iterator<Object> it = ary.iterator();
			while(it.hasNext()) {
				JSONObject obj = JSONObject.parseObject(it.next().toString());
				String json = obj.get("data").toString();
				tmpMap.putAll(JSONUtil.json2Map(json));
			}
			params.put("formParam",tmpMap);
		}
		params.put("actInstId",execution.getProcessInstanceId());
		params.put("cmd", cmd);
		//异步调用
		if("YES".equals(async)){
			BpmHttpCallMessage btcm = new BpmHttpCallMessage(cmd, setting.toJSONString(), params);
			messageProducer.send(btcm);
		}else{//同步调用
			JsonResult<String> jr = sysWebReqDefManager.executeStart(key, paramsData,params);
			if(StringUtil.isEmpty(script)) return;
			
			params.put("execution", execution);
			params.put("result", jr.getData());
			groovyEngine.executeScripts(script, params);
		}
	}

}
