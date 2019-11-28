
/**
 * 
 * <pre> 
 * 描述：人员脚本 DAO接口
 * 作者:ray
 * 日期:2017-06-01 11:33:08
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.List;

import com.redxun.bpm.core.entity.BpmGroupScript;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.context.ContextUtil;

@Repository
public class BpmGroupScriptDao extends BaseMybatisDao<BpmGroupScript> {

	@Override
	public String getNamespace() {
		return BpmGroupScript.class.getName();
	}
	
	public List getAllClass(QueryFilter queryFilter){
		return this.getPageBySqlKey("getAllClass", queryFilter);
	}
	
	public List<BpmGroupScript> getAllClass(){
		
		String tenantId=ContextUtil.getCurrentTenantId();
		
		return this.getBySqlKey("getAllClass", tenantId);
	}

}

