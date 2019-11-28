package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;

/**
 * 流程当前节点的人员来自之前审批的节点的人员
 * @author mansan
 *
 */
public class PreNodeUserCalServiceImpl extends AbstractIdentityCalService{

	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	UserService userService;
	

	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		
		Collection<TaskExecutor> users=new ArrayList<TaskExecutor>();
		
		if(StringUtil.isEmpty(idCalConfig.getProcessInstId())) return users;
		
		JSONObject jsonObj=JSONObject.parseObject(idCalConfig.getJsonConfig());
		
		if(jsonObj==null) return users;
		
		String nodeId=jsonObj.getString("nodeId");
		
		BpmNodeJump bpmNodeJump=bpmNodeJumpManager.getLastNodeJump(idCalConfig.getProcessInstId(), nodeId);
		if(bpmNodeJump==null) return users;
		if(bpmNodeJump.getHandlerId()==null) return users;
		IUser user=userService.getByUserId(bpmNodeJump.getHandlerId());
		
		if(user!=null){
			users.add(TaskExecutor.getUserExecutor(user));
		}
		
		return users;
	}

	

}
