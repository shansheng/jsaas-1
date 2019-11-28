package com.redxun.sys.org.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.org.entity.OsGroupMenu;
/**
 * 用户组菜单
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Repository
public class OsGroupMenuDao extends BaseMybatisDao<OsGroupMenu>{
	@Override
	public String getNamespace() {
		return OsGroupMenu.class.getName();
	}
	
	/**
	 * 删除用户组下的授权菜单
	 * @param groupId
	 */
	public void deleteByGroupId(String groupId){
		this.deleteBySqlKey("deleteByGroupId", groupId);
	}
	
	/**
	 * 取得GroupId下的所有菜单ID列表
	 * @param groupId
	 * @return
	 */
	public List<OsGroupMenu> getByGroupId(String groupId){
		return this.getBySqlKey("getByGroupId", groupId);
	}
}
