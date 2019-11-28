
/**
 * 
 * <pre> 
 * 描述：手机表单配置表 DAO接口
 * 作者:ray
 * 日期:2016-12-05 13:41:07
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
package com.redxun.bpm.form.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.form.entity.BpmMobileForm;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.core.entity.SysInst;

@Repository
public class BpmMobileFormDao extends BaseMybatisDao<BpmMobileForm> {

	@Override
	public String getNamespace() {
		return BpmMobileForm.class.getName();
	}
	
	/**
	 * 判断系统中是否存在指定别名的数据。
	 * @param mobileForm
	 * @return
	 */
	public Integer isAliasExist(Map<String,Object> params){
		
		return (Integer) this.getOne("isAliasExist", params);
	}

	/**
	 * 根据viewId获取关联的手机表单。
	 * @param viewId
	 * @return
	 */
	public List<BpmMobileForm> getByBoDefId(String[] aryBoDefId,String tenantId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("boDefIds", aryBoDefId);
		params.put("tenantId", tenantId);
		return  this.getBySqlKey("getByBoDefId", params);
	}

	/**
	 * 根据表单别名获取手机表单。
	 * @param alias
	 * @return
	 */
	public BpmMobileForm getByAlias(String alias){
		String tenantId=ContextUtil.getCurrentTenantId();
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("alias", alias);
		params.put("tenantId", tenantId);
		BpmMobileForm mobileForm=  this.getUnique("getByAlias", params);
		if(BeanUtil.isNotEmpty(mobileForm)) return mobileForm;
		params.put("tenantId", SysInst.ADMIN_TENANT_ID);
		mobileForm=  this.getUnique("getByAlias", params);
		return mobileForm;
		
	}
	
	
}

