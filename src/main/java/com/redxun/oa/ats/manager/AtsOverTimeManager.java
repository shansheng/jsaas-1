
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsOverTimeDao;
import com.redxun.oa.ats.entity.AtsOverTime;

/**
 * 
 * <pre> 
 * 描述：考勤加班单 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsOverTimeManager extends MybatisBaseManager<AtsOverTime>{
	@Resource
	private AtsOverTimeDao atsOverTimeDao;

	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsOverTimeDao;
	}
	
	
	
	public AtsOverTime getAtsOverTime(String uId){
		AtsOverTime atsOverTime = get(uId);
		return atsOverTime;
	}
}
