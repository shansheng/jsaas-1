package com.redxun.sys.echarts.manager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.sys.echarts.dao.SysEchartsListPremissionDao;
import com.redxun.sys.echarts.entity.SysEchartsListPremission;

@Service
public class SysEchartsListPremissionManager extends MybatisBaseManager<SysEchartsListPremission> {
	
	@Resource
	private SysEchartsListPremissionDao listPremissionDao;
	
	public List<SysEchartsListPremission> getByPreId(String preId){
		return listPremissionDao.getByPreId(preId);
	}
	
	public void delByPreId(String preId) {
		listPremissionDao.delByTreeId(preId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return listPremissionDao;
	}

}
