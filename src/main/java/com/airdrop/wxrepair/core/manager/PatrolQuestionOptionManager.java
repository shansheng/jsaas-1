
package com.airdrop.wxrepair.core.manager;
import com.airdrop.wxrepair.core.dao.PatrolQuestionOptionDao;
import com.airdrop.wxrepair.core.entity.PatrolQuestionOption;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 
 * <pre> 
 * 描述：题目选项 处理接口
 * 作者:zpf
 * 日期:2019-11-13 14:46:31
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolQuestionOptionManager extends MybatisBaseManager<PatrolQuestionOption>{
	
	@Resource
	private PatrolQuestionOptionDao patrolQuestionOptionDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolQuestionOptionDao;
	}
	
	
	
	public PatrolQuestionOption getPatrolQuestionOption(String uId){
		PatrolQuestionOption patrolQuestionOption = get(uId);
		return patrolQuestionOption;
	}
	

	
	
	@Override
	public void create(PatrolQuestionOption entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolQuestionOption entity) {
		super.update(entity);
		
		
		
		
	}
	
	
}
