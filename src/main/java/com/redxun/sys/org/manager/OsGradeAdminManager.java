
package com.redxun.sys.org.manager;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.dao.OsGradeAdminDao;
import com.redxun.sys.org.dao.OsGradeRoleDao;
import com.redxun.sys.org.entity.*;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * <pre> 
 * 描述：分级管理员表 处理接口
 * 作者:ray
 * 日期:2018-11-21 16:21:56
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class OsGradeAdminManager extends MybatisBaseManager<OsGradeAdmin> {
	
	@Resource
	private OsGradeAdminDao osGradeAdminDao;
	@Resource
	private OsGradeRoleDao osGradeRoleDao;
	@Resource
	private OsRelInstManager osRelInstManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return osGradeAdminDao;
	}


	public Integer getCountByGroupId(String groupId) {
		return osGradeAdminDao.getCountByGroupId(groupId);
	}

	public OsGradeAdmin getOsGradeAdmin(String uId){
		OsGradeAdmin osGradeAdmin = get(uId);
		List<OsGradeRole> osGradeRoles= osGradeRoleDao.getByMain(uId);
		osGradeAdmin.setOsGradeRoles(osGradeRoles);
		return osGradeAdmin;
	}


	public void   saveRole(OsGradeRole role) {
		osGradeRoleDao.create(role);
	}

	public List<OsGradeAdmin>  getAdminByUserIdAndTenantId(String userId,String tenantId) {
		return  osGradeAdminDao.getAdminByUserIdAndTenantId(userId,tenantId);
	}

	public List<OsGradeRole>  getGroupByUserId(String userId,String tenantId) {
		return  osGradeRoleDao.getGroupByUserId(userId,tenantId);
	}
	
	@Override
	public void create(OsGradeAdmin entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
		
		List<OsGradeRole> osGradeRoles=entity.getOsGradeRoles();
		for(OsGradeRole osGradeRole:osGradeRoles){
			osGradeRole.setId(IdUtil.getId());
			osGradeRole.setAdminId(entity.getId());
			osGradeRoleDao.create(osGradeRole);
		}
	}

	@Override
	public void update(OsGradeAdmin entity) {
		super.update(entity);
		osGradeRoleDao.delByMainId(entity.getId());
		
		List<OsGradeRole> osGradeRoles=entity.getOsGradeRoles();
		for(OsGradeRole osGradeRole:osGradeRoles){
			osGradeRole.setId(IdUtil.getId());
			osGradeRole.setAdminId(entity.getId());
			osGradeRoleDao.create(osGradeRole);
		}
		
	}

	public boolean isAdminExist(OsGradeAdmin admin) {
		 Integer rtn= osGradeAdminDao.getCount(admin.getGroupId() ,admin.getUserId());
		 if(rtn==null)return false;
		 return rtn>0;
	}

	public List<String>  saveAll(List<OsGradeAdmin> list) {
		List<String> idList = new ArrayList<String>();
		for (OsGradeAdmin osGradeAdmin : list) {
			if(isAdminExist(osGradeAdmin))continue;
			String id = IdUtil.getId();
			osGradeAdmin.setId(id);
			osGradeAdmin.setPath("0."+id+".");
			osGradeAdminDao.create(osGradeAdmin);
			idList.add(id);
		}
		return idList;
	}



	public List getByGroupId(String groupId) {
		return osGradeAdminDao.getByGroupId(groupId);
	}



	public List getByParentId(String parentId) {
		return osGradeAdminDao.getByParentId(parentId);
	}



	public List getRoleByAdminId(String adminId) {
		return osGradeRoleDao.getByMain(adminId);
	}



	public void saveAllRole(List<OsGradeRole> list) {
		for (OsGradeRole osGradeRole : list) {
			osGradeRole.setId(IdUtil.getId());
			osGradeRoleDao.create(osGradeRole);
		}
	}


	public void delete(String id) {
		List<OsGradeRole> roles = osGradeRoleDao.getByMain(id);
		osGradeRoleDao.delByMainId(id);
		super.delete(id);
	}

	public void deleteRole(String id) {
		OsGradeRole role = osGradeRoleDao.get(id);
		String groupId = role.getGroupId();
		String userId = osGradeAdminDao.get(role.getAdminId()).getUserId();
		osGradeRoleDao.delete(id);
	}


	public void deleteRoleByGroupId(String groupId) {
		osGradeRoleDao.deleteRoleByGroupId(groupId);
	}

	public List getRoleByAdminId(QueryFilter filter) {
		return osGradeRoleDao.getAll(filter);
	}

	public void delByMainId(String id) {
		osGradeRoleDao.delByMainId(id);
	}

	public void delByRoleId(List<OsGradeRole> List){
		for(OsGradeRole role:List){
			String userId = osGradeAdminDao.get(role.getAdminId()).getUserId();
			osGradeRoleDao.delByRoleId(role.getId());
		}
	}
	
}
