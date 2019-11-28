
package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.bpm.core.dao.BpmMobileTagDao;
import com.redxun.bpm.core.entity.BpmMobileTag;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;

/**
 * 
 * <pre> 
 * 描述：记录CID和机型 处理接口
 * 作者:mansan
 * 日期:2017-11-29 22:29:36
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmMobileTagManager extends ExtBaseManager<BpmMobileTag>{
	@Resource
	private BpmMobileTagDao bpmMobileTagDao;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmMobileTagDao;
	}
	
	@Override
	public BaseMybatisDao getMyBatisDao() {
		return bpmMobileTagDao;
	}

	public BpmMobileTag getByCid(String cid) {
		// TODO Auto-generated method stub
		return bpmMobileTagDao.getByCid(cid);
	}
}
