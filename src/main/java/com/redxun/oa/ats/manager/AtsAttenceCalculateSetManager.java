
package com.redxun.oa.ats.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.dao.AtsAttenceCalculateSetDao;
import com.redxun.oa.ats.entity.AtsAttenceCalculateSet;

/**
 * 
 * <pre> 
 * 描述：考勤计算设置 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsAttenceCalculateSetManager extends MybatisBaseManager<AtsAttenceCalculateSet>{
	@Resource
	private AtsAttenceCalculateSetDao atsAttenceCalculateSetDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsAttenceCalculateSetDao;
	}
	
	
	
	public AtsAttenceCalculateSet getAtsAttenceCalculateSet(String uId){
		AtsAttenceCalculateSet atsAttenceCalculateSet = get(uId);
		return atsAttenceCalculateSet;
	}

	public AtsAttenceCalculateSet getDefault() {
		return atsAttenceCalculateSetDao.get("1");
	}

	public String save(AtsAttenceCalculateSet atsAttenceCalculateSet) {
		Short type = atsAttenceCalculateSet.getType();
		String id = "1";
		AtsAttenceCalculateSet set = getDefault();
		if (BeanUtil.isEmpty(set)) {
			set = new AtsAttenceCalculateSet();
			set.setId(id);
			if (type == 1) {
				set.setSummary(atsAttenceCalculateSet.getDetail());
			} else {
				set.setDetail(atsAttenceCalculateSet.getDetail());
			}
			this.create(set);
			return "created";
		} else {
			if (type == 1) {
				set.setSummary(atsAttenceCalculateSet.getDetail());
			} else {
				set.setDetail(atsAttenceCalculateSet.getDetail());
			}
			this.update(set);
			return "updated";
		}
	}

}
