
package com.redxun.bpm.core.manager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.task.IdentityLink;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.entity.ActProcessDef;
import com.redxun.bpm.activiti.ext.ActivitiDefCache;
import com.redxun.bpm.activiti.ext.BpmConstants;
import com.redxun.bpm.activiti.ext.DefUtil;
import com.redxun.bpm.activiti.handler.TaskAfterHandler;
import com.redxun.bpm.activiti.handler.TaskPreHandler;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.service.ActTaskService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.bpm.core.dao.ActHiTaskinstDao;
import com.redxun.bpm.core.dao.BpmOpinionTempDao;
import com.redxun.bpm.core.dao.BpmRemindInstDao;
import com.redxun.bpm.core.dao.BpmTaskDao;
import com.redxun.bpm.core.entity.AbstractExecutionCmd;
import com.redxun.bpm.core.entity.ActHiTaskinst;
import com.redxun.bpm.core.entity.BpmExecution;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmLog;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmOpinionTemp;
import com.redxun.bpm.core.entity.BpmRemindInst;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.entity.config.DestNodeUsers;
import com.redxun.bpm.core.entity.config.ExclusiveGatewayConfig;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.TaskNodeUser;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.service.sign.CounterSignService;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.enums.TaskVarType;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.entity.FormulaSetting;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.jms.MessageModel;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.BoResult.ACTION_TYPE;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.util.SysUtil;

import freemarker.template.TemplateException;

/**
 * <pre>
 * 描述：BpmTask业务服务类
 * 构建组：
 * 作者：mansan
 * 邮箱: chshxuan@163.com
 * 日期:2016-2-1-上午12:52:41
 * @Copyright (c) 2016-2017 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmTaskManager extends MybatisBaseManager<BpmTask> {
	
	@Resource
	private BpmTaskDao bpmTaskDao;
	
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private RepositoryService repositoryService;
	@Resource
	private ActTaskService actTaskService;
	@Resource
	private BpmInstManager bpmInstManager;
	@Resource
	private BpmSolutionManager bpmSolutionManager;
	@Resource
	private BpmFormInstManager bpmFormInstManager;
	@Resource
	private BpmIdentityCalService bpmIdentityCalService;
	@Resource
	private BpmRuPathManager bpmRuPathManager;
	@Resource
	private BpmSolVarManager bpmSolVarManager;
	@Resource
	private TaskService taskService;
	@Resource
	private GroovyEngine groovyEngine;
	@Resource
	ActRepService actRepService;
	@Resource
	CounterSignService counterSignService;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	UserService userService;
	@Resource
	GroupService groupService;
	@Resource
	BpmIdentityLinkManager bpmIdentityLinkManager;
	@Resource
	BpmInstCcManager bpmInstCcManager;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	BpmSolFvManager bpmSolFvManager;
	@Resource
	BpmRemindInstDao bpmRemindInstDao;
	@Resource
	BpmExecutionManager bpmExecutionManager;
	@Resource
	BpmInstDataManager bpmInstDataManager;
    @Resource
    BpmOpinionTempDao bpmOpinionTempDao;
    @Resource
    BpmCheckFileManager bpmCheckFileManager;
    @Resource
    TaskManager  taskManager;
    @Resource 
    IJumpRuleService jumpRuleService;
    @Resource
    BpmLogManager bpmLogManager;
    @Resource
    FreemarkEngine freemarkEngine;
    @Resource
    BpmOvertimeNodeManager bpmOvertimeNodeManager;
    @Resource
    ActHiTaskinstDao  actHiTaskinstDao;
	
	
	


	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmTaskDao;
	}
	
	@Override
	public void delete(String id) {
		bpmIdentityLinkManager.deleteByTaskId(id);
		bpmTaskDao.delete(id);
	}
	
	
	/**
	 * 更改非会签任务的审批人员
	 * @param taskId
	 * @param userIds
	 */
	public void doChangeTaskUsers(String taskId,String[]userIds){
		// 删除已经存在的候选用户及组
		List<IdentityLink> links = taskService.getIdentityLinksForTask(taskId);
		for (IdentityLink link : links) {
			if (StringUtils.isNotEmpty(link.getGroupId())) {
				taskService.deleteCandidateGroup(taskId, link.getGroupId());
			} else if (StringUtils.isNotEmpty(link.getUserId())) {
				taskService.deleteCandidateUser(taskId, link.getUserId());
			}
		}
		// 添加新增的
		for (String userId : userIds) {
			if (StringUtils.isNotEmpty(userId)) {
				taskService.addCandidateUser(taskId, userId);
			}
		}
		BpmTask task=get(taskId);
		task.setAssignee(null);
		task.setOwner(null);
		update(task);
	}

	/**
	 * 获得当前任务的后续审批节点及人工任务节点的审批人员
	 * 
	 * @param taskId
	 * @return
	 */
	public List<DestNodeUsers> getDestNodeUsers(String taskId) {
		// 取得当前流程定义对应的下一步的执行人员
//		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		BpmTask bpmTask=this.get(taskId);
		String actDefId=bpmTask.getProcDefId();
		String actInstId=bpmTask.getProcInstId();
		// 取得流程定义
		ActProcessDef actProcessDef = actRepService.getProcessDef(actDefId);
		
		String nodeId = null;
		// 查找是否为原路返回的模式，即当前任务是否由回退处理的
		String curNodeId=bpmTask.getTaskDefKey();
		BpmRuPath ruPath = bpmRuPathManager.getFarestPath(actInstId, curNodeId);
		if (ruPath != null && "orgPathReturn".equals(ruPath.getNextJumpType())) {
			BpmRuPath toNodePath = bpmRuPathManager.get(ruPath.getParentId());
			toNodePath = bpmRuPathManager.getMinPathByNode(actInstId, toNodePath.getNodeId());
			if (toNodePath != null) {
				nodeId = toNodePath.getNodeId();
			}
		}
		if(StringUtil.isEmpty(nodeId)) {
			nodeId = bpmTask.getTaskDefKey();
		}
		// 取得当前任务的节点定义
		ActNodeDef actNodeDef = actProcessDef.getNodesMap().get(nodeId);
		//actProcessDef.getTaskOutValidNodes(task.getProcessDefinitionId(),task.getTaskDefinitionKey());
		List<DestNodeUsers> destNodeUserList = new ArrayList<DestNodeUsers>();
		// 取得流程变量列表
		Map<String, Object> vars = runtimeService.getVariables(actInstId);
		//加入前缀节点的审批人，默认为当前用户
		vars.put(ProcessVarType.PRE_NODE_USERID.getKey(), ContextUtil.getCurrentUserId());
		
		// 计算当前任务节点的后续节点及其后续有效的任务节点的人员列表映射
		for (ActNodeDef outNode : actNodeDef.getOutcomeNodes()) {
			DestNodeUsers nodeUsers = new DestNodeUsers(outNode);
			if (nodeUsers.getNodeType() != null && nodeUsers.getNodeType().indexOf("Gateway") != -1) {// 为网关节点
				genDestNodeUserMap(bpmTask.getSolId(), actDefId, outNode, nodeUsers.getFllowNodeUserMap(), vars);
			} else if ("userTask".equals(nodeUsers.getNodeType())) {// 为用户任务
				TaskNodeUser taskNodeUser = calUserNode(actDefId, outNode, vars);
				nodeUsers.setTaskNodeUser(taskNodeUser);
			} else if("subProcess".equals(nodeUsers.getNodeType())){//子流程
				Collection<ActNodeDef> actNodeDefs=actRepService.getTaskOutValidNodes(actDefId, nodeUsers.getNodeId());
				for(ActNodeDef def:actNodeDefs){
					TaskNodeUser taskNodeUser = calUserNode(actDefId, def, vars);
					// 加入到映射中
					nodeUsers.getFllowNodeUserMap().put(nodeUsers.getNodeId(), taskNodeUser);
				}
			}else {
				TaskNodeUser taskNodeUser = new TaskNodeUser(outNode);
				nodeUsers.setTaskNodeUser(taskNodeUser);
			}
			destNodeUserList.add(nodeUsers);
		}
		return destNodeUserList;
	}
	
	/**
	 * 获得某实例某个节点（任务节点）或后续任务节点的人员处理列表
	 * @param actInstId
	 * @param nodeId
	 * @return
	 */
	public List<DestNodeUsers> getDestNodeUsers(String solId, String actInstId,String nodeId){
		List<DestNodeUsers> destNodeUserList=new ArrayList<DestNodeUsers>();
		
		BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
		// 取得流程定义
		ActProcessDef actProcessDef = actRepService.getProcessDef(bpmInst.getActDefId());
		// 取得当前任务的节点定义
		ActNodeDef actNodeDef = actProcessDef.getNodesMap().get(nodeId);
		
		Map<String, Object> vars = runtimeService.getVariables(actInstId);
		
		if("userTask".equals(actNodeDef.getNodeType())){
			DestNodeUsers nodeUsers=getDestNodeUsers(bpmInst.getActDefId(),bpmInst.getActInstId(),nodeId,actNodeDef,vars);
			destNodeUserList.add(nodeUsers);
		}else{//非任务节点，则查找当前任务节点的后续任务列表及其人员列表

			// 计算当前任务节点的后续节点及其后续有效的任务节点的人员列表映射
			for (ActNodeDef outNode : actNodeDef.getOutcomeNodes()) {
				DestNodeUsers nodeUsers = new DestNodeUsers(outNode);
				if (nodeUsers.getNodeType() != null && nodeUsers.getNodeType().indexOf("Gateway") != -1) {// 为网关节点
					genDestNodeUserMap(solId,bpmInst.getActDefId(), outNode, nodeUsers.getFllowNodeUserMap(), vars);
				} else if ("userTask".equals(nodeUsers.getNodeType())) {// 为用户任务
					nodeUsers=getDestNodeUsers(bpmInst.getActDefId(),bpmInst.getActInstId(),nodeId,outNode,vars);
				} else {
					TaskNodeUser taskNodeUser = new TaskNodeUser(outNode);
					nodeUsers.setTaskNodeUser(taskNodeUser);
				}
				destNodeUserList.add(nodeUsers);
			}
		}
		
		return destNodeUserList;
	}
	
	public TaskNodeUser getNodeUsers(String actInstId,String nodeId){
		BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
		String actDefId=bpmInst.getActDefId();
		// 取得流程定义
		ActProcessDef actProcessDef = actRepService.getProcessDef(actDefId);
		// 取得当前任务的节点定义
		ActNodeDef actNodeDef = actProcessDef.getNodesMap().get(nodeId);
		
		Map<String, Object> vars = runtimeService.getVariables(actInstId);
		
		TaskNodeUser nodeUser=calUserNode(actDefId, actNodeDef, vars);
		
		return nodeUser;
	}
	
	private DestNodeUsers getDestNodeUsers(String actDefId,String actInstId,String nodeId,ActNodeDef actNodeDef,Map<String,Object> vars){
		//优先查找该节点是否已经走过了，若走过，直接找到当时审批的人
		List<BpmNodeJump> nodeJumps=bpmNodeJumpManager.getByActInstIdNodeId(actInstId, nodeId);
		if(nodeJumps.size()>0){
			DestNodeUsers nodeUsers = new DestNodeUsers(actNodeDef);
			Set<IUser> osUsers=new HashSet<IUser>();
			StringBuffer userIds=new StringBuffer();
			StringBuffer userNames=new StringBuffer();
			for(BpmNodeJump nodeJump:nodeJumps){
				if(StringUtils.isEmpty(nodeJump.getHandlerId())){
					continue;
				}
				IUser osUser=userService.getByUserId(nodeJump.getHandlerId());
				if(osUser==null){
					continue;
				}
				
				if(!osUsers.contains(osUser)){
					userIds.append(osUser.getUserId()).append(",");
					userNames.append(osUser.getFullname()).append(",");
					osUsers.add(osUser);
				}
			}
			
			if(userIds.length()>0){
				userIds.deleteCharAt(userIds.length()-1);
				userNames.deleteCharAt(userNames.length()-1);
				TaskNodeUser taskNodeUser=new TaskNodeUser();
				taskNodeUser.setUserIds(userIds.toString());
				taskNodeUser.setUserFullnames(userNames.toString());
				nodeUsers.setTaskNodeUser(taskNodeUser);
			}
			
			return nodeUsers;
		}else{//从流程配置中查找
			TaskNodeUser taskNodeUser = calUserNode(actDefId, actNodeDef, vars);
			DestNodeUsers nodeUsers = new DestNodeUsers(actNodeDef);
			nodeUsers.setTaskNodeUser(taskNodeUser);
			return nodeUsers;
		}
		
	}

	/**
	 * 获得目标节点的人员
	 * @param actDefId
	 * @param nodeDefs
	 * @param vars
	 * @return
	 */
	public List<DestNodeUsers> getDestNodeUsers(String solId, String actDefId, List<ActNodeDef> nodeDefs, Map<String, Object> vars) {
		List<DestNodeUsers> destNodeUserList = new ArrayList<DestNodeUsers>();
		for (ActNodeDef actNodeDef : nodeDefs) {
			if (actNodeDef == null)
				continue;
			DestNodeUsers nodeUsers = new DestNodeUsers();
			nodeUsers.setNodeId(actNodeDef.getNodeId());
			nodeUsers.setNodeType(actNodeDef.getNodeType());
			nodeUsers.setNodeText(actNodeDef.getNodeName());
			if (actNodeDef.getNodeType() != null && actNodeDef.getNodeType().indexOf("Gateway") != -1) {// 为网关节点
				genDestNodeUserMap(solId,actDefId, actNodeDef, nodeUsers.getFllowNodeUserMap(), vars);
			} else if ("userTask".equals(actNodeDef.getNodeType())) {// 为用户任务
				TaskNodeUser taskNodeUser = calUserNode(actDefId, actNodeDef, vars);
				nodeUsers.setTaskNodeUser(taskNodeUser);
			} else {
				TaskNodeUser taskNodeUser = new TaskNodeUser(actNodeDef);
				nodeUsers.setTaskNodeUser(taskNodeUser);
			}
			destNodeUserList.add(nodeUsers);
		}
		return destNodeUserList;
	}

	/**
	 * 获得流程定义中指定的节点的人员列表映射
	 * 
	 * @param actDefId
	 * @param destNodeIds
	 * @param vars
	 * @return
	 */
	public List<DestNodeUsers> getDestNodeUsers(String solId, String actDefId, String[] destNodeIds, Map<String, Object> vars) {
		ActProcessDef processDef = actRepService.getProcessDef(actDefId);
		List<ActNodeDef> actNodeDefs = new ArrayList<ActNodeDef>();
		for (String nodeId : destNodeIds) {
			ActNodeDef actNodeDef = processDef.getNodesMap().get(nodeId);
			if (actNodeDef == null)
				continue;
			actNodeDefs.add(actNodeDef);
		}
		return getDestNodeUsers(solId,actDefId, actNodeDefs, vars);
	}

	/**
	 * 产生指定的节点的后续有效的任务节点的人员，计算出的值存于flowNodeUserMap
	 * 
	 * @param actDefId
	 * @param destNodeDef
	 * @param fllowNodeUserMap
	 * @param vars
	 */
	private void genDestNodeUserMap(String solId,String actDefId, ActNodeDef destNodeDef, Map<String, TaskNodeUser> fllowNodeUserMap, Map<String, Object> vars) {
		String nodeType=destNodeDef.getNodeType();
		//是否需要计算
		boolean needCalc=nodeType.indexOf("inclusive")!=-1 || nodeType.indexOf("exclusive")!=-1;
		
		ExclusiveGatewayConfig configs=null;
		Map<String,String> scriptMap=null;
		if(needCalc){
			configs=bpmNodeSetManager.getExclusiveGatewayConfig(solId,actDefId,destNodeDef.getNodeId());
			scriptMap=DefUtil.getConditionMap(configs);
		}
		//inclusive.exclusiveGateway
		for (ActNodeDef outNode : destNodeDef.getOutcomeNodes()) {
			if ("userTask".equals(outNode.getNodeType())) {
				if(needCalc){
					if(scriptMap.containsKey(outNode.getNodeId())){
						String script=scriptMap.get(outNode.getNodeId());
						Map<String,Object> model=new HashMap<>();
						AbstractExecutionCmd cmd=(AbstractExecutionCmd) ProcessHandleHelper.getProcessCmd();
						if(cmd!=null) {
							model.put("cmd", cmd);
							//获取表单数据
							BpmSolution bpmSolution = bpmSolutionManager.get(solId);
							JSONObject data = JSONObject.parseObject(cmd.getJsonData());
							Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsonsBoIds(data,bpmSolution.getBoDefId());
							vars.put("jsonData", modelFieldMap);
							vars.putAll(cmd.getVars());
						}
						model.put("vars", vars);
						Object boolVal = groovyEngine.executeScripts(script, model);
						if(boolVal instanceof Boolean && (Boolean)boolVal ){
							TaskNodeUser taskNodeUser = calUserNode(actDefId, outNode, vars);
							// 加入到映射中
							fllowNodeUserMap.put(outNode.getNodeId(), taskNodeUser);
						}
					}
					else{
						TaskNodeUser taskNodeUser = calUserNode(actDefId, outNode, vars);
						// 加入到映射中
						fllowNodeUserMap.put(outNode.getNodeId(), taskNodeUser);
					}
				}
				else{
					TaskNodeUser taskNodeUser = calUserNode(actDefId, outNode, vars);
					// 加入到映射中
					fllowNodeUserMap.put(outNode.getNodeId(), taskNodeUser);
				}
				
				
				
			} else if (outNode.getNodeType() != null && outNode.getNodeType().indexOf("Gateway") != -1) {
				genDestNodeUserMap(solId,actDefId, outNode, fllowNodeUserMap, vars);
			} else {
				TaskNodeUser taskNodeUser = new TaskNodeUser(outNode);
				// 加入到映射中
				fllowNodeUserMap.put(outNode.getNodeId(), taskNodeUser);
			}
		}
	}
	
	/**
	 * 将任务转交给某人。
	 * @param taskId		任务ID
	 * @param toUserId		转交用户	
	 * @param opinion		意见
	 * @param noticeTypes	通知类型
	 */
	public void transTo(String taskId,String toUserId,String opinion,String noticeTypes){
		BpmTask bpmTask = get(taskId);

		BpmNodeJump nodeJump = new BpmNodeJump();
		nodeJump.setActDefId(bpmTask.getProcDefId());
		nodeJump.setActInstId(bpmTask.getProcInstId());

		nodeJump.setCreateTime(bpmTask.getCreateTime());
		// 获得任务的创建时间
		nodeJump.setCompleteTime(new Date());
		Long duration = nodeJump.getCompleteTime().getTime() - nodeJump.getCreateTime().getTime();
		nodeJump.setDuration(duration );

		nodeJump.setNodeName(bpmTask.getName());
		nodeJump.setNodeId(bpmTask.getTaskDefKey());
		nodeJump.setHandlerId(ContextUtil.getCurrentUserId());

		nodeJump.setJumpType(BpmNodeJump.JUMP_TYPE_TRANSFER);
		nodeJump.setCheckStatus(BpmNodeJump.JUMP_TYPE_TRANSFER);
		nodeJump.setRemark(opinion);
		bpmNodeJumpManager.create(nodeJump);
		//bpmTask.setAssignee(toUserId);
        bpmTask.setAgentUserId(toUserId);
        bpmTask.setTaskType(BpmTask.TASK_TYPE_AGENT);
		update(bpmTask);
		// 发送通知消息
		sendMessage(toUserId,bpmTask,noticeTypes,"任务转办","transfer");
		
		//记录日志
		BpmInst bpmInst=bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		bpmLogManager.addTaskLog(bpmInst.getSolId(), 
				bpmInst.getInstId(), taskId, 
				BpmLog.LOG_TYPE_TASK, BpmLog.OP_TYPE_TASK_TRANSFER, "审批任务:" +bpmInst.getSubject() +",节点:" + bpmTask.getName());
		
	}

	/**
	 * 计算流程定义中的某个节点的人员配置信息
	 * 
	 * @param actDefId
	 * @param nodeDef
	 * @param vars
	 * @return
	 */
	public TaskNodeUser calUserNode(String actDefId, ActNodeDef nodeDef, Map<String, Object> vars) {
		TaskNodeUser taskNodeUser = new TaskNodeUser(nodeDef);
		// 计算taskNodeUser里的值
		// 取算该节点的人员配置，并且计算其规则
		Collection<TaskExecutor> idInfos = bpmIdentityCalService.calNodeUsersOrGroups(actDefId, nodeDef.getNodeId(), vars);
		StringBuffer userIdSb = new StringBuffer();
		StringBuffer userNameSb = new StringBuffer();
		StringBuffer groupIdSb = new StringBuffer();
		StringBuffer groupNameSb = new StringBuffer();
		
		for (TaskExecutor id : idInfos) {
			if(id==null) continue;
			if (TaskExecutor.IDENTIFY_TYPE_USER .equals(id.getType())) {
				userIdSb.append(id.getId()).append(",");
				userNameSb.append(id.getName()).append(",");
			} else {
				groupIdSb.append(id.getId()).append(",");
				groupNameSb.append(id.getName()).append(",");
			}
		}
		
		taskNodeUser.setUserIds(trimComma(userIdSb));
		taskNodeUser.setUserFullnames(trimComma(userNameSb));
		taskNodeUser.setGroupIds(trimComma(groupIdSb));
		taskNodeUser.setGroupNames(trimComma(groupNameSb));
		return taskNodeUser;
	}
	
	private String trimComma(StringBuffer sb){
		if (sb.length()==0) return "";
		sb.deleteCharAt(sb.length() - 1);
		return sb.toString();
	}

	/**
	 * 我代理出去的待办
	 * 
	 * @param filter
	 * @return
	 */
	public List<BpmTask> getMyAgentTasks(QueryFilter filter) {
		return bpmTaskDao.getMyAgentTasks(filter);
	}

	/**
	 * 别人代理给我的待办
	 * 
	 * @param filter
	 * @return
	 */
	public List<BpmTask> getAgentToTasks(QueryFilter filter) {
		return bpmTaskDao.getAgentToTasks(filter);
	}
	
	/**
	 * 通过INST_ID_查询关联的任务
	 * 
	 * @param filter
	 * @return
	 */
	public List<BpmTask> getByInstId(String instId) {
		return bpmTaskDao.getByInstId(instId);
	}
	
	/**
	 * 保存业务数据
	 * @param taskId
	 * @param jsonData
	 */
	public void doSaveData(String taskId,String jsonData){
		TaskEntity task = (TaskEntity) taskService.createTaskQuery().taskId(taskId).singleResult();
		BpmInst bpmInst = bpmInstManager.getByActInstId(task.getProcessInstanceId());
		
		String	dataSaveMode=bpmInst.getDataSaveMode();
		IFormDataHandler handler=BoDataUtil.getDataHandler(dataSaveMode);
		
		JSONObject jsonObj=JSONObject.parseObject(jsonData);
		JSONArray boArr=jsonObj.getJSONArray("bos");
		if(boArr==null) return;
		//表间公式
		setFormulaSettingSave( bpmInst, task.getTaskDefinitionKey());
		
		for(int i=0;i<boArr.size();i++){
			com.alibaba.fastjson.JSONObject varObj=boArr.getJSONObject(i);
			String boDefId=varObj.getString("boDefId");
			JSONObject boData=varObj.getJSONObject("data");
			//获取主键
			String pk=bpmInstDataManager.getPk(bpmInst.getInstId(), boDefId);
			//返回结果
			BoResult result= handler.saveData(boDefId, pk, boData);
			if(result.getAction().equals(ACTION_TYPE.ADD)){
				bpmInstDataManager.addBpmInstData(boDefId, result.getPk(), bpmInst.getInstId());
			}
		}
	}
	
	private void setFormulaSettingSave(BpmInst bpmInst,String nodeId){
		FormulaSetting setting=new FormulaSetting();
		setting.setMode(FormulaSetting.FLOW);
		setting.setSolId(bpmInst.getSolId());
		setting.setActDefId(bpmInst.getActDefId());
		setting.setNodeId(nodeId);
		
		
		setting.addExtParams("op","save");
		setting.addExtParams("mode", FormulaSetting.FLOW);
		
		ProcessHandleHelper.setFormulaSetting(setting);
		
	}
	
	
	/**
	 * 撤消任务沟通
	 * @param cmd
	 */
	public void doCancelCommuteTask(ProcessNextCmd cmd){
		BpmTask bpmTask=get(cmd.getTaskId());
		List<BpmTask> rcList=bpmTaskDao.getByRcTaskId(bpmTask.getId());
		//删除任务
		for(BpmTask task:rcList){
			if(task.getCmLevel()!=null && task.getCmLevel()==1){
				List<BpmTask> tmpList=bpmTaskDao.getByRcTaskId(bpmTask.getId());
				for(BpmTask t:tmpList){
					deleteObject(t);
				}
			}
			deleteObject(task);
		}
		
		//加上撤消沟通
		BpmNodeJump nodeJump=new BpmNodeJump();
		nodeJump.setActDefId(bpmTask.getProcDefId());
		nodeJump.setActInstId(bpmTask.getProcInstId());
		nodeJump.setNodeId(bpmTask.getTaskDefKey());
		nodeJump.setNodeName(bpmTask.getName());
		nodeJump.setOwnerId(bpmTask.getAssignee());
		nodeJump.setHandlerId(bpmTask.getAssignee());
		nodeJump.setJumpType(TaskOptionType.CANCEL_COMMUNICATE.name());
		nodeJump.setCheckStatus("取消沟通");
		nodeJump.setCompleteTime(new Date());
		nodeJump.setRemark(cmd.getOpinion());
		nodeJump.setDuration(0L);
		bpmNodeJumpManager.create(nodeJump);
		
		//产生沟通任务
		bpmTask.setGenCmTask(MBoolean.NO.name());
		update(bpmTask);
		
		BpmInst bpmInst=bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		bpmLogManager.addTaskLog(bpmInst.getSolId(), 
				bpmInst.getInstId(),cmd.getTaskId(), 
				BpmLog.LOG_TYPE_TASK, BpmLog.OP_TYPE_TASK_REVOKE, "撤销沟通:" +bpmInst.getSubject() +",节点：" +bpmTask.getName());
	}
	
	 /**
     * 通过任务引用Id获得流程任务列表
     * @param rcTaskId
     * @return
     */
    public List<BpmTask> getByRcTaskId(String rcTaskId){
    	return bpmTaskDao.getByRcTaskId(rcTaskId);
    }
	
	/**
	 * 产生沟通任务
	 * @param bpmTask
	 * @param cmUserIds
	 */
    public void createCommuteTask(BpmTask bpmTask,ProcessNextCmd cmd,String noticeTypes){
    	String cmUserIds=cmd.getCommunicateUserId();
		if(StringUtils.isEmpty(cmUserIds)) return;
		String[] userIds=cmUserIds.split("[,]");
		StringBuffer buffer=new StringBuffer();
		//产生多个沟通任务
		for(String userId:userIds){
			
			IUser osUser=userService.getByUserId(userId);
			if(osUser!=null){
				buffer.append(osUser.getFullname()).append(",");
			}
			
			BpmTask vTask=new BpmTask();
			try{
				BeanUtil.copyNotNullProperties(vTask, bpmTask);
			}catch(Exception ex){
				logger.error(ex.getMessage());
			}
			if(bpmTask.getCmLevel()==null){
				vTask.setCmLevel(1);
			}else{
				vTask.setCmLevel(bpmTask.getCmLevel()+1);
			}
			vTask.setId(IdUtil.getId());
			vTask.setGenCmTask(MBoolean.NO.name());
			vTask.setAssignee(userId);
			vTask.setOwner(userId);
			vTask.setRcTaskId(bpmTask.getId());
			vTask.setCmFuserId(ContextUtil.getCurrentUserId());
			vTask.setTaskType(BpmTask.TASK_TYPE_CMM);
			vTask.setDescription(bpmTask.getDescription());
			
			create(vTask);
			//发送通知消息
			sendMessage(userId, vTask, noticeTypes, "沟通任务", "commu");
		}
		if(buffer.length()>0){
			buffer.deleteCharAt(buffer.length()-1);
		}
		String fullnames=buffer.toString();
		
		
		
		BpmNodeJump nodeJump=new BpmNodeJump();
		nodeJump.setActDefId(bpmTask.getProcDefId());
		nodeJump.setActInstId(bpmTask.getProcInstId());
		nodeJump.setNodeId(bpmTask.getTaskDefKey());
		nodeJump.setNodeName(bpmTask.getName());
		nodeJump.setOwnerId(bpmTask.getAssignee());
		nodeJump.setHandlerId(ContextUtil.getCurrentUserId());
		nodeJump.setJumpType(TaskOptionType.COMMUNICATE.name());
		nodeJump.setCheckStatus("沟通："+fullnames);
		nodeJump.setCompleteTime(new Date());
		nodeJump.setRemark(cmd.getOpinion());
		nodeJump.setDuration(0L);
		bpmNodeJumpManager.create(nodeJump);
		
		//审批意见附件
		String opFiles = cmd.getOpFiles();
		bpmNodeJumpManager.addOpFiles( opFiles, nodeJump);
		
		//产生沟通任务
		bpmTask.setGenCmTask(MBoolean.YES.name());
		update(bpmTask);
		
		BpmInst bpmInst=bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		bpmLogManager.addTaskLog(bpmInst.getSolId(), 
				bpmInst.getInstId(),cmd.getTaskId(), 
				BpmLog.LOG_TYPE_TASK, BpmLog.OP_TYPE_TASK_COMMUTE, "沟通:" +bpmInst.getSubject() +",节点:" +bpmTask.getName());
				
	}
    
    
	
	/**	
	 * 回复沟通任务
	 * @param cmd
	 */
    public void doReplyCommunicateTask(ProcessNextCmd cmd,String noticeTypes){
		BpmTask bpmTask=get(cmd.getTaskId());
		
		BpmNodeJump nodeJump=new BpmNodeJump();
		nodeJump.setActDefId(bpmTask.getProcDefId());
		nodeJump.setActInstId(bpmTask.getProcInstId());
		nodeJump.setNodeId(bpmTask.getTaskDefKey());
		nodeJump.setNodeName(bpmTask.getName());
		nodeJump.setOwnerId(bpmTask.getAssignee());
		nodeJump.setHandlerId(bpmTask.getAssignee());
		nodeJump.setJumpType(TaskOptionType.REPLY_COMMUNICATE.name());
		nodeJump.setCheckStatus(TaskOptionType.REPLY_COMMUNICATE.name());
		nodeJump.setCompleteTime(new Date());
		nodeJump.setRemark(cmd.getOpinion());
		nodeJump.setDuration(0L);
		bpmNodeJumpManager.create(nodeJump);
		
		//审批意见附件
		String opFiles = cmd.getOpFiles();
		bpmNodeJumpManager.addOpFiles(opFiles, nodeJump);
		
		
		bpmTaskDao.delete(bpmTask.getId());
		
		List<BpmTask> rcTasks=getByRcTaskId(bpmTask.getRcTaskId());
		if(rcTasks.size()==0){
			BpmTask pTask=get(bpmTask.getRcTaskId());
			pTask.setGenCmTask(MBoolean.NO.name());
			update(pTask);
			
			sendMessage(pTask.getAssignee(), pTask, noticeTypes,"回复沟通",  "replycommu");
		}
		
		//增加日志
		BpmInst bpmInst=bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		bpmLogManager.addTaskLog(bpmInst.getSolId(), 
				bpmInst.getInstId(),cmd.getTaskId(), 
				BpmLog.LOG_TYPE_TASK, BpmLog.OP_TYPE_TASK_REPLY, "回复沟通:" +bpmInst.getSubject() +",节点:" +bpmTask.getName());
		
	}
	
	/**
	 * 删除沟通任务
	 * @param taskId
	 */
	public void doDelCommunicateTask(String taskId){
		BpmTask bpmTask=get(taskId);
		//判断该沟通原任务是否已经全部完成
		bpmTaskDao.delete(bpmTask.getId());
		List<BpmTask> rcTasks=getByRcTaskId(bpmTask.getRcTaskId());
		if(rcTasks.size()==0){
			BpmTask pTask=get(bpmTask.getRcTaskId());
			pTask.setGenCmTask(MBoolean.NO.name());
			update(pTask);
		}
	}

	/**
	 * 保存表单数据。
	 * JSON数据格式。
	 * {bos:[ {boDefId:"",formKey:"",data:{}}]}
	 * @param cmd
	 */
	private void saveFormData(JSONObject cmdJson,BpmInst bpmInst,String nodeId,Map<String,Object> vars,String boDefIds){
		if(cmdJson==null) return;
		JSONArray modelArr=cmdJson.getJSONArray("bos");
		if(BeanUtil.isEmpty(modelArr)) return;
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		BpmSolFv fv= bpmSolFvManager.getBySolIdActDefIdNodeId(bpmInst.getSolId(), bpmInst.getActDefId(), nodeId);
		String saveSetting="";
		if(fv!=null) saveSetting=fv.getDataConfs();
		//可由参数不进行传值
		List<String> boDefIdList=StringUtil.toList(boDefIds);
		
		for(int i=0;i<modelArr.size();i++){
			JSONObject boJson=modelArr.getJSONObject(i);
			
			String boDefId=boJson.getString("boDefId");
			String formKey=boJson.getString("formKey");
			if(StringUtils.isEmpty(boDefId) && i<boDefIdList.size()){
				boDefId=boDefIdList.get(i);
				if(StringUtils.isEmpty(formKey)){
					List<String> keys=bpmFormViewManager.getAliasByBoIdMainVersion(boDefId);
					if(keys!=null && keys.size()>0){
						formKey=keys.get(0);
					}
				}
			}
			if(StringUtil.isEmpty(boDefId)) continue;
			
			JSONObject boData=boJson.getJSONObject("data");
			
			boData.put(SysBoEnt.FIELD_INST,bpmInst.getInstId());
		
			if(StringUtil.isNotEmpty(saveSetting)){
				IDataSettingHandler settingHandler=AppBeanUtil.getBean(IDataSettingHandler.class);
				JSONObject settingJson=JSONObject.parseObject(saveSetting);
				settingHandler.handSetting(boData, boDefId, settingJson, true,vars);
			}
			String	dataSaveMode=bpmInst.getDataSaveMode();
			IFormDataHandler handler=BoDataUtil.getDataHandler(dataSaveMode);
			
			String pk=bpmInstDataManager.getPk(bpmInst.getInstId(), boDefId);

			BoResult result= handler.saveData(boDefId, pk, boData);
			
			if(result.getAction().equals(ACTION_TYPE.ADD)){
				bpmInstDataManager.addBpmInstData(boDefId, result.getPk(), bpmInst.getInstId());
			}
			JSONObject json= handler.getData(boDefId, pk);
			if(StringUtils.isNotEmpty(formKey)){
				cmd.getBoDataMaps().put(formKey, json);
			}
		}
	}

	/**
	 * 任务往下跳转
	 * 
	 * @param taskId
	 * @param jsonData
	 * @param vars
	 * @throws Exception
	 */
	public BpmInst doNext(ProcessNextCmd cmd) throws Exception {
		//清除线程缓存。
		ActivitiDefCache.clearLocal();
		ProcessHandleHelper.clearProcessCmd();
		//设置了回退线程
		ProcessHandleHelper.setProcessCmd(cmd);
		ProcessHandleHelper.clearObjectLocal();
		
		TaskEntity task = (TaskEntity) taskService.createTaskQuery().taskId(cmd.getTaskId()).singleResult();
		String curNodeId=task.getTaskDefinitionKey();
		
		BpmInst bpmInst = bpmInstManager.getByActInstId(task.getProcessInstanceId());
		if(BpmInst.STATUS_PENDING.equals(bpmInst.getStatus())){
			ProcessHandleHelper.addErrorMsg("当前流程实例被挂起,不能审批!");
			return null;
		}
		//流程跳转。
		handJumpRule( cmd, curNodeId, bpmInst);
		
		ProcessConfig processConfig=bpmNodeSetManager.getProcessConfig(task.getSolId(), task.getProcessDefinitionId());
		UserTaskConfig userTaskConfig=bpmNodeSetManager.getTaskConfig(task.getSolId(), task.getProcessDefinitionId(),task.getTaskDefinitionKey());
		
		cmd.addTransientVar("processConfig", processConfig);
		// 加上executionId，用来记录执行的路径
		cmd.setHandleNodeId(curNodeId);
		//记录当前的token
		cmd.setToken(task.getToken());
		ProcessHandleHelper.setObjectLocal(userTaskConfig.getTableRightJson());

		// 若为回退，则处理回退的操作
		if ( TaskOptionType.BACK.name().equals(cmd.getJumpType())) {
			if(StringUtils.isEmpty(cmd.getDestNodeId())){
				boolean rtn=handBack(task, userTaskConfig, cmd);
				if(!rtn) return bpmInst;
			}
		}
		//驳回指定节点。
		else if(TaskOptionType.BACK_SPEC.name().equals(cmd.getJumpType())){
			String nodeId=cmd.getDestNodeId();
			BpmRuPath ruPath = bpmRuPathManager.getFarestPath(task.getProcessInstanceId(), nodeId);
			ProcessHandleHelper.setBackPath(ruPath);
		}
		else if (TaskOptionType.BACK_TO_STARTOR.name().equals(cmd.getJumpType())) {// 回退至发起人
			 ActNodeDef afterNode = actRepService.getNodeAfterStart(task.getProcessDefinitionId());
			if (afterNode == null) {
				ProcessHandleHelper.getProcessMessage().getErrorMsges().add("没有找到发起人所在的审批环节！");
				return null;
			}
			//退回到主线程。
			bpmExecutionManager.backToStart(task,cmd,userTaskConfig);
			return bpmInst;
		} else {
			// 查找是否为原路返回的模式，即当前任务是否由回退处理的
			BpmRuPath ruPath = bpmRuPathManager.getFarestPath(task.getProcessInstanceId(), curNodeId);
			if (ruPath != null && "orgPathReturn".equals(ruPath.getNextJumpType())) {
				BpmRuPath toNodePath = bpmRuPathManager.get(ruPath.getParentId());
				if (toNodePath != null) {
					cmd.setDestNodeId(toNodePath.getNodeId());
				}
			}
		}
		
		//加上前置处理
		handPreHandle( userTaskConfig, task, bpmInst, cmd);
		
		String boDefIds=null;
		if(StringUtils.isNotEmpty(task.getSolId())){
			BpmSolution bpmSolution=bpmSolutionManager.get(task.getSolId());
			if(bpmSolution!=null){
				boDefIds=bpmSolution.getBoDefId();
			}
		}
		JSONObject formJsonData= BoDataUtil.getFormDataFromTaskId(cmd.getTaskId(), cmd.getJsonDataObject());
		Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsonsBoIds(formJsonData,boDefIds);
		//cmd中增加当前节点作为下一个节点的上一个节点的处理人
		cmd.getVars().put(ProcessVarType.PRE_NODE_USERID.getKey(), ContextUtil.getCurrentUserId());
		
		Map<String, Object> vars = handleTaskVars(task, modelFieldMap);
		vars.put("check_"+curNodeId.replace("-", "_"), cmd.getJumpType());
		// 加上外围传过来的变量
		if (BeanUtil.isNotEmpty(cmd.getVars())) {
			vars.putAll(cmd.getVars());
		}
		
		Map<String,Object> allVars= runtimeService.getVariables(task.getProcessInstanceId());
		if(BeanUtil.isNotEmpty(vars)){
			allVars.putAll(vars);
		}
		//表间公式处理。
		setFormulaSetting( bpmInst,curNodeId, cmd.getJumpType());
		
		//表单数据保存
		saveFormData(cmd.getJsonDataObject(), bpmInst,curNodeId,allVars,boDefIds);
		//删除暂存
		bpmOpinionTempDao.delTemp(BpmOpinionTemp.TYPE_TASK, task.getId());
		
		// 以下为任务的跳转处理
		if (StringUtils.isNotEmpty(cmd.getDestNodeId())) {// 进行指定节点的跳转
			actTaskService.completeTask(cmd, new String[] { cmd.getDestNodeId() }, vars);
		} else {// 正常跳转
			taskService.complete(cmd.getTaskId(), vars);
		}
		
		//加上后置处理
		handAfterHandle( userTaskConfig,vars, task, bpmInst, cmd);
		if(!TaskOptionType.RECOVER.name().equals(cmd.getJumpType())) {
			//任务自动跳过
			taskManager.handJump(processConfig);
		}
		//记录日志
		bpmLogManager.addTaskLog(bpmInst.getSolId(), 
				bpmInst.getInstId(), task.getId(), 
				BpmLog.LOG_TYPE_TASK, cmd.getJumpType(), "审批任务:" +bpmInst.getSubject() +",节点:" + task.getName());
		
		bpmOvertimeNodeManager.addTaskLog(task,cmd.getJumpType(),"审批任务:" +bpmInst.getSubject() +",节点:" + task.getName());
		
		return bpmInst;
	}
	
	/**
	 * 表间公式。
	 * @param bpmInst
	 * @param jumpType
	 */
	private void setFormulaSetting(BpmInst bpmInst,String nodeId, String jumpType){
		IExecutionCmd cmd= ProcessHandleHelper.getProcessCmd();
		FormulaSetting setting=new FormulaSetting();
		setting.setMode(FormulaSetting.FLOW);
		setting.setSolId(bpmInst.getSolId());
		setting.setActDefId(bpmInst.getActDefId());
		setting.setNodeId(nodeId);
		
		setting.addExtParams("op","approve");
		setting.addExtParams("opinion",jumpType );
		setting.addExtParams("instId",bpmInst.getInstId());
		setting.addExtParams("actInstId",bpmInst.getActInstId());
		setting.addExtParams("opText",cmd.getOpinion() );
		setting.addExtParams("mode", FormulaSetting.FLOW);
		
		ProcessHandleHelper.setFormulaSetting(setting);
		
	}
	
	/**
	 * 处理前置处理器。
	 * @param userTaskConfig
	 * @param task
	 * @param bpmInst
	 * @param cmd
	 */
	private void handPreHandle(UserTaskConfig userTaskConfig,TaskEntity task,BpmInst bpmInst,ProcessNextCmd cmd){
		if(StringUtils.isEmpty(userTaskConfig.getPreHandle())) return;
		Object preBean=AppBeanUtil.getBean(userTaskConfig.getPreHandle());
		if(preBean instanceof TaskPreHandler){
			TaskPreHandler handler=(TaskPreHandler)preBean;
			handler.taskPreHandle(cmd, task, bpmInst.getBusKey());
		}
	}
	
	/**
	 * 处理跳转规则。
	 * @param cmd
	 * @param curNodeId
	 * @param bpmInst
	 */
	private void handJumpRule(ProcessNextCmd cmd,String curNodeId,BpmInst bpmInst){
		if(TaskOptionType.AGREE.name().equals(cmd.getJumpType()) && StringUtil.isEmpty(cmd.getDestNodeId())){
			String toNodeId=jumpRuleService.getTargetNode(bpmInst, curNodeId);
			if(StringUtil.isNotEmpty(toNodeId)){
				cmd.setDestNodeId(toNodeId);
			}
		}
	}
	
	/**
	 * 处理后置处理器。
	 * @param userTaskConfig
	 * @param vars
	 * @param task
	 * @param bpmInst
	 * @param cmd
	 */
	private void handAfterHandle(UserTaskConfig userTaskConfig,Map<String,Object> vars,TaskEntity task,BpmInst bpmInst,ProcessNextCmd cmd){
		if(StringUtils.isEmpty(userTaskConfig.getAfterHandle())) return;
		
		Object preBean=AppBeanUtil.getBean(userTaskConfig.getAfterHandle());
		if(preBean instanceof TaskAfterHandler){
			TaskAfterHandler handler=(TaskAfterHandler)preBean;
			//设置上下文变量。
			cmd.setVars(vars);
			handler.taskAfterHandle(cmd, task.getTaskDefinitionKey(), bpmInst.getBusKey());
		}	
	}
	
	/**
	 * 处理驳回节点。
	 * @param task
	 * @param userTaskConfig
	 * @param cmd
	 * @return
	 */
	private boolean handBack(TaskEntity task,UserTaskConfig userTaskConfig,ProcessNextCmd cmd){
		PathResult result=bpmRuPathManager.getBackNode(task.getProcessInstanceId(), task.getTaskDefinitionKey());
		// 没有找到回退的节点，提示用户
		if (result == null || !result.canTransto()) {
			ProcessHandleHelper.getProcessMessage().getErrorMsges().add("本环节不能回退！没有找到上一步的回退审批环节!");
			return false;
		}
		//这种情况表示 有网关
		else if(!result.isDirectTo()){
			boolean isInset= actRepService.isInset(task.getProcessDefinitionId(), result.getGateWay());
			BpmTask bpmTask=bpmTaskDao.get(task.getId());
			//当前节点在网关内部。
			if(isInset){
				bpmExecutionManager.handFromInset(bpmTask, userTaskConfig);
			}
			else{
				bpmExecutionManager.handFromOutset(bpmTask,result,userTaskConfig);
			}
			return false;
		}
		else {// 设置回退的节点
			BpmRuPath bpmRuPath=result.getBpmRuPath();
			cmd.setDestNodeId(bpmRuPath.getNodeId());
			ProcessHandleHelper.setBackPath(bpmRuPath);
			return true;
		}
	}

	
	
	/**
	 * 通过流程实例Id获得流程任务列表
	 * 
	 * @param actInstId
	 * @return
	 */
	public List<BpmTask> getByActInstId(String actInstId) {
		return bpmTaskDao.getByActInstId(actInstId);
	}
	
	/**
	 * 根据实例和节点ID获取任务。
	 * @param actInstId
	 * @param nodeId
	 * @return
	 */
	public List<BpmTask> getByActInstNode(String actInstId,String nodeId){
		return bpmTaskDao.getByActInstNode(actInstId, nodeId);
	}

	/**
	 * 处理任务中的流程变量
	 * 
	 * @param task
	 * @param jsonData
	 * @return
	 */
	private Map<String, Object> handleTaskVars(TaskEntity task, Map<String,Object> params) {
		// 处理流程变量
		String solId = (String) task.getSolId();
		List<BpmSolVar> configVars = bpmSolVarManager.getBySolIdActDefIdNodeId(solId, task.getProcessDefinitionId(), BpmSolVar.SCOPE_PROCESS);
		configVars.addAll(bpmSolVarManager.getBySolIdActDefIdNodeId(solId,task.getProcessDefinitionId(), task.getTaskDefinitionKey()));
		//JSONObject jsonDataObj = JSONObject.fromObject(jsonData);
		Map<String,Object> vars=new HashMap<String, Object>();
		for (BpmSolVar var : configVars) {
			String formField=var.getFormField();
			String key=var.getKey();
			
			Object val=null;
			//优先从表单字段映射
			if(StringUtils.isNotEmpty(formField)){
				val= (Object) params.get(formField);
			}
			if(val==null) {
				val= (Object) params.get(key);	
			}
			if (val == null) {
				val=var.getDefVal();
			}
			//防止全局变量没传值也会被清空
			if(val==null) continue;
			try {
				// 计算后的变量值
				Object exeVal = null;
				// 计算表达式以获得值
				if (StringUtils.isNotEmpty(var.getExpress())) {
					exeVal = groovyEngine.executeScripts(var.getExpress(), task.getVariables());
				} else if (BpmSolVar.TYPE_DATE.equals(var.getType())) {// 直接从页面中获得值进行转化
					exeVal = DateUtil.parseDate((String)val);
				} else if (BpmSolVar.TYPE_NUMBER.equals(var.getType())) {
					exeVal = new Double((String)val);
				} else {
					exeVal = val;
				}
				vars.put(var.getKey(), exeVal);
			} catch (Exception ex) {
				logger.error(ex.getMessage());
			}
		}
		return vars;
	}
	
	/**
	 * 获取机构的所有待办列表
	 * @param filter
	 * @return
	 */
	public List<BpmTask> getAllTasksForSaasAdmin(QueryFilter filter){
		String tenantId=ContextUtil.getCurrentTenantId();
		filter.addFieldParam("TENANT_ID_", tenantId);
		List<BpmTask>  bpmTasks=bpmTaskDao.getAllTasks(filter);
		setDueDate(bpmTasks);
		return bpmTasks;
	}
	
	/**
	 * 查询待办。
	 * @param filter
	 * @return
	 */
	public List<BpmTask> getByUserId(QueryFilter filter) {
		
		String userId = ContextUtil.getCurrentUserId();
		
		List<String> groupList=groupService.getGroupsIdByUserId(userId);

		filter.addFieldParam("userId", userId);
		filter.addFieldParam("suspensionState", "1");//查询未作废的任务
		filter.addFieldParam("groupList", groupList);
		if(StringUtil.isNotEmpty(ContextUtil.getCurrentTenantId())){
			filter.addFieldParam("tenantId",ContextUtil.getCurrentTenantId());
		}
		List<BpmTask> list=bpmTaskDao.getByUserId(filter);
		calcExecutors(list);
		return list;
	}
	
	public void calcExecutors(List<BpmTask> bpmTasks){
		/**
		 * 计算得到用户。
		 */
		for(BpmTask task:bpmTasks){
			if(StringUtils.isNotEmpty(task.getAssignee())){
				IUser iUser=userService.getByUserId(task.getAssignee());
				if(iUser!=null){
					task.setAssigneeNames(iUser.getFullname());
				}
			}else{//计算多个用户的任务
				//存放计算出来的人员情况
				StringBuffer userNames=new StringBuffer();
				List<IdentityLink> idLinks = taskService.getIdentityLinksForTask(task.getId());
				for (IdentityLink idLink : idLinks) {
					if(!"candidate".equals(idLink.getType())) continue;
					if (StringUtils.isNotEmpty(idLink.getGroupId())) {
						IGroup osGroup = groupService.getById(idLink.getType(), idLink.getGroupId());
						userNames.append("[组]" +osGroup.getIdentityName() +",");
					} else if (StringUtils.isNotEmpty(idLink.getUserId()) ) {
						IUser osUser = userService.getByUserId(idLink.getUserId());
						if(osUser!=null){
							userNames.append(osUser.getIdentityName() +",");
						}
						
					}
				}
				if(userNames.length()>0){
					userNames.deleteCharAt(userNames.length()-1);
				}
				task.setAssigneeNames(userNames.toString());
			}
		}
	}
	
	
	/**
	 * 获得用户及组下的所有的待办数
	 * @param userId
	 * @return
	 */
	public Long getTaskCountsByUserId(String userId){
		List<String> groupList=groupService.getGroupsIdByUserId(userId);
		return bpmTaskDao.getTaskCountsByUserId(userId, ContextUtil.getCurrentTenantId(),groupList);
	}
	
	/**
	 * 按用户查询对应的待办
	 * @param userId
	 * @param filter
	 * @return
	 */
	public List<BpmTask> getByUserId(String userId,QueryFilter filter){
		
		List<String> groupList=groupService.getGroupsIdByUserId(userId);

		filter.addFieldParam("userId", userId);
		filter.addFieldParam("suspensionState", "1");//查询未作废的任务
		filter.addFieldParam("groupList", groupList);
		
		return bpmTaskDao.getByUserId(filter);
	}
	
	/**
	 * 取得任务所有人。
	 * <pre>
	 * 包括任务所有人或者候选人。
	 * </pre>
	 * @param taskId
	 * @return
	 */
	public Set<IUser> getTaskUsers(String taskId){
		BpmTask bpmTask=get(taskId);
		Set<IUser> userSet=new HashSet<IUser>();
		//从执行用户获取
		if(StringUtils.isNotEmpty(bpmTask.getAssignee())){
			userSet.add(userService.getByUserId( bpmTask.getAssignee()));
		}
		//从候选人获取。
		else{
			List<IdentityLink> idLinks = taskService.getIdentityLinksForTask(bpmTask.getId());
			for (IdentityLink idLink : idLinks) {
				if (StringUtils.isNotEmpty(idLink.getGroupId()) && "candidate".equals(idLink.getType())) {
					List<IUser> userList=userService.getByGroupIdAndType(idLink.getGroupId(),idLink.getType());
					for(IUser user:userList){
						userSet.add(user);
					}
				} else if (StringUtils.isNotEmpty(idLink.getUserId()) && "candidate".equals(idLink.getType())) {
					userSet.add(userService.getByUserId(idLink.getUserId()));
				}
			}
		}
		
		return userSet;
	}
	
	/**
	 * 取得当前任务的处理用户
	 * @param taskId
	 * @return
	 */
	public Set<TaskExecutor> getTaskHandlerUsersIds(String taskId){
		BpmTask bpmTask=get(taskId);
		ActNodeDef nodeDef=actRepService.getActNodeDef(bpmTask.getProcDefId(), bpmTask.getTaskDefKey());
		Set<TaskExecutor> userIds=new HashSet<TaskExecutor>();
	
		//多实例任务
		if(nodeDef!=null && StringUtils.isNotEmpty(nodeDef.getMultiInstance())){
			List<TaskExecutor> signUserIds=(List<TaskExecutor>)runtimeService.getVariable(bpmTask.getExecutionId(), "signUserIds_"+bpmTask.getTaskDefKey());
			userIds.addAll(signUserIds);
			
		}else{
			//从执行用户获取
			if(StringUtils.isNotEmpty(bpmTask.getAssignee())){
				IUser user=userService.getByUserId(bpmTask.getAssignee()); 
				userIds.add(TaskExecutor.getUserExecutor(user));
			}else{
				//取得候选用户
				List<IdentityLink> idLinks = taskService.getIdentityLinksForTask(bpmTask.getId());
				for (IdentityLink idLink : idLinks) {
					if (StringUtils.isNotEmpty(idLink.getGroupId()) && "candidate".equals(idLink.getType())) {
						IGroup group=groupService.getById(idLink.getGroupId());
						userIds.add(TaskExecutor.getGroupExecutor(group));
					} else if (StringUtils.isNotEmpty(idLink.getUserId()) && "candidate".equals(idLink.getType())) {
						IUser user=userService.getByUserId(idLink.getUserId()); 
						userIds.add(TaskExecutor.getUserExecutor(user));
					}
				}
			}
		}

		return userIds;
	}
	
	//显示当前任务对应的候选或执行用户（含其他并行任务的人员）
	public Collection<TaskExecutor> getTaskHandleIdentityInfos(String taskId){
		Collection<TaskExecutor> identityInfos=getTaskHandlerUsersIds(taskId);
		return identityInfos;
	}
	
	/**
	 * 节点人员
	 * @param instId
	 * @param nodeId
	 * @return
	 */
	public Collection<TaskExecutor> getInstNodeUsers(String instId,String nodeId){
		BpmInst bpmInst=bpmInstManager.get(instId);
		Collection<TaskExecutor> identityInfos=null;
		Map<String,Object> variables=null;
		if(BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())){
			//是否为当前任务
			boolean isCurTask=false;
			//若当前节点为运行的流程任务，则从任务中获取
			List<BpmTask> tasks=getByActInstId(bpmInst.getActInstId());
			for(BpmTask task:tasks){
				if(task.getTaskDefKey().equals(nodeId)){
					isCurTask=true;
					identityInfos=getTaskHandleIdentityInfos(task.getId());
				}
			}
			if(!isCurTask){
				variables=runtimeService.getVariables(bpmInst.getActInstId());
				identityInfos= bpmIdentityCalService.calNodeUsersOrGroups(bpmInst.getActDefId(), nodeId, variables);
			}
		}else{//流程已经结束
			identityInfos=new HashSet<TaskExecutor>();
			Set<String> nodeUsers=new HashSet<String>();
			//查找审批环节中的处理人
			List<BpmNodeJump> bpmNodeJumps=bpmNodeJumpManager.getByActInstIdNodeId(bpmInst.getActInstId(), nodeId);
			for(BpmNodeJump jump:bpmNodeJumps){
				if(StringUtils.isNotEmpty(jump.getHandlerId())){
					nodeUsers.add(jump.getHandlerId());
				}
			}
			if(nodeUsers.size()>0){//该节点已经审批
				for(String userId:nodeUsers){
					IUser osUser=userService.getByUserId(userId);
					identityInfos.add(TaskExecutor.getUserExecutor(osUser));
				}
			}else{//需要从审批环节配置中查找该人员
				variables=new HashMap<String, Object>();
				//传入必须的流程变量进行运算处理
				variables.put("startUserId",bpmInst.getCreateBy());
				variables.put(BpmIdentityCalService.SIMULATE_CAL, "true");
				variables.put("solId", bpmInst.getSolId());
				
				Collection<TaskExecutor> bpmIdenties= bpmIdentityCalService.calNodeUsersOrGroups(bpmInst.getActDefId(), nodeId, variables);
				identityInfos.addAll(bpmIdenties);
			}
		}
		
		return identityInfos;
	}
	
	/**
	 * 取得当前任务
	 * @param bpmTask
	 * @return
	 */
	public String getNowUser(BpmTask bpmTask){
		Set<TaskExecutor> userIds=getTaskHandlerUsersIds(bpmTask.getId());
		StringBuffer sb=new StringBuffer();
		for(TaskExecutor uId:userIds){
			if(TaskExecutor.IDENTIFY_TYPE_USER.equals(uId.getType())){
				IGroup mainDep=groupService.getMainByUserId(uId.getId());
				if(mainDep!=null){
					sb.append(mainDep.getIdentityName()).append(":");
				}
				sb.append(uId.getName());
			}
			else{
				sb.append("[组]:" + uId.getName() +";");
			}
		}
		return sb.toString();
	}
	
	public List<BpmTask> getAllTasks(QueryFilter filter){
		IUser user=ContextUtil.getCurrentUser();
		String tenantId=ContextUtil.getCurrentTenantId();
		filter.addFieldParam("TENANT_ID_", tenantId);
		List<BpmTask>  bpmTasks=null;
		if(user.isSuperAdmin()){
			bpmTasks=bpmTaskDao.getAllTasks(filter);
		}
		else{
			Map<String, Set<String>> profileMap= ProfileUtil.getCurrentProfile();
			String grantType=BpmAuthSettingManager.getGrantType();
			filter.addFieldParam("profileMap", profileMap);
			filter.addFieldParam("grantType", grantType);
			bpmTasks=bpmTaskDao.getTasks(filter);
		}
		//设置到期时间。
		setDueDate(bpmTasks);
		
		return bpmTasks;
	}
	
	/**
	 * 根据催办实例设置到期时间。
	 * @param bpmTasks
	 */
	private void setDueDate(List<BpmTask>  bpmTasks){
		if(BeanUtil.isEmpty(bpmTasks)) return;
		Map<String,BpmTask> taskMap=convertTaskToMap(bpmTasks);
		List<BpmRemindInst> instList= bpmRemindInstDao.getByTaskIds(taskMap.keySet());
		if(BeanUtil.isEmpty(instList)) return;
		Map<String,BpmRemindInst> instMap= convertInstToMap(instList);
		for(BpmTask task:bpmTasks){
			String taskId=task.getId();
			if(instMap.containsKey(taskId)){
				BpmRemindInst inst= instMap.get(taskId);
				task.setDueDate(inst.getExpireDate());
			}
			else{
				task.setDueDate(null);
			}
		}
	}
	
	/**
	 * 将任务转成map对象。
	 * @param bpmTasks
	 * @return
	 */
	private Map<String,BpmTask> convertTaskToMap(List<BpmTask>  bpmTasks){
		Map<String,BpmTask> taskMap=new HashMap<String, BpmTask>();
		for(BpmTask task:bpmTasks){
			taskMap.put(task.getId(), task);
		}
		return taskMap;
	}
	
	/**
	 * 催办实例转成map对象。
	 * @param insts
	 * @return
	 */
	private Map<String,BpmRemindInst> convertInstToMap(List<BpmRemindInst>  insts){
		Map<String,BpmRemindInst> instMap=new HashMap<String, BpmRemindInst>();
		for(BpmRemindInst inst:insts){
			instMap.put(inst.getTaskId(), inst);
		}
		return instMap;
	}
	
	/**
	 * 1.获取全部的分类。
	 * 2.获取使用了的分类。
	 * 3.对数据进行处理，删除没有使用的树形数据。
	 * @return
	 */
	public List<SysTree> getTaskTree(){
		String tenantId=ContextUtil.getCurrentTenantId();
		
		Map<String,Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		List<SysTree> sysTrees= sysTreeManager.getByCatKeyTenantId(SysTree.CAT_BPM_SOLUTION, tenantId);
		//用过的树形数据。
		// 行数据为map，键值为 TREE_ID_,TREE_PATH_,AMOUNT
		List userList= bpmTaskDao.getCategoryTree(tenantId, profileMap);
		//取得删除的树形数据。
		List<SysTree> removeTrees = sysTreeManager.getRemoveList(sysTrees, userList);
		
		sysTrees.removeAll(removeTrees);
		
		return sysTrees;
	}
	
	/**
	 * 处理并行会签人员。
	 * <pre>
	 * 	1.修改流程变量，executionID
	 * 		nrOfInstances:总的实例数
	 * 		nrOfActiveInstances:活动的实例数。
	 *  2.增加act_ru_execution。
	 *  3.增加关联的的任务记录 ACT_RU_TASK。
	 * </pre>
	 * @param actInstId
	 * @param nodeId
	 * @param userIds
	 */
	public void doChangeParallelUser(String actInstId,String nodeId,String[] userIds){
		String varName="signUserIds_" + nodeId;
		List<BpmTask> list= (List<BpmTask>) this.getByActInstNode(actInstId, nodeId);
		Map<String,List<String>> mapUsers= getDiffUsers(actInstId,nodeId,userIds);
		
		//计算增加用户
		List<String> addUsers=mapUsers.get("addUsers");
		//计算删除用户
		List<String> delUsers=mapUsers.get("delUsers");
		//
		
		
		List<BpmTask> removeTasks= getDelTask(list,delUsers);
		
		if(addUsers.size()==0 && removeTasks.size()==list.size() ){
			throw new RuntimeException("不能修改会签人员,没有活动的任务了!");
		}
		
		BpmTask task=list.get(0);
		BpmExecution execution=bpmExecutionManager.get(task.getExecutionId());
		String parentId= execution.getParentId();
		
		Integer nrOfInstances=(Integer) runtimeService.getVariable(parentId, "nrOfInstances");
		Integer nrOfActiveInstances=(Integer) runtimeService.getVariable(parentId, "nrOfActiveInstances");
		
		//变更数量
		int diffSize=addUsers.size()-removeTasks.size();
		
		nrOfInstances+=diffSize;
		nrOfActiveInstances+=diffSize;
		//实例数量
		runtimeService.setVariable(parentId, "nrOfInstances", nrOfInstances);
		//活动数量
		runtimeService.setVariable(parentId, "nrOfActiveInstances", nrOfActiveInstances);
		//记录人员
		runtimeService.setVariable(parentId, varName, StringUtil.join(userIds, ","));
		//删除任务
		delTasks(removeTasks);
		//新建任务
		addTasks(addUsers,list.get(0),execution);
	}
	
	
	/**
	 * 串行会签人员更改。
	 * @param actInstId		流程实例ID
	 * @param nodeId		会签节点ID
	 * @param userIds		会签人员数组
	 */
	public void doChangeSequenceUser(String actInstId,String nodeId,String[] userIds){
		String varName="signUserIds_" + nodeId;
		/**
		 * 获取串行会签节点任务。
		 */
		List<BpmTask> taskList=bpmTaskDao.getByActInstNode(actInstId, nodeId);
		BpmTask task=taskList.get(0);
		String executionId=task.getExecutionId();
		//取得执行的索引位置
		Integer loopCounter= (Integer) runtimeService.getVariable(executionId, "loopCounter");
		//取得当前会签的人员。
		String orignUser=(String) runtimeService.getVariable(actInstId, varName);
		//取得会签的用户
		List<String> rtnList = getSeqUsers(userIds, loopCounter, orignUser);
		//取得执行人
		String assignee=rtnList.get(loopCounter);
		//重新设置任务执行人。
		task.setAssignee(assignee);
		//最终的审批人员
		String rtnUserIds= StringUtil.join(rtnList, ",");
		//设置流程变量
		runtimeService.setVariable(actInstId, varName, rtnUserIds);
		//设置会签实例数量。
		runtimeService.setVariable(executionId, "nrOfInstances", rtnList.size());
		
		this.update(task);
		
		
	}

	/**
	 * 计算串行会签人员。
	 * <pre>
	 *  如果已经审批的人员则不能删除。
	 *  1.取得还未审批的人员。
	 *  2.从未审批的人员中取得可以删除的人员。
	 *  3.取得新增的人员。
	 * </pre>
	 * @param userIds			新选择的人员
	 * @param idx		审批到的位置
	 * @param orignUser			之前的会签人员
	 * @return
	 */
	private List<String> getSeqUsers(String[] userIds, Integer idx, String orignUser) {
		String[] aryOriginUser=orignUser.split(",");
		
		List<String> originList=getListByAry(aryOriginUser);
		List<String> willList=new ArrayList<String>();
		List<String> newList= getListByAry(userIds);
		//1.取出还未审批的人员。
		for(int i=idx;i<aryOriginUser.length;i++){
			willList.add(aryOriginUser[i]);
		}
		//2.从未审批的人员中取得需要删除的人员，已经审批的不能删除。
		List<String> delUsers= getUsers( willList ,newList);
		//3.取得需要新增的审批人员。
		List<String> addUsers= getUsers( newList ,originList);
		
		List<String> rtnList= new ArrayList<String>();
		for(int i=0;i<originList.size();i++){
			String val=originList.get(i);
			if(delUsers.contains(val))continue;
			rtnList.add(originList.get(i));
		}
		rtnList.addAll(addUsers);
		return rtnList;
	}
	
	

	/**
	 * 取得变动的用户。
	 * @param actInstId	实例ID
	 * @param nodeId	节点ID
	 * @param userIds	选择的用户
	 * @return Map<String,List<String>> 
	 * 	addUsers :添加的用户
	 *  delUsers :删除的用户
	 */
	private Map<String,List<String>> getDiffUsers(String actInstId,String nodeId,String[] userIds){
		String varName="signUserIds_" + nodeId;
		String orginUsers=(String) runtimeService.getVariable(actInstId, varName);
		String[] aryOrgin=orginUsers.split(",");
		
		List<String> userList= getListByAry(userIds);
		List<String> originList= getListByAry(aryOrgin);
		
		//计算增加用户
		List<String> addUsers=getUsers(userList,originList);
		//计算删除用户
		List<String> delUsers=getUsers(originList,userList);
		
		Map<String,List<String>> mapUsers=new HashMap<String, List<String>>();
		mapUsers.put("addUsers", addUsers);
		mapUsers.put("delUsers", delUsers);
		
		return mapUsers;
		
	}
	
	
	
	/**
	 * 创建意见。
	 * @param bpmtask
	 * @return
	 */
	private BpmNodeJump createNodeJump(BpmTask bpmtask) {
		BpmNodeJump nodeJump = new BpmNodeJump(bpmtask);
		bpmNodeJumpManager.create(nodeJump);
		return nodeJump;
	}
	
	/**
	 * 添加任务。
	 * @param addUsers
	 * @param task
	 */
	private void addTasks(List<String> addUsers,BpmTask task,BpmExecution execution) {
		for(int i=0;i<addUsers.size();i++){
			BpmTask taskNew=(BpmTask) task.clone();
			BpmExecution executionNew=new BpmExecution(execution);
			executionNew.setId(IdUtil.getId());
			
			taskNew.setId(IdUtil.getId());
			taskNew.setExecutionId(executionNew.getId());
			taskNew.setOwner(addUsers.get(i));
			taskNew.setAssignee(addUsers.get(i));
			//增加execution记录。
			bpmExecutionManager.create(executionNew);
			//增加任务
			bpmTaskDao.create(taskNew);
			//增加意见。
			createNodeJump(taskNew);
		}
	}
	
	
	
	/**
	 * 删除任务。
	 * @param removeTasks
	 */
	private void delTasks(List<BpmTask> removeTasks){
		for(int i=0;i<removeTasks.size();i++){
			BpmTask task=removeTasks.get(i);
			this.delete(task.getId());
			
			bpmExecutionManager.delVarsByExecutionId(task.getExecutionId());
			bpmExecutionManager.delete(task.getExecutionId());
		}
	}
	
	/**
	 * 取得删除的任务。
	 * @param list
	 * @param delUsers
	 * @return
	 */
	private List<BpmTask> getDelTask(List<BpmTask> list,List<String> delUsers){
		List<BpmTask> resultList=new ArrayList<BpmTask>();
		for(BpmTask task:list){
			if(delUsers.contains(task.getAssignee())){
				resultList.add(task);
			}
		}
		return resultList;
		
	}
	
	/**
	 * 遍历来新用户查看是否在原用户中是否存在。
	 * 如果存在则跳过，不存在则添加到返回列表中。
	 * @param sourceUsers
	 * @param orginUsers
	 * @return
	 */
	private static List<String> getUsers(List<String>  sourceUsers,List<String> orginUsers){
		List<String> rtnList=new ArrayList<String>();
		for(int i=0;i<sourceUsers.size();i++){
			String val=sourceUsers.get(i);
			boolean rtn= isInAry(val,orginUsers);
			if(rtn) continue;
			rtnList.add(val);
		}
		return rtnList;
	}
	
	/**
	 * 判断一个ID是否在数组中。
	 * @param id
	 * @param aryStr
	 * @return
	 */
	private static boolean isInAry(String id,List<String> aryStr){
		for(int i=0;i<aryStr.size();i++){
			String tmp=aryStr.get(i);
			if(id.equals(tmp))return true;
		}
		return false;
	}
	
	/**
	 * 根据数组获取列表。
	 * @param ary
	 * @return
	 */
	private static List<String> getListByAry(String[] ary){
		List<String> list=new ArrayList<String>();
		for(int i=0;i<ary.length;i++){
			list.add(ary[i]);
		}
		return list;
	}
	

	/**
	 * 返回当前节点后续人员。
	 * @param taskId
	 * @return
	 */
	public List<DestNodeUsers> getDestnationUsers(String taskId){
		List<DestNodeUsers> destNodeUserList = getDestNodeUsers(taskId);
		for (DestNodeUsers destNodeUsers : destNodeUserList) {
			if(destNodeUsers.getTaskNodeUser()==null || StringUtils.isEmpty(destNodeUsers.getTaskNodeUser().getUserIds())){
				continue;
			}
			String[] userIds=destNodeUsers.getTaskNodeUser().getUserIds().split(",");
			String[] userNames=destNodeUsers.getTaskNodeUser().getUserFullnames().split(",");
			JSONArray jsonArray=new JSONArray();
			for (int i = 0; i < userIds.length; i++) {
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("id", userIds[i]);
				jsonObject.put("text", userNames[i]);
				jsonArray.add(jsonObject);
			}
			destNodeUsers.getTaskNodeUser().setUserIdsAndText(jsonArray.toString());
		}
		return destNodeUserList;
	}
	
	public BpmTask getBySolIdActDefIdNodeIdInstId(String solId,String actDefId,String nodeId,String instId) {
		return bpmTaskDao.getBySolIdActDefIdNodeIdInstId(solId,actDefId,nodeId,instId);
	}
	
	
	/**
	 * 是否到达结束节点。
	 * @param nodeUsers
	 * @return
	 */
	public boolean isReachEndEvent(List<DestNodeUsers> nodeUsers){
		boolean isReachEndEvent = false;
		if (nodeUsers.size() == 1) {
			DestNodeUsers destNodeUser = nodeUsers.get(0);
			if (destNodeUser.getNodeType().indexOf("endEvent") != -1) {
				isReachEndEvent = true;
			}
		}
		return isReachEndEvent;
	}
	
	/**
	 * 发送通知消息。
	 * @param receiveId
	 * @param task
	 * @param noticeTypes	通知类型
	 * @param title			标题
	 * @param templateAlias	模板类型
	 */
	public void sendMessage(String receiveId,BpmTask task,String noticeTypes,String title,String templateAlias){
		if(StringUtil.isEmpty(noticeTypes)) return;
		String template=MessageUtil.getFlowTemplateByAlias(templateAlias);
		
		MessageModel msgModel=new MessageModel();
		msgModel.setSubject(title);
		msgModel.setTemplateAlias(template);
		IUser sender=(IUser) userService.getByUserId(ContextUtil.getCurrentUserId());
		
		msgModel.setSender(sender);
		List<IUser> receiverList=new ArrayList<IUser>();
		
		IUser osUser=userService.getByUserId(receiveId);
		receiverList.add(osUser);

		Map<String,Object> vars=msgModel.getVars();
		
		vars.put("sender", sender.getFullname());
		vars.put("receiver", osUser.getFullname());
		
		String installHost="";
		try {
			installHost=WebAppUtil.getInstallHost();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		vars.put("serverUrl", installHost);
		vars.put("taskId", task.getId());
		vars.put("subject", task.getDescription());
		
		msgModel.setRecieverList(receiverList);
		msgModel.setType(noticeTypes);
		
		
		SysUtil.sendMessage(msgModel);
	}
	
	/**
	 * 根据父实例ID获取任务列表。
	 * @param parentId
	 * @return
	 */
	public List<BpmTask> getByParentExecutionId(String parentId){
		List<BpmTask> list=this.bpmTaskDao.getByParentExecutionId(parentId);
		return list;
	}
	
	/**
	 * 根据任务ID获取执行路径节点。
	 * 
	 * 计算逻辑：
	 * 1.根据任务ID获取流程定义。
	 * 2.遍历流程定义节点。
	 * 3.如果节点已经执行，则获取节点的执行人员。
	 * 4.如果碰到网关节点，那么获取网关之后的节点，根据条件判断路径选择。
	 * 
	 * @param taskId
	 * @return
	 */
	public List<TaskNodeUser> getNodeUsersByTaskId(String taskId){
		List<TaskNodeUser> list=new ArrayList<TaskNodeUser>();
		BpmTask bpmTask=this.get(taskId);
		
		String nodeId=bpmTask.getTaskDefKey();
		//获取流程变量。
		String actInstId=bpmTask.getProcInstId();
		Map<String,Object> vars=runtimeService.getVariables(bpmTask.getProcInstId());
		String actDefId=bpmTask.getProcDefId();
		ActProcessDef actProcessDef = actRepService.getProcessDef(actDefId);
		Map<String, ActNodeDef> mapNodes= actProcessDef.getNodesMap();
		
		//获取历史数据。
		handHistory( actInstId, list, bpmTask.getTaskDefKey());
		
		List<ActNodeDef> nodes= mapNodes.get(nodeId).getOutcomeNodes();
		//从当前节点往下遍历。
		ActNodeDef node=nodes.get(0);
		handNode(node,list,actDefId,bpmTask.getSolId(),vars);
		
		return list;
	}
	
	/**
	 * 处理历史信息。
	 * @param actInstId
	 * @param list
	 * @param nodeId
	 */
	private void handHistory(String actInstId,List<TaskNodeUser> list,String nodeId){
		List<BpmRuPath> pathList= bpmRuPathManager.getByActInstId(actInstId);
		Map<String,BpmRuPath> pathNodeMap=new HashMap<>();
		Map<String,BpmRuPath> pathMap=new HashMap<>();
		for(int i=0;i<pathList.size();i++){
			BpmRuPath path=pathList.get(i);
			pathNodeMap.put(path.getNodeId(), path);
			pathMap.put(path.getPathId(), path);
		}
		BpmRuPath curPath=pathNodeMap.get(nodeId);
		
		TaskNodeUser nodeUser=new TaskNodeUser();
		nodeUser.setNodeId(nodeId);
		nodeUser.setNodeText(curPath.getNodeName());
		IUser cuser=ContextUtil.getCurrentUser();
		nodeUser.setExeUserIds(cuser.getUserId());
		nodeUser.setUserFullnames(cuser.getFullname());
		
		list.add(0, nodeUser);
		
		BpmRuPath parentPath=pathMap.get(curPath.getParentId());
		while(!parentPath.getNodeType().equals("startEvent")){
			if(parentPath.getNodeType().equals("userTask") && parentPath.getJumpType().equals("AGREE")){
				nodeUser=new TaskNodeUser();
				nodeUser.setNodeId(parentPath.getNodeId());
				nodeUser.setNodeText(parentPath.getNodeName());
				nodeUser.setUserIds(parentPath.getAssignee());
				IUser user= userService.getByUserId(parentPath.getAssignee());
				nodeUser.setUserFullnames(user.getFullname());
				list.add(0, nodeUser);
				
				
			}
			parentPath=pathMap.get(parentPath.getParentId());
		}
		
	}
	
	private String getNames( Collection<TaskExecutor> idInfoList){
		List<String> list=new ArrayList<>();
		for(TaskExecutor info:idInfoList){
			if(TaskExecutor.IDENTIFY_TYPE_USER.equals(info.getType())){
				list.add(info.getName());
			}
			else{
				list.add(info.getName() +"[组]");
			}
		}
		String str=StringUtil.join(list, ",");
		return str;
	} 
	
	
	public void handNode(ActNodeDef node,List<TaskNodeUser> list,String actDefId,String solId,Map<String,Object> vars){
		String nodeType=node.getNodeType();
		//String nodeId=node.getNodeId();
		if(nodeType.equals("endEvent")) return;
		//任务节点
		if(nodeType.equals("userTask")){
			TaskNodeUser nodeUser=new TaskNodeUser();
			nodeUser.setNodeId(node.getNodeId());
			nodeUser.setNodeText(node.getNodeName());
			
			Collection<TaskExecutor> idInfoList = bpmIdentityCalService.calNodeUsersOrGroups(actDefId,node.getNodeId(), vars);
			
			String userNames= getNames(idInfoList);
			
			nodeUser.setUserFullnames(userNames);
			
			list.add(nodeUser);
			List<ActNodeDef> nodes= node.getOutcomeNodes();
			handNode(nodes.get(0),list,actDefId,solId,vars);
		}
		//分支网关节点。
		if(nodeType.equals("exclusiveGateway")){
			
			List<ActNodeDef> nodes= node.getOutcomeNodes();
			String tmpNodeId="";
			ActNodeDef tmpNode=null;
			boolean flag=false;
			
			ExclusiveGatewayConfig configs=bpmNodeSetManager.getExclusiveGatewayConfig(solId,actDefId,node.getNodeId());
			Map<String,String> scriptMap=DefUtil.getConditionMap(configs);
			
			for(int i=0;i<nodes.size();i++){
				tmpNode=nodes.get(i);
				tmpNodeId=tmpNode.getNodeId();
				
				
				if(!scriptMap.containsKey(tmpNodeId)){
					flag=true;
					break;
				}
				if(scriptMap.containsKey(tmpNodeId)){
					Map<String,Object> model=new HashMap<>();
					model.put("vars", vars);
					Object boolVal = groovyEngine.executeScripts(scriptMap.get(tmpNodeId), model);
					if (boolVal instanceof Boolean && (Boolean)boolVal) {
						flag=true;
						break;
					}
				}
			}
			if(!flag) return;
			
			handNode(tmpNode,list,actDefId,solId,vars);
			
		}
	}
	
	
	/**
	 * 处理任务是否有权限。
	 * @param bpmTask
	 * @param config
	 * @param formModels
	 * @return
	 * @throws TemplateException
	 * @throws IOException
	 */
	public JsonResult<String> handAllowTask(BpmTask bpmTask,UserTaskConfig config,List<FormModel> formModels) throws TemplateException, IOException{
		JsonResult<String> rtn=new JsonResult<String>(true);
		String allowScript=config.getAllowScript();
		
		if(StringUtil.isEmpty(allowScript)) return rtn;
		String actInstId=bpmTask.getProcInstId();
		String tipInfo=config.getAllowTipInfo();
		Map<String,Object> vars=runtimeService.getVariables(actInstId);
		
		Map<String,Object> models=new HashMap<String,Object>();
		models.put("vars", vars);
		models.put("task", bpmTask);
		if(BeanUtil.isNotEmpty(formModels)){
			for(FormModel model:formModels){
				models.put(model.getFormKey(), model.getJsonData());
			}
		}
		
		Boolean result= (Boolean) groovyEngine.executeScripts(allowScript, models);
		if(result) return rtn;
		
		String tipMsg=freemarkEngine.parseByStringTemplate(models, tipInfo);
		
		rtn.setMessage(tipMsg);
		rtn.setSuccess(false);
		
		return rtn;
		
	}
	
	/**
	 * 添加会签。
	 * @param taskId
	 * @param opinion
	 * @param userId
	 * @param notifyTypes
	 * @return
	 */
	public JsonResult doAddSignTask(String taskId,String userId,String notifyTypes){
		String[] aryUsers=userId.split(",");
		JsonResult result= addSignTask( taskId,aryUsers,notifyTypes);
		BpmTask bpmTask=bpmTaskDao.get(taskId);
		BpmInst bpmInst=bpmInstManager.get(bpmTask.getInstId());
		
		bpmLogManager.addTaskLog(bpmInst.getSolId(), 
				bpmInst.getInstId(),taskId, 
				BpmLog.LOG_TYPE_TASK, BpmLog.OP_TYPE_TASK_ADDSIGN, "加签:" +bpmInst.getSubject() +",节点:" +bpmTask.getName());
		
		return result;
	}
	
	
	/**
	 * 添加会签人员。
	 * <pre>
	 * </pre>
	 * @param taskId	任务ID
	 * @param aryUsers	任务人员ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private JsonResult addSignTask(String taskId,String[] aryUsers,String notifyTypes) {
		if(aryUsers==null || aryUsers.length==0) return  new JsonResult(false,"没有选择人员!");
		
		BpmTask bpmTask=bpmTaskDao.get(taskId);
		
		String nodeId=bpmTask.getTaskDefKey();
		
		ActNodeDef actDef=actRepService.getActNodeDef(bpmTask.getProcDefId(), nodeId);
		String multiInstance= actDef.getMultiInstance();
		if(StringUtil.isEmpty(multiInstance)) return  new JsonResult(false,"当前节点不是会签节点!");
		
		String varName=TaskVarType.SIGN_USER_IDS_.getKey()+nodeId;
		
		String executionId=bpmTask.getExecutionId();
		
		List<TaskExecutor> executors= (List<TaskExecutor>) runtimeService.getVariable(executionId, varName);
		
		List<TaskExecutor> taskExecutors= getCanAddUsers( executors , aryUsers);
		
		if(taskExecutors.isEmpty()) return new JsonResult(false,"指定的人员已存在!"); 
		
		int userAmount=taskExecutors.size();
		
		Integer nrOfInstances=(Integer)runtimeService.getVariable(executionId, BpmConstants.NUMBER_OF_INSTANCES);
		//增加总的会签数量。
		if(nrOfInstances!=null){
			runtimeService.setVariable(executionId, BpmConstants.NUMBER_OF_INSTANCES, nrOfInstances + userAmount);
		}
		
		if(BpmConstants.MULTI_INST_PARALLEL.equals(multiInstance)){
			Integer loopCounter=nrOfInstances-1;
			Integer nrOfActiveInstances=(Integer)runtimeService.getVariable(executionId, BpmConstants.NUMBER_OF_ACTIVE_INSTANCES);
			runtimeService.setVariable(executionId, BpmConstants.NUMBER_OF_ACTIVE_INSTANCES, nrOfActiveInstances + userAmount);
			
			for(int i=0;i<userAmount;i++){
				TaskExecutor executor=taskExecutors.get(i);
				BpmTask task= addTask( bpmTask,executor.getId());
				
				String newExecutionId=task.getExecutionId();
				
				Integer index= (Integer)(loopCounter + i +1);
				
				runtimeService.setVariableLocal(newExecutionId,BpmConstants.NUMBER_OF_LOOPCOUNTER,index);
				//添加意见。
				bpmNodeJumpManager.addNodeJump(task);
				//发送会签消息
				sendMessage(executor.getId(), task, notifyTypes, "加签事项", "addsign");
			}
		}
		else{
			//添加流程变量。
			executors.addAll(taskExecutors);
			runtimeService.setVariable(executionId, varName, executors);
		}
		
		return new JsonResult(true,"添加会签人员成功!");
	}
	
	/**
	 * 手工添加会签任务。
	 * <pre>
	 *  1.添加会签任务。
	 *  2.添加Execution。
	 *  3.添加任务历史。
	 * </pre>
	 * @param bpmTask
	 * @param userId
	 * @return
	 */
	private BpmTask addTask(BpmTask bpmTask,String userId){
		String newTaskId=IdUtil.getId();
		String newExecutionId=IdUtil.getId();
		
		String taskId=bpmTask.getId();
		
		BpmExecution bpmExecution=bpmExecutionManager.get(bpmTask.getExecutionId());
		ActHiTaskinst actHiTaskInst=actHiTaskinstDao.get(taskId);
		
		//execution
		BpmExecution newExecution= (BpmExecution) bpmExecution.clone();
		newExecution.setId(newExecutionId);
		bpmExecutionManager.create(newExecution);
		
		//创建任务
		BpmTask newTask= (BpmTask) bpmTask.clone();
		newTask.setId(newTaskId);
		newTask.setExecutionId(newExecutionId);
		newTask.setAssignee(userId);
		newTask.setOwner(userId);
		newTask.setCreateTime(new Date());
		bpmTaskDao.create(newTask);
		
		
		//历史任务信息
		ActHiTaskinst newActHiTask=(ActHiTaskinst)actHiTaskInst.clone();
		newActHiTask.setId(newTaskId);
		newActHiTask.setExecutionId(newExecutionId);
		newActHiTask.setAssignee(userId);
		newActHiTask.setOwner(userId);
		actHiTaskinstDao.create(newActHiTask);
		
		return newTask;
	}
	
	private List<TaskExecutor> getCanAddUsers(List<TaskExecutor> executors ,String[] aryUsers){
		Set<String> users=new  HashSet<>();
		for(TaskExecutor executor:executors){
			if(TaskExecutor.IDENTIFY_TYPE_USER.equals(executor.getType())){
				users.add(executor.getId());
			}
			else{
				List<IUser> iUsers=userService.getByGroupId(executor.getId());
				for(IUser user:iUsers){
					users.add(user.getUserId());
				}
			}
		}
		List<TaskExecutor> taskExecutors=new ArrayList<>();
		for(String userId:aryUsers){
			if(users.contains(userId)) continue;
			IUser user=userService.getByUserId(userId);
			taskExecutors.add(TaskExecutor.getUserExecutor(user));
		}
		return taskExecutors;
		
	}
	
	
	
}