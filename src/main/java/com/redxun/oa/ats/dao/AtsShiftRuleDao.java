
/**
 * 
 * <pre> 
 * 描述：轮班规则 DAO接口
 * 作者:mansan
 * 日期:2018-03-26 16:50:46
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import com.redxun.oa.ats.entity.AtsShiftRule;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsShiftRuleDao extends BaseMybatisDao<AtsShiftRule> {

	@Override
	public String getNamespace() {
		return AtsShiftRule.class.getName();
	}

}

