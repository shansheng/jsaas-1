package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmRemindHistoryDao;
import com.redxun.bpm.core.entity.BpmRemindHistory;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
/**
 * <pre> 
 * 描述：BpmRemindHistory业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmRemindHistoryManager extends MybatisBaseManager<BpmRemindHistory>{
	@Resource
	private BpmRemindHistoryDao bpmRemindHistoryDao;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmRemindHistoryDao;
	}
}