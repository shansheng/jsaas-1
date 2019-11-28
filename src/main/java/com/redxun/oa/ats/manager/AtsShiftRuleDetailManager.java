
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsShiftRuleDetailDao;
import com.redxun.oa.ats.entity.AtsShiftRuleDetail;

/**
 * 
 * <pre> 
 * 描述：轮班规则明细 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsShiftRuleDetailManager extends MybatisBaseManager<AtsShiftRuleDetail>{
	@Resource
	private AtsShiftRuleDetailDao atsShiftRuleDetailDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsShiftRuleDetailDao;
	}
	
	
	
	public AtsShiftRuleDetail getAtsShiftRuleDetail(String uId){
		AtsShiftRuleDetail atsShiftRuleDetail = get(uId);
		return atsShiftRuleDetail;
	}

	public List<AtsShiftRuleDetail> getAtsShiftRuleDetailList(String ruleId) {
		return atsShiftRuleDetailDao.getAtsShiftRuleDetailList(ruleId);
	}
}
