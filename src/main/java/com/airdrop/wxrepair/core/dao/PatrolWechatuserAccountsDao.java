
/**
 * 
 * <pre> 
 * 描述：微信用户与帐号关系表 DAO接口
 * 作者:zpf
 * 日期:2019-10-18 11:39:41
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolWechatuserAccounts;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class PatrolWechatuserAccountsDao extends BaseMybatisDao<PatrolWechatuserAccounts> {

	@Override
	public String getNamespace() {
		return PatrolWechatuserAccounts.class.getName();
	}

	public Object getWxUserAccount(String openId){
		Object userAccount = this.getOne("getWxUserAccount",openId);
		return userAccount;
	}

	public void updateWxUserAccount(String openId,String account,String accountName){
		Map map = new HashMap();
		map.put("openId",openId);
		map.put("account",account);
		map.put("accountName",accountName);
		this.updateBySqlKey("updateWxUserAccount",map);
	}
}

