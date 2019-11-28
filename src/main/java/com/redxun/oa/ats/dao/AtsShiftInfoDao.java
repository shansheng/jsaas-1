
/**
 * 
 * <pre> 
 * 描述：班次设置 DAO接口
 * 作者:mansan
 * 日期:2018-03-26 13:55:50
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.oa.ats.entity.AtsShiftInfo;

@Repository
public class AtsShiftInfoDao extends BaseMybatisDao<AtsShiftInfo> {

	@Override
	public String getNamespace() {
		return AtsShiftInfo.class.getName();
	}

	public AtsShiftInfo getByShiftName(String o) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", o);
		return this.getUnique("getByShiftName", map);
	}

	public List<String> shiftInfoNames() {
		List<String> shiftNames = new ArrayList<String>();
		List<AtsShiftInfo> list = this.getBySqlKey("shiftInfoNames", null);
		for (AtsShiftInfo atsShiftInfo : list) {
			shiftNames.add(atsShiftInfo.getName());
		}
		return shiftNames;
	}

	public List<AtsShiftInfo> getDefaultShiftInfo() {
		return this.getBySqlKey("getDefaultShiftInfo", null);
	}

}

