package com.redxun.bpm.core.identity.service.impl;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;

/**
 * 脚本人员运算服务类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ScriptCalServiceImpl extends AbstractIdentityCalService{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 792168148685748347L;

	protected Logger logger=LogManager.getLogger(ScriptCalServiceImpl.class);
	
	@Resource
	GroovyEngine groovyEngine;
	
	@Resource
	UserService userService;
	
	@Resource
	GroupService groupService;
	

	
	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		
		Set<TaskExecutor> idList=new LinkedHashSet<TaskExecutor>();
		String jsonConfig=idCalConfig.getJsonConfig();
		JSONObject jsonObj=JSONObject.parseObject(jsonConfig);
		//取得运行的脚本
		String script=jsonObj.getString("script");
		
		if(StringUtil.isEmpty(script)) return idList;
		
		try{
			Object jsonResult=groovyEngine.executeScripts(script, idCalConfig.getVars());
			//若返回为集合
			if(jsonResult instanceof Collection){
				Collection  idInfos=(Collection )jsonResult;
				idList.addAll(idInfos);
			}
			
		}catch(Exception ex){
			logger.error(ex.getMessage());
			StringBuffer sb=new StringBuffer("脚本运行错误：");
			sb.append(script);
			sb.append("\n");
			sb.append("原因为:").append(ExceptionUtil.getExceptionMessage(ex));
			ProcessMessage processMessage=ProcessHandleHelper.getProcessMessage();
			if(processMessage!=null){
				processMessage.getErrorMsges().add(sb.toString());
			}
		}
		
		return idList;
	}

	
}
