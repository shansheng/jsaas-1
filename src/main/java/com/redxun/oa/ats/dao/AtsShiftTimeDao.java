
/**
 * 
 * <pre> 
 * 描述：班次时间设置 DAO接口
 * 作者:mansan
 * 日期:2018-03-26 13:55:50
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.List;

import com.redxun.oa.ats.entity.AtsShiftTime;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsShiftTimeDao extends BaseMybatisDao<AtsShiftTime> {

	@Override
	public String getNamespace() {
		return AtsShiftTime.class.getName();
	}

	public List<AtsShiftTime> getAtsShiftTimeList(String uId) {
		List list = this.getBySqlKey("getAtsShiftTimeList", uId);
		return list;
	}
	
	public void delMainId(String uId){
		this.deleteBySqlKey("delByMainId", uId);
	}


}

