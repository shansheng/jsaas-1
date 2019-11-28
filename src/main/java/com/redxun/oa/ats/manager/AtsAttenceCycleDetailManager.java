
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsAttenceCycleDetailDao;
import com.redxun.oa.ats.entity.AtsAttenceCycleDetail;

/**
 * 
 * <pre> 
 * 描述：考勤周期明细 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsAttenceCycleDetailManager extends MybatisBaseManager<AtsAttenceCycleDetail>{
	@Resource
	private AtsAttenceCycleDetailDao atsAttenceCycleDetailDao;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsAttenceCycleDetailDao;
	}
	
	
	
	public AtsAttenceCycleDetail getAtsAttenceCycleDetail(String uId){
		AtsAttenceCycleDetail atsAttenceCycleDetail = get(uId);
		return atsAttenceCycleDetail;
	}
}
