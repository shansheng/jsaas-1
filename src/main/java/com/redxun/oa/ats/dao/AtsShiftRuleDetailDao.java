
/**
 * 
 * <pre> 
 * 描述：轮班规则明细 DAO接口
 * 作者:mansan
 * 日期:2018-03-26 16:50:46
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.List;

import com.redxun.oa.ats.entity.AtsShiftRuleDetail;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsShiftRuleDetailDao extends BaseMybatisDao<AtsShiftRuleDetail> {

	@Override
	public String getNamespace() {
		return AtsShiftRuleDetail.class.getName();
	}

	public List<AtsShiftRuleDetail> getAtsShiftRuleDetailList(String uId) {
		List<AtsShiftRuleDetail> list = getBySqlKey("getAtsShiftRuleDetailList", uId);
		
		return list;
	}

	public void delByMainId(String uId) {
		deleteBySqlKey("delByMainId", uId);
	}
	
}

