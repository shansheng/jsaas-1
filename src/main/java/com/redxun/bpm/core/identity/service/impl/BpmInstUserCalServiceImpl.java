package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.redxun.bpm.core.dao.BpmInstUserDao;
import com.redxun.bpm.core.entity.BpmInstUser;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;

/**
 * 计算发起人
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmInstUserCalServiceImpl extends AbstractIdentityCalService{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7300379580393816205L;
	
	@Resource
	BpmInstUserDao bpmInstUserDao;
	@Resource
	private UserService userService;
	
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		List<TaskExecutor> osUsers=new ArrayList<TaskExecutor>();
		String nodeId= idCalConfig.getNodeId();
		String actDefId= idCalConfig.getProcessDefId();
		Map<String,Object> vars=new HashMap<>();
		BpmInstUser bpmInstUser=null;
		if(vars.containsKey("mainInstId") && vars.containsKey("isSub")){
			String instId=(String)vars.get("mainInstId");
			bpmInstUser=bpmInstUserDao.getByInst(instId, nodeId, 1, actDefId);
		}
		else{
			String instId=idCalConfig.getProcessInstId();
			bpmInstUser=bpmInstUserDao.getByInst(instId, nodeId, 0, "");
		}
		if(bpmInstUser==null) return osUsers;
		String userIds=bpmInstUser.getUserIds();
		if(StringUtil.isEmpty(userIds)){
			return osUsers;
		}
		String[] aryUser=userIds.split(",");
		for(String uid:aryUser){
			IUser osUser=userService.getByUserId(uid);
			osUsers.add(TaskExecutor.getUserExecutor(osUser));
		}
		return osUsers;
	}



	

	
	

}
