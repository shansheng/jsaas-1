
/**
 * 
 * <pre> 
 * 描述：公众号管理 DAO接口
 * 作者:ray
 * 日期:2017-06-29 16:57:29
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.wx.core.dao;

import com.redxun.wx.core.entity.WxPubApp;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class WxPubAppDao extends BaseMybatisDao<WxPubApp> {

	@Override
	public String getNamespace() {
		return WxPubApp.class.getName();
	}

	public WxPubApp getByAppId(String appId){
		Map<String,Object> params=new HashMap<>();
		params.put("appId", appId);
		return (WxPubApp) this.getUnique("getByAppId", params);
	}
}

