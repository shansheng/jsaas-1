
package com.redxun.oa.ats.manager;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateFormatUtil;
import com.redxun.oa.ats.dao.AtsShiftTimeDao;
import com.redxun.oa.ats.entity.AtsShiftTime;

/**
 * 
 * <pre> 
 * 描述：班次时间设置 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsShiftTimeManager extends MybatisBaseManager<AtsShiftTime>{
	@Resource
	private AtsShiftTimeDao atsShiftTimeDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsShiftTimeDao;
	}
	
	
	
	public AtsShiftTime getAtsShiftTime(String uId){
		AtsShiftTime atsShiftTime = get(uId);
		return atsShiftTime;
	}
	public String getShiftTime(String shiftId) {
		List<AtsShiftTime>  list = atsShiftTimeDao.getAtsShiftTimeList(shiftId);
		if(BeanUtil.isEmpty(list))
			return "";
		Date onTime = null;
		Date offTime = null;
		for (AtsShiftTime atsShiftTime : list) {
			Date onTime1 = atsShiftTime.getOnTime();
			if(BeanUtil.isEmpty(onTime)){
				onTime = onTime1;
			}else{
				if(onTime1.compareTo(onTime) < 0)
					onTime = onTime1;
			}
			
			Date offTime1 = atsShiftTime.getOffTime();
			if(BeanUtil.isEmpty(offTime)){
				offTime = offTime1;
			}else{
				if(offTime1.compareTo(offTime) > 0)
					offTime = offTime1;
			}
		}
		return DateFormatUtil.format(onTime, "HH:mm") +"~"+DateFormatUtil.format(offTime,"HH:mm");
	}
	public List<AtsShiftTime> getShiftTimeList(String shiftId) {
		List<AtsShiftTime>  list = atsShiftTimeDao.getAtsShiftTimeList(shiftId);
		return list;
	}
}
