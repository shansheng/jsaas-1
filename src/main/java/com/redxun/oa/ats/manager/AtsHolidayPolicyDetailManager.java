
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsHolidayPolicyDetailDao;
import com.redxun.oa.ats.entity.AtsHolidayPolicyDetail;

/**
 * 
 * <pre> 
 * 描述：假期制度明细 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsHolidayPolicyDetailManager extends MybatisBaseManager<AtsHolidayPolicyDetail>{
	@Resource
	private AtsHolidayPolicyDetailDao atsHolidayPolicyDetailDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsHolidayPolicyDetailDao;
	}
	
	
	
	public AtsHolidayPolicyDetail getAtsHolidayPolicyDetail(String uId){
		AtsHolidayPolicyDetail atsHolidayPolicyDetail = get(uId);
		return atsHolidayPolicyDetail;
	}
}
