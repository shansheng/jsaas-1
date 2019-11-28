
/**
 * 
 * <pre> 
 * 描述：SYS_ES_LIST DAO接口
 * 作者:ray
 * 日期:2019-01-19 15:01:59
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.SysEsList;

@Repository
public class SysEsListDao extends BaseMybatisDao<SysEsList> {

	@Override
	public String getNamespace() {
		return SysEsList.class.getName();
	}

	public SysEsList getByAlias(String alias) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("alias", alias);
		return this.getUnique("getByAlias", params);
	}
	

}

