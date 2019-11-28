
/**
 * 
 * <pre> 
 * 描述：巡店微信用户 DAO接口
 * 作者:zpf
 * 日期:2019-10-18 10:04:32
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolWechatUserinfo;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolWechatUserinfoDao extends BaseMybatisDao<PatrolWechatUserinfo> {

	@Override
	public String getNamespace() {
		return PatrolWechatUserinfo.class.getName();
	}
	
	public Object getUserByOpenId(String openId){
		Object user = this.getOne("getUserByOpenId",openId);
		return user;
	}

	public List<Map> getUserShop(String USERID) {
		Map map = new HashMap();
		map.put("USERID",USERID);
		return this.getBySqlKey("getUserShop", map);
	}

	public List<Map> getUserRole(String USERID) {
		Map map = new HashMap();
		map.put("USERID",USERID);
		return this.getBySqlKey("getUserRole", map);
	}

	public List<Map> getAllShop(){
		Map map = new HashMap();
		return this.getBySqlKey("getAllShop",map);
	}
}

