
/**
 * 
 * <pre> 
 * 描述：组织维度 DAO接口
 * 作者:ray
 * 日期:2017-05-17 09:37:59
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.org.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.org.api.model.ITenant;
import com.redxun.sys.org.entity.OsDimension;

@Repository
public class OsDimensionDao extends BaseMybatisDao<OsDimension> {

	@Override
	public String getNamespace() {
		return OsDimension.class.getName();
	}
	
	public List<OsDimension> filterateAll(QueryFilter queryFilter){
		return this.getPageBySqlKey("filterateAll", queryFilter);
	}
	
	/**
     * 取得某租用下维度Key的值
     * @param dimKey
     * @param tenantId
     * @return 
     * OsDimension
     * @exception 
     * @since  1.0.0
     */
    public OsDimension getByDimKeyTenantId(String dimKey,String tenantId){
    	Map<String,Object> params = new HashMap<String,Object>();
    	params.put("dimKey", dimKey);
    	params.put("tenantId", tenantId);
    	params.put("publicTenantId", ITenant.PUBLIC_TENANT_ID);
    	return this.getUnique("getByDimKeyTenantId", params);
    }


	public OsDimension getByDimIdTenantId(String dimId,String tenantId){
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("dimId", dimId);
		params.put("tenantId", tenantId);
		params.put("publicTenantId", ITenant.PUBLIC_TENANT_ID);
		return this.getUnique("getByDimIdTenantId", params);
	}
}

