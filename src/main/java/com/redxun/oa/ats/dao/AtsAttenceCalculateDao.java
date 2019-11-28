
/**
 * 
 * <pre> 
 * 描述：考勤计算 DAO接口
 * 作者:mansan
 * 日期:2018-03-28 15:47:59
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
import com.redxun.oa.ats.entity.AtsAttenceCalculate;

@Repository
public class AtsAttenceCalculateDao extends BaseMybatisDao<AtsAttenceCalculate> {

	@Override
	public String getNamespace() {
		return AtsAttenceCalculate.class.getName();
	}

	public String getOrgnamesByUserId(String userId) {
		List<AtsAttenceCalculate> list = this.getBySqlKey("getOrgnamesByUserId", userId);
		if(list.size()>0){
			String orgName = list.get(0).getOrgName();
			return orgName;
		}
		return null;
	}

	public List<AtsAttenceCalculate> getListDataAll(QueryFilter filter) {
		return this.getBySqlKey("getListData", filter);
	}
	
	public List<AtsAttenceCalculate> getListData(QueryFilter filter) {
		return this.getPageBySqlKey("getListData", filter);
	}

	public List<AtsAttenceCalculate> getList(QueryFilter filter) {
		return this.getBySqlKey("getList", filter);
	}
	
	public AtsAttenceCalculate getByFileIdAttenceTime(String fileId, Date attenceTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("fileId", fileId);
		params.put("attenceTime", attenceTime);
		return (AtsAttenceCalculate) this.getOne("getByFileIdAttenceTime", params);
	}

	public List<AtsAttenceCalculate> getByFileIdAttenceTime(String fileId, Date beginattenceTime, Date endattenceTime) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("fileId", fileId);
		params.put("beginattenceTime", beginattenceTime);
		params.put("endattenceTime", endattenceTime);
		return this.getBySqlKey("getByFileIdTime", params);
	}

	public void delByFileId(String id) {
		this.deleteBySqlKey("delByFileId", id);
	}


}

