
/**
 * 
 * <pre> 
 * 描述：假期制度明细 DAO接口
 * 作者:mansan
 * 日期:2018-03-23 17:08:22
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.List;

import com.redxun.oa.ats.entity.AtsHolidayPolicyDetail;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsHolidayPolicyDetailDao extends BaseMybatisDao<AtsHolidayPolicyDetail> {

	@Override
	public String getNamespace() {
		return AtsHolidayPolicyDetail.class.getName();
	}

	public List<AtsHolidayPolicyDetail> getAtsHolidayPolicyDetailList(String uId){
		List list = this.getBySqlKey("getAtsHolidayPolicyDetailList", uId);
		
		return list;
	}
	
	public void delByMainId(String uId){
		this.deleteBySqlKey("delByMainId", uId);
	}
}

