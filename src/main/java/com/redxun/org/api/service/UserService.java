package com.redxun.org.api.service;

import java.util.List;

import com.redxun.org.api.model.IUser;
import com.redxun.sys.org.entity.OsUser;


/**
 * 用户接口对象。
 * @author ray
 *
 */
public interface UserService {
	
	/**
	 * 按用户ID取用户
	 * @param userId
	 * @return  IUser
	 */
	IUser getByUserId(String userId);
	/**
	 * 按用户名取用户
	 * @param username
	 * @return IUser
	 */
	IUser getByUsername(String username);

	/**
	 * 按用户名跟机构id获得用户账号
	 * @param username
	 * @param tenantId
	 * @return
	 */
	IUser getByUsernameTenantId(String username,String tenantId);
	/**
	 * 根据组ID和组类型获取关联的用户。
	 * @param groupId   用户组Id
	 * @param groupType 用户组类型
	 * @return  List<IUser>
	 */
	List<IUser> getByGroupIdAndType(String groupId,String groupType);
	
	/**
	 * 根据组ID获取用户数据。
	 * @param groupId
	 * @return
	 */
	List<IUser> getByGroupId(String groupId);

}
