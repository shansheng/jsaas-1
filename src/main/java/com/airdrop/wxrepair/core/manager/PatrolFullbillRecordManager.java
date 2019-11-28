
package com.airdrop.wxrepair.core.manager;
import com.airdrop.wxrepair.core.dao.PatrolFullbillRecordDao;
import com.airdrop.wxrepair.core.entity.PatrolFullbillRecord;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * <pre> 
 * 描述：巡检单填写记录 处理接口
 * 作者:zpf
 * 日期:2019-10-14 10:55:26
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolFullbillRecordManager extends MybatisBaseManager<PatrolFullbillRecord>{
	
	@Resource
	private PatrolFullbillRecordDao patrolFullbillRecordDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolFullbillRecordDao;
	}
	
	
	
	public PatrolFullbillRecord getPatrolFullbillRecord(String uId){
		PatrolFullbillRecord patrolFullbillRecord = get(uId);
		return patrolFullbillRecord;
	}
	

	
	
	@Override
	public void create(PatrolFullbillRecord entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolFullbillRecord entity) {
		super.update(entity);
		
		
		
		
	}

	public List<PatrolFullbillRecord> getRecordByStaff(String staffId) {
		return patrolFullbillRecordDao.getRecordByStaff(staffId);
	}

	/*public void updateRecord(PatrolFullbillRecord record){
		patrolFullbillRecordDao.updateRecord(record);
	}*/
}
