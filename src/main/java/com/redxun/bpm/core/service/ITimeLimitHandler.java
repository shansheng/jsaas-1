package com.redxun.bpm.core.service;

/**
 * 时限计算处理器。
 * @author ray
 *
 */
public interface ITimeLimitHandler {
	
	/**
	 * 根据上下文变量任务到期时间，时间单位为分钟。
	 * @param userId	用户
	 * @param depId		部门
	 * @param actDefId	流程定义ID
	 * @param solId		解决方案ID
	 * @param nodeId	节点ID
	 * @param instId	流程实例
	 * @param taskId	任务Id
	 * @return
	 */
	Integer getExpireTimeLimit(String userId,String depId,String actDefId,String solId,
			String nodeId, String instId,String taskId);
	
	
	/**
	 * 根据上下文变量计算消息发送时间，时间单位为分钟。
	 * @param userId	当前执行人
	 * @param depId		当前人部门
	 * @param actDefId	流程定义ID
	 * @param solId		解决方案ID
	 * @param nodeId	节点ID
	 * @param instId	流程实例ID
	 * @param taskId	任务ID
	 * @return
	 */
	Integer getSendTimeLimit(String userId,String depId,String actDefId,String solId,
			String nodeId,String instId,String taskId);

}
