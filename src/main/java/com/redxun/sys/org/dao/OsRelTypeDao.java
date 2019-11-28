package com.redxun.sys.org.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.org.api.model.ITenant;
import com.redxun.sys.org.entity.OsRelType;
/**
 * <pre> 
 * 描述：OsRelType数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class OsRelTypeDao extends BaseMybatisDao<OsRelType>{
	@Override
	public String getNamespace() {
		return OsRelType.class.getName();
	}



    /**
     * 获得某种类型的关系列表
     * @param relType
     * @return
     */
    public List<OsRelType> getByRelType(String relType){
    	return this.getBySqlKey("getByRelType", relType);
    }
    
    /**
     * 获得用户的关系，排除用户从属关系
     * @return
     */
    public List<OsRelType> getUserRelTypeExcludeBelong(){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("relType1", OsRelType.REL_TYPE_GROUP_USER);
    	params.put("relType2", OsRelType.REL_TYPE_USER_USER);
    	params.put("key", OsRelType.REL_CAT_GROUP_USER_BELONG);
    	return this.getBySqlKey("getUserRelTypeExcludeBelong", params);
    }
    
    /**
     * 获得某租户下的某种类型的关系列表
     * @param relType
     * @param tenantId
     * @return
     */
    public List<OsRelType> getByRelTypeTenantId(String relType,String tenantId){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("relType", relType);
    	params.put("tenantId", tenantId);
    	return this.getBySqlKey("getByRelTypeTenantId", params);
    }
    
    /**
     * 获得某租户下的Key对应的关系
     * @param key
     * @param tenantId
     * @return
     */
    public OsRelType getByKeyTenanId(String key,String tenantId){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("key", key);
    	params.put("tenantId", tenantId);
    	params.put("publicTenantId", ITenant.PUBLIC_TENANT_ID);
    	return this.getUnique("getByKeyTenanId", params);
    }
    /**
     * 按Key获得某种关系类型
     * @param key
     * @return
     */
    public OsRelType getByRelTypeKey(String key){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("key", key);
    	return this.getUnique("getByRelTypeKey", params);
    }
    
    /**
     * 通过维度ID及关系类型获得所有关系
     * @param dimId
     * @param relType
     * @return
     */
    public List<OsRelType> getByDimId1RelType(String dimId,String relType,String tenantId,Integer  level){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("dimId", dimId);
    	params.put("relType", relType);
    	params.put("tenantId", tenantId);
    	params.put("level", level);
    	params.put("publicTenantId", ITenant.PUBLIC_TENANT_ID);
    	return this.getBySqlKey("getByDimId1RelType", params);
    }
    /**
     * 获得租户下可用的某种关系类型定义
     * @param relType
     * @param tenantId
     * @return
     */
    public List<OsRelType> getByRelTypeTenantIdIncludePublic(String relType,String tenantId,String dimId){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("relType", relType);
    	params.put("tenantId", tenantId);
    	params.put("dimId", dimId);
    	params.put("publicTenantId", ITenant.PUBLIC_TENANT_ID);
    	return this.getBySqlKey("getByRelTypeTenantIdIncludePublic", params);
    }
    
    /**
     * 获得某个维度下的所有关系
     * @param dimId
     * @return
     */
    public List<OsRelType> getByDimIdRelType(String dimId){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("dimId", dimId);
    	params.put("isTwoWay", MBoolean.YES.toString());
    	return this.getBySqlKey("getByDimIdRelType", params);
    }
    
    
}
