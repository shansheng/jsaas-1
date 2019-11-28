
/**
 * 
 * <pre> 
 * 描述：法定节假日明细 DAO接口
 * 作者:mansan
 * 日期:2018-03-22 16:48:34
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.List;

import com.redxun.oa.ats.entity.AtsLegalHolidayDetail;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsLegalHolidayDetailDao extends BaseMybatisDao<AtsLegalHolidayDetail> {

	@Override
	public String getNamespace() {
		return AtsLegalHolidayDetail.class.getName();
	}

	public List<AtsLegalHolidayDetail> getAtsLegalHolidayDetailList(String uId) {
		List list = this.getBySqlKey("getAtsLegalHolidayDetailList", uId);
		
		return list;
	}
	
	public void delByMainId(String uId){
		this.deleteBySqlKey("delByMainId", uId);
	}

	public List<AtsLegalHolidayDetail> getHolidayListByAttencePolicy(
			String attencePolicy) {
		return this.getBySqlKey("getHolidayListByAttencePolicy", attencePolicy);
	}

}

