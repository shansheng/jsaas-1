
/**
 * 
 * <pre> 
 * 描述：排班列表 DAO接口
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

import com.redxun.oa.ats.entity.AtsScheduleShift;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsScheduleShiftDao extends BaseMybatisDao<AtsScheduleShift> {

	@Override
	public String getNamespace() {
		return AtsScheduleShift.class.getName();
	}

	public AtsScheduleShift getByFileIdAttenceTime(String fileId,
			Date attenceTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("fileId", fileId);
		params.put("attenceTime", attenceTime);
		return (AtsScheduleShift) this.getOne("getByFileIdAttenceTime", params);
	}

	public List<AtsScheduleShift> getByFileIdStartEndTime(String fileId,
			Date startTime, Date endTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("fileId", fileId);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		return this.getBySqlKey("getByFileIdStartEndTime", params);
	}

	public void delByFileId(String id) {
		this.deleteBySqlKey("delByFileId", id);
	}

}

