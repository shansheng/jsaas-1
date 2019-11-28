package com.redxun.bpm.core.dao;

import java.util.List;

import com.redxun.saweb.context.ContextUtil;
import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;

@Repository
public class BpmInstCcDao extends BaseMybatisDao<BpmInstCc>{
	@Override
	public String getNamespace() {
		return BpmInstCc.class.getName();
	}
	
	public List<BpmInstCc> getToMeCcInsts(QueryFilter filter){
		filter.addFieldParam("tenantId", ContextUtil.getCurrentTenantId());
		return this.getPageBySqlKey("getToMeCc", filter) ;
	}
	
	/**
     * 按流程实例删除抄送
     * @param instId
     */
    public void delByInstId(String instId){
    	this.deleteBySqlKey("delByInstId", instId);
    }
}
