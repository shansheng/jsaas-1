package com.redxun.sys.core.dao;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.sys.core.entity.Subsystem;
/**
 * 子系统查询
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Repository
public class SubsystemDao extends BaseMybatisDao<Subsystem>{
	@Override
	public String getNamespace() {
		return Subsystem.class.getName();
	}
	
	/**
	 * 获得用户组授权下的子系统
	 * @param groupIds
	 * @return
	 */
	public List<Subsystem> getGrantSubsByGroupIds(Collection<String> groupIds){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("groupIdList", groupIds);
		return this.getBySqlKey("getGrantSubsByGroupIds", params);
	}
	
	/**
	 * 获得用户组允许访问的子系统
	 * @param groupId
	 * @return
	 */
	public List<Subsystem> getGrantSubsByGroupId(String groupId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("groupId", groupId);
		return this.getBySqlKey("getGrantSubsByGroupId", params);
	}
	
	public List<Subsystem> getGrantSubsByUserId(String userId,String tenantId,String instType){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("tenantId", tenantId);
		params.put("instType", instType);
		return this.getBySqlKey("getGrantSubsByUserId", params);
	}
	
	
	public List<Subsystem> getByStatus(String status){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("status", status);
		return this.getBySqlKey("getByStatus", params);
	}
	
	public List<Subsystem> getByInstTypeStatus(String instType,String status){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("instType", instType);
		params.put("status", status);
		return this.getBySqlKey("getByInstTypeStatus", params);
	}
	

	/**
	 * 
	 * 按Key与tenantId获取其值
	 * @param key
	 * @param tenantId
	 * @return SysTreeCat
	 * @exception
	 * @since 1.0.0
	 */
	public Subsystem getByKey(String key) {
		
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("key", key);
		Subsystem subsystem=this.getUnique("getByKey", params);
		return subsystem;
	}
	
	 
    /**
     * 获得所有子系统并排序
     * @return
     */
    public List<Subsystem> getAllOrderBySn(){
    	
    	List<Subsystem> list= this.getBySqlKey("getAllOrderBySn", null);
    	return list;
    }
	
	/**
	 * 按状态查找子系统
	 * @param status
	 * @return
	 */
	public List<Subsystem> getByTenantStatus(String status,String tenantId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("tenantId", tenantId);
		params.put("status", status);
		List<Subsystem> list= this.getBySqlKey("getByTenantStatus", params);
    	return list;
	}
	
	

}
