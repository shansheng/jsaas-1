
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsTripDao;
import com.redxun.oa.ats.entity.AtsTrip;

/**
 * 
 * <pre> 
 * 描述：考勤出差单 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsTripManager extends MybatisBaseManager<AtsTrip>{
	@Resource
	private AtsTripDao atsTripDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsTripDao;
	}
	
	
	
	public AtsTrip getAtsTrip(String uId){
		AtsTrip atsTrip = get(uId);
		return atsTrip;
	}
}
