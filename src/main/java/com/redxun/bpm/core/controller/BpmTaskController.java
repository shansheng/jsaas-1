package com.redxun.bpm.core.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.bpm.core.identity.service.IdentityCalConfig;
import com.redxun.bpm.core.identity.service.IdentityCalService;
import com.redxun.bpm.core.identity.service.IdentityTypeService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.entity.ActVarInst;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmInstAttach;
import com.redxun.bpm.core.entity.BpmInstCtl;
import com.redxun.bpm.core.entity.BpmInstRead;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmOpinionTemp;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.entity.config.DestNodeUsers;
import com.redxun.bpm.core.entity.config.MultiTaskConfig;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.TaskNodeUser;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmInstAttachManager;
import com.redxun.bpm.core.manager.BpmInstCtlManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmInstReadManager;
import com.redxun.bpm.core.manager.BpmInstTmpManager;
import com.redxun.bpm.core.manager.BpmLogManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmOpinionTempManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.BpmSolCtlManager;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.bpm.core.service.sign.CounterSignService;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.enums.TaskVarType;
import com.redxun.bpm.form.api.FormHandlerFactory;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SortParam;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.model.IdentityInfo;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;



/**
 * 任务实例管理
 *
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn） 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmTask/")
public class BpmTaskController extends TenantListController {
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmDefManager bpmDefManager;
	@Resource
	BpmInstReadManager bpmInstReadManager;
	@Resource
	TaskService taskService;
	@Resource
	RuntimeService runtimeService;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	BpmInstAttachManager bpmInstAttachManager;
	@Resource
	SysFileManager sysFileManager;
	@Resource
	BpmInstCtlManager bpmInstCtlManager;
	@Resource
	ActRepService actRepService;
	@Resource
	BpmIdentityCalService bpmIdentityCalService;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	BpmAuthSettingManager bpmAuthSettingManager;
	@Resource
	UserService userService;
	@Resource
	GroupService groupService;
	@Resource
	FormHandlerFactory formHandlerFactory;
	@Resource
	BpmOpinionTempManager bpmOpinionTempManager;
	@Resource(name="iJson")
    ObjectMapper objectMapper;
	@Resource
	BpmRuPathManager bpmRuPathManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
    SysBoDefManager sysBoDefManager;
	@Resource
	CounterSignService counterSignService;

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = super.getQueryFilter(request);
		queryFilter.addSortParam("createTime", SortParam.SORT_DESC);
		return queryFilter;
	}

	/**
	 *  获得Vars
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getVars")
	@ResponseBody
	public JsonResult getVars(HttpServletRequest request,HttpServletResponse response)throws Exception{
		String taskId=request.getParameter("taskId");
		BpmTask bpmTask=bpmTaskManager.get(taskId);
		Map<String,Object> vars=runtimeService.getVariables(bpmTask.getExecutionId());

		Iterator<Entry<String, Object>> it2=vars.entrySet().iterator();
		while(it2.hasNext()){
			Entry<String,Object> ent=it2.next();
			logger.info("========key:"+ent.getKey() +" val:"+ent.getValue());
		}

		String json=JSONUtil.toJson(vars);
		logger.info("json:"+json);
		Map<String,Object> mapVars=JSONUtil.json2Map(json);

		//Set<Entry<String, Object>> mySet=mapVars.entrySet();
		Iterator<Entry<String, Object>> it=mapVars.entrySet().iterator();
		while(it.hasNext()){
			Entry<String,Object> ent=it.next();
			logger.info("key:"+ent.getKey() +" val:"+ent.getValue());
		}

		return new JsonResult(true,"success");
	}

	/**
	 * 更改执行路径
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("changePath")
	@ResponseBody
	@LogEnt(action = "changePath", module = "流程", submodule = "任务待办")
	public JsonResult changePath(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String nodeId=request.getParameter("nodeId");
		String destNodeId=request.getParameter("destNodeId");
		String instId=request.getParameter("instId");
		String jumpType=request.getParameter("jumpType");
		String opinion=request.getParameter("opinion");
		String nextJumpType=request.getParameter("nextJumpType");

		ProcessHandleHelper.clearBackPath();


		BpmInst bpmInst=bpmInstManager.get(instId);
		List<BpmTask> bpmTasks=bpmTaskManager.getByActInstId(bpmInst.getActInstId());

		ProcessMessage handleMessage =  new ProcessMessage();
		JsonResult result = new JsonResult();

		for(BpmTask task:bpmTasks){
			if(!task.getTaskDefKey().equals(nodeId)) continue;
			try {
				ProcessHandleHelper.setProcessMessage(handleMessage);
				ProcessNextCmd processNextCmd = new ProcessNextCmd();
				processNextCmd.setTaskId(task.getId());
				processNextCmd.setNextJumpType(nextJumpType);

				IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
				List<FormModel> formModels= formHandler.getByTaskId(task.getId(), "");
				if( formModels!=null &&formModels.size()>0 ){
					JSONObject jsonDataObj=new JSONObject();
					JSONArray boArr=new JSONArray();
					for(FormModel fm:formModels){
						JSONObject bo=new JSONObject();
						bo.put("boDefId", fm.getBoDefId());
						bo.put("formKey", fm.getFormKey());
						bo.put("data", fm.getJsonData());
						boArr.add(bo);
					}
					jsonDataObj.put("bos", boArr);
					processNextCmd.setJsonData(jsonDataObj.toJSONString());
				}else{
					processNextCmd.setJsonData("{}");
				}

				processNextCmd.setDestNodeId(destNodeId);
				if(StringUtils.isEmpty(opinion)){
					processNextCmd.setOpinion(ContextUtil.getCurrentUser().getFullname() + "进行了跳转干预！");
				}else{
					processNextCmd.setOpinion(opinion);
				}
				if(StringUtils.isNotEmpty(jumpType)){
					processNextCmd.setJumpType(jumpType);
				}else{
					processNextCmd.setJumpType(TaskOptionType.INTERPOSE.name());
				}
				bpmTaskManager.doNext(processNextCmd);
			} catch (Exception ex) {
				ex.printStackTrace();
				if (handleMessage.getErrorMsges().size() == 0) {
					handleMessage.getErrorMsges().add(ex.getMessage());
				}
			} finally {
				// 在处理过程中，是否有错误的消息抛出
				if (handleMessage.getErrorMsges().size() > 0) {
					result.setSuccess(false);
					result.setMessage(handleMessage.getErrors());
				} else {
					result.setSuccess(true);
					result.setMessage("成功干预！");
				}
				ProcessHandleHelper.clearProcessMessage();
			}
			break;
		}
		return result;
	}

	/**
	 * 后台管理所有的任务
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getAllTasks")
	@ResponseBody
	public JsonPageResult<BpmTask> getAllTasks(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_",ContextUtil.getCurrentTenantId());

		String treeId=RequestUtil.getString(request, "treeId");
		if(StringUtil.isNotEmpty(treeId)){
			SysTree sysTree= sysTreeManager.get(treeId);
			if(sysTree!=null){
				String path=sysTree.getPath();
				queryFilter.addLeftLikeFieldParam("TREE_PATH_", path);
			}
		}

		List<BpmTask> tasks=bpmTaskManager.getAllTasks(queryFilter);

		bpmAuthSettingManager.setRight(tasks);

		/**
		 * 计算得到用户。
		 */
		bpmTaskManager. calcExecutors(tasks);

		return new JsonPageResult<BpmTask>(tasks,queryFilter.getPage().getTotalItems());
	}



	/**
	 * 计算用户不同情况下的节点的人员,含流程未启动时，流程审批时，流程结束时其节点上的人员
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("calUsers")
	public ModelAndView calUsers(HttpServletRequest request,HttpServletResponse response) throws Exception{
		//任务Id
		String taskId=request.getParameter("taskId");
		//实例Id
		String instId=request.getParameter("instId");
		//解决方案Id
		String solId=request.getParameter("solId");
		//说明，以上三个参数只需要传入一个，代表不同情况下的人员计算获取情况：任务运行时获取，实例运行时获取，流程尚未启动时获取
		//节点Id
		String nodeId=request.getParameter("nodeId");
		//表单数据
		String jsonData=request.getParameter("jsonData");

		//存放计算出来的人员情况
		Collection<TaskExecutor> identityInfos=new ArrayList<TaskExecutor>();
		//获得节点定义
		ActNodeDef actNodeDef=null;
		String nodeName=null;
		//任务类型
		String actDefId=null;
		String actInstId=null;
		if(StringUtils.isNotEmpty(taskId)){
			ProcessStartCmd cmd=new ProcessStartCmd();
			cmd.setJsonData(jsonData);
			ProcessHandleHelper.setProcessCmd(cmd);
			BpmTask bpmTask=bpmTaskManager.get(taskId);
			actDefId=bpmTask.getProcDefId();
			actInstId=bpmTask.getProcInstId();
			//确定具体的执行人
			if(bpmTask.getTaskDefKey().equals(nodeId)
					&& StringUtils.isNotEmpty(bpmTask.getAssignee())){
				actNodeDef=actRepService.getActNodeDef(actDefId, nodeId);
				//若为会签，则显示会签的人员
				if(StringUtils.isNotEmpty(actNodeDef.getMultiInstance())){
					String uIds=(String)taskService.getVariable(bpmTask.getId(), TaskVarType.SIGN_USER_IDS_.getKey()+bpmTask.getTaskDefKey());
					if(StringUtils.isNotEmpty(uIds)){
						String[]signUserIds=uIds.split("[,]");
						for(String userId:signUserIds){
							IUser osUser=userService.getByUserId(userId);
							identityInfos.add(TaskExecutor.getUserExecutor(osUser));
						}
					}
				}else{//非会签，则显示当前任务的人员
					IUser osUser=userService.getByUserId(bpmTask.getAssignee());
					identityInfos.add(TaskExecutor.getUserExecutor(osUser));
				}

			}else if(bpmTask.getTaskDefKey().equals(nodeId)){//找当前任务的候选用户

				List<IdentityLink> idLinks = taskService.getIdentityLinksForTask(bpmTask.getId());
				for (IdentityLink idLink : idLinks) {
					if (StringUtils.isNotEmpty(idLink.getGroupId()) && "candidate".equals(idLink.getType())) {
						IGroup osGroup = groupService.getById(idLink.getType(), idLink.getGroupId());
						identityInfos.add(TaskExecutor.getGroupExecutor(osGroup));
					} else if (StringUtils.isNotEmpty(idLink.getUserId()) && "candidate".equals(idLink.getType())) {
						IUser osUser = userService.getByUserId(idLink.getUserId());
						identityInfos.add(TaskExecutor.getUserExecutor(osUser));
					}
				}
			}else{//计算节点的人员
				Map<String,Object> variables=runtimeService.getVariables(bpmTask.getProcInstId());
				variables.put(ProcessVarType.PRE_NODE_USERID.getKey(),ContextUtil.getCurrentUserId());
				Collection<TaskExecutor> bpmIdenties= bpmIdentityCalService.calNodeUsersOrGroups(bpmTask.getProcDefId(), nodeId, variables);
				identityInfos.addAll(bpmIdenties);
			}
		}else if(StringUtils.isNotEmpty(instId)){//通过流程实例进来看节点的人员
			BpmInst bpmInst=bpmInstManager.get(instId);
			IFormDataHandler handler= BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_DB);
			BpmSolution solution = bpmSolutionManager.get(bpmInst.getSolId());
			String boDefIds = solution.getBoDefId();
			if(StringUtil.isNotEmpty(boDefIds)) {
				String[] defIds = boDefIds.split(",");
				JSONArray bosArr = new JSONArray();
				for (int i = 0; i < defIds.length; i++) {
					String formKey = sysBoDefManager.getAliasById(defIds[i]);
					JSONObject jsonObj = new JSONObject();
					Map<String,Object> param = new HashMap<String,Object>();
					param.put("INST_ID_", instId);
					JSONObject data= handler.getData(defIds[i], param);
					jsonObj.put("data", data);
					jsonObj.put("formKey", formKey);
					jsonObj.put("boDefId", defIds[i]);
					bosArr.add(jsonObj);
				}
				JSONObject bos = new JSONObject();
				bos.put("bos", bosArr.toJSONString());
				ProcessStartCmd cmd=new ProcessStartCmd();
				cmd.setJsonData(bos.toJSONString());
				ProcessHandleHelper.setProcessCmd(cmd);
			}
			actDefId=bpmInst.getActDefId();
			actInstId=bpmInst.getActInstId();
			Map<String,Object> variables=null;
			//流程在运行中
			if(BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())){
				variables=runtimeService.getVariables(bpmInst.getActInstId());
				Collection<TaskExecutor> bpmIdenties= bpmIdentityCalService.calNodeUsersOrGroups(bpmInst.getActDefId(), nodeId, variables);
				identityInfos.addAll(bpmIdenties);
			}else{//流程已经结束
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
		}else if(StringUtils.isNotEmpty(solId)){//在流程启动阶段，计算人员
			BpmSolution bpmSolution=bpmSolutionManager.get(solId);
			BpmDef bpmDef=bpmDefManager.getLatestBpmByKey(bpmSolution.getDefKey(),ContextUtil.getCurrentTenantId());
			actDefId=bpmDef.getActDefId();

			Map<String,Object> variables=new HashMap<String, Object>();
			//传入必须的流程变量进行运算处理
			variables.put("startUserId",ContextUtil.getCurrentUserId());
			variables.put(BpmIdentityCalService.SIMULATE_CAL, "true");
			variables.put("solId", bpmSolution.getSolId());

			//计算人员
			Collection<TaskExecutor> bpmIdenties= bpmIdentityCalService.calNodeUsersOrGroups(bpmDef.getActDefId(), nodeId, variables);
			identityInfos.addAll(bpmIdenties);
		}
		if(actNodeDef==null){
			actNodeDef=actRepService.getActNodeDef(actDefId, nodeId);
		}
		if(actNodeDef!=null){
			nodeName=actNodeDef.getNodeName();
		}
		TaskNodeUser taskNodeUser=new TaskNodeUser();
		taskNodeUser.setMultiInstance(actNodeDef.getMultiInstance());
		taskNodeUser.setNodeId(nodeId);
		taskNodeUser.setNodeText(nodeName);

		StringBuffer userNames=new StringBuffer();
		StringBuffer userIds=new StringBuffer();
		//显示用户
		for(TaskExecutor info:identityInfos){
			if(TaskExecutor.IDENTIFY_TYPE_USER.equals(info.getType())){

				userNames.append(info.getName()).append(",");
				userIds.append(info.getId()).append(",");
			}else if(info instanceof IGroup){
				List<IUser> osUsers=userService.getByGroupIdAndType(info.getId(),"");
				for(IUser user:osUsers){
					userNames.append(user.getFullname()).append(",");
					userIds.append(user.getUserId()).append(",");
				}
			}
		}

		if(userNames.length()>0){
			userNames.deleteCharAt(userNames.length()-1);
			userIds.deleteCharAt(userIds.length()-1);
		}

		taskNodeUser.setUserIds(userIds.toString());
		taskNodeUser.setUserFullnames(userNames.toString());

		ModelAndView mv=this.getPathView(request);

		if(StringUtils.isNotEmpty(actInstId) && StringUtils.isNotEmpty(taskId)){
			List<BpmNodeJump> nodeJumps=bpmNodeJumpManager.getByActInstIdNodeId(actInstId, nodeId);
			mv.addObject("nodeJumps", nodeJumps);
		}

		return mv.addObject("taskNodeUser",taskNodeUser);
	}



	/**
	 * 跳至更改执行路径页
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("toChangePath")
	public ModelAndView toChangePath(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = getPathView(request);
		String taskId = request.getParameter("taskId");
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		mv.addObject("bpmTask", bpmTask);
		return mv;
	}

	/**
	 * 删除任务
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("del")
	@ResponseBody
	@LogEnt(action = "del", module = "流程", submodule = "任务待办")
	public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uId = request.getParameter("ids");
		if (StringUtils.isEmpty(uId)) {
			return new JsonResult(false, "没有选择ID");
		}
		String msg = "成功删除！";
		String[] ids = uId.split(",");
		for (String id : ids) {
			try {
				BpmTask tmp=bpmTaskManager.get(id);
				if(BpmTask.TASK_TYPE_CMM.equals(tmp.getTaskType())){
					bpmTaskManager.doDelCommunicateTask(tmp.getId());
				}else{
					bpmTaskManager.delete(id);
				}
			} catch (Exception ex) {
				msg = "流程任务是运行流程实例中的任务，不允许删除！";
			}
		}
		return new JsonResult(true, msg);
	}

	/**
	 * 获得流程跳转的构建参数
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private ProcessNextCmd getProcessNextCmd(HttpServletRequest request) throws Exception {
		String taskId = request.getParameter("taskId");
		String jsonData = request.getParameter("jsonData");
		String jumpType = request.getParameter("jumpType");
		//意见
		String opinion = request.getParameter("opinion");
		//意见名称
		String opinionName = request.getParameter("opinionName");

		String destNodeId = request.getParameter("destNodeId");
		String destNodeUsers = request.getParameter("destNodeUsers");
		String nextJumpType = request.getParameter("nextJumpType");
		String opFiles = request.getParameter("opFiles");


		// 加上抄送处理
		String ccUserIds = request.getParameter("ccUserIds");

		String communicateUserId=request.getParameter("communicateUserId");

		ProcessNextCmd cmd = new ProcessNextCmd();
		cmd.setOpFiles(opFiles);
		cmd.setTaskId(taskId);
		if(StringUtils.isEmpty(jsonData)){
			jsonData="{}";
		}
		cmd.setJsonData(jsonData);

		cmd.setJumpType(jumpType);
		cmd.setOpinion(opinion);
		cmd.setOpinionName(opinionName);
		cmd.setNextJumpType(nextJumpType);
		cmd.setCommunicateUserId(communicateUserId);
		cmd.setCcUserIds(ccUserIds);

		if (StringUtils.isNotEmpty(destNodeId)) {
			cmd.setDestNodeId(destNodeId);
		}
		cmd.setDestNodeUsers(destNodeUsers);

		return cmd;
	}

	/**
	 * 创建沟通
	 * @param cmd
	 */
	public void communicateTask(ProcessNextCmd cmd,String noticeTypes){
		BpmTask bpmTask =bpmTaskManager.get(cmd.getTaskId());
		//产生沟通任务及记录
		bpmTaskManager.createCommuteTask(bpmTask, cmd,noticeTypes);

	}



	/**
	 * 保存在线任务表单的数据
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doSaveData")
	@ResponseBody
	@LogEnt(action = "doSaveData", module = "流程", submodule = "任务待办")
	public JsonResult doSaveData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = RequestUtil.getString(request,"taskId");
		String jsonData = request.getParameter("jsonData");

		bpmTaskManager.doSaveData(taskId, jsonData);

		return new JsonResult(true, "成功暂存表单的数据！");
	}

	@RequestMapping("saveOpinion")
	@ResponseBody
	@LogEnt(action = "saveOpinion", module = "流程", submodule = "任务待办")
	public JsonResult saveOpinion(HttpServletRequest request){
		String taskId = RequestUtil.getString(request,"taskId");
		String opFiles =request.getParameter("opFiles");
		String opinion = request.getParameter("opinion");
		bpmOpinionTempManager.createTemp(BpmOpinionTemp.TYPE_TASK, taskId, opinion, opFiles);
		return new JsonResult(true, "成功保存意见数据！");
	}

	/**
	 * 自由跳转
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doFreeJump")
	@ResponseBody
	@LogEnt(action = "doFreeJump", module = "流程", submodule = "任务待办")
	public JsonResult doFreeJump(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProcessHandleHelper.clearBackPath();
		// 加上处理的消息提示
		ProcessMessage handleMessage = null;
		JsonResult result = new JsonResult();
		try {
			handleMessage = new ProcessMessage();
			ProcessHandleHelper.setProcessMessage(handleMessage);
			ProcessNextCmd processNextCmd = getProcessNextCmd(request);
			processNextCmd.setOpinion(ContextUtil.getCurrentUser().getFullname() + "进行了跳转干预！");

			bpmTaskManager.doNext(processNextCmd);
		} catch (Exception ex) {
			// ex.printStackTrace();
			if (handleMessage.getErrorMsges().size() == 0) {
				handleMessage.getErrorMsges().add(ex.getMessage());
			}
		} finally {
			// 在处理过程中，是否有错误的消息抛出
			if (handleMessage.getErrorMsges().size() > 0) {
				result.setSuccess(false);
				result.setMessage(handleMessage.getErrors());
			} else {
				result.setSuccess(true);
				result.setMessage("成功干预！");
			}
			ProcessHandleHelper.clearProcessMessage();
		}
		return result;
	}

	/**
	 * 批量处理任务跳下一步
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doNextAll")
	@ResponseBody
	@LogEnt(action = "doNextAll", module = "流程", submodule = "任务待办")
	public JsonResult doNextAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 加上处理的消息提示
		JsonResult result = new JsonResult(true,"批量审批成功!");
		ProcessNextCmd processNextCmd = getProcessNextCmd(request);
		String[] tasks = processNextCmd.getTaskId().split(",");

		try {
			ProcessMessage handleMessage = new ProcessMessage();
			ProcessHandleHelper.setProcessMessage(handleMessage);
			for (String taskId : tasks) {
				processNextCmd.setTaskId(taskId);
				bpmTaskManager.doNext(processNextCmd);
			}

		}catch (Exception ex) {
			ex.printStackTrace();
    		result.setSuccess(false);
    		result.setMessage("批量审批出错!");
    		result.setData(ExceptionUtil.getExceptionMessage(ex));
		} finally {
			// 在处理过程中，是否有错误的消息抛出
			ProcessHandleHelper.clearProcessMessage();
		}
		return result;
	}

	@RequestMapping("approveUserList")
	@ResponseBody
	public JSONObject approveUserList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String data=RequestUtil.getString(request, "postData");
		String taskId=RequestUtil.getString(request, "taskId");
		String jumpType=RequestUtil.getString(request, "jumpType");
		JSONObject postData=JSONObject.parseObject(data).getJSONObject("jsonData");
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		ProcessStartCmd cmd=new ProcessStartCmd();
		cmd.setJsonData(postData.toJSONString());
		cmd.getVars().put("check_"+bpmTask.getTaskDefKey(), jumpType);
		ProcessHandleHelper.setProcessCmd(cmd);

		JSONObject obj = new JSONObject();
		// 获得任务的下一步的人员映射列表
		List<DestNodeUsers> destNodeUserList = bpmTaskManager.getDestnationUsers(taskId);
		// 是否到达结束事件节点
		boolean isReachEndEvent = bpmTaskManager.isReachEndEvent(destNodeUserList);
		obj.put("list", destNodeUserList);
		obj.put("isReachEndEvent", isReachEndEvent);
		return obj;
	}

	@RequestMapping("approve")
	public ModelAndView approve(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId=RequestUtil.getString(request, "taskId");
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		// 获得流程实例
		BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());

		ProcessConfig processConfig= bpmNodeSetManager.getProcessConfig(bpmInst.getSolId(),bpmTask.getProcDefId());

		// 获得任务的下一步的人员映射列表
		//List<DestNodeUsers> destNodeUserList = bpmTaskManager.getDestnationUsers(taskId);
		UserTaskConfig taskConfig = bpmNodeSetManager.getTaskConfig(bpmInst.getSolId(), bpmTask.getProcDefId(),bpmTask.getTaskDefKey());

		ActNodeDef actNodeDef = actRepService.getActNodeDef(bpmTask.getProcDefId(), bpmTask.getTaskDefKey());

		BpmOpinionTemp temp = bpmOpinionTempManager.getByType(BpmOpinionTemp.TYPE_TASK,bpmTask.getId());


		boolean isMulti=StringUtil.isNotEmpty(actNodeDef.getMultiInstance());

		ModelAndView mv=getPathView(request);

		mv.addObject("taskConfig", taskConfig);
		//mv.addObject("destNodeUserList", destNodeUserList);
		mv.addObject("isMulti", isMulti);
		mv.addObject("taskId", taskId);
		mv.addObject("opinion", temp);
		mv.addObject("actDefId", bpmTask.getProcDefId());

		Map<String,String> opinionMap= processConfig.getOpinionTextMap();
		mv.addObject("opinionMap",opinionMap);

		if(processConfig.getShowExecPath().equals("true")){
			List<TaskNodeUser> nodeUsers= bpmTaskManager.getNodeUsersByTaskId(taskId);
			mv.addObject("nodeUsers", nodeUsers);
		}

		return mv;
	}


	@RequestMapping("doCommu")
	@ResponseBody
	public JsonResult doCommu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResult result = new JsonResult(true);
		ProcessNextCmd processNextCmd = getProcessNextCmd(request);
		String noticeTypes = request.getParameter("noticeTypes");
		try{
			communicateTask(processNextCmd,noticeTypes);
			result.setMessage("沟通成功!");
		}
		catch(Exception ex){
			result.setMessage("沟通失败!");
			result.setData(ex.getMessage());
			result.setSuccess(false);
		}
		return result;
	}

	@RequestMapping("revokeCommu")
	@ResponseBody
	public JsonResult revokeCommu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResult result = new JsonResult(true);
		ProcessNextCmd processNextCmd = getProcessNextCmd(request);
		String noticeTypes = request.getParameter("noticeTypes");
		try{
			bpmTaskManager.doCancelCommuteTask(processNextCmd);
			result.setMessage("撤销沟通成功!");
		}
		catch(Exception ex){
			result.setMessage("撤销沟通失败!");
			result.setSuccess(false);
		}
		return result;
	}

	@RequestMapping("doReplyCommu")
	@ResponseBody
	public JsonResult doReplyCommu(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResult result = new JsonResult(true);
		ProcessNextCmd processNextCmd = getProcessNextCmd(request);
		String noticeTypes = request.getParameter("noticeTypes");
		try{
			bpmTaskManager.doReplyCommunicateTask(processNextCmd,noticeTypes);
			result.setMessage("回复沟通成功!");
		}
		catch(Exception ex){
			result.setMessage("回复沟通失败!");
			result.setSuccess(false);
		}
		return result;
	}

	/**
	 * 处理任务跳下一步
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doNext")
	@ResponseBody
	@LogEnt(action = "doNext", module = "流程", submodule = "任务待办")
	public JsonResult doNext(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 加上处理的消息提示
		BpmInst bpmInst=null;
		ProcessMessage handleMessage = null;
		JsonResult result = new JsonResult();
		ProcessHandleHelper.clearBackPath();
		ProcessNextCmd processNextCmd = getProcessNextCmd(request);
		try {
			handleMessage = new ProcessMessage();
			ProcessHandleHelper.setProcessMessage(handleMessage);
			//产生沟通任务
			bpmInst=bpmTaskManager.doNext(processNextCmd);


		}catch (Exception ex) {
			ex.printStackTrace();
    		if(handleMessage.getErrorMsges().size()==0){
    			handleMessage.getErrorMsges().add(ex.getMessage());
    		}
		} finally {
			// 在处理过程中，是否有错误的消息抛出
			if (handleMessage.getErrorMsges().size() > 0) {
				result.setSuccess(false);
				result.setMessage(handleMessage.getErrors());

			} else {
				result.setSuccess(true);
				result.setMessage("成功处理任务！");

			}
			ProcessHandleHelper.clearProcessMessage();
		}
		return result;
	}

	/**
	 * 跳到任务的处理页
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("toStart")
	@LogEnt(action = "toStart", module = "流程", submodule = "任务待办")
	public ModelAndView toStart(HttpServletRequest request) throws Exception {
		String taskId = request.getParameter("taskId");
		// 是否从任务管理窗口进来
		String fromMgr = request.getParameter("fromMgr");
		// 获得任务实例
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		// 若任务为空，则表示任务已经被处理或完成，这时需要提示用户
		if (bpmTask == null) {
			return getTaskEmptyMv();
		}
		String actInstId=bpmTask.getProcInstId();
		String nodeId=bpmTask.getTaskDefKey();

		// 若任务尚未处理，则锁定给当前用户
		lockTask(fromMgr, bpmTask);
		// 获得流程实例
		BpmInst bpmInst = bpmInstManager.getByActInstId(actInstId);
		// 流程实例已经被删除
		if (bpmInst == null) {
			bpmTaskManager.delete(taskId);
			return getTaskEmptyMv();
		}
		// 获得任务节点的配置
		UserTaskConfig taskConfig = bpmNodeSetManager.getTaskConfig(bpmInst.getSolId(), bpmTask.getProcDefId(),nodeId);
		//处理外部URL
		ModelAndView mv= handExternalUrl(taskConfig,bpmTask,bpmInst);

		if(mv!=null) return mv;
		//子表权限
		ProcessHandleHelper.clearObjectLocal();
		ProcessHandleHelper.setObjectLocal(taskConfig.getTableRightJson());
		//审批按钮的Json格式

		//是否显示作废的按钮
		boolean isShowDiscardBtn= canDiscard( bpmInst);
		// 记录阅读人数
		recordRead( bpmInst);
		//处理表单
		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels= formHandler.getByTaskId(taskId, "");
		//任务执行。
		JsonResult<String> result= bpmTaskManager.handAllowTask(bpmTask,taskConfig,formModels);
		//是否能驳回
		List<BpmRuPath> backNodes= bpmRuPathManager.getBackNodes(actInstId, nodeId);

		String userId=ContextUtil.getCurrentUserId();

		boolean canAddSign= getCanAddSignTask( taskConfig, userId);
		return getPathView(request).addObject("bpmTask", bpmTask)
				.addObject("bpmInst", bpmInst)
				.addObject("taskConfig", taskConfig)
				.addObject("isShowDiscardBtn", isShowDiscardBtn)
				.addObject("formModels", formModels)
				.addObject("canReject", backNodes.size()>0)
				.addObject("canAddSign", canAddSign)
				.addObject("allowTask", result);
	}

	/**
	 * 判断是否能够添加用户。
	 * @param taskConfig
	 * @param userId
	 * @return
	 */
	private boolean getCanAddSignTask(UserTaskConfig taskConfig,String userId){
		MultiTaskConfig config=  taskConfig.getMultiTaskConfig();
		if(BeanUtil.isEmpty(config.getAddSignConfigs())){
			return false;
		}
		return counterSignService.hasAddPermission(config, userId);

	}

	/**
	 * 锁定任务。
	 * @param fromMgr
	 * @param bpmTask
	 */
	/**
	 * 锁定任务。
	 * @param fromMgr
	 * @param bpmTask
	 */
	private void lockTask(String fromMgr,BpmTask bpmTask){
		if (!"true".equals(fromMgr) && StringUtils.isEmpty(bpmTask.getAssignee())){
			String curUserId = ContextUtil.getCurrentUserId();
			bpmTask.setAssignee(curUserId);
			if (StringUtils.isEmpty(bpmTask.getOwner())) {
				bpmTask.setOwner(curUserId);
			}
			bpmTask.setLocked(1);
			bpmTaskManager.update(bpmTask);
		}
	}

	private ModelAndView getTaskEmptyMv(){
		return new ModelAndView("bpm/core/bpmTaskEmpty.jsp");
	}


	/**
	 * 处理外部URL处理。
	 * @param taskConfig
	 * @param bpmTask
	 * @param bpmInst
	 * @return
	 * @throws Exception
	 */
	private ModelAndView handExternalUrl(UserTaskConfig taskConfig,BpmTask bpmTask,BpmInst bpmInst) throws Exception{
		if( StringUtils.isEmpty(taskConfig.getExtFormUrl())) return null;

		String url=taskConfig.getExtFormUrl();
		Map<String,Object> vars=runtimeService.getVariables(bpmTask.getExecutionId());
		vars.put("taskId", bpmTask.getId());
		vars.put("instId", bpmInst.getInstId());
		vars.put("solId", bpmInst.getSolId());
		vars.put("nodeId", bpmTask.getTaskDefKey());
		vars.put("actInstId", bpmInst.getActInstId());
		vars.put("busKey", bpmInst.getBusKey());
		url=StringUtil.replaceVariableMap(url, vars);
		return new ModelAndView("redirect:"+url);
	}

	/**
	 * 是否显示作废单据按钮。
	 * @param bpmInst
	 * @return
	 */
	private Boolean canDiscard(BpmInst bpmInst){
		boolean isShowDiscardBtn=false;
		if(!BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) return isShowDiscardBtn;
		ActNodeDef startNodeDef=actRepService.getStartNode(bpmInst.getActDefId());
		List<ActNodeDef> outNodes=startNodeDef.getOutcomeNodes();
		List<BpmTask> bpmTasks=bpmTaskManager.getByActInstId(bpmInst.getActInstId());
		String curUserId=ContextUtil.getCurrentUserId();
		for(BpmTask t:bpmTasks){
			for(ActNodeDef node:outNodes){
				//当前节点处于经办人环节，并且处理人为经办人，即允许作废单据
				if(node.getNodeId().equals(t.getTaskDefKey()) && curUserId.equals(t.getAssignee())){
					isShowDiscardBtn=true;
					break;
				}
			}
		}
		return isShowDiscardBtn;
	}

	/**
	 * 记录阅读人数
	 * @param bpmInst
	 */
	private void recordRead(BpmInst bpmInst){
		String userId = ContextUtil.getCurrentUserId();
		BpmInstRead read = new BpmInstRead();
		read.setInstId(bpmInst.getInstId());
		read.setState(bpmInst.getStatus());
		read.setUserId(userId);
		read.setReadId(IdUtil.getId());
		IGroup dep = groupService.getMainByUserId(userId);
		if(dep!=null){
			read.setDepId(dep.getIdentityId());
		}
		bpmInstReadManager.create(read);
	}



	/**
	 * 获得当前节点的后续节点及其人员列表
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getDestNodeUsers")
	@ResponseBody
	public JsonResult getDestNodeUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String actInstId = request.getParameter("actInstId");
		String nodeId = request.getParameter("nodeId");
		BpmInst bpmInst= bpmInstManager.getByActInstId(actInstId);
		List<DestNodeUsers> destNodeUserList = bpmTaskManager.getDestNodeUsers(bpmInst.getSolId(), actInstId, nodeId);
		return new JsonResult(true,"", destNodeUserList);
	}

	@RequestMapping("getNodeUsers")
	@ResponseBody
	public TaskNodeUser getNodeUsers(HttpServletRequest request){
		String nodeId=RequestUtil.getString(request, "nodeId");
		String data=RequestUtil.getString(request, "postData");
		String taskId=RequestUtil.getString(request, "taskId");
		String jumpType=RequestUtil.getString(request, "jumpType");
		JSONObject postData=JSONObject.parseObject(data).getJSONObject("jsonData");
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		ProcessStartCmd cmd=new ProcessStartCmd();
		cmd.setJsonData(postData.toJSONString());
		cmd.getVars().put("check_"+bpmTask.getTaskDefKey(), jumpType);
		ProcessHandleHelper.setProcessCmd(cmd);
		TaskNodeUser nodeUser= bpmTaskManager.getNodeUsers(bpmTask.getProcInstId(), nodeId);

		return nodeUser;

	}

	/**
	 * 成功保存任务的用户
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveTaskUsers")
	@ResponseBody
	@LogEnt(action = "saveTaskUsers", module = "流程", submodule = "任务待办")
	public JsonResult saveTaskUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		String assignee = request.getParameter("assignee");
		String owner = request.getParameter("owner");
		BpmTask bpmTask = bpmTaskManager.get(taskId);

		String userLinks = request.getParameter("userLinks");
		String groupLinks = request.getParameter("groupLinks");

		Set<String> userLinksSet = new HashSet<String>();
		Set<String> groupLinksSet = new HashSet<String>();
		userLinksSet.addAll(Arrays.asList(userLinks.split(",")));
		groupLinksSet.addAll(Arrays.asList(groupLinks.split(",")));

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
		for (String userId : userLinksSet) {
			if (StringUtils.isNotEmpty(userId)) {
				taskService.addCandidateUser(taskId, userId);
			}
		}

		for (String groupId : groupLinksSet) {
			if (StringUtils.isNotEmpty(groupId)) {
				taskService.addCandidateGroup(taskId, groupId);
			}
		}

		bpmTask.setAssignee(assignee);
		bpmTask.setOwner(owner);
		bpmTaskManager.update(bpmTask);

		return new JsonResult(true, "成功保存任务的用户！");
	}

	/**
	 * 查看明细
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = request.getParameter("pkId");
		ModelAndView mv = getPathView(request);
		BpmTask bpmTask = bpmTaskManager.get(pkId);
		BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		BpmDef bpmDef = bpmDefManager.getByActDefId(bpmTask.getProcDefId());
		mv.addObject("bpmInst", bpmInst);
		mv.addObject("bpmDef", bpmDef);
		// 获得执行人及所属人的具体信息
		if (StringUtils.isNotEmpty(bpmTask.getAssignee())) {
			IUser assignee = userService.getByUserId(bpmTask.getAssignee());
			mv.addObject("assignee", assignee);
		}

		if (StringUtils.isNotEmpty(bpmTask.getSolId())) {
			BpmSolution bpmSolution = bpmSolutionManager.get(bpmTask.getSolId());
			mv.addObject("bpmSolution", bpmSolution);
		}

		if (StringUtils.isNotEmpty(bpmTask.getOwner())) {
			IUser owner = userService.getByUserId(bpmTask.getOwner());
			mv.addObject("owner", owner);
		}
		// 取得候选的用户详细信息
		List<IdentityLink> idLinks = taskService.getIdentityLinksForTask(bpmTask.getId());
		StringBuffer canUserIds = new StringBuffer();
		StringBuffer canUserNames = new StringBuffer();
		StringBuffer canGroupIds = new StringBuffer();
		StringBuffer canGroupNames = new StringBuffer();
		for (IdentityLink idLink : idLinks) {
			if (StringUtils.isNotEmpty(idLink.getGroupId()) && "candidate".equals(idLink.getType())) {
				IGroup osGroup = groupService.getById(idLink.getType(), idLink.getGroupId());
				canGroupIds.append(osGroup.getIdentityId()).append(",");
				canGroupNames.append(osGroup.getIdentityName()).append(",");
			} else if (StringUtils.isNotEmpty(idLink.getUserId()) && "candidate".equals(idLink.getType())) {
				IUser osUser =userService.getByUserId(idLink.getUserId());
				canUserIds.append(osUser.getUserId()).append(",");
				canUserNames.append(osUser.getFullname()).append(",");
			}
		}

		if (canUserIds.length() > 0) {
			canUserIds.deleteCharAt(canUserIds.length() - 1);
			canUserNames.deleteCharAt(canUserNames.length() - 1);
		}

		if (canGroupIds.length() > 0) {
			canGroupIds.deleteCharAt(canGroupIds.length() - 1);
			canGroupNames.deleteCharAt(canGroupNames.length() - 1);
		}

		mv.addObject("canUserNames", canUserNames.toString());
		mv.addObject("canUserIds", canUserIds.toString());

		mv.addObject("canGroupNames", canGroupNames.toString());
		mv.addObject("canGroupIds", canGroupIds.toString());


		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels= formHandler.getByTaskId(pkId, "");

		mv.addObject("formModels", formModels);



		// 加上流程变量的显示
		Map<String, Object> varMaps = runtimeService.getVariables(bpmTask.getProcInstId());
		List<ActVarInst> varInstList = new ArrayList<ActVarInst>();
		Iterator<String> varKeyIt = varMaps.keySet().iterator();
		while (varKeyIt.hasNext()) {
			String key = varKeyIt.next();
			Object val = (Object) varMaps.get(key);
			String clz = null;
			if (val != null) {
				clz = val.getClass().getName();
			}
			ActVarInst inst = new ActVarInst(key, clz, val);
			varInstList.add(inst);
		}
		mv.addObject("varInstList", varInstList);
		return mv.addObject("bpmTask", bpmTask);
	}

	/**
	 * 沟通任务的查看明细
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("comunicateGet")
	public ModelAndView comunicateGet(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = request.getParameter("pkId");
		ModelAndView mv = getPathView(request);
		BpmTask bpmTask = null;

		bpmTask = bpmTaskManager.get(pkId);

		// 若任务为空，则表示任务已经被处理或完成，这时需要提示用户
		if (bpmTask == null) {
			return new ModelAndView("bpm/core/bpmTaskEmpty.jsp");
		}

		BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		BpmDef bpmDef = bpmDefManager.getByActDefId(bpmTask.getProcDefId());
		mv.addObject("bpmInst", bpmInst);
		mv.addObject("bpmDef", bpmDef);
		// 获得执行人及所属人的具体信息
		if (StringUtils.isNotEmpty(bpmTask.getAssignee())) {
			IUser assignee = userService.getByUserId(bpmTask.getAssignee());
			mv.addObject("assignee", assignee);
		}
		if (StringUtils.isNotEmpty(bpmTask.getOwner())) {
			IUser owner = userService.getByUserId(bpmTask.getOwner());
			mv.addObject("owner", owner);
		}

		// 取得候选的用户详细信息
		List<IdentityLink> idLinks = taskService.getIdentityLinksForTask(bpmTask.getId());
		StringBuffer canUserIds = new StringBuffer();
		StringBuffer canUserNames = new StringBuffer();
		StringBuffer canGroupIds = new StringBuffer();
		StringBuffer canGroupNames = new StringBuffer();
		for (IdentityLink idLink : idLinks) {
			if (StringUtils.isNotEmpty(idLink.getGroupId()) && "candidate".equals(idLink.getType())) {
				IGroup osGroup = groupService.getById(idLink.getType(), idLink.getGroupId());
				canGroupIds.append(osGroup.getIdentityId()).append(",");
				canGroupNames.append(osGroup.getIdentityName()).append(",");
			} else if (StringUtils.isNotEmpty(idLink.getUserId()) && "candidate".equals(idLink.getType())) {
				IUser osUser = userService.getByUserId(idLink.getUserId());
				canUserIds.append(osUser.getUserId()).append(",");
				canUserNames.append(osUser.getFullname()).append(",");
			}
		}

		if (canUserIds.length() > 0) {
			canUserIds.deleteCharAt(canUserIds.length() - 1);
			canUserNames.deleteCharAt(canUserNames.length() - 1);
		}

		if (canGroupIds.length() > 0) {
			canGroupIds.deleteCharAt(canGroupIds.length() - 1);
			canGroupNames.deleteCharAt(canGroupNames.length() - 1);
		}

		mv.addObject("canUserNames", canUserNames.toString());
		mv.addObject("canUserIds", canUserIds.toString());

		mv.addObject("canGroupNames", canGroupNames.toString());
		mv.addObject("canGroupIds", canGroupIds.toString());

		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels= formHandler.getByTaskId(pkId, "");
		mv.addObject("formModels", formModels);

		return mv.addObject("bpmTask", bpmTask);
	}

	/**
	 * 跳转至任务转发页
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("transfer")
	public ModelAndView transfer(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskIds = request.getParameter("taskIds");
		String[] tIds = taskIds.split(",");
		StringBuffer taskIdSb = new StringBuffer();
		StringBuffer taskNameSb = new StringBuffer();
		for (String tId : tIds) {
			BpmTask task = bpmTaskManager.get(tId);
			taskIdSb.append(task.getId()).append(",");
			taskNameSb.append(task.getDescription()).append("-").append(task.getName()).append(",");
		}

		if (taskIdSb.length() > 0) {
			taskIdSb.deleteCharAt(taskIdSb.length() - 1);
		}
		if (taskNameSb.length() > 0) {
			taskNameSb.deleteCharAt(taskNameSb.length() - 1);
		}

		return getPathView(request).addObject("taskIds", taskIdSb.toString()).addObject("taskNames", taskNameSb.toString());
	}

	/**
	 * 任务转发
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("transferTask")
	@ResponseBody
	@LogEnt(action = "transferTask", module = "流程", submodule = "任务待办")
	public JsonResult transferTask(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String noticeTypes = request.getParameter("noticeTypes");
		String taskIds = request.getParameter("taskIds");
		String userId = request.getParameter("userId");
		String[] tIds = taskIds.split("[,]");
		String remark = request.getParameter("remark");
		for (String tId : tIds) {
			bpmTaskManager.transTo(tId, userId, remark, noticeTypes);
		}

		return new JsonResult(true, "成功转交任务!");
	}




	/**
	 * 为任务分配处理人员
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("batchClaimUsers")
	@ResponseBody
	@LogEnt(action = "batchClaimUsers", module = "流程", submodule = "任务待办")
	public JsonResult batchClaimUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskIds = request.getParameter("taskIds");
		String userId = request.getParameter("userId");

		if (StringUtils.isEmpty(userId)) {
			userId = ContextUtil.getCurrentUserId();
		}

		String[] tIds = taskIds.split("[,]");
		for (String taskId : tIds) {
			if (StringUtils.isEmpty(taskId)) continue;

			Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
			if (StringUtils.isNotEmpty(task.getOwner())) {
				task.setOwner(userId);
			}
			task.setAssignee(userId);
			// 其自动会调用发布人员分配事件
			taskService.saveTask(task);
		}
		return new JsonResult(true, "成功把任务授权给用户！");
	}


	/**
	 * 后台管理当前机构的所有任务
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getAllTasksForSaasAdmin")
	@ResponseBody
	public JsonPageResult<BpmTask> getAllTasksForSaasAdmin(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		String treeId=RequestUtil.getString(request, "treeId");
		if(StringUtil.isNotEmpty(treeId)){
			SysTree sysTree= sysTreeManager.get(treeId);
			if(sysTree!=null){
				String path=sysTree.getPath();
				queryFilter.addLeftLikeFieldParam("TREE_PATH_", path);
			}
		}

		List<BpmTask> tasks=bpmTaskManager.getAllTasksForSaasAdmin(queryFilter);

		for(BpmTask task:tasks){
			if(StringUtils.isNotEmpty(task.getAssignee())){
				IUser iUser=userService.getByUserId(task.getAssignee());
				if(iUser!=null){
					task.setAssigneeNames(iUser.getFullname());
				}
			}else{//计算多个用户的任务
				//存放计算出来的人员情况
				Collection<IdentityInfo> identityInfos=new ArrayList<IdentityInfo>();
				StringBuffer userNames=new StringBuffer();
				List<IdentityLink> idLinks = taskService.getIdentityLinksForTask(task.getId());
				for (IdentityLink idLink : idLinks) {
					if (StringUtils.isNotEmpty(idLink.getGroupId()) && "candidate".equals(idLink.getType())) {
						IGroup osGroup = groupService.getById(idLink.getType(), idLink.getGroupId());
						identityInfos.add(osGroup);
					} else if (StringUtils.isNotEmpty(idLink.getUserId()) && "candidate".equals(idLink.getType())) {
						IUser osUser = userService.getByUserId(idLink.getUserId());
						identityInfos.add(osUser);
					}
				}
				for(IdentityInfo info:identityInfos){
					if(info instanceof IUser){
						IUser user=(IUser)info;
						userNames.append(user.getFullname()).append(",");
					}else if(info instanceof IGroup){
						IGroup group=(IGroup)info;
						List<IUser> osUsers=userService.getByGroupIdAndType(group.getIdentityId(), group.getType());
						for(IUser user:osUsers){
							userNames.append(user.getFullname()).append(",");
						}
					}
				}
				if(userNames.length()>0){
					userNames.deleteCharAt(userNames.length()-1);
				}
				task.setAssigneeNames(userNames.toString());
			}
		}

		return new JsonPageResult<BpmTask>(tasks,queryFilter.getPage().getTotalItems());
	}

	/**
	 * 查找我的任务
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("myTasks")
	@ResponseBody
	public JsonPageResult<BpmTask> myTasks(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);
		String treeId=request.getParameter("treeId");
		if(StringUtils.isNotEmpty(treeId)){
			filter.addFieldParam("treeId", treeId);
		}
		List<BpmTask> bpmTasks = bpmTaskManager.getByUserId(filter);



		return new JsonPageResult(bpmTasks, filter.getPage().getTotalItems());
	}


	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping("myListNode/{nodeId}")
	public ModelAndView myListNode(HttpServletRequest request, @PathVariable(value="nodeId")String nodeId) throws Exception {
		ModelAndView mv=new ModelAndView();
		mv.addObject("nodeId",nodeId);
		mv.setViewName("bpm/core/bpmTaskMyListNode.jsp");
		return mv;
	}


	/**
	 * 代办事项列表
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("myAgents")
	@ResponseBody
	public JsonPageResult<BpmTask> myAgents(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String agent = request.getParameter("agent");
		String userId = ContextUtil.getCurrentUserId();
		QueryFilter filter=  QueryFilterBuilder.createQueryFilter(request);
		filter.addFieldParam("userId", userId);
		filter.addSortParam("CREATE_TIME_", "DESC");
		List<BpmTask> bpmTasks = null;
		if ("toMe".equals(agent)) {// 别人代理出给我的待办
			if(StringUtil.isNotEmpty(ContextUtil.getCurrentTenantId())){
				filter.addFieldParam("tenantId", ContextUtil.getCurrentTenantId());
			}
			bpmTasks = bpmTaskManager.getAgentToTasks(filter);
		} else {// 我转给别人的代办
			bpmTasks = bpmTaskManager.getMyAgentTasks(filter);
		}
		return new JsonPageResult(bpmTasks, filter.getPage().getTotalItems());
	}

	/**
	 * 把任务的处理权限收回
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("batchUnClaimUsers")
	@ResponseBody
	@LogEnt(action = "batchUnClaimUsers", module = "流程", submodule = "任务待办")
	public JsonResult batchUnClaimUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskIds = request.getParameter("taskIds");
		String[] tIds = taskIds.split("[,]");
		for (String taskId : tIds) {
			taskService.unclaim(taskId);
		}
		return new JsonResult(true, "成功把任务的处理权限收回！");
	}



	@RequestMapping("getTaskTree")
	@ResponseBody
	public List<SysTree> getTaskTree(HttpServletRequest request,HttpServletResponse response) throws Exception{
		IUser user=ContextUtil.getCurrentUser();
		List<SysTree> treeList=null;
		if(user.isSuperAdmin()){
			treeList=sysTreeManager.getByCatKeyTenantId(SysTree.CAT_BPM_SOLUTION, ContextUtil.getCurrentTenantId());
		}
		else{
			treeList=bpmTaskManager.getTaskTree();
		}
		return treeList;
	}

	/**
	 * 跳到任务的无表单审批页
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("approval")
	public ModelAndView approval(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		// 是否从任务管理窗口进来
		String fromMgr = request.getParameter("fromMgr");
		// 获得任务的节点信息
		// 获得任务实例
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		// 若任务为空，则表示任务已经被处理或完成，这时需要提示用户
		if (bpmTask == null) {
			return new ModelAndView("bpm/core/bpmTaskEmpty.jsp");
		}

		// 若任务尚未处理，则锁定给当前用户
		if (!"true".equals(fromMgr) && StringUtils.isEmpty(bpmTask.getAssignee())) {
			String curUserId = ContextUtil.getCurrentUserId();
			bpmTask.setAssignee(curUserId);
			if (StringUtils.isEmpty(bpmTask.getOwner())) {
				bpmTask.setOwner(curUserId);
			}
			bpmTaskManager.update(bpmTask);
		}

		// 获得流程实例
		BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		// 流程实例已经被删除
		if (bpmInst == null) {
			try {
				bpmTaskManager.delete(taskId);
			} catch (Exception ex) {
				logger.error(ex.getMessage());
			}
			return new ModelAndView("bpm/core/bpmTaskEmpty.jsp");
		}

		// 获得流程定义
		BpmDef bpmDef = bpmDefManager.getByActDefId(bpmTask.getProcDefId());
		// 获得流程解决方案
		BpmSolution bpmSolution = bpmSolutionManager.get(bpmInst.getSolId());
		if (bpmSolution == null) {
			throw new java.lang.RuntimeException("找不到业务解决方案");
		}
		// 获得任务节点的配置
		UserTaskConfig taskConfig = bpmNodeSetManager.getTaskConfig(bpmSolution.getSolId(), bpmTask.getProcDefId(),bpmTask.getTaskDefKey());

		// 加上线程变量
		ProcessHandleHelper.clearObjectLocal();
		ProcessHandleHelper.setObjectLocal(taskConfig.getTableRightJson());
		//审批按钮的Json格式
		String checkButtonsJson=iJson.toJson(taskConfig.getButtons()).replace("\"","'");
		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(bpmSolution.getSolId(),bpmTask.getProcDefId());

		ActNodeDef actNodeDef = actRepService.getActNodeDef(bpmTask.getProcDefId(), bpmTask.getTaskDefKey());

		// 获得任务的下一步的人员映射列表
		List<DestNodeUsers> destNodeUserList = bpmTaskManager.getDestNodeUsers(taskId);
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
		// 是否到达结束事件节点
		boolean isReachEndEvent = false;
		if (destNodeUserList.size() == 1) {
			DestNodeUsers destNodeUser = destNodeUserList.get(0);
			if (destNodeUser.getNodeType().indexOf("endEvent") != -1) {
				isReachEndEvent = true;
			}
		}

		String nodeId = bpmTask.getTaskDefKey();
		BpmNodeSet bpmNodeSet = bpmNodeSetManager.getBySolIdActDefIdNodeId(bpmTask.getSolId(),bpmTask.getProcDefId(), nodeId);

		//是否显示作废的按钮
		boolean isShowDiscardBtn=false;
		//取得开始节点
		ActNodeDef startNodeDef=actRepService.getStartNode(bpmDef.getActDefId());
		//正在运行，并且当前审批节点处于经办人环节
		if(BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())){
			List<ActNodeDef> outNodes=startNodeDef.getOutcomeNodes();
			List<BpmTask> bpmTasks=bpmTaskManager.getByActInstId(bpmInst.getActInstId());
			for(BpmTask t:bpmTasks){
				for(ActNodeDef node:outNodes){
					//当前节点处于经办人环节，并且处理人为经办人，即允许作费单据
					if(node.getNodeId().equals(t.getTaskDefKey()) && ContextUtil.getCurrentUserId().equals(t.getAssignee())){
						isShowDiscardBtn=true;
						break;
					}
				}
			}
		}


		// 附件回显
		List<BpmInstAttach> list = bpmInstAttachManager.getByInstId(bpmInst.getInstId());
		StringBuffer fileIds = new StringBuffer();
		StringBuffer fileNames = new StringBuffer();
		StringBuffer fileBytes = new StringBuffer();
		for (BpmInstAttach bia : list) {
			fileIds.append(bia.getFileId());
			fileIds.append(",");
			fileNames.append(sysFileManager.get(bia.getFileId()).getFileName());
			fileNames.append(",");
			fileBytes.append((sysFileManager.get(bia.getFileId()).getTotalBytes()));
			fileBytes.append(",");
		}
		if (fileIds.length() > 0) {
			fileNames.deleteCharAt(fileNames.length() - 1);
			fileIds.deleteCharAt(fileIds.length() - 1);
			fileBytes.deleteCharAt(fileBytes.length()-1);
		}

		// 记录阅读人数
		String userId = ContextUtil.getCurrentUserId();
		BpmInstRead read = new BpmInstRead();
		read.setInstId(bpmInst.getInstId());
		read.setState(bpmInst.getStatus());
		read.setUserId(userId);
		read.setReadId(idGenerator.getSID());
		IGroup dep = groupService.getMainByUserId(userId);
		if(dep!=null){
			read.setDepId(dep.getIdentityId());
		}
		bpmInstReadManager.create(read);


		//附件权限
		boolean isDown = bpmInstCtlManager.sysFileCtl(userId, bpmInst.getInstId(), BpmInstCtl.CTL_RIGHT_DOWN);
		boolean isPrint = bpmInstCtlManager.sysFileCtl(userId, bpmInst.getInstId(), BpmInstCtl.CTL_RIGHT_PRINT);

		//显示以前操作人
		String beforeUser = bpmNodeJumpManager.getBeforeUser(bpmTask.getProcInstId());
		//显示当前操作人
		String nowUser =bpmTaskManager.getNowUser(bpmTask);

		return getPathView(request).addObject("bpmTask", bpmTask)
				.addObject("fileIds", fileIds.toString())
				.addObject("fileNames", fileNames.toString())
				.addObject("fileBytes", fileBytes)
				.addObject("bpmInst", bpmInst)
				.addObject("bpmDef", bpmDef).addObject("checkButtonsJson",checkButtonsJson)
				.addObject("bpmSolution", bpmSolution)
				.addObject("taskConfig", taskConfig).addObject("isShowDiscardBtn", isShowDiscardBtn)
				.addObject("processConfig", processConfig)
				.addObject("actNodeDef", actNodeDef).addObject("destNodeUserList", destNodeUserList)
				.addObject("isReachEndEvent", isReachEndEvent).addObject("bpmNodeSet", bpmNodeSet)
				.addObject("beforeUser", beforeUser).addObject("nowUser", nowUser).addObject("isDown", isDown)
				.addObject("isPrint", isPrint);
	}


	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmTaskManager;
	}

	@RequestMapping("reject")
	public ModelAndView reject(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv=getPathView(request);
		String taskId=RequestUtil.getString(request, "taskId");
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		BpmNodeSet bpmNodeSet = bpmNodeSetManager.getBySolIdActDefIdNodeId(bpmTask.getSolId(), bpmTask.getProcDefId(), bpmTask.getTaskDefKey());
		JSONObject json = JSONObject.parseObject("{'BACK':'驳回(上一节点)','BACK_TO_STARTOR':'驳回(发起人)','BACK_SPEC':'驳回指定节点'}");
		String jumpTypes="";
		if(bpmNodeSet!=null && StringUtil.isNotEmpty(bpmNodeSet.getSettings())){
			JsonNode jsonObject=objectMapper.readTree(bpmNodeSet.getSettings());
			JsonNode configsNode=jsonObject.get("configs");
			jumpTypes = (String) JSONUtil.jsonNode2Map(configsNode).get("jumpTypes");
		}


		if(bpmNodeSet!=null && StringUtil.isEmpty(jumpTypes)) {
			bpmNodeSet = bpmNodeSetManager.getBySolIdActDefIdNodeId(bpmTask.getSolId(), bpmTask.getProcDefId(),ProcessConfig.PROCESS_NODE_ID);
			if(StringUtil.isNotEmpty(bpmNodeSet.getSettings())){
				JsonNode jsonObject=objectMapper.readTree(bpmNodeSet.getSettings());
				JsonNode configsNode=jsonObject.get("configs");
				jumpTypes = (String) JSONUtil.jsonNode2Map(configsNode).get("jumpTypes");
			}
		}
		if(StringUtil.isEmpty(jumpTypes)){
			jumpTypes="BACK,BACK_TO_STARTOR,BACK_SPEC";
		}

		JSONArray array = new JSONArray();
		String[] jumpType = jumpTypes.split(",");
		for (int i = 0; i < jumpType.length; i++) {
			JSONObject obj = new JSONObject();
			obj.put("id", jumpType[i]);
			obj.put("text", json.getString(jumpType[i]));
			array.add(obj);
		}
		mv.addObject("jumpTypes",array);
		mv.addObject("task", bpmTask);
		return mv;
	}

	@RequestMapping("releaseTask")
	@ResponseBody
	public JsonResult releaseTask(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId=RequestUtil.getString(request, "taskId");
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		bpmTask.setLocked(0);
		bpmTask.setAssignee(null);
		bpmTask.setOwner(null);
		bpmTaskManager.update(bpmTask);
		return new JsonResult(true,"任务释放成功");
	}

	@RequestMapping("checkTaskLockStatus")
	@ResponseBody
	public JsonResult checkTaskLockStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId=RequestUtil.getString(request, "taskId");
		String fromMgr = RequestUtil.getString(request, "fromMgr");
		if("true".equals(fromMgr)){
			return new JsonResult(true);
		}

		BpmTask bpmTask = bpmTaskManager.get(taskId);
		String curUserId = ContextUtil.getCurrentUserId();

		//任务已完结
		if(BeanUtil.isEmpty(bpmTask)){
			return new JsonResult(false,"任务办理完结");
		}
		//任务被锁定
		if(bpmTask.getLocked()==1 && bpmTask.getAssignee()!=null){
			if(!(bpmTask.getAssignee().equals(curUserId))){
				OsUser assignee = osUserManager.get(bpmTask.getAssignee());
				return new JsonResult(false,"任务已被"+assignee.getFullname()+"认领");
			}
		}
		return new JsonResult(true);
	}


	@RequestMapping("doAddSign")
	@ResponseBody
	public JsonResult doAddSign(HttpServletRequest request, HttpServletResponse response){
		String taskId=RequestUtil.getString(request, "taskId");
		String noticeTypes=RequestUtil.getString(request, "noticeTypes");
		String user=RequestUtil.getString(request, "user");

		JsonResult result=bpmTaskManager.doAddSignTask(taskId, user, noticeTypes);

		return result;

	}

}
