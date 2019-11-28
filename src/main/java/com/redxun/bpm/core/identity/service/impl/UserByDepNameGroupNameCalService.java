package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 查找某部门下的拥有某种用户组（角色、职务）的人
 * @author ray
 *
 */
public class UserByDepNameGroupNameCalService extends AbstractIdentityCalService{
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	OsUserManager osUserManager;

	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		String config=idCalConfig.getJsonConfig();
		if(StringUtils.isEmpty(config)){
			return new ArrayList<TaskExecutor>();
		}
		JSONObject configObj=JSONObject.parseObject(config);
		String from=configObj.getString("from");
		String depName=configObj.getString("depName");
		String groupName=configObj.getString("groupName");
		String dName=null;
		if("var".equals(from)){
			dName=(String)idCalConfig.getVars().get(depName);
		}else if("def".equals(depName)){
			dName=depName;
		}
		
		List<TaskExecutor> infos=new ArrayList<TaskExecutor>();
		List<OsGroup> groupList=osGroupManager.getByDepName(dName);
		List<OsGroup> group2List=osGroupManager.getByGroupNameExcludeAdminDim(groupName);
		for(OsGroup osGroup:groupList){
			for(OsGroup group2:group2List){
				List<OsUser> osUsers=osUserManager.getByDepIdGroupId(osGroup.getGroupId(), group2.getGroupId());
				for(OsUser user:osUsers){
					infos.add(TaskExecutor.getUserExecutor(user));
				}
			}
		}
		
		/*
		 *  form,def
		 * {from:'var',depName:'',groupName:'合同部'}
		 */
		return infos;
	}

	

}
