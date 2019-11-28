
/**
 * 
 * <pre> 
 * 描述：打卡记录 DAO接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.DateUtil;
import com.redxun.oa.ats.entity.AtsCardRecord;

@Repository
public class AtsCardRecordDao extends BaseMybatisDao<AtsCardRecord> {

	@Override
	public String getNamespace() {
		return AtsCardRecord.class.getName();
	}

	public List<AtsCardRecord> getByCardNumberCardDate(String cardNumber,
			Date startTime, Date endTime) {
		Map<String,Object> params =  new HashMap<String,Object>();
		params.put("cardNumber", cardNumber);
		params.put("startTime", DateUtil.addDay(startTime, -1));
		params.put("endTime", DateUtil.addDay(endTime, 1));
		return this.getBySqlKey("getByCardNumberCardDate", params);
	}

	public AtsCardRecord getValildDate(String cardNumber, Date startTime) {
		Map<String,Object> params =  new HashMap<String,Object>();
		params.put("cardNumber", cardNumber);
		params.put("startTime", DateUtil.formatDate(startTime,"yyyy-MM-dd HH:mm:ss"));
		return this.getUnique("getValildDate", params);
	}

	public List<AtsCardRecord> getByInvalidRecord() {
		return this.getBySqlKey("getByInvalidRecord",null);
	}

	public List<AtsCardRecord> getByNotInvalidRecord() {
		return this.getBySqlKey("getByNotInvalidRecord",null);
	}

	public List<AtsCardRecord> getDataAll(QueryFilter queryFilter) {
		return this.getBySqlKey("query", queryFilter);
	}

}

