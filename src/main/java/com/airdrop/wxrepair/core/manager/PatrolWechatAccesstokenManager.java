
package com.airdrop.wxrepair.core.manager;

import com.airdrop.common.util.WeChatUtil;
import com.airdrop.wxrepair.core.dao.PatrolWechatAccesstokenDao;
import com.airdrop.wxrepair.core.entity.PatrolWechatAccesstoken;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 
 * <pre> 
 * 描述：微信接口调用凭证 处理接口
 * 作者:zpf
 * 日期:2019-10-21 15:00:28
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolWechatAccesstokenManager extends MybatisBaseManager<PatrolWechatAccesstoken>{
	
	@Resource
	private PatrolWechatAccesstokenDao patrolWechatAccesstokenDao;

	private String mAppID;
	private String mAppSceret;
	private static PatrolWechatAccesstoken mToken = new PatrolWechatAccesstoken();
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolWechatAccesstokenDao;
	}
	
	
	
	public PatrolWechatAccesstoken getPatrolWechatAccesstoken(String uId){
		PatrolWechatAccesstoken patrolWechatAccesstoken = get(uId);
		return patrolWechatAccesstoken;
	}
	

	
	
	@Override
	public void create(PatrolWechatAccesstoken entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolWechatAccesstoken entity) {
		super.update(entity);
		
		
		
		
	}

	public PatrolWechatAccesstoken getAccessToken(String appID, String appSceret) {
		mAppID = appID;
		mAppSceret = appSceret;
		// 1.确定是否要更新token，无需更新则直接直接返回获取的token
		if ( updateToken() ) {
			return mToken;
		}

		// 2. 如需更新
		if ( !getTokenbyhttps(mAppID, mAppSceret) ) {
			System.out.println("获取失败！");
			return null;
		}
		return mToken;
	}

	private boolean getTokenbyhttps(String appID, String appSceret) {
		Date current_time = new Date();
		try {
			JSONObject res = WeChatUtil.getAccessToken(appID, appSceret);
			if ( res != null && res.getString("access_token") != null ) {
				mToken.setId(IdUtil.getId());
				mToken.setToken(res.getString("access_token"));
				mToken.setExpiresIn(res.getLongValue("expires_in"));
				mToken.setAppid(appID);
				mToken.setAppsecret(appSceret);
				mToken.setCreatetime(current_time);
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		patrolWechatAccesstokenDao.create(mToken);
		return true;
	}

	/**
	 * 获取Token信息
	 *
	 * @return
	 */
	private boolean updateToken() {
		// 查询数据库数据，如果有则不用更新，无则需要更新
		// 判断当前token是否在有效时间内
		try {
			List<PatrolWechatAccesstoken> rs = patrolWechatAccesstokenDao.getAccessToken(mAppID, mAppSceret);
			if ( rs != null && !rs.isEmpty() ) {
				PatrolWechatAccesstoken token = rs.get(0);
				mToken = token;
			} else {
				//System.out.println("未查询到对应token");
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		//System.out.println(mToken.getToken());
		return true;
	}
}
