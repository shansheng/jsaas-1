
/**
 * 
 * <pre> 
 * 描述：ES自定义查询 DAO接口
 * 作者:ray
 * 日期:2018-11-28 14:21:52
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.entity.SysEsQuery;

@Repository
public class SysEsQueryDao extends BaseMybatisDao<SysEsQuery> {

	@Override
	public String getNamespace() {
		return SysEsQuery.class.getName();
	}
	
	/**
	 * 根据别名获取数量。
	 * @param alias			别名
	 * @param tenantId		租户
	 * @param id			主键ID
	 * @return
	 */
	public Integer getCountByAlias(String alias,String tenantId,String id){
		Map<String ,String> params=new HashMap<>();
		params.put("alias", alias);
		params.put("tenantId",tenantId);
		if(StringUtil.isNotEmpty(id)){
			params.put("id",id);
		}
		Integer rtn=(Integer) this.getOne("getCountByAlias", params);
		
		return rtn;
		
	}
	
	/**
	 * 根据别名获取es查询对象。
	 * @param alias
	 * @param tenantId
	 * @return
	 */
	public SysEsQuery getByAlias(String alias,String tenantId){
		Map<String ,Object> params=new HashMap<>();
		params.put("alias", alias);
		params.put("tenantId",tenantId);
		SysEsQuery esQuery=this.getUnique("getByAlias", params);
		return esQuery;
	}
}

