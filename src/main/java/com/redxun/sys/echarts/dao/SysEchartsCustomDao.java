package com.redxun.sys.echarts.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.dao.mybatis.domain.PageList;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.echarts.entity.SysEchartsCustom;

@Repository
public class SysEchartsCustomDao extends BaseMybatisDao<SysEchartsCustom> {

	@Override
	public String getNamespace() {
		return SysEchartsCustom.class.getName();
	}
	
	/**
	 * 根据租户ID获取列表。
	 * @param tenantId
	 * @return
	 */
	public List<SysEchartsCustom> getByTenantId(String tenantId){
		return this.getBySqlKey("getByTenantId", tenantId);
	}
	
	@SuppressWarnings("rawtypes")
	public List testQuery(String sql, QueryFilter queryFilter) {
		int page=queryFilter.getPage().getStartIndex();
		int pageSize=queryFilter.getPage().getPageSize();
		PageList list = (PageList) this.sqlSessionTemplate.selectList(sql, queryFilter.getParams(), new RowBounds(page, pageSize));
		((Page)queryFilter.getPage()).setTotalItems(list.getPageResult().getTotalCount());
		return list;
	}
	
	public SysEchartsCustom getByAlias(String key,String tenantId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		return this.getUnique("getByAlias", params);
	}
	
	public SysEchartsCustom getKeyNotCurrent(String id, String key) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("key", key);
		params.put("id", null);
		if(!StringUtil.isEmpty(id)) {
			params.put("id", id);
		}
		return this.getUnique("getKeyNotCurrent", params);
	}

	public List<SysEchartsCustom> getByTreeId(String treeId, String name, String key){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("treeId", treeId);
		params.put("name", StringUtil.isEmpty(name) ? null : ("%" + name + "%"));
		params.put("key", StringUtil.isEmpty(key) ? null : ("%" + key + "%"));
		return this.getBySqlKey("getByTreeId", params);
	}

	public List<SysEchartsCustom> getByKey(String key) {
		Map<String, Object> params = new HashMap<>();
		params.put("key", key);
		return this.getBySqlKey("getByKey", params);
	}
}
