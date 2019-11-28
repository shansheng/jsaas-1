
/**
 * 
 * <pre> 
 * 描述：考勤组明细 DAO接口
 * 作者:mansan
 * 日期:2018-03-27 11:27:43
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.ats.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.entity.AtsAttenceGroupDetail;

@Repository
public class AtsAttenceGroupDetailDao extends BaseMybatisDao<AtsAttenceGroupDetail> {

	@Override
	public String getNamespace() {
		return AtsAttenceGroupDetail.class.getName();
	}

	public List<AtsAttenceGroupDetail> getAtsAttenceGroupDetailList(String uId) {
		List<AtsAttenceGroupDetail> list = this.getBySqlKey("getAtsAttenceGroupDetailList", uId);
		return list;
	}
	
	public void delByMainId(String uId){
		this.deleteBySqlKey("delByMainId", uId);
	}

	public String getUserGroup(String uId) {
		String obj =  (String) this.getOne("getUserGroup", uId);
		return obj;
	}

	public List<AtsAttenceGroupDetail> getAtsAttenceGroupDetailListSet(
			QueryFilter queryFilter) {
		List<AtsAttenceGroupDetail> list = this.getBySqlKey("getAtsAttenceGroupDetailListSet", queryFilter);
		return list;
	}

	public void delByFileId(String id) {
		this.deleteBySqlKey("delByFileId", id);
	}
	

}

