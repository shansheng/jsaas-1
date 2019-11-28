
package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.bpm.core.dao.TaskCandidateDao;
import com.redxun.bpm.core.entity.TaskCandidate;



import java.util.List;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：act_ru_identitylink 处理接口
 * 作者:ray
 * 日期:2018-10-26 17:26:32
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class TaskCandidateManager extends MybatisBaseManager<TaskCandidate>{
	
	@Resource
	private TaskCandidateDao taskCandidateDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return taskCandidateDao;
	}
	
	
	
	public TaskCandidate getTaskCandidate(String uId){
		TaskCandidate taskCandidate = get(uId);
		return taskCandidate;
	}
	

	
	
	@Override
	public void create(TaskCandidate entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(TaskCandidate entity) {
		super.update(entity);
		
		
		
		
	}
	
	
}
