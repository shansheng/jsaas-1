package com.redxun.wx.portal.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.wx.portal.entity.WxMobilePortal;

/**
 * @author Louis 
 * for 移动门户
 */
@Repository
public class WxMobilePortalDao extends BaseMybatisDao<WxMobilePortal> {

	@Override
	public String getNamespace() {
		return WxMobilePortal.class.getName();
	}

	public Integer checkTypeRepeat(String id, String typeId){
		Map<String, String> params = new HashMap<String, String>();
		params.put("id", id);
		params.put("typeId", typeId);
		return (Integer)this.getOne("checkTypeidRepeat", params);
		
	}
}
