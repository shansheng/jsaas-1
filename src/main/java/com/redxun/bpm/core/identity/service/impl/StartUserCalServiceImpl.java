package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;

/**
 * 计算发起人
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class StartUserCalServiceImpl extends AbstractIdentityCalService{
	
	@Resource
	private UserService userService;
	
	
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		
		String startUserId=(String)idCalConfig.getVars().get("startUserId");
		if(StringUtil.isEmpty(startUserId)){
			startUserId=ContextUtil.getCurrentUserId();
		}
		List osUsers=new ArrayList<IUser>();
		IUser osUser=userService.getByUserId(startUserId);
		osUsers.add(TaskExecutor.getUserExecutor(osUser) );
		return osUsers;
	}

}
