
/**
 * 
 * <pre> 
 * 描述：栏目模板管理表 DAO接口
 * 作者:mansan
 * 日期:2018-08-30 09:50:56
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.info.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.oa.info.entity.InsColumnTemp;
import com.redxun.saweb.context.ContextUtil;

@Repository
public class InsColumnTempQueryDao extends BaseMybatisDao<InsColumnTemp> {

	@Override
	public String getNamespace() {
		return InsColumnTemp.class.getName();
	}

	public Integer getCountByAlias(InsColumnTemp entity) {
		String tenantId=ContextUtil.getCurrentTenantId();
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("key", entity.getKey());
		params.put("id", entity.getId());
		Integer rtn=(Integer) this.getOne("getCountByKey", params);
		return rtn;
	}

	public InsColumnTemp getKey(String key) {
		String tenantId=ContextUtil.getCurrentTenantId();
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("key", key);
		InsColumnTemp rtn=(InsColumnTemp) this.getUnique("getByKey", params);
		return rtn;
	}
	

}

