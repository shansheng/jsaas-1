package com.redxun.bpm.core.manager;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.listener.EventUtil;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.dao.BpmExecutionDao;
import com.redxun.bpm.core.entity.BpmExecution;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.enums.TaskEventType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.listener.ListenerUtil;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;

/**
 *  BpmExecution任务执行
 * @author csx
 *
 */
@Service
public class BpmExecutionManager extends BaseManager<BpmExecution>{
	@Resource
	private BpmExecutionDao bpmExecutionDao;
	@Resource
	private RuntimeService runtimeService;
	
	@Resource
	private ActRepService actRepService;
	@Resource
	BpmInstManager bpmInstManager;
	
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmRuPathManager bpmRuPathManager;

	
	
	
	
	
	@Override
	protected IDao getDao() {
		return bpmExecutionDao;
	}
	
	

	


	/**
	 * 把当前任务更新回主线程上
	 * @param executionId
	 * @param taskId
	 */
	public void updateTaskToMainThreadId(String executionId,String taskId){
		bpmExecutionDao.updateTaskToMainThreadId(executionId, taskId);
	}
	
	/**
	 * 更新主线程的执行为当前节点
	 * @param executionId
	 * @param nodeId
	 */
	public void updateMainThread(String executionId,String nodeId){
		bpmExecutionDao.updateMainThread(executionId, nodeId);
	}
	
	/**
	 * 按流程实例Id删除非主线程的Execution
	 * @param procInstId
	 */
	public void delNotMainThread(String procInstId){
		bpmExecutionDao.delNotMainThread(procInstId);
	}
	
	public void delVarsByExecutionId(String executionId){
		bpmExecutionDao.delVarsByExecutionId(executionId);
	}
	
	
	/**
	 * 构建BpmExecution树。
	 * @param proceInstId
	 * @return
	 */
	private BpmExecution getByProcInstId(String processInstId){
		List<BpmExecution> list= bpmExecutionDao.getByProcInstId(processInstId);
		BpmExecution main= getMain(list);
		
		constructExecution(main,list);
		
		return main;
	}
	
	/**
	 * 回退到主线程。
	 * <pre>
	 * 1.找到主线程
	 * 2.删除关联记录。
	 * 3.创建主线程任务。
	 * </pre>
	 * @param processInstId
	 */
	public void backToStart(TaskEntity task,ProcessNextCmd cmd,UserTaskConfig userTaskConfig){
		String nodeId=task.getTaskDefinitionKey();
		
		//删除会签人员变量
		runtimeService.removeVariable(task.getExecutionId(), "signUserIds_" +nodeId);
		
		BpmExecution curExecution=get(task.getExecutionId());
		//执行完成脚本。
		EventUtil.executeEventScript(curExecution,TaskEventType.TASK_COMPLETED );
		
		
		String processInstId=task.getProcessInstanceId();
		BpmExecution execution= getByProcInstId(processInstId);
		
		BpmInst inst=bpmInstManager.getByActInstId(processInstId);
	
		ActNodeDef firstNode = actRepService.getNodeAfterStart(execution.getProcessDefinitionId());
		//1.删除记录
		delByExecution(execution);
		//2.更新主线程
		execution.setActivityId(firstNode.getNodeId());
		execution.setIsActive((short) 1);
		execution.setIsConcurrent((short) 0);
		bpmExecutionDao.update(execution);
		//执行创建脚本
		EventUtil.executeEventScript(execution,TaskEventType.TASK_CREATED );
		//3.创建任务
		BpmTask bpmTask=createTaskByExecution(execution, inst, firstNode);
		bpmTaskManager.create(bpmTask);
		
		//4.插入意见
		
		createNodeJump(bpmTask,task);
		BpmNodeJump oldNodeJump=bpmNodeJumpManager.getByTaskId(task.getId());
		bpmNodeJumpManager.addOpFiles(cmd.getOpFiles(),oldNodeJump);	
		//5.插入RU_PATH
		BpmRuPath bpmRuPath=bpmRuPathManager.getFarestPath(task.getProcessInstanceId(), nodeId);
		
		
		createRuPath( bpmTask, inst,  bpmRuPath);
		//6.发送消息
		task.setAssignee(inst.getCreateBy());
		task.setId(bpmTask.getId());
		sendMsg( task, userTaskConfig,"backToStart");
	}
	
	private void createRuPath(BpmTask bpmTask,BpmInst bpmInst, BpmRuPath bpmRuPath){
		ProcessNextCmd cmd = (ProcessNextCmd) ProcessHandleHelper.getProcessCmd();
		String userId=ContextUtil.getCurrentUserId();
		long duration=System.currentTimeMillis()-bpmRuPath.getCreateTime().getTime();
		bpmRuPath.setEndTime(new Date());
		bpmRuPath.setDuration(duration);
		bpmRuPath.setAssignee(userId);
		bpmRuPath.setJumpType(TaskOptionType.BACK_TO_STARTOR.name());
		bpmRuPath.setOpinion(cmd.getOpinion());
		bpmRuPathManager.update(bpmRuPath);
		
		//添加ruPath
		BpmRuPath ruPath=new BpmRuPath();
		ruPath.setPathId(IdUtil.getId());
		ruPath.setInstId(bpmInst.getInstId());
		ruPath.setActDefId(bpmInst.getActDefId());
		ruPath.setActInstId(bpmTask.getProcInstId());
		ruPath.setSolId(bpmInst.getSolId());
		ruPath.setNodeId(bpmTask.getTaskDefKey());
		ruPath.setNodeName(bpmTask.getName());
		ruPath.setNodeType("userTask");
		ruPath.setCreateTime(new Date());
		ruPath.setAssignee(bpmTask.getAssignee());
		ruPath.setIsMultiple("NO");
		ruPath.setExecutionId(bpmTask.getExecutionId());
		ruPath.setParentId(bpmRuPath.getPathId());
		ruPath.setLevel(bpmRuPath.getLevel() +1);
		ruPath.setJumpType("UNHANDLE");
		ruPath.setNextJumpType(cmd.getNextJumpType());
		ruPath.setStartTime(new Date());
		
		
		bpmRuPathManager.create(ruPath);
	}
	
	/**
	 * 发送消息
	 * @param bpmTask
	 * @param userTaskConfig
	 */
	private void sendMsg(TaskEntity task,UserTaskConfig userTaskConfig,String templateType) {
		
		String notifyType =  userTaskConfig.getNotices();
		if(BeanUtil.isEmpty(notifyType)) {
			ProcessConfig procConfig=bpmNodeSetManager.getProcessConfig(task.getSolId(),task.getProcessDefinitionId()) ;
			notifyType=procConfig.getNotices();
		}
		String receiverId=task.getAssignee();
		UserService userService=AppBeanUtil.getBean(UserService.class);
		IUser user=userService.getByUserId(receiverId);
		Map<String,Object> vars=new HashMap<>();
		ListenerUtil. sendMsg( task ,"待办任务", user, notifyType,templateType,vars);
		
	}
	
	private void sendMsg(BpmTask task,UserTaskConfig userTaskConfig,String templateType) {
		
		String notifyType =  userTaskConfig.getNotices();
		if(BeanUtil.isEmpty(notifyType)) {
			ProcessConfig procConfig=bpmNodeSetManager.getProcessConfig(task.getSolId(),task.getProcDefId()) ;
			notifyType=procConfig.getNotices();
		}
		String receiverId=task.getAssignee();
		UserService userService=AppBeanUtil.getBean(UserService.class);
		IUser user=userService.getByUserId(receiverId);
		Map<String,Object> vars=new HashMap<>();
		ListenerUtil. sendMsg( task ,"待办任务", user, notifyType,templateType,vars);
		
	}
	
	/**
	 * 加入审批意见。
	 * @param bpmTask
	 */
	private void createNodeJump(BpmTask bpmTask,TaskEntity task) {
		ProcessNextCmd cmd = (ProcessNextCmd) ProcessHandleHelper.getProcessCmd();
		String userId=ContextUtil.getCurrentUserId();
		BpmNodeJump oldNodeJump=bpmNodeJumpManager.getByTaskId(task.getId());
		oldNodeJump.setCompleteTime(new Date());
		oldNodeJump.setDuration(System.currentTimeMillis()-oldNodeJump.getCreateTime().getTime());
		oldNodeJump.setHandlerId(userId);
		oldNodeJump.setCheckStatus(TaskOptionType.BACK_TO_STARTOR.name());
		oldNodeJump.setJumpType(TaskOptionType.BACK_TO_STARTOR.name());
		oldNodeJump.setRemark(cmd.getOpinion());
		bpmNodeJumpManager.update(oldNodeJump);
		
		
		BpmNodeJump nodeJump = new BpmNodeJump();
		nodeJump.setActDefId(bpmTask.getProcDefId());
		nodeJump.setActInstId(bpmTask.getProcInstId());
		nodeJump.setTaskId(bpmTask.getId());
		nodeJump.setCreateTime(bpmTask.getCreateTime());
		// 获得任务的创建时间
		nodeJump.setNodeName(bpmTask.getName());
		nodeJump.setNodeId(bpmTask.getTaskDefKey());
		nodeJump.setTenantId(oldNodeJump.getTenantId());
		bpmNodeJumpManager.create(nodeJump);
		
	}
	
	/**
	 * 创建任务。
	 * @param execution
	 * @param bpmInst
	 * @param node
	 * @return
	 */
	private BpmTask createTaskByExecution(BpmExecution execution,
			BpmInst bpmInst,
			ActNodeDef node){
		BpmTask task=new BpmTask();
		task.setId(IdUtil.getId());
		task.setRev(1);
		task.setExecutionId(execution.getId());
		task.setProcInstId(execution.getProcessInstanceId());
		task.setProcDefId(execution.getProcessDefinitionId());
		task.setName(node.getNodeName());
		task.setTaskDefKey(node.getNodeId());
		task.setOwner(bpmInst.getCreateBy());
		task.setAssignee(bpmInst.getCreateBy());
		task.setCreateTime(new Date());
		task.setSuspensionState(1);
		task.setTenantId(bpmInst.getTenantId());
		task.setSolId(bpmInst.getSolId());
		task.setDescription(bpmInst.getSubject());
		task.setEnableMobile(bpmInst.getSupportMobile());
		
		return task;
	}
	
	
	
	
	
	
	/**
	 * 根据实例ID删除activiti 关联记录。
	 * <pre>
	 * 1.构建bpmexecution树。
	 * 2.递归删除关联数据。
	 * 	1.变量
	 * 	2.任务候选人
	 * 	3.任务
	 * 	4.删除线程
	 * </pre>
	 * @param proceInstId
	 */
	private void delByExecution(BpmExecution parent){
		//是主线程并没有子线程情况。
		if(parent.isMain() && BeanUtil.isEmpty( parent.getChildren())){
			String executeId=parent.getId();
			//删除任务候选人
			bpmExecutionDao.delIdentityByExecution(executeId);
			//删除关联任务
			bpmExecutionDao.delTaskByExecution(executeId);
			return;
		}
		
		for(BpmExecution execution:parent.getChildren()){
			delByExecution(execution);
			
			String executeId=execution.getId();
			//根据executionId删除数据。
			delByExecutionId(executeId);
		}
		
	}
	
	
	private void delByExecutionId(String executeId){
		//删除变量
		bpmExecutionDao.delVarsByExecution(executeId);
		//删除任务候选人
		bpmExecutionDao.delIdentityByExecution(executeId);
		//删除关联任务
		bpmExecutionDao.delTaskByExecution(executeId);
		//删除线程
		bpmExecutionDao.delete(executeId);
	}
	
	
	
	private void constructExecution(BpmExecution parent,List<BpmExecution> list){
		String id=parent.getId();
		for(BpmExecution execution:list){
			if(id.equals(execution.getParentId())){
				parent.addChildren(execution);
				//递归构建。
				constructExecution(execution,list);
			}
		}
	}
	
	/**
	 * 获取主线程
	 * @param list
	 * @return
	 */
	private  BpmExecution getMain(List<BpmExecution> list){
		for(BpmExecution execution:list){
			if(execution.getId().equals(execution.getProcessInstanceId())){
				return execution;
			}
		}
		return null;
	}

	/**
	 * 处理在并行网关内部进行驳回。
	 * 实现原理：构造excution 和任务数据 让他符合流程引擎的需求。
	 * <pre>
	 * 	1.找到当前任务的executionId。
	 * 	2.找到需要驳回的节点。
	 * 	4.查询并行网关的结束网关。
	 * 	5.删除当前excutionid 的excution。
	 * 	6.删除 父id为 当前exution的parentId并且节点为结束网关节点的excution数据。
	 * 	7.将当前任务挂到主线程下。
	 * 	8.将主线程的ACT_ID_修改成驳回节点的ID.
	 * 	9.发送通知。
	 * 	10.修改ru_path.
	 * </pre>
	 * @param task
	 */
	public void handFromInset(BpmTask task,UserTaskConfig userTaskConfig){
		String executionId=task.getExecutionId();
		String actDefId=task.getProcDefId();
		String nodeId=task.getTaskDefKey();
		
		
		BpmExecution execution= this.get(executionId);
		
		// 获取开始网关。
		ActNodeDef startWay=actRepService.getPreGateway(actDefId,nodeId,true);
		
		ActNodeDef endWay=actRepService.getCorrespondGateWay(actDefId, startWay.getNodeId(), false);
		
		//获取网关内的节点
		Set<ActNodeDef> outNodes= actRepService.getOutNodesByGateWay(actDefId, startWay.getNodeId());
		//删除并行网关产生的数据
		List<BpmExecution> bpmExecutions= bpmExecutionDao.getByParentId(execution.getParentId());
		delExecutions(bpmExecutions,outNodes,endWay.getNodeId());
		//获取网关之前的节点。
		ActNodeDef taskNode= getPreTask(execution.getProcessInstanceId(),startWay.getNodeId());
		
		//获取主的execution
		BpmExecution mainExecution= this.get(execution.getParentId());
		
		mainExecution.setActivityId(taskNode.getNodeId());
		mainExecution.setIsActive((short)1);
		this.update(mainExecution);
		
		BpmRuPath ruPath=bpmRuPathManager.getFarestPath(task.getProcInstId(),task.getTaskDefKey());
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		ruPath.setJumpType(cmd.getJumpType());
		bpmRuPathManager.update(ruPath);
		//获取跳转节点的路径
		BpmRuPath toRuPath=bpmRuPathManager.getFarestPath(mainExecution.getProcessInstanceId(),taskNode.getNodeId());
		
		//构建任务指向主线程。
		constructTask( taskNode, mainExecution, toRuPath, task,userTaskConfig);
		//构建审批意见。
		
		constructNodePath( mainExecution);
		//结束审批意见
		bpmNodeJumpManager.updateNodeJump(task.getId());
	}
	
	
	/**
	 * 获取前面的任务节点。
	 * @param actInstId
	 * @param nodeId
	 * @return
	 */
	private ActNodeDef getPreTask(String actInstId,String nodeId){
		String tmpId="";
		BpmRuPath ruPath=bpmRuPathManager.getFarestPath(actInstId,nodeId);
		String actDefId=ruPath.getActDefId();
		String parentId=ruPath.getParentId();
		BpmRuPath parent=bpmRuPathManager.get(parentId);
		String type=parent.getNodeType();
		if(type.equals("userTask")){
			tmpId=parent.getNodeId();
		}
		else{
			do{
				parentId=ruPath.getParentId();
				parent=bpmRuPathManager.get(parentId);
				type=parent.getNodeType();
			}
			while(!type.equals("userTask") && !type.equals("startEvent"));
			if(type.equals("userTask")){
				tmpId=parent.getNodeId();
			}
		}
		if(StringUtil.isNotEmpty(tmpId)){
			ActNodeDef def= actRepService.getByNode(actDefId,tmpId);
			return def;
		}
		return null;
	}
 
	/**
	 * 构建任务指向主线程。
	 * @param taskNode
	 * @param mainExecution
	 * @param toRuPath
	 * @param task
	 * @param config
	 */
	private void constructTask(ActNodeDef taskNode,BpmExecution mainExecution,BpmRuPath toRuPath,BpmTask task,UserTaskConfig config){
		BpmTask bpmTask=new BpmTask();
		bpmTask.setId(IdUtil.getId());
		bpmTask.setExecutionId(mainExecution.getId());
		bpmTask.setProcInstId(mainExecution.getProcessInstanceId());
		bpmTask.setProcDefId(mainExecution.getProcessDefinitionId());
		
		bpmTask.setName(taskNode.getNodeName());
		bpmTask.setRev(1);
		bpmTask.setTaskDefKey(taskNode.getNodeId());
		bpmTask.setDescription(task.getDescription());
		bpmTask.setCreateTime(new Date());
		
		bpmTask.setOwner(toRuPath.getAssignee());
		bpmTask.setAssignee(toRuPath.getAssignee());
		
		bpmTask.setSuspensionState(1);
		bpmTask.setTenantId(task.getTenantId());
		bpmTask.setSolId(task.getSolId());
		
		bpmTaskManager.create(bpmTask);
		//创建意见。
		bpmNodeJumpManager.createNodeJump(bpmTask);
		//发送消息
		sendMsg(bpmTask, config,"back");
	}
	
	/**
	 * 删除executions。
	 * @param bpmExecutions
	 * @param outNodes
	 * @param endWay
	 */
	private void delExecutions(List<BpmExecution> bpmExecutions,Set<ActNodeDef> outNodes,String endWay){
		Set<String> nodes= getNodeIds(outNodes);
		for(BpmExecution execution:bpmExecutions){
			String executionId=execution.getId();
			String nodeId=execution.getActivityId();
			//删除之后的等待节点和正在运行的节点。
			if(nodes.contains(nodeId) || nodeId.equals(endWay)){
				delByExecutionId(executionId);
			}
		}
	}
	
	/**
	 * 获取节点。
	 * @param nodes
	 * @return
	 */
	private Set<String> getNodeIds(Set<ActNodeDef> nodes){
		Set<String> set=new HashSet<String>();
		for(ActNodeDef def:nodes){
			set.add(def.getNodeId());
		}
		return set;
	}
	
	/**
	 * 处理在并行网关从外部进行驳回。
	 * 实现原理：构造excution 和任务数据 让他符合流程引擎的需求。
	 * <pre>
	 * 	1.找到当前任务的executionId。
	 * 	2.根据BPM_RU_PATH 找到需要驳回的节点。
	 * 	4.查询并行网关的开始网关。
	 * 	5.将主execution 的ACT_ID_更新为 开始网关的ID。
	 *  6.构建execution 挂载到主线程下。
	 *  	根据网关汇入的线条构建execution，其中的一条为当前的execution，将bpmtask 指向，这条execution。
	 *  7.发送通知。
	 *  8.修改ru_path
	 *  	
	 * </pre>
	 * @param task
	 */
	public void handFromOutset(BpmTask bpmtask,PathResult result,UserTaskConfig userTaskConfig){
		String taskId=bpmtask.getId();
		String executionId=bpmtask.getExecutionId();
		String actDefId=bpmtask.getProcDefId();
		// 上次审批的节点
		BpmRuPath lastRuPath=result.getBpmRuPath();
		String targetNode=lastRuPath.getNodeId();
		// 获取结束网关。
		ActNodeDef endWay=actRepService.getByNode(actDefId, result.getGateWay());
		
		ActNodeDef startWay=actRepService. getCorrespondGateWay( actDefId,endWay.getNodeId(),true);
		
		//修改主线程
		BpmExecution mainExecution= this.get(executionId);
		mainExecution.setActivityId(startWay.getNodeId());
		mainExecution.setIsActive((short)0);
		this.update(mainExecution);
		
		//更新path。
		BpmRuPath ruPath=bpmRuPathManager.getFarestPath(bpmtask.getProcInstId(),bpmtask.getTaskDefKey());
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		ruPath.setJumpType(cmd.getJumpType());
		bpmRuPathManager.update(ruPath);
		
		//增加execution
		BpmExecution activeExecution= addChild( targetNode, endWay, mainExecution,bpmtask,userTaskConfig);
		
		//构建RU_PATH
		constructNodePath( activeExecution);
		//结束当前NODE_JUMP
		bpmNodeJumpManager.updateNodeJump(taskId);
	}
	
	
	
	/**
	 * 构建RU_PATH
	 * @param execution
	 * 
	 */
	private void constructNodePath(BpmExecution execution){
		ActNodeDef nodeDef= actRepService.getByNode(execution.getProcessDefinitionId(), execution.getActivityId());
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		BpmRuPath path=new BpmRuPath();

		path.setPathId(IdUtil.getId());
		path.setActDefId(execution.getProcessDefinitionId());
		path.setActInstId(execution.getProcessInstanceId());
		path.setExecutionId(execution.getId());
		path.setNodeName(nodeDef.getNodeName());
		path.setNodeId(execution.getActivityId());
		
		path.setNodeType("userTask");

		path.setStartTime(new Date());
		path.setToken(cmd.getToken());
		
		
		BpmInst bpmInst=bpmInstManager.getByActInstId(execution.getProcessInstanceId());
		path.setInstId(bpmInst.getInstId());
		path.setSolId(bpmInst.getSolId());
		
		
		path.setIsMultiple(MBoolean.NO.name());
			
		
		//记录跳转的原节点,并且把跳转记录挂至该节点上
		BpmRuPath parentPath=bpmRuPathManager.getFarestPath(execution.getProcessInstanceId(),execution.getActivityId());
		path.setParentId(parentPath.getParentId());
		path.setLevel(parentPath.getLevel()+1);
		
		bpmRuPathManager.create(path);
	}
	
	
	
	/**
	 * 网关从外部驳回添加execution数据。
	 * @param nodeId
	 * @param endWay
	 * @param mainExecution
	 * @param bpmtask
	 */
	private BpmExecution addChild(String nodeId,ActNodeDef endWay,BpmExecution mainExecution,BpmTask bpmtask,UserTaskConfig config){
		BpmExecution activeExecution=null; 
		for(ActNodeDef node:endWay.getIncomeNodes()){
			BpmExecution execution=new BpmExecution();
			execution.setProcessInstanceId(mainExecution.getProcessInstanceId());
			execution.setParentId(mainExecution.getId());
			execution.setId(IdUtil.getId());
			execution.setRevision(1);
			execution.setIsScope((short)0);
			execution.setIsEventScope((short)0);
			execution.setSuspensionState(1);
			execution.setProcessDefinitionId(mainExecution.getProcessDefinitionId());
			execution.setIsActive((short)0);
			execution.setIsConcurrent((short)1);
			if(node.getNodeId().equals(nodeId)){
				execution.setActivityId(nodeId);
				execution.setIsActive((short)1);
				activeExecution=execution;
				//获取执行人
				BpmRuPath ruPath=bpmRuPathManager.getLastPathByNode(mainExecution.getProcessInstanceId(), nodeId);
				
				bpmExecutionDao.create(execution);
				//删除任务。
				bpmTaskManager.delete(bpmtask.getId());
				//添加任务。
				bpmtask.setId(IdUtil.getId());
				bpmtask.setExecutionId(execution.getId());
				bpmtask.setTaskDefKey(nodeId);
				bpmtask.setAssignee(ruPath.getAssignee());
				bpmtask.setName(node.getNodeName());
				bpmTaskManager.create(bpmtask);
				//添加意见。
				bpmNodeJumpManager.createNodeJump(bpmtask);
				
				//发送流程消息
				sendMsg(bpmtask, config,"back");
				
			}
			else{
				execution.setActivityId(endWay.getNodeId());
				bpmExecutionDao.create(execution);
			}
		}
		return activeExecution;
	}
	
	/**
	 * 根据流程实例ID删除关联得任务，实例，变量等数据。
	 * @param actInstId
	 */
	public void delByInstId(String actInstId){
		BpmExecution excution= this.getByProcInstId(actInstId);
		this.delByExecution(excution);
	}
}
