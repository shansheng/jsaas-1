package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.json.JSONUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;

import net.sf.json.JSONObject;
/**
 * 通过用户及用户组关系计算用户
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class GroupRelCalServiceImpl extends AbstractIdentityCalService {
	@Resource
	OsRelTypeManager osRelTypeManager;
	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
	UserService userService;
	@Resource
	GroupService groupService;
	
	
	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		Set<TaskExecutor> idInfos=new LinkedHashSet<TaskExecutor>();
		
		if(StringUtils.isEmpty(idCalConfig.getJsonConfig())) 	return idInfos;
		
		JSONObject jsonObj=JSONObject.fromObject(idCalConfig.getJsonConfig());
		//{"userId":"startUser","relTypeKey":"关系类型"}
		String userIdVar=JSONUtil.getString(jsonObj, "userId");
		//从变量中取得该用户的实际值，其他来源有：上一任务审批人、发起人、变量。
		String userId=(String)idCalConfig.getVars().get(userIdVar);
		//获得关系Key及需要查找的关系方
		String relTypeKey=JSONUtil.getString(jsonObj, "relTypeKey");
		//查找到该关系类型
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId(relTypeKey, ContextUtil.getCurrentTenantId());
		
		if(osRelType==null)  return idInfos;
		
		//查找一方		
		List<OsRelInst> osRelInsts = new ArrayList<OsRelInst>();
		if("startUser".equals(userIdVar)) {
			osRelInsts=osRelInstManager.getByRelTypeIdParty2(osRelType.getId(), userId);
			for(OsRelInst inst:osRelInsts){
				IGroup osGroup=groupService.getById(inst.getParty1());
				if(osGroup!=null) idInfos.add(TaskExecutor.getGroupExecutor(osGroup) );
			}
		}else if("startDepId".equals(userIdVar)) {
			osRelInsts=osRelInstManager.getByRelTypeIdParty1(osRelType.getId(), userId,ContextUtil.getCurrentTenantId());
			for(OsRelInst inst:osRelInsts){
				IUser user = userService.getByUserId(inst.getParty2());
				if(user!=null) idInfos.add(new TaskExecutor(user.getUserId(), user.getFullname()));
			}
		}
		
		return idInfos;

	}

	
}
