package com.redxun.wx.portal.manager;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import com.redxun.wx.portal.dao.WxMobilePortalButtonDao;
import com.redxun.wx.portal.entity.WxMobilePortalButton;

/**
 * @author Louis
 * for 移动门户
 */
@Service
public class WxMobilePortalButtonManager extends MybatisBaseManager<WxMobilePortalButton> {
	@Resource
	private WxMobilePortalButtonDao wxPortalButtonDao;
	
	@Override
	public void create(WxMobilePortalButton portalBtn) {
		portalBtn.setId(IdUtil.getId());
		super.create(portalBtn);
	}

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return wxPortalButtonDao;
	}
	
	public List<WxMobilePortalButton> getByType(String typeId){
		return wxPortalButtonDao.getByType(typeId);
	}

}
