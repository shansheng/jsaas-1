
/**
 * 
 * <pre> 
 * 描述：巡检单填写记录 DAO接口
 * 作者:zpf
 * 日期:2019-10-14 10:55:26
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolFullbillRecord;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolFullbillRecordDao extends BaseMybatisDao<PatrolFullbillRecord> {

	@Override
	public String getNamespace() {
		return PatrolFullbillRecord.class.getName();
	}

	public List<PatrolFullbillRecord> getRecordByStaff(String staffId) {
		Map map = new HashMap();
		map.put("staffId",staffId);
		return this.getBySqlKey("getRecordByStaff",map);
	}

	/*public void updateRecord(PatrolFullbillRecord record){
		Map map = new HashMap();
		map.put("recordId",recordId);
		map.put("statusId",statusId);
		map.put("statusName",statusName);
		map.put("shopId",shopId);
		map.put("shopName",shopName);
		map.put("fulldate",new Date());
		this.updateBySqlKey("updateRecord",map);
	}*/
}

