
/**
 * 
 * <pre> 
 * 描述：微信接口调用凭证 DAO接口
 * 作者:zpf
 * 日期:2019-10-21 15:00:28
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolWechatAccesstoken;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolWechatAccesstokenDao extends BaseMybatisDao<PatrolWechatAccesstoken> {

	@Override
	public String getNamespace() {
		return PatrolWechatAccesstoken.class.getName();
	}

	public List<PatrolWechatAccesstoken> getAccessToken(String mAppID, String mAppSceret){
		Map map = new HashMap();
		map.put("mAppID",mAppID);
		map.put("mAppSceret",mAppSceret);
		return this.getBySqlKey("getAccessToken",map);
	}
}

