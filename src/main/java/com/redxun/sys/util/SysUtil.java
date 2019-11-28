package com.redxun.sys.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.jms.MessageModel;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.api.ContextHandlerFactory;

public class SysUtil {
	
	/**
	 * 发送消息。
	 * @param model
	 */
	public static void sendMessage(MessageModel model){
		String type=model.getType();
		if(StringUtil.isEmpty(type)) return;
		IMessageProducer producer= MessageUtil.getProducer();
		producer.send(model);
	}

	
	/**
	 * 替换常量。
	 * @param sql
	 * @return
	 */
	public static String replaceConstant(String str){
		ContextHandlerFactory contextHandlerFactory=AppBeanUtil.getBean(ContextHandlerFactory.class);
		String patten="\\[[a-z0-9A-Z-_\\.]*?\\]";
		Pattern p=Pattern.compile(patten, Pattern.CASE_INSENSITIVE);
		Matcher m= p.matcher(str);
		while(m.find()){
			String val=(String) contextHandlerFactory.getValByKey(m.group(0),new HashMap<String, Object>());
			if(val==null) continue;
			str=str.replace(m.group(0), (String)contextHandlerFactory.getValByKey(m.group(0),new HashMap<String, Object>()));
		}
		return str;
	}
	
	/**
	 * 替换常量并且使用freemaker 进行替换。
	 * @param script
	 * @param vars
	 * @return
	 */
	public static String parseScript(String script,Map<String,Object> vars){
		FreemarkEngine freemarkEngine=AppBeanUtil.getBean(FreemarkEngine.class);
		script=replaceConstant(script);
		//使用freemark解析。
		try {
			script="<#setting number_format=\"#\">"+script;
			script = freemarkEngine.parseByStringTemplate(vars, script);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return script;
	}
	
}
