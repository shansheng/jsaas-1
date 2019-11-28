package com.redxun.bpm.core.identity.service.impl;

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
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.org.entity.OsRelInst;
import com.redxun.sys.org.entity.OsRelType;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;

import net.sf.json.JSONObject;

/**
 * 基于用户关系计算的用户查找
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class UserRelCalServiceImpl extends AbstractIdentityCalService{
	@Resource
	OsRelTypeManager osRelTypeManager;
	@Resource
	OsRelInstManager osRelInstManager;
	@Resource
	UserService userService;
	
	
	
	/**
	 * configJson格式如:
	 * {
	 *   userId:'startUser',
	 *   relTypeKey:'',
	 *   party:''
	 * }
	 */
	@Override
	public Collection<TaskExecutor> calIdentities(IdentityCalConfig idCalConfig) {
		Set<TaskExecutor> idInfos=new LinkedHashSet<TaskExecutor>();
		
		if(StringUtils.isEmpty(idCalConfig.getJsonConfig())){
			return idInfos;
		}
		
		JSONObject jsonObj=JSONObject.fromObject(idCalConfig.getJsonConfig());
		
		String userIdVar=JSONUtil.getString(jsonObj, "userId");
		//从变量中取得该用户的实际值，其他来源有：上一任务审批人、发起人、变量。
		
		String userId=(String)idCalConfig.getVars().get(userIdVar);
		
		//获得关系Key及需要查找的关系方
		String relTypeKey=JSONUtil.getString(jsonObj, "relTypeKey");
		//查找的关系方，为party1或party2里的值
		String party=JSONUtil.getString(jsonObj,"party");
		String tenantId=ContextUtil.getCurrentTenantId();
		//查找到该关系类型
		OsRelType osRelType=osRelTypeManager.getByKeyTenanId(relTypeKey, tenantId);
		
		if(osRelType==null) return idInfos;
		
		//查找一方
		if(osRelType.getParty1().equals(party)){
			List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty2(osRelType.getId(), userId);
			for(OsRelInst inst:osRelInsts){
				if(inst==null || StringUtils.isEmpty(inst.getParty1())) continue;
				IUser osUser=userService.getByUserId(inst.getParty1());
				if(osUser!=null){
					idInfos.add(TaskExecutor.getUserExecutor(osUser));
				}
			}
		}else{//查找另一方
			List<OsRelInst> osRelInsts=osRelInstManager.getByRelTypeIdParty1(osRelType.getId(), userId,tenantId);
			for(OsRelInst inst:osRelInsts){
				IUser osUser=userService.getByUserId(inst.getParty2());
				if(osUser!=null){
					idInfos.add(TaskExecutor.getUserExecutor(osUser));
				}
			}
		}

		return idInfos;
	}
	
	
}
