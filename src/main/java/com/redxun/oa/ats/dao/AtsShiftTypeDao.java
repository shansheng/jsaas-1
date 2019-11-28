
/**
 * 
 * <pre> 
 * 描述：班次类型 DAO接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.ArrayList;
import java.util.List;

import com.redxun.oa.ats.entity.AtsShiftType;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsShiftTypeDao extends BaseMybatisDao<AtsShiftType> {

	@Override
	public String getNamespace() {
		return AtsShiftType.class.getName();
	}

	public List<String> getDateTypes() {
		List<String> types = new ArrayList<String>();
		List<AtsShiftType> dateTypes = this.getBySqlKey("getDateTypes", null);
		for (AtsShiftType atsShiftType : dateTypes) {
			types.add(atsShiftType.getName());
		}
		return types;
	}

	public List<String> getByName(String name) {
		List<String> ids = new ArrayList<String>();
		List<AtsShiftType> dateTypes = this.getBySqlKey("getByName", name);
		for (AtsShiftType atsShiftType : dateTypes) {
			ids.add(atsShiftType.getId());
		}
		return ids;
	}
}

