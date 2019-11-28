package com.redxun.sys.core.manager;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.security.metadata.MenuGroupModel;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.dao.SysMenuDao;
import com.redxun.sys.core.entity.Subsystem;
import com.redxun.sys.core.entity.SysMenu;
/**
 * 
 * <pre> 
 * 描述：SysMenu业务服务类
 * 构建组：ent-base-web
 * 作者：csx
 * 邮箱: chshxuan@163.com
 * 日期:2014年8月1日-上午10:43:05
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class SysMenuManager extends MybatisBaseManager<SysMenu>{
	
	@Resource
	private SysMenuDao sysMenuDao;
	
	@Resource
	private SubsystemManager subsystemManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysMenuDao;
	}
	
	
	public List<SysMenu> getBySystemKey(String systemKey){
		Subsystem subsystem=subsystemManager.getByKey(systemKey);
		if(subsystem==null) return new ArrayList<SysMenu>();
		return sysMenuDao.getBySysId(subsystem.getSysId());
	}
	
	
	
	/**
	 * 获得系统下的导航菜单列表
	 * @param sysId
	 * @param isMgr
	 * @return
	 */
	public List<SysMenu> getUrlMenuBySysIdIsMgr(String sysId){
		return sysMenuDao.getBySysIdIsMgrIsBtnMenu(sysId, MBoolean.NO.name());
	}
	
	/**
	 * 通过系统或是否非功能菜单获得菜单列表
	 * @param sysId
	 * @param isBtnMenu
	 * @return
	 */
	public List<SysMenu> getBySysIdIsBtnMenu(String sysId,String isBtnMenu){
		return sysMenuDao.getBySysIdIsBtnMenu(sysId,isBtnMenu);
	}
	
	public void deleteCascade(String menuId){
		SysMenu sysMenu=sysMenuDao.get(menuId);
		SysMenu parentMenu=sysMenuDao.get(sysMenu.getParentId());
		if(parentMenu!=null && parentMenu.getChilds()>0){
			parentMenu.setChilds(parentMenu.getChilds()-1);
			sysMenuDao.update(parentMenu);
		}
		if(StringUtils.isNotEmpty(sysMenu.getPath())){
			sysMenuDao.delByPath(sysMenu.getPath());
		}else{
			sysMenuDao.delete(sysMenu.getMenuId());
		}
	}
	/**
	 * 创建系统子菜单
	 * @param sysMenu 
	 * void
	 * @exception 
	 * @since  1.0.0
	 */
	public void createSysMenu(SysMenu sysMenu){
		SysMenu parentMenu=sysMenuDao.get(sysMenu.getParentId());
		int depth=1;
		String parentPath="0.";
		if(parentMenu!=null){
			depth=parentMenu.getDepth()+1;
			Long childs=sysMenuDao.getChildsCount(parentMenu.getMenuId());
			//更新父节点的子节点数
			parentMenu.setChilds(childs.intValue()+1);
			sysMenuDao.update(parentMenu);
			//设置与父菜单一样的子系统配置
			sysMenu.setSysId(parentMenu.getSysId());
		}
		
		sysMenu.setMenuId(IdUtil.getId());
		sysMenu.setPath(parentPath+sysMenu.getMenuId()+".");
		sysMenu.setDepth(depth);
		sysMenu.setChilds(0);
		int sn=sysMenuDao.getCountsByParentId(sysMenu.getParentId(), sysMenu.getSysId());
		//获取该父类下的子类数
		sysMenu.setSn(sn+1);
		sysMenuDao.create(sysMenu);
	}
	
	public SysMenu insert(String name,String parentId,String sysId){
		
		SysMenu parentSysMenu=sysMenuDao.get(parentId);
		String parentPath="0.";
		int depth=1;
		if(parentSysMenu!=null){
			depth=parentSysMenu.getDepth()+1;
			parentPath=parentSysMenu.getPath();
			Long childs=sysMenuDao.getChildsCount(parentSysMenu.getMenuId());
			//更新父节点的子节点数
			parentSysMenu.setChilds(childs.intValue()+1);
			sysMenuDao.update(parentSysMenu);
		}
		SysMenu sysMenu=new SysMenu();
		sysMenu.setMenuId(IdUtil.getId());
		sysMenu.setKey(sysMenu.getMenuId());
		sysMenu.setName(name);
		sysMenu.setSysId(sysId);
		sysMenu.setPath(parentPath+sysMenu.getMenuId()+".");
		sysMenu.setDepth(depth);
		sysMenu.setParentId(parentId);
		sysMenu.setChilds(0);
		int sn=sysMenuDao.getCountsByParentId(parentId, sysId);
		//获取该父类下的子类数
		sysMenu.setSn(sn+1);
		sysMenuDao.create(sysMenu);
		return sysMenu;
	}
	
	 public List<SysMenu> getByParentIdSysId(String sysId,String parentId){
		 return sysMenuDao.getByParentIdSysId(sysId, parentId);
	 }
	 
	 
	 /**
	  * 获得用户组授权的菜单 
	  * @param groupId
	  * @return
	  */
	 public List<SysMenu> getGrantMenusByGroupId(String groupId){
		 return sysMenuDao.getGrantMenusByGroupId(groupId);
	 }
	 
	 
	public List<SysMenu> getGrantMenusBySysIdGroupId(String sysId,String groupId){
		return sysMenuDao.getGrantMenusBySysIdGroupId(sysId, groupId);
	}
 	
	
	public List<SysMenu> getGrantMenusBySysIdUserId(String sysId,String userId,String tenantId, String isBtnMenu){
		return sysMenuDao.getGrantMenusBySysIdUserId(sysId, userId,tenantId,isBtnMenu);
	}
	
	/**
	 * 获得某个子系统下某些用户组可访问的功能权限
	 * @param sysId
	 * @param groupIds
	 * @return
	 */
	public List<SysMenu> getGrantMenusBySysIdGroupIds(String sysId,Collection<String> groupIds){
		return sysMenuDao.getGrantMenusBySysIdGroupIds(sysId, groupIds);
	}
	 
	 /**
	  * 获得菜单URL对应的用户组ID列表
	  * @return
	  */
	 public synchronized Map<String,Set<String>> getUrlGroupIdMap(){
		 Map<String,Set<String>> map=new HashMap<String, Set<String>>();
		 List<MenuGroupModel> list=sysMenuDao.getMenuGroupUrlMap();
		 for(MenuGroupModel model:list){
			 Set<String> groupIdSet=map.get(model.getUrl());
			
			 if(groupIdSet==null){
				 groupIdSet=new HashSet<String>();
				 map.put(model.getUrl(), groupIdSet);
			 }
			 groupIdSet.add(model.getGroupKey());
		 }
		 return map;
	 }
	 /**
	  * 按父Id获得其下一级的子菜单列表
	  * @param parentId
	  * @return
	  */
	 public List<SysMenu> getByParentId(String parentId){
		 return sysMenuDao.getByParentId(parentId);
	 }
	 
	 /**
	  * 按父Id获得其下一级的子菜单列表,不含按钮
	  * @param parentId
	  * @return
	  */
	 public List<SysMenu> getMenusByParentId(String parentId){
		 return sysMenuDao.getMenusByParentId(parentId);
	 }
	 
	 /**
	  * 取得某个菜单目录下的子菜单目录列表
	  * @param parentId
	  * @param menuKey
	  * @return
	  */
	 public SysMenu getByParentIdMenuKey(String parentId,String menuKey){
		 return sysMenuDao.getByParentIdMenuKey(parentId, menuKey);
	 }
	 
 	
    
    /**
     * 获得某菜单的所有子菜单
     * @param path
     * @return
     */
    public List<SysMenu> getSysMenuLeftLike(String path){
    	return sysMenuDao.getSysMenuLeftLike(path);
    }
    
    /**
     * 根据机构类型获取菜单.
     * @param instType
     * @return
     */
    public List<SysMenu> getByInstType(String instType){
    	return sysMenuDao.getByInstType(instType);
    }
    
    public List<SysMenu> getBySysId(String sysId){
    	return sysMenuDao.getBySysId(sysId);
    }
    
  
    
    public SysMenu getByKey(String key){
    	return sysMenuDao.getByKey(key);
    }
    
    /**
     * 根据用户和菜单（主部门菜单）判断用户是否有菜单权限
     * @author Stephen
     * @param userId
     * @param menuId
     * @return
     */
    public SysMenu getByUserMenuId(String userId,String menuId){
    	return sysMenuDao.getByUserMenuId(userId,menuId);
    }
    
    /**
	 * 获得该菜单是否授权
	 * @param menuId
	 * @param groupIds
	 * @return
	 */
	public SysMenu getGrantMenusByMenuIdGroupIds(String menuId,Collection<String> groupIds){
		return sysMenuDao.getGrantMenusByMenuIdGroupIds(menuId,groupIds);
	}
    
    
    public boolean isBoListExist(SysMenu sysMenu){
    	return sysMenuDao.isBoListExist(sysMenu.getBoListId(), sysMenu.getMenuId());
    }

	/**
	 * 获得某个机构类型在某个子系统上的授权菜单
	 * @param sysId 子系统Id
	 * @param instTypeId 机构类型Id
	 * @return
	 */
	public List<SysMenu> getGrantMenusBySysIdInstTypeId(String sysId,String instTypeId){
		return sysMenuDao.getGrantMenusBySysIdInstTypeId(sysId, instTypeId);
	}

	public List<SysMenu> getGrantMenusByTypeId(String typeId) {
		return sysMenuDao.getGrantMenusByTypeId(typeId);
	}


	public List<SysMenu> getUrlMenuByTenantMgr(String sysId, String tenantId,String isBtnMenu) {
		return sysMenuDao.getUrlMenuByTenantMgr(sysId,tenantId,isBtnMenu);
	}


	public List<SysMenu> getMenusByTenantUser(String parentId,String userId) {
		return sysMenuDao.getMenusByTenantUser(parentId,userId);
	}


	public List<SysMenu> getByTenantType(String sysId, String instType) {
		return sysMenuDao.getByTenantType(sysId,instType);
	}
	
	/**
	 * 表单key是否存在。
	 * @param key
	 * @param menuId
	 * @return
	 */
	public boolean isKeyExist(String key,String menuId){
		return sysMenuDao.isKeyExist(key, menuId);
	}
    
    
    
}