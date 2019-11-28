package com.redxun.sys.bo.manager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.sys.bo.dao.SysBoRelationDao;
import com.redxun.sys.bo.entity.SysBoRelation;

@Service
public class SysBoRelationManager extends BaseManager<SysBoRelation> {

	@Resource
	private SysBoRelationDao sysBoRelationDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysBoRelationDao;
	}
	
	/**
	 * 按业务实体定义Id跟实体取得关系配置
	 * @param boDefId
	 * @param entId
	 * @return
	 */
	public SysBoRelation getByDefEntId(String boDefId,String entId){
		return sysBoRelationDao.getByDefEntId(boDefId, entId);
	}
	
	public List<SysBoRelation> getByDefId(String boDefId){
		return sysBoRelationDao.getByBoDefId(boDefId);
	}

}
