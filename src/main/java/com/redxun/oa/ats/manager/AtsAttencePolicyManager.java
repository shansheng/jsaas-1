
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.dao.AtsAttencePolicyDao;
import com.redxun.oa.ats.entity.AtsAttencePolicy;

/**
 * 
 * <pre> 
 * 描述：考勤制度 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsAttencePolicyManager extends MybatisBaseManager<AtsAttencePolicy>{
	@Resource
	private AtsAttencePolicyDao atsAttencePolicyDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsAttencePolicyDao;
	}
	
	
	
	public AtsAttencePolicy getAtsAttencePolicy(String uId){
		AtsAttencePolicy atsAttencePolicy = get(uId);
		return atsAttencePolicy;
	}

	public AtsAttencePolicy getDefaultAttencePolicy() {
		List<AtsAttencePolicy> list = atsAttencePolicyDao.getDefaultAttencePolicy();
		if(BeanUtil.isEmpty(list)){
			return new AtsAttencePolicy();
		}
		return list.get(0);
	}

	public List<String> getAttencePolicy() {
		return atsAttencePolicyDao.getAttencePolicy();
	}
	
	public AtsAttencePolicy getAttencePolicyByName(String name){
		List<AtsAttencePolicy> list = atsAttencePolicyDao.getAttencePolicyByName(name);
		if(BeanUtil.isEmpty(list)){
			return null;
		}
		return list.get(0);
	}

	public String getAtsAttencePolicyName(Object userName) {
		AtsAttencePolicy atsAttencePolicy = atsAttencePolicyDao.getAtsAttencePolicyName(userName);
		if(BeanUtil.isEmpty(atsAttencePolicy)){
			return null;
		}
		return atsAttencePolicy.getName();
	}
}
