package com.redxun.sys.org.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.org.api.model.ITenant;
import com.redxun.sys.org.entity.OsDimension;
import com.redxun.sys.org.entity.OsGroup;

/**
 *  OsGroup的用户组的DAO的查询
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Repository
public class OsGroupDao extends BaseMybatisDao<OsGroup>{
	@Override
	public String getNamespace() {
		return OsGroup.class.getName();
	}


	public List<OsGroup> getByUserIdConfig(String userId) {
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		return this.getBySqlKey("getByUserIdConfig", params);
	}

	public List<OsGroup> getByMyParentId(String parentId) {
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("parentId", parentId);
		return this.getBySqlKey("getByMyParentId", params);
	}


	/**
	 *根据	SQL查询用户列表
	 */
	public List<OsGroup> getBySql(String sql){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", ContextUtil.getCurrentTenantId());
		params.put("groupId", sql);
		return this.getBySqlKey("getBySql", params);
	}
	/**
	 * 根据维度ID取得某用户所分配的分级行政维度
	 * @param groupIdList
	 * @return
	 */
	public List<OsGroup> getByGroupId(List<String> groupIdList){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("groupIdList", groupIdList);
		return this.getBySqlKey("getByGroupId",params);
	}

	/**
	 * 查找某个用户组下的某关系用户组,并且按条件过滤
	 * @param filter
	 * @return
	 */
	public List<OsGroup> getByGroupIdRelTypeId(SqlQueryFilter filter){
		Map<String,Object> params=filter.getParams();
		return this.getBySqlKey("getByGroupIdRelTypeId", params,filter.getPage());
	}
	/**
	 * 取得跟用户有某种关系的用户组列表
	 * @param userId
	 * @param relTypeId
	 * @return
	 */
	public List<OsGroup> getByUserIdRelTypeId(String userId,String relTypeId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("relTypeId", relTypeId);
		params.put("tenantId", ContextUtil.getCurrentTenantId());
		return this.getBySqlKey("getByUserIdRelTypeId", params);
	}
	/**
	 * 取得某用户某维度某种关系的用户组
	 * @param dimId
	 * @param userId
	 * @param relTypeId
	 * @return
	 */
	public List<OsGroup> getByDimIdUserIdRelTypeId(String dimId,String userId,String relTypeId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("userId", userId);
		params.put("dimId", dimId);
		params.put("relTypeId", relTypeId);
		return this.getBySqlKey("getByDimIdUserIdRelTypeId",params);
	}
	/**
	 * 取得与关系2方某种分类关系下的用户组
	 * @param party2
	 * @param relType
	 * @return
	 */
	public List<OsGroup> getByParty2RelType(String party2,String relType,String tenantId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("party2", party2);
		params.put("relType", relType);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getByParty2RelType",params);
	}

	/**
	 * 取得某用户某维度某种关系的主用户组
	 * @param dimId
	 * @param userId
	 * @param relTypeId
	 * @param isMain
	 * @return
	 */
	public List<OsGroup> getByDimIdUserIdRelTypeIdIsMain(String dimId,String userId,String relTypeId,String isMain,String tenantId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("userId", userId);
		params.put("dimId", dimId);
		params.put("relTypeId", relTypeId);
		params.put("isMain", isMain);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getByDimIdUserIdRelTypeIdIsMain",params);
	}
	
	/**
	 * 获取某维度下的某用户所在的group。
	 * @param dimId
	 * @param userId
	 * @return
	 */
	public List<OsGroup> getByDimIdUserId(String dimId,String userId,String tenantId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("userId", userId);
		params.put("dimId", dimId);
		if(StringUtil.isNotEmpty(tenantId)){
			params.put("tenantId", tenantId);
		}
		List<OsGroup> osGroups= this.getBySqlKey("getByDimIdUserId",params);
		return osGroups;
		
	}
	
	public OsGroup getByParentIdGroupName(String parentId,String name){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("parentId", parentId);
		params.put("name", name);
		List<OsGroup> osGroups= this.getBySqlKey("getByParentIdGroupName",params);
		if(osGroups.size()>0) return osGroups.get(0);
		return null;
	}
	
	/**
	 * 取得用户拥有的用户组
	 * @param userId
	 * @return
	 */
	public List<OsGroup> getByUserId(String userId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		return this.getBySqlKey("getByUserId", params);
	}
	
	/**
	 * 根据用户ID查找他所在的的组。
	 * @param userId
	 * @return
	 */
	public OsGroup getMainGroupByUserId(String userId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		return this.getUnique("getMainGroupByUserId", params);
	}
	
	public OsGroup getByKeyTenantId(String key,String tenantId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		return this.getUnique("getByKeyTenantId", params);
	}
	
	/**
	 * 根据用户ID和维度名查找他所在的组
	 * @param userId
	 * @param dimName
	 * @return
	 * */
	
	public List<OsGroup> getByReportUserIdByGroup(String userId,String dimName){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("dimName", dimName);
		return this.getBySqlKey("getByReportUserIdByGroup", params);
	}
	
	/**
	 * 获取微信用户。
	 * @param tenantId
	 * @return
	 */
	public List<OsGroup> getSyncWx(String tenantId){
		return this.getBySqlKey("getSyncWx", tenantId);
	}
	
	/**
	 * 获取微信用户。
	 * @param groupId
	 * @return
	 */
	public void updWxFlag(String groupId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("groupId", groupId);
		this.updateBySqlKey("updWxFlag", params);
	}

	public Integer getMaxPid() {
		// TODO Auto-generated method stub
		return (Integer) this.getOne("getMaxPid", null);
	}
	
	public void updateWxPid(String groupId,Integer wxParentPid,Integer wxPid){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("wxPid", wxPid);
		params.put("wxParentPid", wxParentPid);				
		params.put("groupId", groupId);
		this.updateBySqlKey("updateWxPid", params);
	}
	
	/**
	 * 根据菜单获取有权限的组织。
	 * @param menuId
	 * @return
	 */
	public List<OsGroup> getByMenuId(String menuId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("menuId", menuId);
		List<OsGroup> list= this.getBySqlKey("getByMenuId", params);
		return list;
	}

	public List<OsGroup> getByDimAndLevel(String dimId, String rankLevel) {
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("dimId", dimId);
		params.put("rankLevel", rankLevel);
		List<OsGroup> list= this.getBySqlKey("getByDimAndLevel", params);
		return list;
	}

	public List<OsGroup> getByDimAndParent(String tenantId,String dimId, String parentId) {
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("dimId", dimId);
		params.put("parentId", parentId);
		List<OsGroup> list= this.getBySqlKey("getByDimAndParent", params);
		return list;
	}
	


	
	/**
     * 按维度ID取得该维度下的所有用户组
     * @param dimId
     * @return 
     * List<OsGroup>
     * @exception 
     * @since  1.0.0
     */
    public List<OsGroup> getByDimId(String dimId){
		return this.getBySqlKey("getByDimId", dimId);
	}
    
    /**
     * 按维度ID及租房Id取得该维度下的所有用户组
     * @param dimId
     * @param tenantId
     * @return
     */
   public List<OsGroup> getByDimIdTenantId(String dimId,String tenantId){
	   Map<String,Object> params=new HashMap<String, Object>();
	   params.put("dimId", dimId);
	   params.put("tenantId", tenantId);
	   return this.getBySqlKey("getByDimIdTenantId", params);
   }
   
   public List<OsGroup> getByDimIdGroupIdTenantId(String dimId,String parentId,String tenantId){
	   Map<String,Object> params=new HashMap<String, Object>();
	   params.put("dimId", dimId);
	   params.put("parentId", parentId);
	   params.put("tenantId", tenantId);
	   return this.getBySqlKey("getByDimIdGroupIdTenantId", params);
   }


	public List<OsGroup> getByDimIdGroupIdTenantIdAdmin(String dimId, String parentId, String tenantId) {
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("dimId", dimId);
		params.put("parentId", parentId);
		params.put("tenantId", tenantId);
		params.put("userId", ContextUtil.getCurrentUserId());
		return this.getBySqlKey("getByDimIdGroupIdTenantIdAdmin", params);
	}

	public List<OsGroup> getByDimIdGroupIdTenantIdRole(String dimId, String parentId, String tenantId) {
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("dimId", dimId);
		params.put("parentId", parentId);
		params.put("tenantId", tenantId);
		params.put("userId", ContextUtil.getCurrentUserId());
		return this.getBySqlKey("getByDimIdGroupIdTenantIdRole", params);
	}
   
   
    /**
     * 取得该父节点下的所有子结节点
     * @param parentId
     * @return 
     * List<OsGroup>
     * @exception 
     * @since  1.0.0
     */
    public List<OsGroup> getByParentId(String parentId){
    	Map<String,Object> params=new HashMap<String, Object>();
    	params.put("parentId", parentId);
    	return this.getBySqlKey("getByParentId", params);
    }
   /**
    * 取得某个父类下的所有子组及数
    * @param parentId
    * @return 
    * Long
    * @exception 
    * @since  1.0.0
    */
    public Long getChildCounts(String parentId){
    	return(Long)this.getOne("getChildCounts", parentId);
    }
    /**
     * 取得该父节点下的所有子结节点
     * @param parentId 父Id
     * @param tenantId 租用机构ID
     * @return 
     * List<OsGroup>
     * @exception 
     * @since  1.0.0
     */
    public List<OsGroup> getByParentId(String parentId,String tenantId){
    	Map<String,Object> params=new HashMap<String, Object>();
    	params.put("parentId", parentId);
    	params.put("tenantId", tenantId);
 	    return this.getBySqlKey("getByParentId", params);
    }
    /**
     * 取得该维度下该父节点下的所有子结节点
     * @param dimId
     * @param parentId
     * @return 
     * List<OsGroup>
     * @exception 
     * @since  1.0.0
     */
    public List<OsGroup> getByDimIdParentId(String dimId,String parentId){
    	Map<String,Object> params=new HashMap<String, Object>();
    	params.put("dimId", dimId);
    	params.put("parentId", parentId);
    	return this.getBySqlKey("getByDimIdParentId",params);
    }
    
    public List<OsGroup> getByDepName(String depName){
    	Map<String,Object> params=new HashMap<String, Object>();
    	params.put("dimId", OsDimension.DIM_ADMIN_ID);
    	params.put("depName", depName);
    	return this.getBySqlKey("getByDepName", params);
    }
    
    public List<OsGroup> getByGroupNameExcludeAdminDim(String groupName){
    	Map<String,Object> params=new HashMap<String, Object>();
    	params.put("dimId", OsDimension.DIM_ADMIN_ID);
    	params.put("groupName", groupName);
    	return this.getBySqlKey("getByGroupNameExcludeAdminDim", params);
    }
    
    
    /**
     * 按维度Id及name,key查找用户组列表
     * @param tenantId
     * @param dimId
     * @param name
     * @param key
     * @return
     */
    public List<OsGroup> getByDimIdNameKey(String tenantId,String dimId,String name,String key){
    	Map<String,Object> params=new HashMap<String, Object>();
    	params.put("tenantId", tenantId);
    	params.put("publicTenantId", ITenant.PUBLIC_TENANT_ID);
    	params.put("dimId", dimId);
    	params.put("name", name);
    	params.put("key", key);
    	return this.getBySqlKey("getByDimIdNameKey", params);
    }
    
    /**
     *  获得该Id下的子类数
     * @param parentId
     * @return
     */
    public int getCountByparentId(String parentId){
    	long a =  (Long)this.getOne("getCountByparentId", parentId);
    	return (int)a;
    }
    
    public boolean isLDAPExist(String key){
    	long a = (Long)this.getOne("isLDAPExist", key);
    	if(a>0L){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    public OsGroup getByKey(String key){
    	Map<String,Object> params=new HashMap<String, Object>();
    	params.put("key", key);
    	return this.getUnique("getByKey", params);
    }
    
    /**
	 * 根据parentId获取用户组
	 * @param parentId
	 * @return
	 */
	public List<OsGroup> getGroupByParentId(String parentId){
		return this.getBySqlKey("getGroupByParentId", parentId);

	}
	public OsGroup getByPath(String path){
		Map<String,Object> params=new HashMap<String, Object>();
    	params.put("path", path);
		return this.getUnique("getByPath", params);
	}

	public List<OsGroup> getByParentIdBelongs(String clickNodeId,String tenantId,String currentUserId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("parentId", clickNodeId);
		params.put("tenantId", tenantId);
		params.put("currentUserId", currentUserId);
		return this.getBySqlKey("getByParentIdBelongs", params);
	}

	public List<OsGroup> getByDimAndLevelBelongs(String dimId,String initRankLevel,String currentUserId, String tenantId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("dimId", dimId);
		params.put("initRankLevel", initRankLevel);
		params.put("currentUserId", currentUserId);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getByDimAndLevelBelongs", params);
	}
	
	public List<OsGroup> getByPathLeftLike(String path,String tenantId){
		Map<String,Object> params=new HashMap<String, Object>();
    	params.put("path", path+"%");
    	params.put("tenantId", tenantId);
    	params.put("selfPath", path);
		return this.getBySqlKey("getByPathLeftLike", params);
	}


	public boolean getByDimIAndkey(String dimId,String key,String tenantId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("dimId", dimId);
		params.put("key", key);
		long a = (Long)this.getOne("getByDimIAndkey", params);
		if(a>0L){
			return false;
		}else{
			return true;
		}
	}
	
}
