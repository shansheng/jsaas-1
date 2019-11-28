package com.redxun.bpm.core.identity.service.impl;

import java.util.LinkedHashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;



public class UserCalcUtil {
	
	/**
	 * 从启动配置的节点人员变量中取
	 * @param vars
	 * @param nodeId
	 * @return
	 */
	public static Set<TaskExecutor> getFromStartVars(String nodeUserIds,String nodeId){
		UserService userService=AppBeanUtil.getBean(UserService.class);
		Set<TaskExecutor> infos=new LinkedHashSet<TaskExecutor>();
		
		if(StringUtils.isEmpty(nodeUserIds)) return infos;
		
		try{
			JSONArray nodeUserArr=JSONArray.parseArray(nodeUserIds);
			for(int i=0;i<nodeUserArr.size();i++){
				JSONObject obj=nodeUserArr.getJSONObject(i);
				String tNodeId=(String)obj.getString("nodeId");
				if(!nodeId.equals(tNodeId)) continue;

				String userIds=(String)obj.getString("userIds");
				if(StringUtils.isEmpty(userIds)) break;
				
				String[]uIds=userIds.split("[,]");
				for(String uId:uIds){
					IUser osUser=userService.getByUserId(uId);
					TaskExecutor executor=new TaskExecutor(osUser.getUserId(), osUser.getFullname());
					infos.add(executor);
				}
				break;
					
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return infos;
	}

}
