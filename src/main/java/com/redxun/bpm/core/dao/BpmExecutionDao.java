package com.redxun.bpm.core.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.bpm.core.entity.BpmExecution;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
@Repository
public class BpmExecutionDao extends BaseMybatisDao<BpmExecution>
{
	@Override
	public String getNamespace() {
		return com.redxun.bpm.core.entity.BpmExecution.class.getName();
	}
	/**
	 * 更新主线程的执行为当前节点
	 * @param executionId
	 * @param nodeId
	 */
	public void updateMainThread(String executionId,String nodeId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("nodeId", nodeId);
		params.put("executionId", executionId);
		this.updateBySqlKey("updateMainThread", params);
	}
	
	/**
	 * 按流程实例Id删除非主线程的Execution
	 * @param procInstId
	 */
	public void delNotMainThread(String procInstId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("procInstId", procInstId);
		this.deleteBySqlKey("delNotMainThread", params);
	}
	/**
	 * 把当前任务更新回主线程上
	 * @param executionId
	 * @param taskId
	 */
	public void updateTaskToMainThreadId(String executionId,String taskId){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("executionId", executionId);
		params.put("taskId", taskId);
		updateBySqlKey("updateTaskToMainThreadId",params);
	}
	/**
	 * 删除非主线程Id
	 * @param executionId
	 */
	public void delExecutionById(String executionId)
	{
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("executionId", executionId);
		this.deleteBySqlKey("delCandidateByProcInstId",params);
		this.deleteBySqlKey("delById", params);
	}
	
	public void delTokenVarByTaskId(String taskId,String token){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("taskId", taskId);
		params.put("name", token);
		this.deleteBySqlKey("delTokenVarByTaskId", params);
	}
	
	/**
	 * 根据流程实例Id删除流程变量。
	 * @param procInstId
	 */
	public void delVariableByProcInstId(String procInstId){
		this.deleteBySqlKey("delVariableByProcInstId", procInstId);
	}
	
	/**
	 * 根据流程实例ID删除execution表。
	 * @param procInstId
	 */
	public void delExecutionByProcInstId(String procInstId){
		this.deleteBySqlKey("delCandidateByProcInstId",new Object[]{procInstId});
		this.deleteBySqlKey("delExecutionByProcInstId", procInstId);
	}
	
	public List<BpmExecution> getByProcInstId(String procInstId){
		return this.getBySqlKey("getByProcInstId", procInstId);
	}
	
	/**
	 * 删除出主线程之外的excution。
	 * @param procInstId
	 */
	public void delSubExecutionByProcInstId(String procInstId){
		deleteBySqlKey("delSubExecutionByProcInstId", procInstId);
	}

	public void updateRevByInstanceId(String actInstId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("actInstId", actInstId);
		updateBySqlKey("updateRevByInstanceId",params);
	}

	public void delVarsByExecutionId(String executionId) {
		this.deleteBySqlKey("delVarsByExecutionId", executionId);
	}
	
	public List<BpmExecution> getByParentId(String parentId){
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("parentId", parentId);
		List<BpmExecution> list=this.getBySqlKey("getByParentId", parentId);
		return list;
	}
	
	/**
	 * 根据流程实例Id删除非主线程的流程变量及子流程实例。
	 * @param procInstId
	 */
	public void delSubByProcInstId(String procInstId){
		//删除子流程的流程变量
		this.deleteBySqlKey("delSubVarByProcInstId", procInstId);
		//删除子流程的实例
		this.deleteBySqlKey("delSubInstByProcInstId", procInstId);		
	}
	
	/**
	 * 根据流程实例Id删除非主线程的流程变量及子流程实例。
	 * @param procInstId
	 */
	public List<BpmExecution> getSubExecutionByProcInstId(String procInstId){
		return this.getBySqlKey("getSubExecutionByProcInstId", procInstId)	;
	}

	/**
	 * 
	 * @param procInstId
	 * @return
	 */
	public List<BpmExecution> getExecutionBySuperId(String procInstId){
		return this.getBySqlKey("getExecutionBySuperId", procInstId)	;
	}
	
	/**
	 * 
	 * @param procInstId
	 * @return
	 */
	public List<BpmExecution> getSubExecutionBySuperId(String id){
		return this.getBySqlKey("getSubExecutionBySuperId", id)	;
	}
	
	public void delVarByInstIdAndVarName(Long procInstId,String name){
		Map<String, Object> vars=new HashMap<String, Object>();
		vars.put("procInstId", procInstId);
		vars.put("name", name);
		this.deleteBySqlKey("delVarByInstIdAndVarName", vars);
	}
	
	
	public void delSubVariableByProcInstId(Long procInstId) {
		//删除子流程的流程变量
		this.deleteBySqlKey("delSubVarByProcInstId", procInstId);	
	}
	
	public void delIdentityByExecution(String executionId){
		this.deleteBySqlKey("delIdentityByExecution", executionId);	
	}
	
	public void delTaskByExecution(String executionId){
		this.deleteBySqlKey("delTaskByExecution", executionId);	
	}
	
	public void delVarsByExecution(String executionId){
		this.deleteBySqlKey("delVarsByExecution", executionId);	
	}
	
	
}
