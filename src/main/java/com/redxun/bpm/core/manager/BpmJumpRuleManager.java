
package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.bpm.core.dao.BpmJumpRuleDao;
import com.redxun.bpm.core.entity.BpmJumpRule;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;

/**
 * 
 * <pre> 
 * 描述：流程跳转规则 处理接口
 * 作者:ray
 * 日期:2018-04-10 13:44:42
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmJumpRuleManager extends ExtBaseManager<BpmJumpRule>{
	@Resource
	private BpmJumpRuleDao bpmJumpRuleDao;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmJumpRuleDao;
	}
	
	@Override
	public BaseMybatisDao getMyBatisDao() {
		return bpmJumpRuleDao;
	}
	
	public BpmJumpRule getBpmJumpRule(String uId){
		BpmJumpRule bpmJumpRule = get(uId);
		return bpmJumpRule;
	}
	
	public List<BpmJumpRule> getBySolId(String solId) {
		return bpmJumpRuleDao.getBySolId(solId);
	}
}
