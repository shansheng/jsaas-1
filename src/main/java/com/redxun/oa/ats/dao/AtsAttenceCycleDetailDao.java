
/**
 * 
 * <pre> 
 * 描述：考勤周期明细 DAO接口
 * 作者:mansan
 * 日期:2018-03-23 14:36:39
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.oa.ats.entity.AtsAttenceCycleDetail;

@Repository
public class AtsAttenceCycleDetailDao extends BaseMybatisDao<AtsAttenceCycleDetail> {

	@Override
	public String getNamespace() {
		return AtsAttenceCycleDetail.class.getName();
	}

	public List<AtsAttenceCycleDetail> getAtsAttenceCycleDetailList(String uId){
		List list = this.getBySqlKey("getAtsAttenceCycleDetailList", uId);
			
		return list;
	}
	
	public void delByMainId(String uId){
		this.deleteBySqlKey("delByMainId", uId);
	}
}

