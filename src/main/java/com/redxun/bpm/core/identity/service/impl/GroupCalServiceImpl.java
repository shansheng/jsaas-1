package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;

import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.constants.MBoolean;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;
/**
 * 用户组计算
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class GroupCalServiceImpl extends AbstractIdentityCalService{
	@Resource
	private OsGroupManager osGroupManager;
	@Resource
	private OsRelTypeManager osRelTypeManager;
	@Resource
	private OsUserManager osUserManager;
	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		
		List<TaskExecutor> identityList=new ArrayList<TaskExecutor>();
		//获得流程的节点配置信息，并且根据节点获得用户或组
		String jsonConfig=idCalConfig.getJsonConfig();
		if(StringUtils.isNotEmpty(jsonConfig)){
			String[] groupIds=jsonConfig.split("[,]");
			for(String gId:groupIds){
				OsGroup osGroup=osGroupManager.get(gId);
				if(osGroup!=null) identityList.add(TaskExecutor.getGroupExecutor(osGroup));
			}
		}
		return identityList;
	}

}
