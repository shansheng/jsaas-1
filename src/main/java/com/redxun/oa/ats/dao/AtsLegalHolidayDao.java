
/**
 * 
 * <pre> 
 * 描述：法定节假日 DAO接口
 * 作者:mansan
 * 日期:2018-03-22 16:48:35
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import com.redxun.oa.ats.entity.AtsLegalHoliday;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsLegalHolidayDao extends BaseMybatisDao<AtsLegalHoliday> {

	@Override
	public String getNamespace() {
		return AtsLegalHoliday.class.getName();
	}

}

