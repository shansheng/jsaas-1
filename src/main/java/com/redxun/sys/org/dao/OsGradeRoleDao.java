
/**
 * 
 * <pre> 
 * 描述：分级管理角色表 DAO接口
 * 作者:ray
 * 日期:2018-11-21 16:21:56
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.org.dao;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.org.entity.OsGradeRole;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class OsGradeRoleDao extends BaseMybatisDao<OsGradeRole> {

	@Override
	public String getNamespace() {
		return OsGradeRole.class.getName();
	}
	
	public List<OsGradeRole> getByMain(String mainId){
		List<OsGradeRole> list=this.getBySqlKey("getByMain", mainId);
		return list;
	}
	
	public void delByMainId(String mainId){
		this.deleteBySqlKey("delByMainId", mainId);
	}


	public void delByRoleId(String id){
		this.deleteBySqlKey("delByRoleId", id);
	}


	public void deleteRoleByGroupId(String groupId) {
		this.deleteBySqlKey("deleteRoleByGroupId", groupId);
	}


	public List<OsGradeRole>  getGroupByUserId(String userId,String tenantId) {
		Map<String,Object> params=new HashMap<>();
		params.put("tenantId", tenantId);
		params.put("userId", userId);
		return  this.getBySqlKey("getGroupByUserId", params);
	}

}

