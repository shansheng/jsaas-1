package com.redxun.bpm.activiti.listener;

import java.util.Date;

import javax.annotation.Resource;

import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.impl.ActivitiActivityEventImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.manager.BpmExecutionManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.enums.ActivityEventType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;

/**
 * 活动节点结束时的监听器
 * @author mansan
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActivityCompletedListener implements EventHandler{
	
	protected static Logger logger=LogManager.getLogger(ActivityCompletedListener.class);
	
	@Resource 
	BpmRuPathManager bpmRuPathManager;
	@Resource
	BpmExecutionManager bpmExecutionManager ; 
	@Resource 
	ActRepService actRepService;
	

	
	@Override
	public void handle(ActivitiEvent event)throws BpmRunException{
		
		
		
		logger.debug("enter the event ActivityCompletedListener handler is .....============");
		ActivitiActivityEventImpl eventImpl=(ActivitiActivityEventImpl)event;
		
		
		//记录当前节点，在下一个节点进行使用。
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		if(cmd==null) return;
		
		cmd.setNodeId(eventImpl.getActivityId());
		updBpmRuPath(eventImpl.getProcessInstanceId(), eventImpl.getActivityId(), cmd);
	}
	
	/**
	 * 修正rupath
	 * @param actInstId
	 * @param nodeId
	 * @param cmd
	 */
	private void updBpmRuPath(String actInstId,String nodeId,IExecutionCmd cmd){
		BpmRuPath ruPath=null;
		if(StringUtils.isNotEmpty(cmd.getRunPathId())){
			ruPath=bpmRuPathManager.get(cmd.getRunPathId());
		}else{
			if(StringUtil.isNotEmpty(cmd.getToken())){
				ruPath=bpmRuPathManager.getFarestPath(actInstId,nodeId,cmd.getToken());
			}else{
				ruPath=bpmRuPathManager.getFarestPath(actInstId,nodeId);
			}
		}
		
		if(ruPath==null) return;
		
		ruPath.setAssignee(ContextUtil.getCurrentUserId());
		//FIXME 设置代理人，表示代理谁来执行
		//ruPath.setAgnentUserId(aValue);
		if(cmd instanceof ProcessNextCmd){
			ruPath.setToUserId(((ProcessNextCmd)cmd).getAgentToUserId());
		}
		
		ruPath.setEndTime(new Date());
		Long duration=ruPath.getEndTime().getTime()-ruPath.getStartTime().getTime();
		ruPath.setDuration(duration);
		//TODO，结合工作日历计算有效时间
		ruPath.setDurationVal(duration);
		ruPath.setToken(cmd.getToken());
		if(cmd!=null && "userTask".equals(ruPath.getNodeType())){
			if(StringUtils.isNotEmpty(cmd.getJumpType())){
				ruPath.setJumpType(cmd.getJumpType());
				ruPath.setOpinion(cmd.getOpinion());
			}else{
				ruPath.setJumpType(TaskOptionType.AGREE.name());
				ruPath.setOpinion("");
			}
		}
		if(cmd.getTransientVars().containsKey("signUsers")){
			ruPath.setUserIds((String)cmd.getTransientVars().get("signUsers"));
		}
		//更新其数据
		bpmRuPathManager.update(ruPath);
	}
}
