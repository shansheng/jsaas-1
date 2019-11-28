
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.dao.AtsHolidayPolicyDao;
import com.redxun.oa.ats.dao.AtsHolidayPolicyDetailDao;
import com.redxun.oa.ats.entity.AtsHolidayPolicy;
import com.redxun.oa.ats.entity.AtsHolidayPolicyDetail;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：假期制度 处理接口
 * 作者:mansan
 * 日期:2018-03-23 17:08:22
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsHolidayPolicyManager extends MybatisBaseManager<AtsHolidayPolicy>{
	@Resource
	private AtsHolidayPolicyDao atsHolidayPolicyDao;
	
	@Resource
	private AtsHolidayPolicyDetailDao atsHolidayPolicyDetailDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsHolidayPolicyDao;
	}
	
	
	
	public AtsHolidayPolicy getAtsHolidayPolicy(String uId){
		AtsHolidayPolicy atsHolidayPolicy = get(uId);
		if(BeanUtil.isEmpty(atsHolidayPolicy)) {
			return null;
		}
		List<AtsHolidayPolicyDetail> atsHolidayPolicyDetail= atsHolidayPolicyDetailDao.getAtsHolidayPolicyDetailList(uId);
		atsHolidayPolicy.setAtsHolidayPolicyDetails(atsHolidayPolicyDetail);
		return atsHolidayPolicy;
	}

	public void updateByAtsHolidayPolicy(AtsHolidayPolicy atsHolidayPolicy) {
		this.update(atsHolidayPolicy);
		String uId = atsHolidayPolicy.getId();
		
		atsHolidayPolicyDetailDao.delByMainId(uId);
		
		List<AtsHolidayPolicyDetail> atsHolidayPolicyDetailList = atsHolidayPolicy.getAtsHolidayPolicyDetails();
		for(AtsHolidayPolicyDetail atsHolidayPolicyDetail : atsHolidayPolicyDetailList){
			if(BeanUtil.isEmpty(atsHolidayPolicyDetail.getHolidayType()))
				continue;
			atsHolidayPolicyDetail.setId(IdUtil.getId());
			atsHolidayPolicyDetail.setHolidayId(uId);
			atsHolidayPolicyDetailDao.create(atsHolidayPolicyDetail);
		}
	}

	public void save(AtsHolidayPolicy atsHolidayPolicy) {
		this.create(atsHolidayPolicy);
		String uId = atsHolidayPolicy.getId();
		
		List<AtsHolidayPolicyDetail> atsHolidayPolicyDetailList = atsHolidayPolicy.getAtsHolidayPolicyDetails();
		for(AtsHolidayPolicyDetail atsHolidayPolicyDetail : atsHolidayPolicyDetailList){
			if(BeanUtil.isEmpty(atsHolidayPolicyDetail.getHolidayType()))
				continue;
			atsHolidayPolicyDetail.setId(IdUtil.getId());//添加一行
			atsHolidayPolicyDetail.setHolidayId(uId);
			atsHolidayPolicyDetailDao.create(atsHolidayPolicyDetail);
		}
	}

	public List<String> getHolidayPolicys() {
		return atsHolidayPolicyDao.getHolidayPolicys();
	}
	
	public AtsHolidayPolicy getHolidayPolicyByName(String name){
		List<AtsHolidayPolicy> list = atsHolidayPolicyDao.getHolidayPolicyByName(name);
		if(BeanUtil.isEmpty(list)){
			return null;
		}
		return list.get(0);
	}

	public AtsHolidayPolicy getDefaultHolidayPolicy() {
		List<AtsHolidayPolicy> list = atsHolidayPolicyDao.getDefaultHolidayPolicy();
		if(BeanUtil.isEmpty(list)){
			return new AtsHolidayPolicy();
		}
		return list.get(0);
	}
}
