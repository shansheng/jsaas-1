
package com.redxun.oa.ats.manager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.DateUtil;
import com.redxun.oa.ats.dao.AtsLegalHolidayDetailDao;
import com.redxun.oa.ats.entity.AtsLegalHolidayDetail;

/**
 * 
 * <pre> 
 * 描述：法定节假日明细 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsLegalHolidayDetailManager extends MybatisBaseManager<AtsLegalHolidayDetail>{
	@Resource
	private AtsLegalHolidayDetailDao atsLegalHolidayDetailDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsLegalHolidayDetailDao;
	}
	
	
	
	public AtsLegalHolidayDetail getAtsLegalHolidayDetail(String uId){
		AtsLegalHolidayDetail atsLegalHolidayDetail = get(uId);
		return atsLegalHolidayDetail;
	}

	public Map<String, String> getHolidayMap(String attencePolicy) {
		List<AtsLegalHolidayDetail> holidayList = atsLegalHolidayDetailDao
				.getHolidayListByAttencePolicy(attencePolicy);

		Map<String, String> holidayMap = new HashMap<String, String>();
		for (AtsLegalHolidayDetail atsLegalHolidayDetail : holidayList) {
			String[] dates = DateUtil.getDaysBetweenDate(
					atsLegalHolidayDetail.getStartTime(),
					atsLegalHolidayDetail.getEndTime());
			for (String d : dates) {
				holidayMap.put(d, atsLegalHolidayDetail.getName());
			}
		}
		return holidayMap;
	}
}
