
/**
 * 
 * <pre> 
 * 描述：执行脚本配置 DAO接口
 * 作者:ray
 * 日期:2018-10-18 11:06:29
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.SysInvokeScript;

@Repository
public class SysInvokeScriptDao extends BaseMybatisDao<SysInvokeScript> {

	@Override
	public String getNamespace() {
		return SysInvokeScript.class.getName();
	}
	
	
	/**
	 * 根据别名获取调用脚本。
	 * @param alias
	 * @param tenantId
	 * @return
	 */
	public SysInvokeScript getByAlias(String alias,String tenantId){
		Map<String,Object> params=new HashMap<>();
		params.put("alias", alias);
		params.put("tenantId", tenantId);
		SysInvokeScript script=this.getUnique("getByAlias", params);
		return script;
	}

}

