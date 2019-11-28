package com.redxun.bpm.core.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.bpm.core.dao.BpmRemindHistoryDao;
import com.redxun.bpm.core.dao.BpmRemindInstDao;
import com.redxun.bpm.core.dao.BpmRemindInstDao;
import com.redxun.bpm.core.entity.BpmRemindInst;
/**
 * <pre> 
 * 描述：BpmRemindInst业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmRemindInstManager extends BaseManager<BpmRemindInst>{
	@Resource
	private BpmRemindInstDao bpmRemindInstDao;
	
	@Resource
	private BpmRemindHistoryDao bpmRemindHistoryDao;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmRemindInstDao;
	}
	
	
	
	@Override
	public List<BpmRemindInst> getAll(QueryFilter queryFilter) {
		String tenantId=ContextUtil.getCurrentTenantId();
		return bpmRemindInstDao.getAllByTenantId(tenantId,queryFilter);
	}
	
	
	/**
	 * 根据实例删除催办
	 * @param actInstId
	 */
	public void removeByActInst(String actInstId){
		//删除历史
		bpmRemindHistoryDao.removeByActInst(actInstId);
		//删除催办
		bpmRemindInstDao.removeByInst(actInstId);
		
	}
	
	
}