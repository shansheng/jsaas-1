
/**
 * 
 * <pre> 
 * 描述：SYS_WORD_TMPLATE【模板表】 DAO接口
 * 作者:mansan
 * 日期:2018-05-29 14:54:08
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.SysWordTemplate;

@Repository
public class SysWordTemplateDao extends BaseMybatisDao<SysWordTemplate> {

	@Override
	public String getNamespace() {
		return SysWordTemplate.class.getName();
	}
	
	
	public SysWordTemplate getByAlias(String alias){
		return (SysWordTemplate) this .getOne("getByAlias", alias);
	}
	
	public Integer isAliasExist(String id,String alias){
		Map<String,Object> params=new HashMap<>();
		params.put("alias", alias);
		params.put("id", id);
		return (Integer) this.getOne("isAliasExist", params);
	}

}

