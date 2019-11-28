
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsLegalHolidayDao;
import com.redxun.oa.ats.dao.AtsLegalHolidayDetailDao;
import com.redxun.oa.ats.entity.AtsLegalHoliday;
import com.redxun.oa.ats.entity.AtsLegalHolidayDetail;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：法定节假日 处理接口
 * 作者:mansan
 * 日期:2018-03-22 16:48:35
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsLegalHolidayManager extends MybatisBaseManager<AtsLegalHoliday>{
	@Resource
	private AtsLegalHolidayDao atsLegalHolidayDao;
	@Resource
	private AtsLegalHolidayDetailDao atsLegalHolidayDetailDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsLegalHolidayDao;
	}
	
	
	
	public AtsLegalHoliday getAtsLegalHoliday(String uId){
		AtsLegalHoliday atsLegalHoliday = get(uId);
		List<AtsLegalHolidayDetail> atsLegalHolidayDetail= atsLegalHolidayDetailDao.getAtsLegalHolidayDetailList(uId);
		atsLegalHoliday.setAtsLegalHolidayDetails(atsLegalHolidayDetail);
		return atsLegalHoliday;
	}
	
	public void save(AtsLegalHoliday atsLegalHoliday){
		this.create(atsLegalHoliday);
		
		String uId = atsLegalHoliday.getId();
		for (AtsLegalHolidayDetail detail : atsLegalHoliday.getAtsLegalHolidayDetails()) {
			if(detail.getStartTime()!=null && detail.getEndTime()!=null) {
				detail.setHolidayId(uId);
				detail.setId(IdUtil.getId());
				atsLegalHolidayDetailDao.create(detail);
			}
		}
	}
	
	public void updateLegalHoliday(AtsLegalHoliday atsLegalHoliday){
		this.update(atsLegalHoliday);
		
		String uId = atsLegalHoliday.getId();
		atsLegalHolidayDetailDao.delByMainId(uId);
		for (AtsLegalHolidayDetail detail : atsLegalHoliday.getAtsLegalHolidayDetails()) {
			detail.setHolidayId(uId);
			detail.setId(IdUtil.getId());
			atsLegalHolidayDetailDao.create(detail);
		}
	}

	public void deleteAll(String id) {
		atsLegalHolidayDao.delete(id);
		atsLegalHolidayDetailDao.delByMainId(id);
	}
}
