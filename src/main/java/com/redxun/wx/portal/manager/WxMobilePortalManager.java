package com.redxun.wx.portal.manager;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import com.redxun.wx.portal.dao.WxMobilePortalDao;
import com.redxun.wx.portal.entity.WxMobilePortal;

/**
 * @author Louis
 * for 移动门户
 */
@Service
public class WxMobilePortalManager extends MybatisBaseManager<WxMobilePortal> {
	@Resource
	private WxMobilePortalDao wxMobilePortalDao;
	
	@Override
	public void create(WxMobilePortal portal) {
		portal.setId(IdUtil.getId());
		super.create(portal);
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return wxMobilePortalDao;
	}
	
	public Integer checkTypeRepeat(String id, String typeId){
		return wxMobilePortalDao.checkTypeRepeat(id, typeId);
	}
}
