package com.redxun.microsvc.bpm;

import java.util.List;

import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.microsvc.bpm.entity.ActivitiNode;
import com.redxun.microsvc.bpm.entity.ApproveModel;
import com.redxun.microsvc.bpm.entity.BpmSolutionModel;
import com.redxun.microsvc.bpm.entity.PageParamsModel;
import com.redxun.microsvc.bpm.entity.StartModel;

/**
 * 微服务接口。
 * @author ray
 *
 */
public interface BpmService {

	/**
	 * 启动流程
	 * @param cmd
	 * @return
	 */
	JsonResult<BpmInst>  startProcess(StartModel cmd);
	
	/**
	 * 审批任务。
	 * @param cmd
	 * @return
	 */
	JsonResult  doNext(ApproveModel model);
	
	
	/**
	 * 根据流程实例ID获取任务列表情况。
	 * @param instId
	 * @return
	 */
	JsonResult<BpmTask> getTasksByInstId(String instId);
	
	
	/**
	 * 根据用户获取待办任务。
	 * @param model
	 * @return
	 */
	JsonPageResult<BpmTask> getTasksByUserAccount(PageParamsModel model);
	
	
	/**
	 * 根据任务ID获取后续节点。
	 * @param taskId
	 * @return
	 */
	JsonResult<List<ActivitiNode>> getTaskOutNodes(String taskId);
	
	/**
	 * 获取我有权限的解决方案。
	 * @param model
	 * @return
	 */
	JsonPageResult<BpmSolutionModel> getMySolutions(PageParamsModel model);
	
	/**
	 * 撤销实例任务。
	 * @param account
	 * @param instId
	 * @return
	 */
	JsonResult recoverInst(String account,String instId);
	
	/**
	 * 获取代理给我的任务。
	 * @param model
	 * @return
	 */
	JsonPageResult<BpmTask> getMyAgentTasks(PageParamsModel model);
}
