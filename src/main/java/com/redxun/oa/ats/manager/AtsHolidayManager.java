
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsHolidayDao;
import com.redxun.oa.ats.entity.AtsHoliday;

/**
 * 
 * <pre> 
 * 描述：考勤请假单 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsHolidayManager extends MybatisBaseManager<AtsHoliday>{
	@Resource
	private AtsHolidayDao atsHolidayDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsHolidayDao;
	}
	
	
	
	public AtsHoliday getAtsHoliday(String uId){
		AtsHoliday atsHoliday = get(uId);
		return atsHoliday;
	}
}
