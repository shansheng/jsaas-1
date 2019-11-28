
/**
 * 
 * <pre> 
 * 描述：考勤档案 DAO接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
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
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.entity.AtsAttendanceFile;

@Repository
public class AtsAttendanceFileDao extends BaseMybatisDao<AtsAttendanceFile> {

	@Override
	public String getNamespace() {
		return AtsAttendanceFile.class.getName();
	}
	
	public List<AtsAttendanceFile> getDisUserList(QueryFilter queryFilter){
		List<AtsAttendanceFile> list = this.getBySqlKey("getDisUserList", queryFilter);
		return list;
	}

	public AtsAttendanceFile getDisUserOne(String userId){
		AtsAttendanceFile obj = (AtsAttendanceFile) this.getOne("getDisUserOne", userId);
		return obj;
	}

	public AtsAttendanceFile getUserFile(String userNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", userNo);
		return this.getUnique("getUserFile", map);
	}
	
	public AtsAttendanceFile getUserCardFile(String cardNumber) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cardNumber", cardNumber);
		return this.getUnique("getUserCardFile", map);
	}

	public List<AtsAttendanceFile> getNoneCalList(QueryFilter queryFilter) {
		return this.getPageBySqlKey("getNoneCalList", queryFilter);
	}

	public List<AtsAttendanceFile> getByAttendPolicy(String attencePolicyId) {
		return this.getBySqlKey("getByAttendPolicy", attencePolicyId);
	}

	public List<String> getAttendance() {
		List<String> users = new ArrayList<String>();
		List<AtsAttendanceFile> list = this.getBySqlKey("getAttendance", null);
		for (AtsAttendanceFile atsAttendanceFile : list) {
			if(atsAttendanceFile==null) {
				continue;
			}
			users.add(atsAttendanceFile.getCardNumber());
		}
		return users;
	}
	
	public List<String> getNotAttendance() {
		List<String> users = new ArrayList<String>();
		List<AtsAttendanceFile> list = this.getBySqlKey("getNotAttendance", null);
		for (AtsAttendanceFile atsAttendanceFile : list) {
			if(atsAttendanceFile==null) {
				continue;
			}
			users.add(atsAttendanceFile.getCardNumber());
		}
		return users;
	}

	public List<String> getFileAll() {
		List<String> users = new ArrayList<String>();
		List<AtsAttendanceFile> list = this.getBySqlKey("getFileAll", null);
		for (AtsAttendanceFile atsAttendanceFile : list) {
			if(atsAttendanceFile==null) {
				continue;
			}
			users.add(atsAttendanceFile.getCardNumber());
		}
		return users;
	}

	public List<AtsAttendanceFile> getByTenantId(String tenantId) {
		return this.getBySqlKey("getByTenantId", tenantId);
	}

}

