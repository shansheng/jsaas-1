
/**
 * 
 * <pre> 
 * 描述：分级管理员表 DAO接口
 * 作者:ray
 * 日期:2018-11-21 16:21:56
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.org.dao;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.org.entity.OsGradeAdmin;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OsGradeAdminDao extends BaseMybatisDao<OsGradeAdmin> {

	@Override
	public String getNamespace() {
		return OsGradeAdmin.class.getName();
	}

	public Integer getCountByGroupId(String groupId) {
		return (Integer)this.getOne("getCountByGroupId", groupId);
	}

	public List<OsGradeAdmin> getByGroupId(String groupId) {
		return this.getBySqlKey("getByGroupId", groupId);
	}

	public List getByParentId(String parentId) {
		return this.getBySqlKey("getByParentId", parentId);
	}

	public Integer getCount(String groupId, String userId) {
		Map<String,Object> params=new HashMap<>();
		params.put("groupId", groupId);
		params.put("userId", userId);
		return (Integer)this.getOne("getCount", params);
	}

	public List<OsGradeAdmin>  getAdminByUserIdAndTenantId(String userId,String tenantId) {
		Map<String,Object> params=new HashMap<>();
		params.put("userId", userId);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getAdminByUserIdAndTenantId", params);
	}
}

