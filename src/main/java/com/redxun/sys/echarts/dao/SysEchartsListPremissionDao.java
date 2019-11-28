package com.redxun.sys.echarts.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.echarts.entity.SysEchartsListPremission;

@Repository
public class SysEchartsListPremissionDao  extends BaseMybatisDao<SysEchartsListPremission>  {

	@Override
	public String getNamespace() {
		return SysEchartsListPremission.class.getName();
	}

	public List<SysEchartsListPremission> getByPreId(String preId){
		return this.getBySqlKey("getByPreId", preId);
	}
	
	public void delByTreeId(String preId) {
		this.deleteBySqlKey("delByPreId", preId);
	}
}
