package com.redxun.bpm.activiti.listener;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.delegate.event.ActivitiEvent;
import org.activiti.engine.delegate.event.impl.ActivitiActivityEventImpl;
import org.activiti.engine.delegate.event.impl.ActivitiEntityEventImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.saweb.util.IdUtil;

/**
 * 活动节点开始时的监听器
 * @author mansan
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2018 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActivityStartedListener implements EventHandler{
	
	protected Logger logger=LogManager.getLogger(ActivityStartedListener.class);
	
	@Resource 
	BpmRuPathManager bpmRuPathManager;
	@Resource 
	BpmInstManager bpmInstManager;
	@Resource 
	ActRepService actRepService;
	@Resource 
	RuntimeService runtimeService;
	@Resource 
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	RepositoryService repositoryService;

	
	
	
	/**
	 * 创建执行路径的数据，用于流程图的追踪，流程回退及执行等
	 */
	@Override
	public void handle(ActivitiEvent event) throws BpmRunException{
		logger.debug("enter the event ActivityStartedListener handler is .....============");
		//ActivitiEntityEventImpl e=(ActivitiEntityEventImpl)event;
		if(event instanceof ActivitiEntityEventImpl){
			System.out.println("ok");
		}
		ActivitiActivityEventImpl eventImpl=(ActivitiActivityEventImpl)event;
		String actDefId=eventImpl.getProcessDefinitionId();
		ProcessDefinitionEntity processDefEntity=(ProcessDefinitionEntity)repositoryService.getProcessDefinition(actDefId);
		String activityId=eventImpl.getActivityId();
		String entityName=eventImpl.getActivityName();
		
		ActivityImpl actImpl= processDefEntity.findActivity(activityId);
		Map<String, Object> propMap= actImpl.getProperties();
		
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		//多实例子流程设置临时变量。
		if(propMap.get("type").equals("subProcess") && propMap.containsKey("multiInstance")){
			cmd.addTransientVar("subMulti", true);
		}
		
		
		
		logger.debug("entity:"+activityId + " entityName:"+entityName);
		
		//记录执行路径。
		createRuPath( eventImpl);
		
	}
	
	/**
	 * 记录执行路径
	 * <pre>
	 * 	1.数据库表记录到BPM_RU_PATH
	 * </pre>
	 * 
	 * @param eventImpl
	 */
	private void createRuPath(ActivitiActivityEventImpl eventImpl){
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		ActNodeDef actNodeDef=actRepService.getActNodeDef(eventImpl.getProcessDefinitionId(), eventImpl.getActivityId());
		
		
		if(actNodeDef==null) return;
		String activityId=eventImpl.getActivityId();
		String nodeType=eventImpl.getActivityType();
		if(nodeType.indexOf("parallelGateway")!=-1 || nodeType.indexOf("inclusiveGateway")!=-1){
			return;
		}
		
		//判断一些并行的网关的结束点，防止其生成多条记录
		if( StringUtils.isNotEmpty(actNodeDef.getMultiInstance())){
			BpmRuPath ruPath= bpmRuPathManager.getFarestPath(eventImpl.getProcessInstanceId(),activityId);
			if(ruPath!=null)return;
		}
		
		//创建执行路径
		BpmRuPath path=new BpmRuPath();
		path.setPathId(IdUtil.getId());
		
		path.setActDefId(eventImpl.getProcessDefinitionId());
		path.setActInstId(eventImpl.getProcessInstanceId());
		path.setExecutionId(eventImpl.getExecutionId());
		path.setNodeName(actNodeDef.getNodeName());
		path.setNodeId(activityId);
		path.setNodeType(actNodeDef.getNodeType());
		//if("userTask".equals(path.getNodeType())){
		cmd.setRunPathId(path.getPathId());
		//}
		path.setStartTime(new Date());
		path.setToken(cmd.getToken());
		
		if(cmd instanceof ProcessStartCmd){//若为启动时，需要从线程中获得
			ProcessStartCmd startCmd=(ProcessStartCmd)cmd;
			path.setInstId(startCmd.getBpmInstId());
			path.setSolId(startCmd.getSolId());
		}else{
			BpmInst bpmInst=bpmInstManager.getByActInstId(eventImpl.getProcessInstanceId());
			path.setInstId(bpmInst.getInstId());
			path.setSolId(bpmInst.getSolId());
			path.setNextJumpType(((ProcessNextCmd)cmd).getNextJumpType());
		}
		//是否为多实例
		if(StringUtils.isNotEmpty(actNodeDef.getMultiInstance())){
//			String userIds=(String)runtimeService.getVariable(eventImpl.getExecutionId(), "signUserIds_"+activityId);
//			path.setUserIds(userIds);
			path.setIsMultiple(MBoolean.YES.name());
		}else{
			path.setIsMultiple(MBoolean.NO.name());
		}		
		
		//记录跳转的原节点,并且把跳转记录挂至该节点上
		BpmRuPath parentPath=null;
		if(cmd!=null && StringUtils.isNotEmpty(cmd.getNodeId())){
			parentPath=bpmRuPathManager.getFarestPath(eventImpl.getProcessInstanceId(),cmd.getNodeId());
		}
		if(parentPath!=null){
			path.setParentId(parentPath.getPathId());
			path.setLevel(parentPath.getLevel()+1);
		}else{
			path.setLevel(1);
			path.setParentId("0");
		}
		
		//是否由回退时产生的，若是需要记录回退时的流程ID
//		BpmRuPath bpmRuPath=ProcessHandleHelper.getBackPath();
//		if(bpmRuPath!=null){
//			path.setRefPathId(bpmRuPath.getPathId());
//		}
		//当从开始启动时，进入两次，这时需要记录其父ID
		//或在任务节点后的非任务点时，传递其父Id
		if(!"userTask".equals(actNodeDef.getNodeType())){
			String nodeId=eventImpl.getActivityId();
			cmd.setNodeId(nodeId);
		}
		
		bpmRuPathManager.create(path);
	}
}
