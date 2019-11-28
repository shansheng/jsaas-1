
package com.redxun.sys.org.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.dao.OsInstUsersDao;
import com.redxun.sys.org.entity.OsInstUsers;
import com.redxun.sys.org.entity.OsUser;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre> 
 * 描述：os_inst_users 处理接口
 * 作者:ray
 * 日期:2019-01-18 16:05:11
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class OsInstUsersManager extends MybatisBaseManager<OsInstUsers>{
	
	@Resource
	private OsInstUsersDao osInstUsersDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return osInstUsersDao;
	}
	/**
	 * 从用户中创建用户与机构的关系
	 */
	public void createFormOsUser(OsUser osUser,String domain){
		OsInstUsers osInstUsers=new OsInstUsers();
		osInstUsers.setId(IdUtil.getId());
		osInstUsers.setApproveUser(osUser.getUserId());
		osInstUsers.setUserId(osUser.getUserId());
		osInstUsers.setStatus(osUser.getStatus());
		osInstUsers.setIsAdmin(osUser.getIsAdmin());
		osInstUsers.setDomain(domain);
		osInstUsers.setTenantId(osUser.getTenantId());
		osInstUsers.setStatus(osUser.getStatus());
		osInstUsers.setApplyStatus("ENABLED");
		osInstUsers.setCreateType("CREATE");
		create(osInstUsers);
	}

	/**
	 *  审批操作
	 */
	public void agreeOrRefuse(OsInstUsers osInstUsers){
		osInstUsersDao.agreeOrRefuse(osInstUsers);
	}

	/**
	 *查询所有申请加入本机构的人员名单
	 * @param domain
	 * @throws Exception
	 */
	public List<OsInstUsers> getByDomain(String domain){
		return  osInstUsersDao.getByDomain(domain);
	}

	/**
	 * 根据用户ID和租户获取id
	 */
	public OsInstUsers getByUserIdAndTenantId(String userId, String tenantId){
		return  osInstUsersDao.getByUserIdAndTenantId(userId, tenantId);
	}

	/**
	 * 取消申请或者主动推出操作
	 */
	public void removeByUserId(String userId,String tenantId){
		osInstUsersDao.removeByUserId(userId,tenantId);
	}
	
	public void updateIsAdmin(String userId,Integer isAdmin,String tenantId ){
		osInstUsersDao.updateIsAdmin(tenantId, userId, isAdmin);
	}
	
	public void updDomain(String tenantId, String domain){
		osInstUsersDao.updDomain(tenantId, domain);
	}
	
}
