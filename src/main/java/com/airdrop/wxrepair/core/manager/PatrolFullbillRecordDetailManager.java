
package com.airdrop.wxrepair.core.manager;

import com.airdrop.wxrepair.core.dao.PatrolFullbillRecordDetailDao;
import com.airdrop.wxrepair.core.dao.PatrolQuestionInfoDao;
import com.airdrop.wxrepair.core.entity.PatrolFullbillRecordDetail;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 
 * <pre> 
 * 描述：巡检单填写详情 处理接口
 * 作者:zpf
 * 日期:2019-10-14 10:55:26
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolFullbillRecordDetailManager extends MybatisBaseManager<PatrolFullbillRecordDetail>{
	
	@Resource
	private PatrolFullbillRecordDetailDao patrolFullbillRecordDetailDao;
	@Resource
	private PatrolQuestionInfoDao patrolQuestionInfoDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolFullbillRecordDetailDao;
	}
	
	
	
	public PatrolFullbillRecordDetail getPatrolFullbillRecordDetail(String uId){
		PatrolFullbillRecordDetail patrolFullbillRecordDetail = get(uId);
		return patrolFullbillRecordDetail;
	}
	

	
	
	@Override
	public void create(PatrolFullbillRecordDetail entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolFullbillRecordDetail entity) {
		super.update(entity);
		
		
		
		
	}

	public List<Map> getRecordDetail(String recordId) {
		List<Map> list =  patrolFullbillRecordDetailDao.getRecordDetail(recordId);
		for (Map m : list
		) {
			Object type = m.get("F_QUESTION_TYPE");
			if ( type != null && type.equals("002")) {
				List<Map> options = patrolQuestionInfoDao.getQuestionOption(m.get("QID"));
				m.put("options",options);
			}
		}
		return list;
	}

	public void updateRecordDetail(String rdId,String answer){
		patrolFullbillRecordDetailDao.updateRecordDetail(rdId, answer);
	}
}
