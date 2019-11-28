
/**
 * 
 * <pre> 
 * 描述：模板文件管理表 DAO接口
 * 作者:ray
 * 日期:2018-11-01 16:22:39
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.code.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.sys.code.entity.SysCodeTemp;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class SysCodeTempDao extends BaseMybatisDao<SysCodeTemp> {

	@Override
	public String getNamespace() {
		return SysCodeTemp.class.getName();
	}

	public SysCodeTemp getByAlias(String alias, String tenantId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("alias", alias);
		params.put("tenantId", tenantId);
		return this.getUnique("getByAlias", params);
	}
	

}

