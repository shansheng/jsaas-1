package com.redxun.bpm.core.identity.service;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.TaskExecutor;

/**
 * 流程人员计算服务类
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface BpmIdentityCalService {
	/**
	 * 模拟计算
	 */
	public final String SIMULATE_CAL="SIMULATE_CAL";
	
	
	/**
	 * 计算节点的人员
	 * @param actDefId 流程定义Id
	 * @param nodeId 流程节点Id
	 * @param vars 流程变量
	 * @return
	 */
	Collection<TaskExecutor> calNodeUsersOrGroups(String actDefId,String nodeId,Map<String,Object> vars);
	
	/**
	 * 计算节点的用户及组
	 * @param actDefId
	 * @param nodeId
	 * @param bpmSolUsers
	 * @param vars
	 * @return
	 */
	Set<TaskExecutor> calNodeUsersOrGroups(String actDefId,String nodeId,List<BpmSolUser> bpmSolUsers,Map<String,Object> vars);
}
