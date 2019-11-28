
/**
 * 
 * <pre> 
 * 描述：考勤制度 DAO接口
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
import com.redxun.oa.ats.entity.AtsAttencePolicy;

@Repository
public class AtsAttencePolicyDao extends BaseMybatisDao<AtsAttencePolicy> {

	@Override
	public String getNamespace() {
		return AtsAttencePolicy.class.getName();
	}
	
	public List<AtsAttencePolicy> getDefaultAttencePolicy(){
		return this.getBySqlKey("getDefaultAttencePolicy", null);
	}

	public List<String> getAttencePolicy() {
		List<String> attencePolicys = new ArrayList<String>();
		List<AtsAttencePolicy> list = this.getBySqlKey("getAttencePolicy", null);
		for (AtsAttencePolicy atsAttencePolicy : list) {
			attencePolicys.add(atsAttencePolicy.getName());
		}
		return attencePolicys;
	}

	public List<AtsAttencePolicy> getAttencePolicyByName(String name) {
		return this.getBySqlKey("getAttencePolicyByName", name);
	}

	public AtsAttencePolicy getAtsAttencePolicyName(Object userName) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userName", userName);
		return this.getUnique("getAtsAttencePolicyName", map);
	}

}

