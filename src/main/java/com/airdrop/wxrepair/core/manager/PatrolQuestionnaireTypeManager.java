
package com.airdrop.wxrepair.core.manager;
import com.airdrop.wxrepair.core.dao.PatrolQuestionnaireTypeDao;
import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireType;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * <pre> 
 * 描述：问卷类型 处理接口
 * 作者:zpf
 * 日期:2019-11-20 15:28:18
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolQuestionnaireTypeManager extends MybatisBaseManager<PatrolQuestionnaireType>{
	
	@Resource
	private PatrolQuestionnaireTypeDao patrolQuestionnaireTypeDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolQuestionnaireTypeDao;
	}
	
	
	
	public PatrolQuestionnaireType getPatrolQuestionnaireType(String uId){
		PatrolQuestionnaireType patrolQuestionnaireType = get(uId);
		return patrolQuestionnaireType;
	}
	

	
	
	@Override
	public void create(PatrolQuestionnaireType entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolQuestionnaireType entity) {
		super.update(entity);
		
		
		
		
	}

	public List<PatrolQuestionnaireType> getAllType(){
		return patrolQuestionnaireTypeDao.getAllType();
	}
}
