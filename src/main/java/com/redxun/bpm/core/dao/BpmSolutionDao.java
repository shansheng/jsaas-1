package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.WebAppUtil;
/**
 * 流程解决方案查询
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Repository
public class BpmSolutionDao extends BaseMybatisDao<BpmSolution>{

	@Override
	public String getNamespace() {
		return BpmSolution.class.getName();
	}
	
	
	/**
	 * 获取管理员列表。
	 * @param filter
	 * @return
	 */
	public List<BpmSolution> getSolutionsByAdmin(QueryFilter filter){
		return this.getPageBySqlKey("getSolutionsByAdmin", filter);
	}
	
	public List<BpmSolution> getSolutions(QueryFilter filter){
		return this.getPageBySqlKey("getSolutions", filter);
	}
	
	/**
	 * 获取树
	 * @param tenantId
	 * @param profileMap
	 * @return
	 */
	public List getCategoryTree(String tenantId,String userId,boolean isAdmin, Map<String, Set<String>> profileMap){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("TENANT_ID_", tenantId);
		params.put("userId", userId);
		params.put("profileMap", profileMap);
		if(isAdmin){
			params.put("admin", "admin");
		}
		params.put("rightType", isAdmin?"def":"start");
		String grantType=BpmAuthSettingManager.getGrantType();
		params.put("grantType", grantType);
		return this.getBySqlKey("getCategoryTree", params);
	}
	
	/**
	 * 根据租户和key判断是否存在数据。
	 * @param bpmSolution
	 * @return
	 */
	public Integer getCountByKey(BpmSolution bpmSolution){
		Integer rtn=(Integer) this.getOne("getCountByKey", bpmSolution);
		return rtn;
	}
	
	/**
	 * 根据主键和key查询是否有数据，如果存在表示key没有修改，不存在表示key被修改。
	 * @param bpmSolution
	 * @return
	 */
	public Integer getCountByKeyId(BpmSolution bpmSolution){
		Integer rtn=(Integer) this.getOne("getCountByKeyId", bpmSolution);
		return rtn;
	}
	
	/**
	 * 返回treeId不为空的bpmauthdef所对应的solution
	 * @return
	 */
	public List getAllNotEmptyTreeId(){
		String tenantId=ContextUtil.getCurrentTenantId();
		return this.getBySqlKey("getAllNotEmptyTreeId",tenantId);
	}
	
	/**
	 * 
	 * @param actDefId
	 * @return
	 */
	public Integer getCountByActdefId(String actDefId){
		Integer rtn=(Integer) this.getOne("getCountByActdefId", actDefId);
		return rtn;
	}
	
	
	/**
     * 按流程定义Key获得解决方案
     * @param defKey
     * @param tenantId
     * @return
     */
    public List<BpmSolution> getByDefKey(String defKey,String tenantId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("defKey", defKey);
    	params.put("tenantId", tenantId);
    	
    	return this.getBySqlKey("getByDefKey", params);
    }
    
    /**
     * 获得所有状态为DEPLOYED的解决方案
     * @return
     */
    public List<BpmSolution> getDeployedSol(){
    	Map<String, Object> params=new HashMap<String, Object>();
    	List<BpmSolution> list=this.getBySqlKey("getDeployedSol", params);
    	return list;
    }
    
    /**
     * 通过Key获得解决方案
     * @param key
     * @param tenantId
     * @return
     */
    public BpmSolution getByKey(String key,String tenantId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("key", key);
    	params.put("tenantId", tenantId);
    	return (BpmSolution)this.getUnique("getByKey",params);
    }
    
    public List<BpmSolution> getByTreeId(String treeId){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("treeId", treeId);
    	
    	return this.getBySqlKey("getByTreeId",params);
    
    }
	
	/**
     * 按流程定义Key获得解决方案
     * @param defKey
     * @param tenantId
     * @return
     */
    public BpmSolution getByDefKeyId(String actDefId, String solId, String tenantId) {
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("actDefId", actDefId);
    	params.put("solId", solId);
    	params.put("tenantId", tenantId);
    	
    	return (BpmSolution)this.getUnique("getByDefKeyId", params);
    }
}
