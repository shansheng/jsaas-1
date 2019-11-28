
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.ats.dao.AtsAttenceCycleDao;
import com.redxun.oa.ats.dao.AtsAttenceCycleDetailDao;
import com.redxun.oa.ats.entity.AtsAttenceCycle;
import com.redxun.oa.ats.entity.AtsAttenceCycleDetail;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：考勤周期 处理接口
 * 作者:mansan
 * 日期:2018-03-23 14:36:39
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsAttenceCycleManager extends MybatisBaseManager<AtsAttenceCycle>{
	@Resource
	private AtsAttenceCycleDao atsAttenceCycleDao;
	
	@Resource
	private AtsAttenceCycleDetailDao atsAttenceCycleDetailDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsAttenceCycleDao;
	}
	

	
	public AtsAttenceCycle getAtsAttenceCycle(String uId){
		AtsAttenceCycle atsAttenceCycle = get(uId);
		if(BeanUtil.isNotEmpty(atsAttenceCycle)) {
			List<AtsAttenceCycleDetail> atsAttenceCycleDetail= atsAttenceCycleDetailDao.getAtsAttenceCycleDetailList(uId);
			atsAttenceCycle.setAtsAttenceCycleDetails(atsAttenceCycleDetail);
		}
		return atsAttenceCycle;
	}

	public void save(AtsAttenceCycle atsAttenceCycle) {
		//设置开始月
		atsAttenceCycle.setStartMonth(atsAttenceCycle.getMonth()==null?null:atsAttenceCycle.getMonth().shortValue());

		this.create(atsAttenceCycle);
		
		String uId = atsAttenceCycle.getId();
		List<AtsAttenceCycleDetail> ary = atsAttenceCycle.getAtsAttenceCycleDetails();
		for (AtsAttenceCycleDetail detail : ary) {
			if(StringUtil.isEmpty(detail.getName())) {
				continue;
			}
			detail.setCycleId(uId);
			detail.setId(IdUtil.getId());
			atsAttenceCycleDetailDao.create(detail);
		}
	}

	public void updateAttenceCycle(AtsAttenceCycle atsAttenceCycle) {
		this.update(atsAttenceCycle);
		String uId = atsAttenceCycle.getId();
		atsAttenceCycleDetailDao.delByMainId(uId);
		
		List<AtsAttenceCycleDetail> ary = atsAttenceCycle.getAtsAttenceCycleDetails();
		for (AtsAttenceCycleDetail detail : ary) {
			if(StringUtil.isEmpty(detail.getName())) {
				continue;
			}
			detail.setCycleId(uId);
			detail.setId(IdUtil.getId());
			atsAttenceCycleDetailDao.create(detail);
		}
	}
}
