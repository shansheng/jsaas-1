
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.oa.ats.dao.AtsShiftTypeDao;
import com.redxun.oa.ats.entity.AtsShiftType;

/**
 * 
 * <pre> 
 * 描述：班次类型 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsShiftTypeManager extends MybatisBaseManager<AtsShiftType>{
	@Resource
	private AtsShiftTypeDao atsShiftTypeDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsShiftTypeDao;
	}
	

	
	public AtsShiftType getAtsShiftType(String uId){
		AtsShiftType atsShiftType = get(uId);
		return atsShiftType;
	}

	public List<String> getDateTypes() {
		return atsShiftTypeDao.getDateTypes();
	}
	
	public List<String> getByName(String name) {
		return atsShiftTypeDao.getByName(name);
	}
}
