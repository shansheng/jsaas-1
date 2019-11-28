package com.redxun.sys.dashboard.manager;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.dashboard.dao.SysDashboardCustomDao;
import com.redxun.sys.dashboard.entity.SysDashboardCustom;

@Service
public class SysDashboardCustomManager extends MybatisBaseManager<SysDashboardCustom> {
	
	@Resource
	private SysDashboardCustomDao dashboardDao;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return dashboardDao;
	}

	/**
	 * 通过key查找对象
	 */
	public SysDashboardCustom getByKey(String key) {
		String tenantId = ContextUtil.getCurrentTenantId();
		SysDashboardCustom dashboard = this.dashboardDao.getByAlias(key, tenantId);
		if(dashboard == null) {
			dashboard = this.dashboardDao.getByAlias(key, ITenant.ADMIN_TENANT_ID);
		}
		return dashboard;
	}
}
