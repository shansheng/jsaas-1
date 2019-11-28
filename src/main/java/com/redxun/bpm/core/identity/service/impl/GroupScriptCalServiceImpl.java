package com.redxun.bpm.core.identity.service.impl;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.parser.Feature;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;

/**
 * 人员脚本运算服务类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class GroupScriptCalServiceImpl extends AbstractIdentityCalService{
	
	protected Logger logger=LogManager.getLogger(GroupScriptCalServiceImpl.class);
	
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
		LinkedHashMap<String, Object> map= JSON.parseObject(jsonConfig,new TypeReference<LinkedHashMap<String, Object>>(){}, Feature.OrderedField);
		//取得运行的脚本
		String script=(String) map.get("script");
		JSONObject jsonObject=(JSONObject) map.get("param");
		String className=(String) map.get("className");
		String totalScript=className+"."+script+joinScript(jsonObject);
		if(StringUtil.isEmpty(script)) return idList;
		
		try{
			Object jsonResult=groovyEngine.executeScripts(totalScript, idCalConfig.getVars());
			//若返回为集合
			if(jsonResult instanceof Collection){
				Collection  idInfos=(Collection)jsonResult;
				for (Object object : idInfos) {
					if(object instanceof IGroup){//返回值为用户组
						IGroup group=(IGroup)object;
						idList.add(TaskExecutor.getGroupExecutor(group));
					}else if(object instanceof IUser){//返回值为用户
						idList.add(TaskExecutor.getUserExecutor((IUser)object));
					}
				}
				//idList.addAll(idInfos);
			}else if(jsonResult instanceof IGroup){//返回值为用户组
				IGroup group=(IGroup)jsonResult;
				idList.add(TaskExecutor.getGroupExecutor(group));
			}else if(jsonResult instanceof IUser){//返回值为用户
				idList.add(TaskExecutor.getUserExecutor((IUser)jsonResult));
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
	
	
	/**
	 * 拼接json
	 * @param jsonObject
	 * @return
	 */
	public String joinScript(JSONObject jsonObject){
		StringBuilder stringBuilder=new StringBuilder("(");
		Set<String> set=jsonObject.keySet();
		int i=0;
		for (String string : set) {
			if(i>0){
				stringBuilder.append(",");
			}
			JSONObject object= (JSONObject) jsonObject.get(string);
			String paramType= object.getString("paramType");
			String paramValue= object.getString("paramValue");
			String paramCombox= object.getString("paramCombox");
			
			if("java.lang.String".equals(paramType) || "variable".equals(paramCombox)){
				stringBuilder.append("\"");
				stringBuilder.append(paramValue);
				stringBuilder.append("\"");
				
			}else{
				stringBuilder.append(paramValue);
			}
			i++;
		}
		stringBuilder.append(");");
		String totalScript=stringBuilder.toString();
		return totalScript;
	}
	
	public static void main(String[] args) {
		String str="{name:\"A\",address:\"B\",tel:\"C\",user:{name:\"A\",address:\"B\"}}";
		LinkedHashMap<String, Object> map= JSON.parseObject(str,new TypeReference<LinkedHashMap<String, Object>>(){}, Feature.OrderedField);
		
		Set<String> set=map.keySet();
		for (String key : set) {
			System.out.println(key);
			if(key.equals("user")){
				Object user=map.get("user");
				System.out.println("ok");
			}
		}
	}


	
}
