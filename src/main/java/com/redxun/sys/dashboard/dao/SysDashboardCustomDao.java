package com.redxun.sys.dashboard.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.dashboard.entity.SysDashboardCustom;

@Repository
public class SysDashboardCustomDao extends BaseMybatisDao<SysDashboardCustom> {

	@Override
	public String getNamespace() {
		return SysDashboardCustom.class.getName();
	}

	public SysDashboardCustom getByAlias(String key,String tenantId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		return this.getUnique("getByAlias", params);
	}
}
