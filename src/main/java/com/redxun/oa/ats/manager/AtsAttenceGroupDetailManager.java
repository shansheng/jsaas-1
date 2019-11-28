
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.dao.AtsAttenceGroupDetailDao;
import com.redxun.oa.ats.entity.AtsAttenceGroupDetail;

/**
 * 
 * <pre> 
 * 描述：考勤组明细 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsAttenceGroupDetailManager extends MybatisBaseManager<AtsAttenceGroupDetail>{
	@Resource
	private AtsAttenceGroupDetailDao atsAttenceGroupDetailDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsAttenceGroupDetailDao;
	}
	
	
	
	public AtsAttenceGroupDetail getAtsAttenceGroupDetail(String uId){
		AtsAttenceGroupDetail atsAttenceGroupDetail = get(uId);
		return atsAttenceGroupDetail;
	}

	public String getUserGroup(String uId) {
		return atsAttenceGroupDetailDao.getUserGroup(uId);
	}
	
	

	public List<AtsAttenceGroupDetail> getAtsAttenceGroupDetailListSet(
			QueryFilter queryFilter) {
		return atsAttenceGroupDetailDao.getAtsAttenceGroupDetailListSet(queryFilter);
	}

	public void delByFileId(String id) {
		atsAttenceGroupDetailDao.delByFileId(id);
	}
}
