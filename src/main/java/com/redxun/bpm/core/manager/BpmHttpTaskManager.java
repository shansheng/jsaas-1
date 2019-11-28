
package com.redxun.bpm.core.manager;

import com.redxun.bpm.core.dao.BpmHttpTaskDao;
import com.redxun.bpm.core.entity.BpmHttpTask;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * <pre> 
 * 描述：调用任务 处理接口
 * 作者:ray
 * 日期:2019-01-24 10:30:29
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmHttpTaskManager extends MybatisBaseManager<BpmHttpTask> {
	
	@Resource
	private BpmHttpTaskDao bpmHttpTaskDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmHttpTaskDao;
	}
	
	
	
	public BpmHttpTask getBpmHttpTask(String uId){
		BpmHttpTask bpmHttpTask = get(uId);
		return bpmHttpTask;
	}
	

	
	
	@Override
	public void create(BpmHttpTask entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(BpmHttpTask entity) {
		super.update(entity);
		
		
		
		
	}

	public List<BpmHttpTask> getUnfinishedTask(){
		return bpmHttpTaskDao.getUnfinishedTask();
	}
	
	
}
