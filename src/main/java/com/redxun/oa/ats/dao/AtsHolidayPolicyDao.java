
/**
 * 
 * <pre> 
 * 描述：假期制度 DAO接口
 * 作者:mansan
 * 日期:2018-03-23 17:08:22
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.ArrayList;
import java.util.List;

import com.redxun.oa.ats.entity.AtsHolidayPolicy;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsHolidayPolicyDao extends BaseMybatisDao<AtsHolidayPolicy> {

	@Override
	public String getNamespace() {
		return AtsHolidayPolicy.class.getName();
	}

	public List<String> getHolidayPolicys() {
		List<String> holidayPolicys = new ArrayList<String>();
		List<AtsHolidayPolicy> list = this.getBySqlKey("getHolidayPolicys", null);
		for (AtsHolidayPolicy atsHolidayPolicy : list) {
			holidayPolicys.add(atsHolidayPolicy.getName());
		}
		return holidayPolicys;
	}
	
	public List<AtsHolidayPolicy> getHolidayPolicyByName(String name){
		return this.getBySqlKey("getHolidayPolicyByName", name);
	}

	public List<AtsHolidayPolicy> getDefaultHolidayPolicy() {
		return this.getBySqlKey("getDefaultHolidayPolicy", null);
	}

}

