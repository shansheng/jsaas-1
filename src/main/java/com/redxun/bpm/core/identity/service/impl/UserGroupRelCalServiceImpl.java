package com.redxun.bpm.core.identity.service.impl;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.identity.service.AbstractIdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;

/**
 * 通过用户及用户组关系计算用户
 * <pre>
 *  可以使用关系或不使用关系查找用户。
 * 	1.根据发起人所在的组 查找用户
 * 	2.根据当前人所在的组查找用户。
 *  3.从变量中获取用户组查找用户。
 *  4.指定用户组查找用户。
 * </pre>
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class UserGroupRelCalServiceImpl extends AbstractIdentityCalService {
	@Resource
	OsRelTypeManager osRelTypeManager;
	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
	UserService userService;
	@Resource
	OsGroupManager osGroupManager;
	
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		Set<TaskExecutor> idInfos=new LinkedHashSet<TaskExecutor>();
		if(StringUtils.isEmpty(idCalConfig.getJsonConfig())) return idInfos;
		
		String groupId= getGroupId( idCalConfig);
		//{"groupText":"","from":"start-org","groupVar":"","groupId":"","relTypeKey":"","useRelation":"false"}
		JSONObject jsonObj=JSONObject.parseObject(idCalConfig.getJsonConfig());
		
		boolean useRelation=jsonObj.getBooleanValue("useRelation");
		if(useRelation){
			idInfos= getByRelations(jsonObj,groupId);
		}
		else{
			List<IUser> users=userService.getByGroupId(groupId);
			for(IUser user:users){
				idInfos.add(new TaskExecutor(user.getUserId(), user.getFullname()));
			}
		}
		
		return idInfos;

	}
	
	private Set<TaskExecutor> getByRelations(JSONObject jsonObj,String groupId){
		OsGroup group=osGroupManager.get(groupId);
		String tenantId=group.getTenantId();
		Set<TaskExecutor> idInfos=new LinkedHashSet<TaskExecutor>();
		//获得关系Key及需要查找的关系方
		String relTypeKey=jsonObj.getString("relTypeKey");
		//查找到该关系类型
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId(relTypeKey, tenantId);
		
		if(osRelType==null || StringUtil.isEmpty(groupId)) return idInfos;
		
		String[] aryGroup=groupId.split("[,]");
		for(String id :aryGroup){
			//查找一方		
			List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty1(osRelType.getId(), id,tenantId);
			for(OsRelInst inst:osRelInsts){
				IUser osUser=userService.getByUserId(inst.getParty2());
				if(osUser==null) continue;
				idInfos.add(new TaskExecutor(osUser.getUserId(), osUser.getFullname()));
			}
		}
		return idInfos;
	}
	
	/**
	 * 根据配置获取用户组。
	 * @param idCalConfig
	 * @return
	 */
	private String getGroupId(IdentityCalConfig idCalConfig){
		JSONObject jsonObj=JSONObject.parseObject(idCalConfig.getJsonConfig());
		String from=jsonObj.getString( "from");
		String groupId=null;
		String logTenantId = ContextUtil.getCurrentTenantId();
		if("start-org".equals(from)){//发起人所在部门
			String startUserId=(String)idCalConfig.getVars().get("startUserId");
			OsGroup mainGroup=osGroupManager.getMainDeps(startUserId,logTenantId);
			if(mainGroup!=null){
				groupId=mainGroup.getGroupId();
			}
		}
		//上一步执行人所在部门
		else if("cur-org".equals(from)){
			String userId=ContextUtil.getCurrentUserId();
			OsGroup mainGroup=osGroupManager.getMainDeps(userId,logTenantId);
			if(mainGroup!=null){
				groupId=mainGroup.getGroupId();
			}
		}
		else if("var".equals(from)){//变量
			String varName=jsonObj.getString("groupVar");
			groupId=(String)idCalConfig.getVars().get(varName);
		}else{//来自用户组
			groupId=jsonObj.getString("groupId");
		}
		//查找上级部门。
		if(jsonObj.containsKey("upperDep")){
			String upperDep=jsonObj.getString("upperDep");
			if(upperDep.equals("true")){
				OsGroup group=osGroupManager.get(groupId);
				if(BeanUtil.isNotEmpty(group)) {
					groupId=group.getParentId();
				}
			}
		}
		
		return groupId;
	}


	
}
