
/**
 * 
 * <pre> 
 * 描述：日历模版明细 DAO接口
 * 作者:mansan
 * 日期:2018-03-22 09:49:46
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.List;

import com.redxun.oa.ats.entity.AtsCalendarTemplDetail;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class AtsCalendarTemplDetailDao extends BaseMybatisDao<AtsCalendarTemplDetail> {

	@Override
	public String getNamespace() {
		return AtsCalendarTemplDetail.class.getName();
	}
	
	
	public List<AtsCalendarTemplDetail> getByCalId(String calId){
		
		List list=this.getBySqlKey("getByCalId", calId);
		
		return list;
	}
	
	public void delByMainId(String calId){
		this.deleteBySqlKey("delByMainId", calId);
	}

}

