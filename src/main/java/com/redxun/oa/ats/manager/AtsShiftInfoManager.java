
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.dao.AtsShiftInfoDao;
import com.redxun.oa.ats.dao.AtsShiftTimeDao;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.oa.ats.entity.AtsShiftTime;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：班次设置 处理接口
 * 作者:mansan
 * 日期:2018-03-26 13:55:50
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsShiftInfoManager extends MybatisBaseManager<AtsShiftInfo>{
	@Resource
	private AtsShiftInfoDao atsShiftInfoDao;
	
	@Resource
	private AtsShiftTimeDao atsShiftTimeDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsShiftInfoDao;
	}
	
	
	
	public AtsShiftInfo getAtsShiftInfo(String uId){
		AtsShiftInfo atsShiftInfo = get(uId);
		List<AtsShiftTime> atsShiftTime= atsShiftTimeDao.getAtsShiftTimeList(uId);
		atsShiftInfo.setAtsShiftTimes(atsShiftTime);
		return atsShiftInfo;
	}

	public void save(AtsShiftInfo atsShiftInfo) {
		atsShiftInfoDao.create(atsShiftInfo);
		String uId = atsShiftInfo.getId();
		
		List<AtsShiftTime> list =atsShiftInfo.getAtsShiftTimes();
		for (AtsShiftTime atsShiftTime : list) {
			atsShiftTime.setShiftId(uId);
			atsShiftTime.setId(IdUtil.getId());
			atsShiftTimeDao.create(atsShiftTime);
		}
		
	}

	public void updateShiftInfo(AtsShiftInfo atsShiftInfo) {
		atsShiftInfoDao.update(atsShiftInfo);
		String uId = atsShiftInfo.getId();
		atsShiftTimeDao.delMainId(uId);
		
		List<AtsShiftTime> list =atsShiftInfo.getAtsShiftTimes();
		for (AtsShiftTime atsShiftTime : list) {
			atsShiftTime.setShiftId(uId);
			atsShiftTime.setId(IdUtil.getId());
			atsShiftTimeDao.create(atsShiftTime);
		}
		
	}

	public AtsShiftInfo getByShiftName(String o) {
		return atsShiftInfoDao.getByShiftName(o);
	}

	public List<String> shiftInfoNames() {
		return atsShiftInfoDao.shiftInfoNames();
	}

	public AtsShiftInfo getDefaultShiftInfo() {
		List<AtsShiftInfo> list = atsShiftInfoDao.getDefaultShiftInfo();
		if(BeanUtil.isEmpty(list)){
			return new AtsShiftInfo();
		}
		return list.get(0);
	}

}
