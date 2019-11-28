
/**
 * 
 * <pre> 
 * 描述：项目 DAO接口
 * 作者:陈茂昌
 * 日期:2017-09-29 14:38:27
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.oa.article.dao;

import com.redxun.oa.article.entity.ProItem;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class ProItemDao extends BaseMybatisDao<ProItem> {

	@Override
	public String getNamespace() {
		return ProItem.class.getName();
	}

	public ProItem getByKey(String key, String adminTenantId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("alias", key);
		params.put("tenantId", adminTenantId);
		return this.getUnique("getByKey", params);
	}

}

