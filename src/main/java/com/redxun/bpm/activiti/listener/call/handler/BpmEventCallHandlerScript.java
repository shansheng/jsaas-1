package com.redxun.bpm.activiti.listener.call.handler;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.activiti.listener.call.BpmEventCallHandler;
import com.redxun.bpm.activiti.listener.call.BpmEventCallSetting;
import com.redxun.core.script.GroovyEngine;
import com.redxun.sys.util.SysUtil;
/**
 * 流程事件配置，动态执行脚本
 * @author mansan
 *
 */
public class BpmEventCallHandlerScript extends AbstractBpmEventCallHandler{
	@Resource
	GroovyEngine groovyEngine;
	
	@Override
	public void handle(BpmEventCallMessage callMessage){
		BpmEventCallSetting eventSetting= callMessage.getBpmEventCallSetting();
		logger.debug("===============enter BpmEventCallHandlerScript handle method=============== ");
		String script=eventSetting.getScript();
		if(StringUtils.isEmpty(script)) return;
		logger.debug("===============execute groovy script=============== " +script);

		Map<String,Object> vars=getVariables(callMessage);
		script=SysUtil.parseScript(script, vars);
		groovyEngine.executeScripts(script, vars);
	}

	@Override
	public String getHandlerType() {
		return BpmEventCallHandler.HANDLER_TYPE_SCRIPT;
	}

}
