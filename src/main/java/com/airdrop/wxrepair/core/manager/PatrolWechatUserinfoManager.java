
package com.airdrop.wxrepair.core.manager;

import com.airdrop.wxrepair.core.dao.PatrolWechatUserinfoDao;
import com.airdrop.wxrepair.core.entity.PatrolWechatUserinfo;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre> 
 * 描述：巡店微信用户 处理接口
 * 作者:zpf
 * 日期:2019-10-18 10:04:32
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolWechatUserinfoManager extends MybatisBaseManager<PatrolWechatUserinfo>{
	
	@Resource
	private PatrolWechatUserinfoDao patrolWechatUserinfoDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolWechatUserinfoDao;
	}
	
	
	
	public PatrolWechatUserinfo getPatrolWechatUserinfo(String uId){
		PatrolWechatUserinfo patrolWechatUserinfo = get(uId);
		return patrolWechatUserinfo;
	}
	

	
	
	@Override
	public void create(PatrolWechatUserinfo entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolWechatUserinfo entity) {
		super.update(entity);
		
		
		
		
	}

	public Object getUserByOpenId(String openId){
		return patrolWechatUserinfoDao.getUserByOpenId(openId);
	}

	/**
	 * 根据账户userid获取账户角色
	 * @param USERID
	 * @return
	 */
	public JSONObject getUserRoleInfo(String USERID) {
		JSONObject json = new JSONObject();
		List list1 = patrolWechatUserinfoDao.getUserRole(USERID);//是否为督导
		List list2 = patrolWechatUserinfoDao.getUserShop(USERID);//是否为门店人员
		if ( list2 != null && list2.size() > 0 ) {
			json.put("code",1);//门店人员
			json.put("data",list2);
		}else if ( list1 != null && list1.size() > 0 ){
			json.put("code",2);//督导
		}else{
			json.put("code",3);//其它人员
		}
		return json;
	}

	/**
	 * 获取到所有的门店
	 * @return
	 */
	public List<Map> getAllShop(){
		return patrolWechatUserinfoDao.getAllShop();
	}
}
