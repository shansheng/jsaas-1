package com.redxun.sys.bo.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.sys.bo.dao.SysBoAttrDao;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoEnt;

@Service
public class SysBoAttrManager extends BaseManager<SysBoAttr> {

	@Resource
	private SysBoAttrDao sysBoAttrDao;
	@Resource
	private BpmSolutionManager bpmSolutionManager;
	@Resource
	private SysBoEntManager sysBoEntManager;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysBoAttrDao;
	}
	

	/**
	 * 根据boDefId 删除属性数据。
	 * @param boDefId
	 */
	public void delByMainId(String entId){
		sysBoAttrDao.delByMainId(entId);
	}
	
	/**
	 * 根据实体ID获取属性。
	 * @param entId
	 * @return
	 */
	public List<SysBoAttr> getAttrsByEntId(String entId){
		return sysBoAttrDao.getAttrsByEntId(entId);
	}
	public Map<String,SysBoAttr> getAttrsMapByEntId(String tableName){
		SysBoEnt ent = sysBoEntManager.getByTableName(tableName);
		List<SysBoAttr> list = sysBoAttrDao.getAttrsByEntId(ent.getId());
		Map<String, SysBoAttr> map = new HashMap<String,SysBoAttr>();
		for (SysBoAttr sysBoAttr : list) {
			map.put(sysBoAttr.getFieldName().toUpperCase(), sysBoAttr);
		}
		return map;
	}
	
}
