package com.redxun.bpm.core.identity.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.json.JSONUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;

import net.sf.json.JSONObject;

/**
 * 查找发起用户所在的组的上级有等级的用户组，并且与该用户组有某种关系的用户
 * @author mansan
 *
 */
public class GroupRankTypeRelCalService extends AbstractIdentityCalService {
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
		//{"groupText":"","userType":"cur","rankLevel":"2","relTypeKey":"chenxuyuan"}
		List<TaskExecutor> identityList=new ArrayList<TaskExecutor>();
		
		JSONObject jsonObj=JSONObject.fromObject(idCalConfig.getJsonConfig());
		String userType=jsonObj.getString("userType");
		Integer rankLevel=JSONUtil.getInt(jsonObj, "rankLevel");
		
		
		String userId="";
		if(userType.equals("start")){
			userId=(String)idCalConfig.getVars().get("startUserId");
		}
		else{
			userId=ContextUtil.getCurrentUserId();
		}
		
		OsGroup mainDep=(OsGroup) groupService.getMainByUserId(userId);
		if(mainDep==null) return identityList;
		
		//往上查找到符合等级的用户组
		OsGroup fitGroup=upGroup(mainDep,rankLevel);
		
		if(fitGroup==null) 	return identityList;
		
		String tenantId=mainDep.getTenantId();
		//获得关系Key及需要查找的关系方
		String relTypeKey=JSONUtil.getString(jsonObj, "relTypeKey");
		//查找到该关系类型
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId(relTypeKey, tenantId);
		//找不到该关系
		if(osRelType==null) return identityList;
	
		//查找一方		
		List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty1(osRelType.getId(), fitGroup.getGroupId(),tenantId);
		for(OsRelInst inst:osRelInsts){
			IUser osUser=userService.getByUserId(inst.getParty2());
			if(osUser==null) continue;
			identityList.add(TaskExecutor.getUserExecutor(osUser));
		}
		
		return identityList;
	}
	
	/**
	 * 往上查找符合条件的用户组
	 * @param osGroup
	 * @param level
	 * @return
	 */
	protected OsGroup upGroup(OsGroup osGroup,Integer level){
		
		if(osGroup==null){
			return null;
		}
		
		if(osGroup.getRankLevel()!=null && osGroup.getRankLevel().equals(level)){
			return osGroup;
		}
		
		if(StringUtils.isNotEmpty(osGroup.getParentId())){
			OsGroup parentGroup=(OsGroup) groupService.getById(osGroup.getParentId());
			return upGroup(parentGroup,level);
		}
		
		return null;
	}

	

}
