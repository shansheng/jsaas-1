package com.redxun.bpm.core.entity;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import com.alibaba.fastjson.JSONObject;

/**
 * 流程执行的接口
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface IExecutionCmd extends Serializable {
	
	public final static String FORM_OPINION="FORM_OPINION_";
	
	/**
	 * 获得需要跳转的后续节点ID
	 * @return
	 */
	String getDestNodeId();
	/**
	 * 获得后续节点的人员执行映射列表
	 * @return
	 */
	Map<String, BpmDestNode> getNodeUserMap();
	/**
	 * 获得提交的业务数据JSON
	 * @return
	 */
	String getJsonData();
	
	/**
	 * 获得提交的业务数据JSON对象
	 * @return
	 */
	JSONObject getJsonDataObject();
	
	/**
	 * 用于获得BO中的业务对象Map
	 * @return
	 */
	Map<String,JSONObject> getBoDataMaps();
	
	/**
	 * 获得当前实例Id
	 * @return
	 *//*
	String getActInstId();
	
	*//**
	 * 设置当前实例Id
	 * @param executionId
	 *//*
	void setActInstId(String actInstId);*/
	/**
	 * 获得当前节点ID
	 * @return
	 */
	String getNodeId();
	
	/**
	 * 获得当前办理的任务节点Id
	 * @return
	 */
	String getHandleNodeId();
	
	/**
	 * 设置当前执行节点的Id
	 * @param nodeId
	 */
	void setNodeId(String nodeId);
	/**
	 * 获得跳转的方式
	 * @return
	 */
	String getJumpType();
	/**
	 * 获得审批意见
	 * @return
	 */
	String getOpinion();
	
	/**
	 * 审批意见表单名称。
	 * @return
	 */
	String getOpinionName();
	/**
	 * 获得审批意见
	 * @return
	 */

	String getOpFiles();
	
	String getBpmInstId();
	/**
	 * 获得需要跳过的任务ID集合
	 * @return
	 */
	//Map<String,String> getSkipCheckTaskUserIds();
	List<TaskEntity> getNewTasks();
	
	void addTask(TaskEntity entity);
	
	void cleanTasks();
	
	/**
	 * 获得令牌
	 * @return
	 */
	String getToken();
	
	void setToken(String token);
	
	void setRunPathId(String runPathId);
	
	String getRunPathId();
	
	String getTimeoutStatus();
	
	/**
	 * 获取瞬态变量。
	 * @return
	 */
	Map<String,Object> getTransientVars();
	
	/**
	 * 添加瞬态变量。
	 * @param name
	 * @param obj
	 */
	void addTransientVar(String name,Object obj);
	
	/**
	 * 清除瞬态变量。
	 */
	void clearTransientVars();
}
