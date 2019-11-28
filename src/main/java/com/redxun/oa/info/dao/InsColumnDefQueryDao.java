/**
 * 
 * <pre> 
 * 描述：ins_column_def DAO接口
 * 作者:mansan
 * 日期:2017-08-16 11:39:47
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.info.entity.InsColumnDef;

@Repository
public class InsColumnDefQueryDao extends BaseMybatisDao<InsColumnDef> {

	@Override
	public String getNamespace() {
		return InsColumnDef.class.getName();
	}

	public List<InsColumnDef> getAllAndPublic(QueryFilter qf) {
		return this.getBySqlKey("getAllAndPublic", qf.getParams());
	}
	
	public List<InsColumnDef> getAllByType(String type,String tenantId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("type", type);
		params.put("tenantId", tenantId);
		return this.getBySqlKey("getAllByType", params);
	}
public Integer getCountByKey(String tenantId, String key) {
		Map<String,Object> params=new HashMap<String, Object>();
        params.put("tenantId", tenantId);
        params.put("key", key);
        Integer rtn=(Integer) this.getOne("getCountByKey", params);
        return rtn;
	}

	public InsColumnDef getByKey(String key) {
		Map<String, Object> params = new HashMap<>();
		params.put("key", key);
		return this.getUnique("getByKey", params);
	}/**
	 * append by Louis
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<InsColumnDef> getMobileColumnDef(){
		return this.getBySqlKey("getMobileColumnDef", new HashMap());
	}}

