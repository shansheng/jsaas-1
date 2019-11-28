package com.redxun.bpm.core.identity.service.impl;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;

import net.sf.json.JSONObject;

/**
 * 用户计算来自流程变量
 * @author mansan
 * jsonConfig 格式:
 * {
 *   varKey:'userId',
 *   varType:'user' or 'org'
 *   varText:''
 * }
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class VarCalServiceImpl extends AbstractIdentityCalService{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5431079422095187201L;
	
	@Resource
	UserService userService;
	@Resource
	GroupService groupService; 
	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		Set<TaskExecutor> idList=new LinkedHashSet<TaskExecutor>();
		if(StringUtils.isEmpty(idCalConfig.getJsonConfig())){
			return idList;
		}
		JSONObject configObj=JSONObject.fromObject(idCalConfig.getJsonConfig());
		
		if(configObj.get("varKey")==null || configObj.get("varType")==null) return idList;
		
		String varKey=configObj.getString("varKey");
		String userType=configObj.getString("varType");
		
		if(StringUtils.isEmpty(varKey)) return idList;
		
		String idVals=(String)idCalConfig.getVars().get(varKey);
		
		if(StringUtils.isEmpty(idVals)) return idList;
		
		//是否计算用户
		String[] uIds=idVals.split("[,]");
		if("org".equals(userType)){
			for(String orgId:uIds){
				IGroup osGroup=groupService.getById(orgId);
				if(osGroup==null) continue;
				idList.add(TaskExecutor.getGroupExecutor(osGroup));
			}
		}else{//user
			for(String userId:uIds){
				IUser osUser=userService.getByUserId(userId);
				if(osUser==null) continue;
				idList.add(TaskExecutor.getUserExecutor(osUser));
			}
		}
		
		return idList;
	}

}
