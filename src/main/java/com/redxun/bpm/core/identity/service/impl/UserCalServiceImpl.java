package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.UserService;

/**
 * 直接指定用户的方式。
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class UserCalServiceImpl extends AbstractIdentityCalService{
	@Resource
	UserService userService;
	

	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		List osUsers=new ArrayList();
		
		if(StringUtils.isNotEmpty(idCalConfig.getJsonConfig())){
			String[]userIds=idCalConfig.getJsonConfig().split("[,]");
			for(String uId:userIds){
				IUser osUser=userService.getByUserId(uId);
				if(osUser!=null){
					osUsers.add(new TaskExecutor(osUser.getUserId(), osUser.getFullname()));
				}
			}
		}
		return osUsers;
	}



	

	
}
