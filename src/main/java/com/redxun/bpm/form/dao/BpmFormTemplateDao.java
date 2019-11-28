package com.redxun.bpm.form.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

/**
 * 
 * <pre> 
 * 描述：表单模版 DAO接口
 * 作者:ray
 * 日期:2016-12-01 15:05:06
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
import com.redxun.bpm.form.entity.BpmFormTemplate;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.saweb.context.ContextUtil;

@Repository
public class BpmFormTemplateDao extends BaseMybatisDao<BpmFormTemplate> {

	@Override
	public String getNamespace() {
		return BpmFormTemplate.class.getName();
	}
	
	/**
	 * 删除初始化的模版。
	 */
	public void delByInit(){
		this.deleteBySqlKey("delByInit");
	}
	

	/**
	 * 根据类型和分类获取表单模版。
	 * @param categroy	main,sub,field
	 * @param type	pc,mobile
	 * @return
	 */
	public List<BpmFormTemplate> getTemplateByType(String categroy,String type){
		Map<String,Object> params=new HashMap<String, Object>();
		String tenantId=ContextUtil.getCurrentTenantId();
		params.put("type", type);
		params.put("category", categroy);
		params.put("tenantId", tenantId);
		List<BpmFormTemplate>  list= this.getBySqlKey("getTemplateByType", params);
		return list;
	}
	
	/**
	 * 根据别名获取模版。
	 * @param alias
	 * @param type
	 * @return
	 */
	public BpmFormTemplate getTemplateByAlias(String alias,String type){
		Map<String,Object> params=new HashMap<String, Object>();
		String tenantId=ContextUtil.getCurrentTenantId();
		params.put("type", type);
		params.put("alias", alias);
		params.put("tenantId", tenantId);
		BpmFormTemplate  template= getUnique("getTemplateByAlias", params);
		return template;
	}
}

