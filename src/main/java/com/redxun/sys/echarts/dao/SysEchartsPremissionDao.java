package com.redxun.sys.echarts.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.echarts.entity.SysEchartsPremission;

@Repository
public class SysEchartsPremissionDao extends BaseMybatisDao<SysEchartsPremission> {

	@Override
	public String getNamespace() {
		return SysEchartsPremission.class.getName();
	}

	public void delByTreeId(String treeId) {
		this.deleteBySqlKey("delByTreeId", treeId);
	}
	
	public List<SysEchartsPremission> getUserTreeGrant(Set<String> userIds, Set<String> groupIds, Set<String> subGroupIds){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userIds", userIds.toArray());
		params.put("groupIds", groupIds == null ? null : groupIds);
		params.put("subGroupIds", subGroupIds == null ? null : subGroupIds);
		return this.getBySqlKey("getUserTreeGrant", params);
	}
	
	public List<SysEchartsPremission> getByTreeId(String treeId){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("treeId", treeId);
		return this.getBySqlKey("getByTreeId", params);
	}
}
