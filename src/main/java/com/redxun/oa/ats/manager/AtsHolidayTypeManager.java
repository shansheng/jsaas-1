
package com.redxun.oa.ats.manager;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsHolidayTypeDao;
import com.redxun.oa.ats.entity.AtsHolidayType;

/**
 * 
 * <pre> 
 * 描述：假期类型 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsHolidayTypeManager extends MybatisBaseManager<AtsHolidayType>{
	@Resource
	private AtsHolidayTypeDao atsHolidayTypeDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsHolidayTypeDao;
	}
	
	
	public AtsHolidayType getAtsHolidayType(String uId){
		AtsHolidayType atsHolidayType = get(uId);
		return atsHolidayType;
	}
	
	public AtsHolidayType getByName(String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		return atsHolidayTypeDao.getUnique("getByName", map);
	}
}
