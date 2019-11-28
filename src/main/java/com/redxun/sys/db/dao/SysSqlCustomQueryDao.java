
/**
 * 
 * <pre> 
 * 描述：自定义查询 DAO接口
 * 作者:cjx
 * 日期:2017-02-21 15:32:09
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.db.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.db.entity.SysSqlCustomQuery;

@Repository
public class SysSqlCustomQueryDao extends BaseMybatisDao<SysSqlCustomQuery> {

	@Override
	public String getNamespace() {
		return SysSqlCustomQuery.class.getName();
	}

	
	/**
	 * 根据租户ID获取列表。
	 * @param tenantId
	 * @return
	 */
	public List<SysSqlCustomQuery> getByTenantId(String tenantId){
		return  this.getBySqlKey("getByTenantId", tenantId);
	}
	

	/**
	 * 根据别名（标识） 租户ID查找
	 * @param key
	 * @param tenantId
	 * @return
	 */
	public SysSqlCustomQuery getByAlias(String key,String tenantId) {
		Map<String,Object> params=new HashMap<>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		return (SysSqlCustomQuery)this.getUnique("getByAlias", params);
	}
}

