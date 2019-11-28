package com.redxun.sys.core.dao;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.saweb.security.metadata.MenuGroupModel;
import com.redxun.sys.core.entity.SysMenu;
/**
 * 子系统查询的Dao
 * @author csx
 *@Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Repository
public class SysMenuDao extends BaseMybatisDao<SysMenu>{

	@Override
	public String getNamespace() {
		return SysMenu.class.getName();
	}

	/**
	 * 获得用户授权的菜单
	 * @param groupId
	 * @return
	 */
	public List<SysMenu> getGrantMenusByGroupId(String groupId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("groupId",groupId);
		return this.getBySqlKey("getGrantMenusByGroupId", params);
	}
	
	
	/**
	 * 通过子系统Id及组Id获得授权访问的菜单
	 * @param sysId
	 * @param groupId
	 * @return
	 */
	public List<SysMenu> getGrantMenusBySysIdGroupId(String sysId,String groupId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("sysId", sysId);
		params.put("groupId",groupId);
		return this.getBySqlKey("getGrantMenusBySysIdGroupId", params);
	}
	
	
	public List<SysMenu> getGrantMenusBySysIdUserId(String sysId,String userId,String tenantId,String isBtnMenu){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("sysId", sysId);
		params.put("userId",userId);
		params.put("tenantId",tenantId);
		params.put("isBtnMenu",isBtnMenu);
		return this.getBySqlKey("getGrantMenusBySysIdUserId", params);
	}
	/**
	 * 获得某个子系统下某些用户组可访问的功能权限
	 * @param sysId
	 * @param groupIds
	 * @return
	 */
	public List<SysMenu> getGrantMenusBySysIdGroupIds(String sysId,Collection<String> groupIds){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("sysId", sysId);
		params.put("groupIdList",groupIds);
		return this.getBySqlKey("getGrantMenusBySysIdGroupIds", params);
	}
	
	public List<SysMenu> getBySysIdIsBtnMenu(String sysId, String isBtnMenu){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("sysId", sysId);
		params.put("isBtnMenu", isBtnMenu);
		return this.getBySqlKey("getBySysIdIsBtnMenu", params);
	}
	
	/**
	 * 根据key 获取 所属的用户组。
	 * @param key
	 * @return
	 */
	public List getGroupsByKey(String key){
		return this.getBySqlKey("getGroupsByKey", key);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<MenuGroupModel> getMenuGroupUrlMap(){
		List list=this.getBySqlKey("getMenuGroupUrlMap", new HashMap<String,Object>());
		return list;
	}
	
	/**
	 * 根据机构类型获取菜单.
	 * @param instType
	 * @return
	 */
	public List<SysMenu> getByInstType(String instType){
		return this.getBySqlKey("getByInstType", instType);
	}
	
	/**
	 * 
	 * @param sysId
	 * @return
	 */
	public List<SysMenu> getBySysId(String sysId){
		return this.getBySqlKey("getBySysId", sysId);
	}
	
	public SysMenu getByUserMenuId(String userId,String menuId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("menuId", menuId);
		return this.getUnique("getByUserMenuId", params);
	}
	
	/**
	 * 获得该菜单是否授权
	 * @param menuId
	 * @param groupIds
	 * @return
	 */
	public SysMenu getGrantMenusByMenuIdGroupIds(String menuId,Collection<String> groupIds){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("menuId", menuId);
		params.put("groupIdList", groupIds);
		return this.getUnique("getGrantMenusByMenuIdGroupIds", params);
	}
	
	/**
	 * 菜单是否存在bo。
	 * @param boListId
	 * @param menuId
	 * @return
	 */
	public boolean isBoListExist(String boListId,String menuId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("boListId", boListId);
		params.put("menuId", menuId);
		Integer rtn=(Integer) this.getOne("isBoListExist", params);
		return rtn>0;
	}
	
	/**
	 * 根据租户Id和用户ID获取菜单列表。
	 * @param tenantId	租户ID
	 * @param userId	用户ID
	 * @return
	 */
	public List getBoMenuByUserId(String tenantId,String userId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("userId", userId);
		List list= this.getBySqlKey("getBoMenuByUserId",params);
		return list;
	}

	public List<SysMenu> getGrantMenusByTypeId(String typeId) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("typeId", typeId);
		return getBySqlKey("getGrantMenusByTypeId", params);
	}
	
	/**
	 * 获得某个机构类型在某个子系统上的授权菜单
	 * @param sysId 子系统Id
	 * @param instTypeId 机构类型Id
	 * @return
	 */
	public List<SysMenu> getGrantMenusBySysIdInstTypeId(String sysId,String instTypeId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("sysId", sysId);
		params.put("instTypeId", instTypeId);
		return getBySqlKey("getGrantMenusBySysIdInstTypeId", params);
	}

	public List<SysMenu> getUrlMenuByTenantMgr(String sysId,String tenantId,String isBtnMenu) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("sysId", sysId);
		params.put("tenantId", tenantId);
		params.put("isBtnMenu", isBtnMenu);
		return getBySqlKey("getUrlMenuByTenantMgr", params);
	}

	public List<SysMenu> getMenusByTenantUser(String parentId,String userId) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("parentId", parentId);
		params.put("isBtnMenu", MBoolean.NO.name());
		return getBySqlKey("getMenusByTenantUser", params);
	}

	public List<SysMenu> getByTenantType(String sysId, String instType) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("sysId", sysId);
		params.put("instType", instType);
		return getBySqlKey("getByTenantType", params);
	}
	
	/**
	 * 判断菜单是否存在。
	 * @param key		菜单key
	 * @param menuId	菜单ID
	 * @return
	 */
	public boolean isKeyExist(String key,String menuId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("key", key);
		params.put("menuId", menuId);
		Integer rtn=(Integer) this.getOne("isKeyExist", params);
		return rtn>0;
	}
	
	
	public int getCountsByParentId(String parentId,String sysId){
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("parentId", parentId);
		params.put("sysId", sysId);
		Integer rtn=(Integer) this.getOne("getCountsByParentId", params);
    	return rtn;
    }
   
  
    /**
     * 按系统Id及是否为SAAS菜单及菜单类型查询
     * @param sysId
     * @param isMgr
     * @param isBtnMenu
     * @return
     */
    public List<SysMenu> getBySysIdIsMgrIsBtnMenu(String sysId,String isBtnMenu){
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("sysId", sysId);
		params.put("isBtnMenu", isBtnMenu);
		return getBySqlKey("getBySysIdIsMgrIsBtnMenu", params);
    }
    
   
    
    /**
     * 通过父ID及系统ID获取菜单列表
     * @param sysId
     * @param parentId
     * @param tenantId
     * @return 
     * List<SysMenu>
     * @exception 
     * @since  1.0.0
     */
    public List<SysMenu> getByParentIdSysId(String sysId,String parentId){
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("sysId", sysId);
		params.put("parentId", parentId);
		return getBySqlKey("getBySysIdIsMgrIsBtnMenu", params);
    }
    /**
     * 按父ID获取所有子菜单
     * @param parentId
     * @return 
     * List<SysMenu>
     * @exception 
     * @since  1.0.0
     */
    public List<SysMenu> getByParentId(String parentId){
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("parentId", parentId);
		return getBySqlKey("getByParentId", params);
		
    }
    
    /**
     * 获得某菜单下的非按钮子菜单
     * @param parentId 当前菜单Id
     * @return
     */
    public List<SysMenu> getMenusByParentId(String parentId){
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("parentId", parentId);
		params.put("isBtnMenu", MBoolean.NO.name());
		return getBySqlKey("getMenusByParentId", params);
	}
    /**
     * 获得某个菜单下的子菜单
     * @param parentId
     * @param menuKey
     * @return
     */
    public SysMenu getByParentIdMenuKey(String parentId,String key){
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("parentId", parentId);
		params.put("key", key);
		
		return this.getUnique("getByParentIdMenuKey", params);
		
    	
    }
    
    /**
     * 按路径删除其记录
     * @param path 
     * void
     * @exception 
     * @since  1.0.0
     */
    public void delByPath(String path){
    	this.deleteBySqlKey("delByPath", path+"%");
    }
    /**
     * 按子系统Id删除子系统
     * @param sysId 
     * void
     * @exception 
     * @since  1.0.0
     */
    public void delBySysId(String sysId){
    	this.deleteBySqlKey("delBySysId", sysId);
    }
    
    /**
     * 更新子结节数
     * @param menuId 
     * void
     * @exception 
     * @since  1.0.0
     */
    public Long getChildsCount(String menuId){
    	return (Long)this.getOne("getChildsCount", menuId) ;
    }
    
 
    
    /**
     * 通过菜单的路径相似来查找所有它的子菜单
     * @param path
     * @return
     */
    public List<SysMenu> getSysMenuLeftLike(String path){
    	List<SysMenu> list=this.getBySqlKey("getSysMenuLeftLike", path+"%");
    	return list;
    }
    
   
    
    public SysMenu getByKey(String key){
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("key", key);
    	return  this.getUnique("getByKey",params);
    }
	
	
}
