
/**
 * 
 * <pre> 
 * 描述：系统自定义业务管理列表 DAO接口
 * 作者:mansan
 * 日期:2017-05-21 12:11:18
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.SysBoList;

@Repository
public class SysBoListDao extends BaseMybatisDao<SysBoList> {

	@Override
	public String getNamespace() {
		return SysBoList.class.getName();
	}

	public SysBoList getByKey(String key, String tenantId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("key", key);
		params.put("tenantId", tenantId);
		return this.getUnique("getByKey", params);
	}
}

