package com.redxun.wx.portal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.wx.portal.entity.WxMobilePortalButton;

/**
 * @author Louis 
 * for 移动门户
 */
@Repository
public class WxMobilePortalButtonDao extends BaseMybatisDao<WxMobilePortalButton> {

	@Override
	public String getNamespace() {
		return WxMobilePortalButton.class.getName();
	}
	
	public List<WxMobilePortalButton> getByType(String typeId){
		Map<String, String> params = new HashMap<String, String>();
		params.put("typeId", typeId);
		return this.getBySqlKey("getByType", params);
	}

}
