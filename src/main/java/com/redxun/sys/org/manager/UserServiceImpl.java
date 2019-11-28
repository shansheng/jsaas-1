package com.redxun.sys.org.manager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.org.entity.OsUser;

@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	OsUserManager osUserManager;
	@Resource
	SysInstManager sysInstManager;
	

	@Override
	public IUser getByUserId(String userId) {
		OsUser osUser= osUserManager.get(userId);
		if(osUser==null) return osUser;
		
		ITenant tenant=ContextUtil.getTenant();
		if(tenant!=null){
			osUser.setTenant(tenant);
		}
		return (IUser) osUser;
	}
	
	private ITenant getByTenant(String tenantId){
		
		SysInst inst = sysInstManager.get(tenantId);
		if(BeanUtil.isNotEmpty(inst)) {
			return inst;
		}
		return null;
	}

	@Override
	public IUser getByUsername(String username) {
		OsUser osUser=this.osUserManager.getByUserName(username);
		if(osUser==null) return null;
		ITenant tenant=  getByTenant(osUser.getTenantId());
		osUser.setTenant(tenant);
		return osUser;
	}


	/**
	 * 更新默认登陆机构
	 */
	public void updateTenantIdFromDomain(String userId,String defaultDomain){
		this.osUserManager.updateTenantIdFromDomain(userId,defaultDomain);
	}

	/**
	 * 根据用户帐号获取用户数据。
	 * @param userNo
	 * @return
	 */
	public List<OsUser> getByUserNo(String userNo){
		return this.osUserManager.getByUserNo(userNo);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<IUser> getByGroupIdAndType(String groupId, String groupType) {
		return(List)osUserManager.getBelongUsers(groupId);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<IUser> getByGroupId(String groupId) {
		List users= osUserManager.getBelongUsers(groupId);
		return users;
	}
	/**
	 * 一个用户属于多个机构时，需要传入账号与机构Id
	 * @param username
	 * @param
	 * @return
	 */
	@Override
	public IUser getByUsernameTenantId(String username, String tenantId) {
		OsUser osUser=osUserManager.getByUserName(username, tenantId);
		ITenant tenant=  getByTenant(osUser.getTenantId());
		osUser.setTenant(tenant);
		return osUser;
	}

}
