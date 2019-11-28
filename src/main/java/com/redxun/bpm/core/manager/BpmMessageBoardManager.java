
package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.bpm.core.dao.BpmMessageBoardDao;
import com.redxun.bpm.core.entity.BpmMessageBoard;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.QueryFilter;

/**
 * 
 * <pre> 
 * 描述：流程沟通留言板 处理接口
 * 作者:mansan
 * 日期:2017-10-27 16:51:41
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmMessageBoardManager extends ExtBaseManager<BpmMessageBoard>{
	@Resource
	private BpmMessageBoardDao bpmMessageBoardDao;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmMessageBoardDao;
	}
	
	@Override
	public BaseMybatisDao getMyBatisDao() {
		return bpmMessageBoardDao;
	}

	public List<BpmMessageBoard> getMessageBoardByInstId(String instId,QueryFilter filter) {
		return bpmMessageBoardDao.getMessageBoardByInstId(instId,filter);
	}
	
	public List getInstUser(String instId) {
		return bpmMessageBoardDao.getInstUser(instId);
		
	}

	public void deleteByInst(String instId) {
		bpmMessageBoardDao.deleteByInst(instId);
	}
	
	
}
