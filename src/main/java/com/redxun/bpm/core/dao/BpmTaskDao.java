package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.util.WebAppUtil;

@Repository
public class BpmTaskDao extends BaseMybatisDao<BpmTask>{

	@Override
	public String getNamespace() {
		return BpmTask.class.getName();
	}
	
	public List<BpmTask> getByUserId(QueryFilter filter){
		return this.getPageBySqlKey("getByUserId", filter);
	}
	
	/**
	 * 获得用户及组下的所有的待办数
	 * @param userId
	 * @param groupIdList
	 * @return
	 */
	public Long getTaskCountsByUserId(String userId,String tenantId,List<String>groupIdList){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("userId",userId);
		params.put("groupList",groupIdList);
		params.put("tenantId",tenantId);
		Object counts=this.getOne("getTaskCountsByUserId", params);
		if(counts!=null){
			return new Long(counts.toString());
		}
		return 0L;
	}

	
	public List<BpmTask> getAgentToTasks(QueryFilter filter){
		return this.getPageBySqlKey("getAgentToTasks", filter);
	}

	public List<BpmTask> getMyAgentTasks(QueryFilter filter){
		return this.getPageBySqlKey("getMyAgentTasks",filter);
	}
	
	/**
	 * 查找所有的任务
	 * @param filter
	 * @return
	 */
	public List<BpmTask> getAllTasks(QueryFilter filter){
		return this.getPageBySqlKey("getAllTasks", filter);
	}
	
	public List<BpmTask> getTasks(QueryFilter filter){
		return this.getPageBySqlKey("getTasks", filter);
	}
	
	/**
	 * 按流程实例Id及非任务Id删除
	 * @param actInstId
	 * @param taskId
	 */
	public void delByActInstIdNotTaskId(String actInstId,String taskId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		params.put("taskId", taskId);
		this.deleteBySqlKey("delByActInstIdNotTaskId", params);
	}
	
	public void delTaskUsersByActId(String actInstId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		this.deleteBySqlKey("delTaskUsersByActId", params);
	}
	
	/**
	 * 获取流程实例用过的分类数据。
	 * @param tenantId
	 * @param profileMap
	 * @return
	 */
	public List getCategoryTree(String tenantId, Map<String, Set<String>> profileMap){
		Map<String, Object> params=new HashMap<String, Object>();
		String grantType=BpmAuthSettingManager.getGrantType();
		params.put("tenantId", tenantId);
		params.put("profileMap", profileMap);
		params.put("grantType", grantType);
		return this.getBySqlKey("getCategoryTree", params);
	}
	
	/**
	 * 获得实例非当前任务Id的其他任务
	 * @param actInstId
	 * @param taskId
	 * @return
	 */
	public List<BpmTask> getByActInstIdNotTaskId(String actInstId,String taskId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		params.put("taskId", taskId);
		return this.getBySqlKey("getByActInstIdNotTaskId", params);
	}
	/**
	 * 根据以下参数查找唯一的BpmTask
	 * @param solId
	 * @param actDefId
	 * @param nodeId
	 * @param instId
	 * @return
	 */
	public BpmTask getBySolIdActDefIdNodeIdInstId(String solId,String actDefId,String nodeId,String instId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("solId", solId);
		params.put("actDefId", actDefId);
		params.put("nodeId", nodeId);
		params.put("instId", instId);
		return this.getUnique("getBySolIdActDefIdNodeIdInstId", params);
	}
	
	/**
	 * 根据父实例ID获取任务列表。
	 * @param parentId
	 * @return
	 */
	public List<BpmTask> getByParentExecutionId(String parentId){
		List<BpmTask> list= this.getBySqlKey("getByParentExecutionId", parentId);
		return list;
	}
	
	
	public List<BpmTask> getByActInstId(String actInstId){
		Map<String, String> params=new HashMap<>();
		params.put("actInstId", actInstId);
		params.put("nodeId", "");
    	List<BpmTask> list= this.getBySqlKey("getByActInstId", params);
		return list;
    }
	
	public List<BpmTask> getByActInstNode(String actInstId,String nodeId){
		Map<String, String> params=new HashMap<>();
		params.put("actInstId", actInstId);
		params.put("nodeId", nodeId);
		List<BpmTask> list= this.getBySqlKey("getByActInstId", params);
		return list;
    }
	
	public List<BpmTask> getByRcTaskId(String rcTaskId){
		List<BpmTask> list= this.getBySqlKey("getByRcTaskId", rcTaskId);
		return list;
    }

	public List<BpmTask> getByInstId(String instId) {
		List<BpmTask> list= this.getBySqlKey("getByInstId", instId);
		return list;
	}


}
