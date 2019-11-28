
/**
 * 
 * <pre> 
 * 描述：os_inst_users DAO接口
 * 作者:ray
 * 日期:2019-01-18 16:05:11
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.org.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.org.entity.OsInstUsers;

@Repository
public class OsInstUsersDao extends BaseMybatisDao<OsInstUsers> {

	@Override
	public String getNamespace() {
		return OsInstUsers.class.getName();
	}

	/**
	 *  审批操作
	 */
	public void agreeOrRefuse(OsInstUsers osInstUsers){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("id", osInstUsers.getId());
		params.put("status", osInstUsers.getStatus());
		params.put("note", osInstUsers.getNote());
		params.put("applyStatus", osInstUsers.getApplyStatus());
		params.put("approveUser", osInstUsers.getApproveUser());
		this.updateBySqlKey("agreeOrRefuse", params);
	}

	/**
	 *查询所有申请加入本机构的人员名单
	 * @param domain
	 * @throws Exception
	 */
	public List<OsInstUsers> getByDomain(String domain){
		return  this.getBySqlKey("getByDomain", domain);
	}

	/**
	 * 根据用户ID和租户获取id
	 */
	public OsInstUsers getByUserIdAndTenantId(String userId, String tenantId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("tenantId", tenantId);
		return  this.getUnique("getByUserIdAndTenantId", params);
	}

	/**
	 * 取消申请或者主动推出操作
	 */
	public void removeByUserId(String userId,String tenantId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("tenantId", tenantId);
		this.deleteBySqlKey("removeByUserId", params);
	}
	
	/**
	 * 更新为是否管理员。
	 * @param tenantId
	 * @param userId
	 * @param isAdmin
	 */
	public void updateIsAdmin(String tenantId, String userId,Integer isAdmin){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("userId", userId);
		params.put("isAdmin", isAdmin);
		this.updateBySqlKey("updateIsAdmin", params);
	}
	
	public void updDomain(String tenantId, String domain){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("domain", domain);
		this.updateBySqlKey("updDomain", params);
	}
}

