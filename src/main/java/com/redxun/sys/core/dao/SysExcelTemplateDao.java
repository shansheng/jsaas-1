
/**
 * 
 * <pre> 
 * 描述：EXCEL导入模板 DAO接口
 * 作者:ray
 * 日期:2018-12-20 11:56:39
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.entity.SysExcelTemplate;

@Repository
public class SysExcelTemplateDao extends BaseMybatisDao<SysExcelTemplate> {

	@Override
	public String getNamespace() {
		return SysExcelTemplate.class.getName();
	}
	
	public SysExcelTemplate getByAlias(String alias){
		Map<String,Object> params=new HashMap<>();
		params.put("alias", alias);
		return this.getUnique("getByAlias", params);
	}
	
	public int getCountByKey(String alias,String tenantId,String id){
		Map<String,Object> params=new HashMap<>();
		params.put("alias", alias);
		params.put("tenantId", tenantId);
		if(StringUtil.isNotEmpty(id)){
			params.put("id", id);
		}
		return (int) this.getOne("getCountByKey", params);
	}	

}

