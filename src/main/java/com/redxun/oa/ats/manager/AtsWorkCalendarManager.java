
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsWorkCalendarDao;
import com.redxun.oa.ats.entity.AtsWorkCalendar;

/**
 * 
 * <pre> 
 * 描述：工作日历 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsWorkCalendarManager extends MybatisBaseManager<AtsWorkCalendar>{
	@Resource
	private AtsWorkCalendarDao atsWorkCalendarDao;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsWorkCalendarDao;
	}
	
	
	
	public AtsWorkCalendar getAtsWorkCalendar(String uId){
		AtsWorkCalendar atsWorkCalendar = get(uId);
		return atsWorkCalendar;
	}
}
