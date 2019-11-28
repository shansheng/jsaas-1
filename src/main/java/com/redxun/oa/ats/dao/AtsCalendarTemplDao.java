
/**
 * 
 * <pre> 
 * 描述：日历模版 DAO接口
 * 作者:mansan
 * 日期:2018-03-22 09:49:46
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import com.redxun.oa.ats.entity.AtsCalendarTempl;
import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsCalendarTemplDao extends BaseMybatisDao<AtsCalendarTempl> {

	@Override
	public String getNamespace() {
		return AtsCalendarTempl.class.getName();
	}


}

