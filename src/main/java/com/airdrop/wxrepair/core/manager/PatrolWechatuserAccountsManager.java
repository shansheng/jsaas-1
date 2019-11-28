
package com.airdrop.wxrepair.core.manager;
import com.airdrop.wxrepair.core.dao.PatrolWechatuserAccountsDao;
import com.airdrop.wxrepair.core.entity.PatrolWechatuserAccounts;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 
 * <pre> 
 * 描述：微信用户与帐号关系表 处理接口
 * 作者:zpf
 * 日期:2019-10-18 11:39:41
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolWechatuserAccountsManager extends MybatisBaseManager<PatrolWechatuserAccounts>{
	
	@Resource
	private PatrolWechatuserAccountsDao patrolWechatuserAccountsDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolWechatuserAccountsDao;
	}
	
	
	
	public PatrolWechatuserAccounts getPatrolWechatuserAccounts(String uId){
		PatrolWechatuserAccounts patrolWechatuserAccounts = get(uId);
		return patrolWechatuserAccounts;
	}
	

	
	
	@Override
	public void create(PatrolWechatuserAccounts entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolWechatuserAccounts entity) {
		super.update(entity);
		
		
		
		
	}

	public Object getWxUserAccount(String openId){
		return patrolWechatuserAccountsDao.getWxUserAccount(openId);
	}

	public void updateWxUserAccount(String openId,String account,String accountName){
		patrolWechatuserAccountsDao.updateWxUserAccount(openId, account, accountName);
	}
}
