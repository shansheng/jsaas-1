
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsCardRuleDao;
import com.redxun.oa.ats.entity.AtsCardRule;

/**
 * 
 * <pre> 
 * 描述：取卡规则 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsCardRuleManager extends MybatisBaseManager<AtsCardRule>{
	@Resource
	private AtsCardRuleDao atsCardRuleDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsCardRuleDao;
	}
	
	
	public AtsCardRule getAtsCardRule(String uId){
		AtsCardRule atsCardRule = get(uId);
		return atsCardRule;
	}
}
