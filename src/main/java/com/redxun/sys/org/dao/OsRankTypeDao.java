package com.redxun.sys.org.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.org.entity.OsRankType;
/**
 * <pre> 
 * 描述：OsRankType数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Repository
public class OsRankTypeDao extends BaseMybatisDao<OsRankType>{
	@Override
	public String getNamespace() {
		return OsRankType.class.getName();
	}
    
    /**
     * 按维度ID获得等级分类列表
     * @param dimId
     * @return 
     * List<OsRankType>
     * @exception 
     * @since  1.0.0
     */
    public List<OsRankType> getByDimId(String dimId){
    	return this.getBySqlKey("getByDimId", dimId);
    }
    
    public List<OsRankType> getByDimIdTenantId(String dimId,String tenantId){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("dimId", dimId);
    	params.put("tenantId", tenantId);
    	return this.getBySqlKey("getByDimIdTenantId", params);
    }
    /**
     * 删除维度下的等级
     * @param dimId
     */
    public void deleteByDimId(String dimId){
    	this.deleteBySqlKey("deleteByDimId", dimId);
    }
    
    public OsRankType getbyKey(String key,String tenantId){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("key", key);
    	params.put("tenantId", tenantId);
    	return this.getUnique("getbyKey", params);
    }

	public OsRankType getByDimIdRankLevelTenantId(String dimId, Integer rankLevel, String tenantId) {
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("dimId", dimId);
    	params.put("rankLevel", rankLevel);
    	params.put("tenantId", tenantId);
    	return this.getUnique("getByDimIdRankLevelTenantId", params);
	}

	public List<OsRankType> getByMyDimIdTenantId(String dimId, String currentUserId, String currentTenantId) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("dimId", dimId);
		params.put("userId", currentUserId);
		params.put("tenantId", currentTenantId);
		return this.getBySqlKey("getByMyDimIdTenantId", params);
	}
}
