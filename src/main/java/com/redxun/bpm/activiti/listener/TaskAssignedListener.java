package com.redxun.bpm.activiti.listener;

import javax.annotation.Resource;

import com.redxun.bpm.core.entity.BpmTask;
import org.activiti.engine.delegate.event.ActivitiEntityEvent;
import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.manager.BpmAgentManager;
import com.redxun.core.util.BeanUtil;

/**
 * 处理代理任务
 * 1.判断任务执行人是否为空
 * 2.如果不为空则查询该人是否有有效的代理人。
 * 3.如果找到代理人则进行设置代理。
 * @author mansan
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class TaskAssignedListener implements EventHandler {
	
	@Resource
	BpmAgentManager bpmAgentManager;

	protected Logger logger=LogManager.getLogger(TaskAssignedListener.class);
	
	@Override
	public void handle(ActivitiEvent event)throws BpmRunException{
		ActivitiEntityEvent actEvent=(ActivitiEntityEvent)event;
		TaskEntity taskEntity=(TaskEntity)actEvent.getEntity();
		
		String assginee=taskEntity.getAssignee();
		IExecutionCmd processNextCmd=ProcessHandleHelper.getProcessCmd();
		//1.如果执行人为空则不管代理
		if(StringUtils.isEmpty(assginee))  return;
		
		String solId=(String) taskEntity.getVariable("solId");
		//2.获取代理人。
		String userId=bpmAgentManager.getAgentByUserId(assginee, solId, taskEntity.getVariables());
		if(BeanUtil.isEmpty(userId)) return;
		//3.存在代理人则设置代理。
		taskEntity.setAgentUserId(userId);
		taskEntity.setTaskType(BpmTask.TASK_TYPE_AGENT);
		setCmdAgentUser(processNextCmd,taskEntity.getAgentUserId());
	}
	
	private void setCmdAgentUser(IExecutionCmd cmd,String userId){
		if(cmd instanceof ProcessNextCmd){
			((ProcessNextCmd) cmd).setAgentToUserId(userId);
		}
	}
}
