
/**
 * 
 * <pre> 
 * 描述：巡检单填写详情 DAO接口
 * 作者:zpf
 * 日期:2019-10-14 10:55:26
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolFullbillRecordDetail;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PatrolFullbillRecordDetailDao extends BaseMybatisDao<PatrolFullbillRecordDetail> {

	@Override
	public String getNamespace() {
		return PatrolFullbillRecordDetail.class.getName();
	}

	public List<Map> getRecordDetail(String recordId) {
		Map map = new HashMap();
		map.put("recordId",recordId);
		return this.getBySqlKey("getRecordDetail",map);
	}

	public void updateRecordDetail(String rdId,String answer){
		Map map = new HashMap();
		map.put("rdId",rdId);
		map.put("answer",answer);
		this.updateBySqlKey("updateRecordDetail",map);
	}
}

