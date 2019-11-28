package com.redxun.bpm.core.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.entity.ActProcessDef;
import com.redxun.bpm.activiti.entity.ActVarInst;
import com.redxun.bpm.activiti.entity.ActivityNodeInst;
import com.redxun.bpm.activiti.image.ProcessDiagramGeneratorExt;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.bm.entity.BpmFormInst;
import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmInstAttach;
import com.redxun.bpm.core.entity.BpmInstCtl;
import com.redxun.bpm.core.entity.BpmInstData;
import com.redxun.bpm.core.entity.BpmInstRead;
import com.redxun.bpm.core.entity.BpmInstTmp;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmOpinionTemp;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.BpmSolTemplateRight;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.MyInteger;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.entity.TaskExecutor;
import com.redxun.bpm.core.entity.VirtualBpmNode;
import com.redxun.bpm.core.entity.VirtualNodeList;
import com.redxun.bpm.core.entity.config.DestNodeUsers;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.StartEventConfig;
import com.redxun.bpm.core.entity.config.TaskNodeUser;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmInstAttachManager;
import com.redxun.bpm.core.manager.BpmInstCtlManager;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmInstReadManager;
import com.redxun.bpm.core.manager.BpmInstTmpManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmOpinionTempManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.BpmSolCtlManager;
import com.redxun.bpm.core.manager.BpmSolTemplateRightManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.bpm.form.api.FormHandlerFactory;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.util.DbUtil;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SortParam;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.controller.PublicController;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.manager.SysTreeCatManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 流程实例管理
 * 
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 *            本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmInst/")
public class BpmInstController extends TenantListController {
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmDefManager bpmDefManager;
	@Resource
	ActRepService actRepService;
	@Resource
	HistoryService historyService;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmTaskManager bpmTaskManager;

	@Resource
	BpmInstAttachManager bpmInstAttachManager;
	@Resource
	SysFileManager sysFileManager;
	@Resource
	BpmInstReadManager bpmInstReadManager;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	BpmInstTmpManager bpmInstTmpManager;
	@Resource
	BpmFormInstManager bpmFormInstManager;
	@Resource
	BpmSolCtlManager bpmSolCtlManager;
	@Resource
	RuntimeService runtimeService;
	@Resource
	BpmInstCtlManager bpmInstCtlManager;
	@Resource
	BpmIdentityCalService bpmIdentityCalService;
	@Resource
	SysTreeCatManager sysTreeCatManager;
	@Resource
	BpmSolTemplateRightManager bpmSolTemplateRightManager;
	@Resource
	TaskService taskService;

	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	BpmAuthSettingManager bpmAuthSettingManager;

	@Resource
	GroupService groupService;
	@Resource
	UserService userService;
	@Resource
	FormHandlerFactory formHandlerFactory;
	@Resource
	BpmInstDataManager bpmInstDataManager;
	@Resource
	SysBoDefManager sysBoDefManager;
	@Resource
	BpmOpinionTempManager bpmOpinionTempManager;
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
	ProcessDiagramGeneratorExt processDiagramGenerator;

	@Resource
	BpmRuPathManager bpmRuPathManager;
	@Resource(name = "iJson")
	ObjectMapper objectMapper;
	@Resource
	BpmTableFormulaManager bpmTableFormulaManager;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	CommonDao commonDao;

	/**
	 * 存放流程图操作状态的示例颜色
	 */
	private Map<String, String> bpmImageColors = new LinkedHashMap<String, String>();
	/**
	 * 存放超时的颜色
	 */
	private Map<String, String> bpmTimeoutColors = new LinkedHashMap<String, String>();

	@RequestMapping("image")
	public ModelAndView image(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// if(bpmImageColors.size()==0){
		bpmImageColors = new LinkedHashMap<String, String>();
		Map<String, String> statusColors = processDiagramGenerator.getProcessColors();
		Iterator<Entry<String, String>> it = statusColors.entrySet().iterator();
		while (it.hasNext()) {
			Entry<String, String> entry = it.next();
			String label = null;
			if (entry.getKey().equals("UNHANDLE")) {
				label = "未处理";
			} else {
				TaskOptionType entype = TaskOptionType.valueOf(entry.getKey());
				label = entype.getText();
			}
			bpmImageColors.put(entry.getValue(), label);
		}
		// }
		// if(bpmTimeoutColors.size()==0){
		bpmTimeoutColors = new LinkedHashMap<String, String>();
		Map<String, String> timeoutColors = processDiagramGenerator.getTimeoutColors();
		Iterator<Entry<String, String>> it2 = timeoutColors.entrySet().iterator();
		while (it2.hasNext()) {
			Entry<String, String> entry = it2.next();
			String label = null;
			if ("0".equals(entry.getKey())) {
				label = "未超时";
			} else if ("1".equals(entry.getKey())) {
				label = "已超时";
			} else if ("2".equals(entry.getKey())) {
				label = "严重超时";
			}
			bpmTimeoutColors.put(entry.getValue(), label);
			// }
		}

		ModelAndView mv = getPathView(request).addObject("bpmImageColors", bpmImageColors).addObject("bpmTimeoutColors",
				bpmTimeoutColors);
		return mv;
	}

	/**
	 * 流程实例干预
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("operator")
	@ResponseBody
	@LogEnt(action = "流程实例干预", module = "流程", submodule = "流程实例")
	public ModelAndView operator(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");
		String taskId = request.getParameter("taskId");
		BpmInst bpmInst = null;
		if (StringUtils.isNotEmpty(instId)) {
			bpmInst = bpmInstManager.get(instId);
		} else {
			BpmTask bpmTask = bpmTaskManager.get(taskId);
			if (bpmTask == null) {
				return new ModelAndView("bpm/core/bpmTaskEmpty.jsp");
			}
			bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		}

		Collection<TaskDefinition> taskDefs = actRepService.getTaskDefs(bpmInst.getActDefId());
		List<TaskNodeUser> taskNodeUsers = new ArrayList<TaskNodeUser>();
		Map<String, Object> nodeIdUserMap = new HashMap<String, Object>();

		// 从变量中获得人员列表
		String nodeUserIds = (String) runtimeService.getVariable(bpmInst.getActInstId(),
				ProcessVarType.NODE_USER_IDS.getKey());
		if (StringUtils.isNotEmpty(nodeUserIds)) {
			net.sf.json.JSONArray nodeUsersArr = net.sf.json.JSONArray.fromObject(nodeUserIds);
			for (int i = 0; i < nodeUsersArr.size(); i++) {
				net.sf.json.JSONObject obj = nodeUsersArr.getJSONObject(i);
				String nodeId = obj.getString("nodeId");
				String userIds = obj.getString("userIds");
				nodeIdUserMap.put(nodeId, userIds);
			}
		}
		// 获得当前的待办任务
		List<Task> curTasks = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();

		for (TaskDefinition td : taskDefs) {
			String nodeId = td.getKey();

			TaskNodeUser taskNodeUser = new TaskNodeUser();
			taskNodeUser.setNodeId(nodeId);
			taskNodeUser.setNodeText(td.getNameExpression().getExpressionText());

			// 1.优先从流程变量中获得其人员列表
			if (nodeIdUserMap.containsKey(nodeId)) {
				List<TaskExecutor> identityInfos = new ArrayList<TaskExecutor>();
				String userIds = (String) nodeIdUserMap.get(nodeId);
				if (StringUtils.isNotEmpty(userIds)) {
					String[] uIds = userIds.split("[,]");
					for (String uId : uIds) {
						IUser osUser = userService.getByUserId(uId);
						identityInfos.add(TaskExecutor.getUserExecutor(osUser));
					}

					KeyValEnt ent = getUserInfoIdNames(identityInfos);
					taskNodeUser.setUserIds(ent.getKey());
					taskNodeUser.setUserFullnames(ent.getVal().toString());
				}
			}
			IFormDataHandler handler = BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_DB);
			BpmSolution solution = bpmSolutionManager.get(bpmInst.getSolId());
			String boDefIds = solution.getBoDefId();
			if (StringUtil.isNotEmpty(boDefIds)) {
				String[] defIds = boDefIds.split(",");
				JSONArray bosArr = new JSONArray();
				for (int i = 0; i < defIds.length; i++) {
					String formKey = sysBoDefManager.getAliasById(defIds[i]);
					JSONObject jsonObj = new JSONObject();
					Map<String, Object> param = new HashMap<String, Object>();
					param.put("INST_ID_", bpmInst.getInstId());
					JSONObject data = handler.getData(defIds[i], param);
					jsonObj.put("data", data);
					jsonObj.put("formKey", formKey);
					jsonObj.put("boDefId", defIds[i]);
					bosArr.add(jsonObj);
				}
				JSONObject bos = new JSONObject();
				bos.put("bos", bosArr.toJSONString());
				ProcessStartCmd cmd = new ProcessStartCmd();
				cmd.setJsonData(bos.toJSONString());
				ProcessHandleHelper.setProcessCmd(cmd);
			}
			// 2.从流程配置获得实例
			Map<String, Object> variables = runtimeService.getVariables(bpmInst.getActInstId());
			Collection<TaskExecutor> bpmIdenties = bpmIdentityCalService.calNodeUsersOrGroups(bpmInst.getActDefId(),
					nodeId, variables);

			KeyValEnt ent = getUserInfoIdNames(bpmIdenties);
			taskNodeUser.setRefUserIds(ent.getKey());
			taskNodeUser.setRefUserFullnames(ent.getVal().toString());

			taskNodeUsers.add(taskNodeUser);

			// 3.查找已经审批的

			List<BpmNodeJump> bpmNodeJumps = bpmNodeJumpManager.getByActInstIdNodeId(bpmInst.getActInstId(), nodeId);
			List<TaskExecutor> checkIdentites = new ArrayList<TaskExecutor>();
			Set<String> userIds = new HashSet<String>();
			for (BpmNodeJump jp : bpmNodeJumps) {
				if (StringUtils.isNotEmpty(jp.getHandlerId()) && (!userIds.contains(jp.getHandlerId()))) {
					userIds.add(jp.getHandlerId());
					IUser osUser = userService.getByUserId(jp.getHandlerId());
					if (osUser != null) {
						checkIdentites.add(TaskExecutor.getUserExecutor(osUser));
					}
				}
			}
			KeyValEnt entVal = getUserInfoIdNames(checkIdentites);
			taskNodeUser.setExeUserIds(entVal.getKey());
			taskNodeUser.setExeUserFullnames(entVal.getVal().toString());

			// 4.从正在运行中的流程任务实例中获得执行人
			for (Task ctask : curTasks) {
				if (ctask.getTaskDefinitionKey().equals(td.getKey())) {
					Collection<TaskExecutor> taskIdentites = bpmTaskManager.getTaskHandleIdentityInfos(ctask.getId());

					KeyValEnt valEnt = getUserInfoIdNames(taskIdentites);
					taskNodeUser.setExeUserIds(valEnt.getKey());
					taskNodeUser.setExeUserFullnames(valEnt.getVal().toString());
					taskNodeUser.setRunning(true);
				}
			}
		}

		return getPathView(request).addObject("bpmInst", bpmInst).addObject("taskNodeUsers", taskNodeUsers);

	}

	private KeyValEnt getUserInfoIdNames(Collection<TaskExecutor> identityInfos) {
		StringBuffer userNames = new StringBuffer();
		StringBuffer userIds = new StringBuffer();
		// 显示用户
		for (TaskExecutor info : identityInfos) {
			if (TaskExecutor.IDENTIFY_TYPE_USER.equals(info.getType())) {

				userNames.append(info.getName()).append(",");
				userIds.append(info.getId()).append(",");
			} else {
				userNames.append(info.getName() + "[组]").append(",");
				userIds.append(info.getId()).append(",");
			}
		}

		if (userNames.length() > 0) {
			userNames.deleteCharAt(userNames.length() - 1);
			userIds.deleteCharAt(userIds.length() - 1);
		}

		return new KeyValEnt(userIds.toString(), userNames.toString());

	}

	@RequestMapping("getBpmInstByActInstId")
	@ResponseBody
	public net.sf.json.JSONObject getBpmInstByActInstId(HttpServletRequest request, HttpServletResponse response) {
		String actInstId = request.getParameter("actInstId");
		BpmInst bpmInst = bpmInstManager.getByActInstId(actInstId);
		net.sf.json.JSONObject jsonObject = new net.sf.json.JSONObject();
		jsonObject.put("bpmInstId", bpmInst.getInstId());
		return jsonObject;
	}

	/**
	 * 显示流程实例中的流程变量值
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listVars")
	@ResponseBody
	public JsonPageResult<ActVarInst> listVars(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String actInstId = request.getParameter("actInstId");
		Map<String, Object> varMaps = runtimeService.getVariables(actInstId);
		List<ActVarInst> varInstList = new ArrayList<ActVarInst>();
		Iterator<String> varKeyIt = varMaps.keySet().iterator();
		while (varKeyIt.hasNext()) {
			String key = varKeyIt.next();
			Object val = (Object) varMaps.get(key);
			String clz = null;
			if (val != null) {
				clz = val.getClass().getName();
			}
			if (!"java.util.HashMap".equals(clz)) {
				ActVarInst inst = new ActVarInst(key, clz, val);
				varInstList.add(inst);
			}
		}
		return new JsonPageResult<ActVarInst>(varInstList, varInstList.size());
	}

	/**
	 * 保存表单数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveFormData")
	@ResponseBody
	@LogEnt(action = "saveFormData", module = "流程", submodule = "流程实例")
	public JsonResult saveFormData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = RequestUtil.getString(request, "instId");
		String formData = RequestUtil.getString(request, "formData");
		BpmInst bpmInst = bpmInstManager.get(instId);
		IFormDataHandler handler = BoDataUtil.getDataHandler(bpmInst.getDataSaveMode());
		try {
			JSONObject jsonObj = JSONObject.parseObject(formData);
			Set<String> set = jsonObj.keySet();
			for (String boAlias : set) {
				SysBoDef boDef = sysBoDefManager.getByAlias(boAlias);
				JSONObject jsonObject = jsonObj.getJSONObject(boAlias);
				String boDefId = boDef.getId();
				String pk = bpmInstDataManager.getPk(instId, boDefId);
				handler.saveData(boDefId, pk, jsonObject);
			}
			return new JsonResult(true, "成功保存！");
		} catch (Exception ex) {
			return new JsonResult(false, "保存失败！");
		}
	}

	/**
	 * 保存变量行值
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveVarRow")
	@ResponseBody
	@LogEnt(action = "saveVarRow", module = "流程", submodule = "流程实例")
	public JsonResult saveVarRow(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String actInstId = request.getParameter("actInstId");
		String data = request.getParameter("data");
		try {
			ActVarInst var = JSON.parseObject(data, ActVarInst.class);
			Object val = null;
			if ("java.util.Date".equals(var.getType())) {
				val = DateUtil.parseDate((String) var.getVal());
			} else if ("java.lang.Double".equals(var.getType())) {
				val = new Double(var.getVal().toString());
			} else {
				val = var.getVal();
			}
			runtimeService.setVariable(actInstId, var.getKey(), val);
		} catch (Exception ex) {
			logger.error(ex);
			return new JsonResult(false, "保存失败：" + ex.getCause());
		}

		return new JsonResult(true, "成功保存！");
	}

	/**
	 * 返回表单JSON数据。
	 * 
	 * @param instId
	 * @return
	 */
	@RequestMapping("getJsonByInstId")
	@ResponseBody
	public JSONObject getJsonByInstId(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		String instId = RequestUtil.getString(request, "instId");
		BpmInst bpmInst = bpmInstManager.get(instId);
		IFormDataHandler handler = BoDataUtil.getDataHandler(bpmInst.getDataSaveMode());
		List<BpmInstData> list = bpmInstDataManager.getByInstId(instId);
		for (BpmInstData data : list) {
			String boDefId = data.getBoDefId();
			String pk = data.getPk();
			JSONObject jsonObj = handler.getData(boDefId, pk);
			SysBoDef sysBoDef = sysBoDefManager.get(boDefId);
			json.put(sysBoDef.getAlais(), jsonObj);
		}

		return json;
	}

	/**
	 * 更改任务执行人
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("changeTaskUser")
	@ResponseBody
	@LogEnt(action = "changeTaskUser", module = "流程", submodule = "流程实例")
	public JsonResult changeTaskUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");
		String nodeId = request.getParameter("nodeId");
		String userIdArr = request.getParameter("userIds");
		String[] userIds = userIdArr.split("[,]");
		BpmInst bpmInst = bpmInstManager.get(instId);
		try {
			// 获取节点类型。
			ActNodeDef nodeDef = actRepService.getActNodeDef(bpmInst.getActDefId(), nodeId);
			boolean isMultiti = StringUtils.isNotEmpty(nodeDef.getMultiInstance());
			if (isMultiti) {
				doChangeSignUser(bpmInst.getActInstId(), nodeId, userIds, nodeDef.getMultiInstance());
			} else {
				doChangeCommonUser(bpmInst.getActInstId(), nodeId, userIds);
			}
			return new JsonResult(true, "成功更新！");
		} catch (Exception ex) {
			String msg = ex.getMessage();
			return new JsonResult(false, msg);
		}

	}

	/**
	 * 处理多实例的情况。
	 * 
	 * @param actInstId
	 * @param nodeId
	 * @param userIds
	 */
	private void doChangeSignUser(String actInstId, String nodeId, String[] userIds, String multiType) {
		// 并行会签
		if ("parallel".equals(multiType)) {
			bpmTaskManager.doChangeParallelUser(actInstId, nodeId, userIds);
		}
		// 串行会签。
		else {
			bpmTaskManager.doChangeSequenceUser(actInstId, nodeId, userIds);
		}
	}

	/**
	 * 处理普通任务的人员。
	 * 
	 * @param actInstId
	 * @param nodeId
	 * @param userIds
	 */
	private void doChangeCommonUser(String actInstId, String nodeId, String[] userIds) {
		BpmTask task = bpmTaskManager.getByActInstNode(actInstId, nodeId).get(0);
		if (userIds.length == 1) {
			task.setAssignee(userIds[0]);// 更改任务的单一执行人
			bpmTaskManager.update(task);
		} else {// 更改任务为多个执行人
			bpmTaskManager.doChangeTaskUsers(task.getId(), userIds);
		}
	}

	/**
	 * 批量保存多个变量
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveVarRows")
	@ResponseBody
	@LogEnt(action = "saveVarRows", module = "流程", submodule = "流程实例")
	public JsonResult saveVarRows(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String vars = request.getParameter("data");
		String actInstId = request.getParameter("actInstId");

		if (StringUtils.isNotEmpty(vars)) {
			List<ActVarInst> actInstVars = JSON.parseArray(vars, ActVarInst.class);
			for (ActVarInst var : actInstVars) {
				Object val = null;
				if ("java.util.Date".equals(var.getType())) {
					val = DateUtil.parseDate((String) var.getVal());
				} else if ("java.lang.Double".equals(var.getType())) {
					val = new Double(var.getVal().toString());
				} else {
					val = var.getVal();
				}
				runtimeService.setVariable(actInstId, var.getKey(), val);
			}
		}

		return new JsonResult(true, "成功保存变量！");
	}

	/**
	 * 删除变量行
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("delVarRows")
	@ResponseBody
	@LogEnt(action = "delVarRows", module = "流程", submodule = "流程实例")
	public JsonResult delVarRows(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String actInstId = request.getParameter("actInstId");
		String keys = request.getParameter("keys");
		String[] ks = keys.split("[,]");
		for (String k : ks) {
			runtimeService.removeVariable(actInstId, k);
		}

		return new JsonResult(true, "成功删除变量！");
	}

	/**
	 * 保存干预的人员节点
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveNodeUsers")
	@ResponseBody
	@LogEnt(action = "saveNodeUsers", module = "流程", submodule = "流程实例")
	public JsonResult saveNodeUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");
		BpmInst bpmInst = bpmInstManager.get(instId);
		String nodeUsers = request.getParameter("nodeUsers");
		runtimeService.setVariable(bpmInst.getActInstId(), ProcessVarType.NODE_USER_IDS.getKey(), nodeUsers);
		return new JsonResult(true, "成功保存！");
	}

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = super.getQueryFilter(request);
		queryFilter.getOrderByList().add(new SortParam("createTime", SortParam.SORT_DESC));
		return queryFilter;
	}

	/**
	 * 获得流程实例的查询列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listByTreeId")
	@ResponseBody
	public JsonPageResult<BpmInst> listByTreeId(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);

		filter.addFieldParam("b.TENANT_ID_", ContextUtil.getCurrentTenantId());
		String treeId = RequestUtil.getString(request, "treeId");
		if (StringUtil.isNotEmpty(treeId)) {
			SysTree sysTree = sysTreeManager.get(treeId);
			if (sysTree != null) {
				String path = sysTree.getPath();
				filter.addLeftLikeFieldParam("s.TREE_PATH_", path);
			}
		}

		String userId = RequestUtil.getString(request, "userId");
		if (StringUtil.isNotEmpty(userId)) {
			filter.addFieldParam("b.CREATE_BY_", userId);
		}

		List<BpmInst> bpmInstList = bpmInstManager.getInstByTreeId(filter, treeId);

		for (BpmInst bpmInst : bpmInstList) {
			if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
				List<Task> taskList = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();
				Set<String> taskNodeSet = new HashSet<String>();
				Set<String> taskUserSet = new HashSet<String>();
				for (Task task : taskList) {
					taskNodeSet.add(task.getName());
					if (StringUtils.isNotEmpty(task.getAssignee())) {
						IUser osUser = userService.getByUserId(task.getAssignee());
						if (osUser != null) {
							taskUserSet.add(osUser.getFullname());
						}
					}
				}
				// 当前环节
				bpmInst.setTaskNodes(StringUtil.getCollectionString(taskNodeSet, ","));
				// 当前执行人
				bpmInst.setTaskNodeUsers(StringUtil.getCollectionString(taskUserSet, ","));

			}
			// 分类
			BpmSolution sol = bpmSolutionManager.get(bpmInst.getSolId());
			if (sol != null && StringUtils.isNotEmpty(sol.getTreeId())) {
				SysTree sysTree = sysTreeManager.get(sol.getTreeId());
				bpmInst.setTreeName(sysTree.getName());
			}
		}

		bpmAuthSettingManager.setRight(bpmInstList);
		return new JsonPageResult<BpmInst>(bpmInstList, filter.getPage().getTotalItems());
	}

	/**
	 * 获得流程实例的查询列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listForSaasAdmin")
	@ResponseBody
	public JsonPageResult<BpmInst> listForSaasAdmin(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);

		filter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		String treeId = RequestUtil.getString(request, "treeId");
		// 根据分类进行过滤
		if (StringUtil.isNotEmpty(treeId)) {
			SysTree sysTree = sysTreeManager.get(treeId);
			if (sysTree != null) {
				String path = sysTree.getPath();
				filter.addLeftLikeFieldParam("TREE_PATH_", path);
			}
		}
		List<BpmInst> bpmInstList = bpmInstManager.getInstsForSaasAdmin(filter);

		for (BpmInst bpmInst : bpmInstList) {

			if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
				List<Task> taskList = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();
				Set<String> taskNodeSet = new HashSet<String>();
				Set<String> taskUserSet = new HashSet<String>();
				for (Task task : taskList) {
					taskNodeSet.add(task.getName());
					if (StringUtils.isNotEmpty(task.getAssignee())) {
						IUser osUser = userService.getByUserId(task.getAssignee());
						if (osUser != null) {
							taskUserSet.add(osUser.getFullname());
						}
					}
				}
				// 当前环节
				bpmInst.setTaskNodes(StringUtil.getCollectionString(taskNodeSet, ","));
				// 当前执行人
				bpmInst.setTaskNodeUsers(StringUtil.getCollectionString(taskUserSet, ","));

			}
			// 分类
			BpmSolution sol = bpmSolutionManager.get(bpmInst.getSolId());
			if (sol != null && StringUtils.isNotEmpty(sol.getTreeId())) {
				SysTree sysTree = sysTreeManager.get(sol.getTreeId());
				bpmInst.setTreeName(sysTree.getName());
			}
		}

		bpmAuthSettingManager.setRight(bpmInstList);

		return new JsonPageResult<BpmInst>(bpmInstList, filter.getPage().getTotalItems());
	}

	/**
	 * 我的草稿
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listDrafts")
	@ResponseBody
	public JsonPageResult<BpmInst> listDrafts(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);

		filter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		String treeId = RequestUtil.getString(request, "treeId");
		if (StringUtil.isNotEmpty(treeId)) {
			SysTree sysTree = sysTreeManager.get(treeId);
			if (sysTree != null) {
				String path = sysTree.getPath();
				filter.addFieldParam("TREE_PATH_", path + "%");
			}
		}
		filter.addFieldParam("CREATE_BY_", ContextUtil.getCurrentUserId());
		List<BpmInst> bpmInstList = bpmInstManager.getMyDrafts(filter);
		for (BpmInst bpmInst : bpmInstList) {
			// 分类
			BpmSolution sol = bpmSolutionManager.get(bpmInst.getSolId());
			if (sol != null && StringUtils.isNotEmpty(sol.getTreeId())) {
				SysTree sysTree = sysTreeManager.get(sol.getTreeId());
				if (sysTree != null) {
					bpmInst.setTreeName(sysTree.getName());
				}
			}
		}
		return new JsonPageResult<BpmInst>(bpmInstList, filter.getPage().getTotalItems());
	}

	/**
	 * 启动流程
	 * 
	 * @param request
	 * @param reponse
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("startProcess")
	@ResponseBody
	@LogEnt(action = "startProcess", module = "流程", submodule = "流程实例")
	public JsonResult startProcess(HttpServletRequest request, HttpServletResponse reponse) throws Exception {

		// 加上处理的消息提示
		ProcessMessage handleMessage = new ProcessMessage();
		BpmInst bpmInst = null;
		JsonResult result = new JsonResult();
		try {
			ProcessHandleHelper.setProcessMessage(handleMessage);
			ProcessStartCmd cmd = getProcessStartCmd(request);
			// 启动流程
			bpmInst = bpmInstManager.doStartProcess(cmd);

			result.setData(bpmInst);

		} catch (Exception ex) {
			// 把具体的错误放置在内部处理，以显示正确的错误信息提示，在此不作任何的错误处理
			logger.error(ExceptionUtil.getExceptionMessage(ex));
			if (handleMessage.getErrorMsges().size() == 0) {
				handleMessage.addErrorMsg(ex.getMessage());
			}
		} finally {
			// 在处理过程中，是否有错误的消息抛出
			if (handleMessage.getErrorMsges().size() > 0) {
				result.setSuccess(false);
				result.setMessage("启动流程失败!");
				result.setData(handleMessage.getErrors());
				// 记录出错信息
				if (bpmInst != null) {
					bpmInst.setErrors(result.getMessage());
					bpmInstManager.update(bpmInst);
				}

			} else {
				result.setSuccess(true);
				result.setMessage("成功启动流程！");
			}
			ProcessHandleHelper.clearProcessCmd();
			ProcessHandleHelper.clearProcessMessage();
		}
		return result;

	}

	@RequestMapping("saveInstCtl")
	@LogEnt(action = "saveInstCtl", module = "流程", submodule = "流程实例")
	public void saveInstCtl(HttpServletRequest request, HttpServletResponse response) {
		String printAuserIds = request.getParameter("printAuserIds");
		String printAgroupIds = request.getParameter("printAgroupIds");
		String downAgroupIds = request.getParameter("downAgroupIds");
		String downAuserIds = request.getParameter("downAuserIds");
		String bpmInstId = request.getParameter("bpmInstId");

		// ----------------------------附件下载权限-----------------------------------
		BpmInstCtl bpmInstCtl2 = new BpmInstCtl();
		bpmInstCtl2.setInstId(bpmInstId);
		bpmInstCtl2.setType("FILE");
		bpmInstCtl2.setRight("DOWN");
		bpmInstCtl2.setUserIds(downAuserIds);
		bpmInstCtl2.setGroupIds(downAgroupIds);
		bpmInstCtl2.setCreateBy(ContextUtil.getCurrentUserId());
		bpmInstCtl2.setCreateTime(new Date());
		bpmInstCtl2.setTenantId(ContextUtil.getCurrentTenantId());
		bpmInstCtlManager.saveOrUpdate(bpmInstCtl2);
		// ----------------------------附件打印权限-----------------------------------
		BpmInstCtl bpmInstCtl3 = new BpmInstCtl();
		bpmInstCtl3.setInstId(bpmInstId);
		bpmInstCtl3.setType("FILE");
		bpmInstCtl3.setRight("PRINT");
		bpmInstCtl3.setUserIds(printAuserIds);
		bpmInstCtl3.setGroupIds(printAgroupIds);
		bpmInstCtl3.setCreateBy(ContextUtil.getCurrentUserId());
		bpmInstCtl3.setCreateTime(new Date());
		bpmInstCtl3.setTenantId(ContextUtil.getCurrentTenantId());
		bpmInstCtlManager.saveOrUpdate(bpmInstCtl3);
	}

	/**
	 * 获得流程启动的参数配置
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws JsonProcessingException
	 */
	private ProcessStartCmd getProcessStartCmd(HttpServletRequest request) throws Exception {
		ProcessStartCmd cmd = new ProcessStartCmd();
		String solId = request.getParameter("solId");
		String taskId = request.getParameter("taskId");
		String mainSolId = request.getParameter("mainSolId");
		String jsonData = request.getParameter("jsonData");
		String bpmInstId = request.getParameter("bpmInstId");
		String destNodeId = request.getParameter("destNodeId");
		String from = request.getParameter("from");
		String busKey = request.getParameter("busKey");
		String opinion = request.getParameter("opinion");
		String opFiles = request.getParameter("opFiles");
		String vars = request.getParameter("vars");

		if (StringUtils.isEmpty(solId)) {
			String solKey = request.getParameter("solKey");
			if (StringUtils.isNotEmpty("solKey")) {
				BpmSolution bpmSol = bpmSolutionManager.getByKey(solKey, ContextUtil.getCurrentTenantId());
				if (bpmSol != null) {
					solId = bpmSol.getSolId();
				}
			}
		}
		// 节点人员配置
		String nodeUserIds = request.getParameter("nodeUserIds");
		// 目标节点用户列表
		String destNodeUsers = request.getParameter("destNodeUsers");

		cmd.setOpFiles(opFiles);
		cmd.setSolId(solId);
		if (StringUtils.isEmpty(jsonData)) {
			jsonData = "{}";
		}
		// 转成json值，以在后续中使用
		cmd.setJsonData(jsonData);

		cmd.setBpmInstId(bpmInstId);
		cmd.setDestNodeId(destNodeId);
		cmd.setFrom(from);
		cmd.setBusinessKey(busKey);
		cmd.setOpinion(opinion);
		// 节点人员配置
		cmd.setNodeUserIds(nodeUserIds);
		// 获得目标节点的人员配置
		cmd.setDestNodeUsers(destNodeUsers);

		if (StringUtils.isNotEmpty(vars)) {
			Map<String, Object> varsMap = JSONUtil.jsonArr2Map(vars);
			cmd.setVars(varsMap);
		}
		if (StringUtil.isNotEmpty(taskId)) {
			cmd.getVars().put("mainTaskId", taskId);
		}
		if (StringUtil.isNotEmpty(mainSolId)) {
			cmd.getVars().put("mainSolId", mainSolId);
		}

		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		if (StringUtil.isNotEmpty(mainSolId)) {
			BpmSolution mainBpmSolution = bpmSolutionManager.get(mainSolId);
			BpmNodeSet set = bpmNodeSetManager.getBySolIdActDefIdNodeId(mainSolId, mainBpmSolution.getActDefId(),
					ProcessConfig.PROCESS_NODE_ID);
			JsonNode jsonObject = objectMapper.readTree(set.getSettings());
			JsonNode configsNode = jsonObject.get("configs");
			Map<String, Object> configMap = JSONUtil.jsonNode2Map(configsNode);
			JSONArray ary = JSONArray.parseArray((String) configMap.get("bpmDefs"));
			for (Object object : ary) {
				JSONObject obj = (JSONObject) object;
				if (bpmSolution.getKey().equals(obj.getString("alias"))) {
					JSONArray data = obj.getJSONObject("config").getJSONArray("varData");
					cmd.getVars().putAll(setVarData(data, jsonData));
					break;
				}
			}
		}

		return cmd;
	}

	private Map<String, Object> setVarData(JSONArray configVars, String jsonData) {
		Map<String, Object> vars = new HashMap<String, Object>();
		JSONObject params = JSONObject.parseObject(jsonData);
		for (Object obj : configVars) {
			JSONObject var = (JSONObject) obj;
			String formField = var.getString("formField");
			String key = var.getString("key");

			Object val = null;
			// 优先从表单字段映射
			if (StringUtils.isNotEmpty(formField)) {
				val = (Object) params.get(formField);
			}
			if (val == null) {
				val = (Object) params.get(key);
			}
			if (val == null) {
				val = var.getString("defVal");
			}
			// 防止全局变量没传值也会被清空
			if (val == null)
				continue;
			try {
				// 计算后的变量值
				Object exeVal = null;
				// 计算表达式以获得值
				if (StringUtils.isNotEmpty(var.getString("express"))) {
					exeVal = groovyEngine.executeScripts(var.getString("express"), null);
				} else if (BpmSolVar.TYPE_DATE.equals(var.getString("type"))) {// 直接从页面中获得值进行转化
					exeVal = DateUtil.parseDate((String) val);
				} else if (BpmSolVar.TYPE_NUMBER.equals(var.getString("type"))) {
					exeVal = new Double((String) val);
				} else {
					exeVal = val;
				}
				vars.put(var.getString("key"), exeVal);
			} catch (Exception ex) {
				logger.error(ex.getMessage());
			}
		}
		return vars;
	}

	@RequestMapping("saveDraft")
	@ResponseBody
	@LogEnt(action = "保存草稿", module = "流程", submodule = "流程实例")
	public JsonResult saveDraft(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProcessStartCmd cmd = getProcessStartCmd(request);
		BpmInst bpmInst = bpmInstManager.doSaveDraft(cmd);
		return new JsonResult(true, "成功保存草稿", bpmInst);
	}

	/**
	 * 显示关联的数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("showLinkData")
	public ModelAndView showLinkData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");
		// 来自临时实例Id
		if (StringUtils.isEmpty(instId)) {
			instId = request.getParameter("tmpInstId");
		}

		String json = null;
		BpmFormInst formInst = bpmFormInstManager.getByBpmInstId(instId);
		if (formInst != null) {
			json = formInst.getJsonData();
		} else {
			BpmInstTmp tmp = bpmInstTmpManager.get(instId);
			if (tmp != null) {
				json = tmp.getFormJson();
			}
		}
		return getPathView(request).addObject("json", json);
	}

	/**
	 * 跳至流程的启动页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("{solKey}/start")
	@LogEnt(action = "start", module = "流程", submodule = "流程实例")
	public ModelAndView start(@PathVariable("solKey") String solKey, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		return start(request, solKey);
	}

	/**
	 * 跳至流程的启动页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("start")
	@LogEnt(action = "start", module = "流程", submodule = "流程实例")
	public ModelAndView start(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return start(request, "");
	}

	public ModelAndView start(HttpServletRequest request, String solKey) throws Exception {
		// 从流程解决方案中启动流程
		String solId = request.getParameter("solId");
		// 从流程草稿中启动流程
		String instId = request.getParameter("instId");
		// 从临时实例数据中启动流程
		String tmpInstId = request.getParameter("tmpInstId");
		String from = request.getParameter("from");
		String pk = request.getParameter("pk");

		// 判断临时的实例是否已经创建起来
		if (StringUtils.isNotEmpty(tmpInstId)) {
			BpmInst bpmInst = bpmInstManager.get(tmpInstId);
			if (bpmInst != null) {
				return new ModelAndView("redirect:start.do?instId=" + tmpInstId);
			}
		}

		ModelAndView mv = new ModelAndView("bpm/core/bpmInstStart.jsp");
		BpmSolution bpmSolution = null;

		// 来自流临时保存页跳转过来的
		if (StringUtils.isNotEmpty(tmpInstId) && StringUtils.isNotEmpty(solId)) {
			bpmSolution = bpmSolutionManager.get(solId);
			BpmInstTmp tmp = bpmInstTmpManager.get(tmpInstId);
			if (tmp != null) {
				pk = tmp.getBusKey();
			}
		} else if (StringUtils.isNotEmpty(solId)) {
			bpmSolution = bpmSolutionManager.get(solId);
		} else if (StringUtils.isNotEmpty(solKey)) {
			bpmSolution = bpmSolutionManager.getByKey(solKey, ContextUtil.getCurrentTenantId());
			solId = bpmSolution.getSolId();
		} else {// 从流程草稿中启动流程
			BpmInst bpmInst = bpmInstManager.get(instId);
			bpmSolution = bpmSolutionManager.get(bpmInst.getSolId());
			solId = bpmSolution.getSolId();
		}

		// ////////////////////////开始--用于控制开始节点的相关配置////////////////////////////////////////
		// 取得流程的全局配置
		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(solId, bpmSolution.getActDefId());
		mv.addObject("processConfig", processConfig);
		mv.addObject("bpmSolution", bpmSolution);
		mv.addObject("instId", instId);
		mv.addObject("from", from);
		mv.addObject("buttons", processConfig.getButtons());

		// 展示当前表单
		IFormHandler formHandler = formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels = formHandler.getStartForm(solId, instId, pk);

		mv.addObject("formModels", formModels);

		return mv;
	}

	/**
	 * 跳至流程的启动页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("inform")
	public ModelAndView inform(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = RequestUtil.getString(request, "instId");
		String actInstId = RequestUtil.getString(request, "actInstId");

		// 获取当前用户名
		String userName = ContextUtil.getCurrentUser().getFullname();
		BpmInst bpmInst = bpmInstManager.get(instId);
		if (StringUtils.isEmpty(instId)) {
			bpmInst = bpmInstManager.getByActInstId(actInstId);
			instId = bpmInst.getInstId();
		}

		if (bpmInst == null) {
			return PublicController.getTipInfo("提示信息", "流程实例不存在，可能已被删除!");
		}
		// 判断是否能查看
		boolean canRead = bpmInstManager.canRead(bpmInst);
		if (!canRead) {
			return PublicController.getTipInfo("提示信息", "你没有阅读权限!");
		}

		ModelAndView mv = getPathView(request);
		BpmSolution bpmSolution = bpmSolutionManager.get(bpmInst.getSolId());
		String solId = bpmSolution.getSolId();
		mv.addObject("bpmInst", bpmInst);

		BpmDef bpmDef = bpmDefManager.getByActDefId(bpmInst.getActDefId());

		////////////////////////// 开始--用于控制开始节点的相关配置////////////////////////////////////////
		// 取得开始节点
		ActNodeDef startNodeDef = actRepService.getStartNode(bpmDef.getActDefId());
		// 取得流程的全局配置
		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(solId, bpmDef.getActDefId());

		if (StringUtils.isNotEmpty(processConfig.getExtFormUrl())) {
			Map<String, Object> vars = new HashMap<String, Object>();
			vars.put("instId", bpmInst.getInstId());
			vars.put("busKey", bpmInst.getBusKey());
			String url = StringUtil.replaceVariableMap(processConfig.getExtFormUrl(), vars);
			return new ModelAndView("redirect:" + url);
		}

		// 增加子表权限过滤。
		ProcessHandleHelper.clearObjectLocal();
		ProcessHandleHelper.setObjectLocal(processConfig.getTableRightJson());

		// 取得流程的目标节点信息
		List<ActNodeDef> destNodes = actRepService.getStartFlowUserNodes(bpmDef.getActDefId(),
				"true".equals(processConfig.getIsSkipFirst()));

		List<DestNodeUsers> destNodeUserList = new ArrayList<DestNodeUsers>();
		// 取得开始节点的配置
		StartEventConfig startEventConfig = bpmNodeSetManager.getStartEventConfig(solId, bpmDef.getActDefId(),
				startNodeDef.getNodeId());
		// 计算后续节点的执行人员
		if ("true".equals(startEventConfig.getAllowNextExecutor())) {
			Map<String, Object> vars = new HashMap<String, Object>();
			vars.put("startUserId", ContextUtil.getCurrentUserId());
			vars.put("solId", solId);
			destNodeUserList = bpmTaskManager.getDestNodeUsers(solId, bpmDef.getActDefId(), destNodes, vars);
		}
		mv.addObject("processConfig", processConfig);
		mv.addObject("startEventConfig", startEventConfig);
		// 加上后续的节点的人员配置信息
		mv.addObject("destNodeUserList", destNodeUserList);

		// 是否显示作废的按钮
		boolean isShowDiscardBtn = false;
		// 正在运行，并且当前审批节点处于经办人环节
		if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
			List<ActNodeDef> outNodes = startNodeDef.getOutcomeNodes();
			List<BpmTask> bpmTasks = bpmTaskManager.getByActInstId(bpmInst.getActInstId());

			Set<String> taskUserSet = new HashSet<String>();
			Set<String> taskNodeSet = new HashSet<String>();
			for (BpmTask task : bpmTasks) {
				taskNodeSet.add(task.getName());
				taskNodeSet.add(task.getName());
				if (StringUtils.isNotEmpty(task.getAssignee())) {
					IUser osUser = userService.getByUserId(task.getAssignee());
					if (osUser != null) {
						taskUserSet.add(osUser.getFullname());
					}
				} else {
					Map<String, Object> variables = runtimeService.getVariables(bpmInst.getActInstId());
					Collection<TaskExecutor> bpmIdenties = bpmIdentityCalService
							.calNodeUsersOrGroups(bpmInst.getActDefId(), task.getTaskDefKey(), variables);
					KeyValEnt ent = bpmInstManager.getUserInfoIdNames(bpmIdenties);
					taskUserSet.add(ent.getVal().toString());
				}
			}
			// 当前环节
			bpmInst.setTaskNodes(StringUtil.getCollectionString(taskNodeSet, ","));
			// 当前执行人
			bpmInst.setTaskNodeUsers(StringUtil.getCollectionString(taskUserSet, ","));

			for (BpmTask t : bpmTasks) {
				for (ActNodeDef node : outNodes) {
					// 当前节点处于经办人环节，并且处理人为经办人，即允许作费单据
					if (node.getNodeId().equals(t.getTaskDefKey())
							&& ContextUtil.getCurrentUserId().equals(t.getAssignee())) {
						isShowDiscardBtn = true;
						break;
					}
				}
			}
		}

		if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
			List<Task> taskList = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();
			// 检查当前任务的前一任务是否为当前用户，若为当前用户则允许追回按钮
			String curUserId = ContextUtil.getCurrentUserId();
			boolean isFromMe = false;
			// 前一个任务节点Id

			for (Task task : taskList) {
				ActivityImpl taskNode = actRepService.getActivityImplByActDefIdNodeId(task.getProcessDefinitionId(),
						task.getTaskDefinitionKey());
				if (taskNode != null) {
					List<PvmTransition> trans = taskNode.getIncomingTransitions();
					for (PvmTransition t : trans) {
						PvmActivity pa = t.getSource();
						// 查找该节点的审批过的人员是否为当前人
						String nodeId = pa.getId();
						String nodeType = (String) pa.getProperty("type");
						if ("startEvent".equals(nodeType)) {
							continue;
						}
						BpmRuPath bpmRuPath = bpmRuPathManager.getFarestPath(bpmInst.getActInstId(), nodeId, null);
						if (bpmRuPath != null && StringUtils.isNotEmpty(bpmRuPath.getAssignee())) {
							if (curUserId.equals(bpmRuPath.getAssignee())) {
								isFromMe = true;
								break;
							}
						}
					}
					if (isFromMe) {
						break;
					}
				}
			}
			// 是否由我转下去的事项
			mv.addObject("isFromMe", isFromMe);
		}

		mv.addObject("isShowDiscardBtn", isShowDiscardBtn);

		// 附件权限
		String userId = ContextUtil.getCurrentUserId();
		boolean isDown = bpmInstCtlManager.sysFileCtl(userId, instId, BpmInstCtl.CTL_RIGHT_DOWN);
		boolean isPrint = bpmInstCtlManager.sysFileCtl(userId, instId, BpmInstCtl.CTL_RIGHT_PRINT);

		// 附件回显
		List<BpmInstAttach> list = bpmInstAttachManager.getByInstId(instId);
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
			fileBytes.deleteCharAt(fileBytes.length() - 1);
		}

		// 记录阅读人数

		BpmInstRead read = new BpmInstRead();
		read.setInstId(bpmInst.getInstId());
		read.setState(bpmInst.getStatus());
		read.setUserId(userId);
		read.setReadId(idGenerator.getSID());
		IGroup dep = groupService.getMainByUserId(userId);
		if (dep != null) {
			read.setDepId(dep.getIdentityId());
		}
		bpmInstReadManager.create(read);

		// 是否草稿状态
		Boolean isDraft = false;
		if ("DRAFTED".equals(bpmInst.getStatus())) {
			isDraft = true;
		} else {
			isDraft = false;
		}

		mv.addObject("isDown", isDown);
		mv.addObject("isPrint", isPrint);
		mv.addObject("isDraft", isDraft);
		mv.addObject("fileBytes", fileBytes);
		mv.addObject("fileIds", fileIds.toString());
		mv.addObject("fileNames", fileNames.toString());
		mv.addObject("bpmDef", bpmDef);
		mv.addObject("bpmSolution", bpmSolution);
		mv.addObject("userName", userName);

		IFormHandler formHandler = formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels = formHandler.getByInstId(instId);
		mv.addObject("formModels", formModels);

		return mv;
	}

	/**
	 * 任务撤回
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("recoverInst")
	@ResponseBody
	public JsonResult recoverInst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");
		JsonResult result = bpmInstManager.recoverInst(instId);
		return result;
	}

	@RequestMapping("del")
	@ResponseBody
	@LogEnt(action = "del", module = "流程", submodule = "流程实例")
	public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uId = request.getParameter("ids");
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				bpmInstManager.deleteCascade(id, "");
			}
		}
		return new JsonResult(true, "成功删除！");
	}

	@RequestMapping("delDraft")
	@ResponseBody
	@LogEnt(action = "删除草稿", module = "流程", submodule = "流程实例")
	public JsonResult delDraft(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uId = request.getParameter("ids");
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				bpmInstManager.deleteCascade(id, "");
			}
		}
		return new JsonResult(true, "成功删除！");
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
		String actInstId = request.getParameter("actInstId");
		BpmInst bpmInst = null;

		if (StringUtils.isNotEmpty(pkId)) {
			bpmInst = bpmInstManager.get(pkId);
		} else if (StringUtils.isNotEmpty(actInstId)) {
			bpmInst = bpmInstManager.getByActInstId(actInstId);
		}
		// 实例已经删除
		if (bpmInst == null) {
			return new ModelAndView("bpm/core/bpmInstEmpty.jsp");
		}
		ModelAndView mv = getPathView(request);

		return mv.addObject("bpmInst", bpmInst);
	}

	/**
	 * 结束流程实例
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("endProcess")
	@ResponseBody
	@LogEnt(action = "endProcess", module = "流程", submodule = "流程实例")
	public JsonResult endProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JsonResult result = new JsonResult(true, "成功结束流程实例!");
		try {
			String instId = request.getParameter("instId");
			BpmInst bpmInst = bpmInstManager.get(instId);
			if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
				bpmInstManager.doEndProcessInstance(instId);
				return result;
			} else {
				return new JsonResult(true, "流程实例结束失败,实例不是运行状态!");
			}
		} catch (Exception ex) {
			String msg = ExceptionUtil.getExceptionMessage(ex);
			result.setData(msg);
			result.setSuccess(false);
			result.setMessage("流程结束失败!");

			return result;
		}

	}

	/**
	 * 挂起流程实例
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("pendingProcess")
	@ResponseBody
	@LogEnt(action = "pendingProcess", module = "流程", submodule = "流程实例")
	public JsonResult pendingProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");
		BpmInst bpmInst = bpmInstManager.get(instId);
		if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
			bpmInstManager.doPendingProcessInstance(instId);
		} else if (BpmInst.STATUS_ABORT_END.equals(bpmInst.getStatus())) {
			return new JsonResult(true, "实例已结束,不能挂起!");
		}
		return new JsonResult(true, "成功挂起流程实例!");
	}

	/**
	 * 恢复激活流程实例
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("activateProcess")
	@ResponseBody
	@LogEnt(action = "activateProcess", module = "流程", submodule = "流程实例")
	public JsonResult activateProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");
		BpmInst bpmInst = bpmInstManager.get(instId);
		if (BpmInst.STATUS_PENDING.equals(bpmInst.getStatus())) {
			bpmInstManager.doActivateProcessInstance(instId);
		} else if (BpmInst.STATUS_ABORT_END.equals(bpmInst.getStatus())) {
			return new JsonResult(true, "实例已结束,不能恢复!");
		}
		return new JsonResult(true, "成功恢复流程实例!");
	}

	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = request.getParameter("pkId");
		// 复制添加
		String forCopy = request.getParameter("forCopy");
		BpmInst bpmInst = null;
		if (StringUtils.isNotEmpty(pkId)) {
			bpmInst = bpmInstManager.get(pkId);
			if ("true".equals(forCopy)) {
				bpmInst.setInstId(null);
			}
		} else {
			bpmInst = new BpmInst();
		}
		return getPathView(request).addObject("bpmInst", bpmInst);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmInstManager;
	}

	/**
	 * 作废流程:将相关联的bpmtask的suspensionstate设置成404
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("discardInst")
	@ResponseBody
	@LogEnt(action = "作废流程实例", module = "流程", submodule = "流程实例")
	public JsonResult discardInst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instId = request.getParameter("instId");

		bpmInstManager.doDiscardProcessInstance(instId);
		return new JsonResult(true, "成功作废");
	}

	/**
	 * 返回流程定义的跳转表格信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getActNodeInsts")
	@ResponseBody
	public Collection<ActivityNodeInst> getActNodeInsts(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String taskId = request.getParameter("taskId");
		String instId = request.getParameter("instId");
		String solId = request.getParameter("solId");
		// 是否排除网关
		String excludeGateway = request.getParameter("excludeGateway");

		// 以上三个值只需要传入一个
		// 放置流程变量
		Map<String, Object> variables = null;

		Map<String, ActivityNodeInst> nodeMap = new LinkedHashMap<String, ActivityNodeInst>();
		String actDefId = null;
		String actInstId = null;

		if (StringUtils.isNotEmpty(taskId)) {
			BpmTask bpmTask = bpmTaskManager.get(taskId);
			actDefId = bpmTask.getProcDefId();
			actInstId = bpmTask.getProcInstId();
			variables = taskService.getVariables(taskId);

		} else if (StringUtils.isNotBlank(instId)) {
			BpmInst bpmInst = bpmInstManager.get(instId);
			if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
				variables = runtimeService.getVariables(bpmInst.getActInstId());
			} else {
				variables = new HashMap<String, Object>();
				List<HistoricVariableInstance> varInsts = historyService.createHistoricVariableInstanceQuery()
						.processInstanceId(bpmInst.getActInstId()).list();
				for (HistoricVariableInstance var : varInsts) {
					variables.put(var.getVariableName(), var.getValue());
				}
			}
			actDefId = bpmInst.getActDefId();
			actInstId = bpmInst.getActInstId();
		} else {
			BpmSolution bpmSolution = bpmSolutionManager.get(solId);
			variables = new HashMap<String, Object>();
			variables.put("startUserId", ContextUtil.getCurrentUserId());
			variables.put(BpmIdentityCalService.SIMULATE_CAL, "true");
			variables.put("solId", solId);
			BpmDef bpmDef = bpmDefManager.getValidBpmDef(bpmSolution.getActDefId(), bpmSolution.getDefKey());
			actDefId = bpmDef.getActDefId();
		}
		Map<String, BpmNodeJump> nodeJumpMap = null;
		if (actInstId != null) {
			nodeJumpMap = bpmNodeJumpManager.getMapByActInstId(actInstId);
		}
		List<ActivityImpl> activityNodes = actRepService.getActivityNodeImpls(actDefId);

		for (ActivityImpl actNode : activityNodes) {
			String actId = actNode.getId();
			String type = (String) actNode.getProperty("type");
			String name = (String) actNode.getProperty("name");
			String multiInstance = (String) actNode.getProperty("multiInstance");
			// 若排除了网关，则只显示任务节点
			if ("true".equals(excludeGateway) && type.indexOf("Gateway") != -1) {
				continue;
			}
			if ("startEvent".equals(type) || "endEvent".equals(type)) {
				continue;
			}
			ActivityNodeInst inst = nodeMap.get(actNode);

			if (inst == null) {
				inst = new ActivityNodeInst();
				Collection<TaskExecutor> infos = bpmIdentityCalService.calNodeUsersOrGroups(actDefId, actId, variables);

				String exeUserNames = getNamesFromIdentifyInfos(infos);

				inst.setNodeId(actId);
				inst.setNodeName(name);
				if ("parallel".equals(multiInstance)) {
					inst.setMultipleType("会签：并行");
				} else {
					inst.setMultipleType("审批：串行");
				}

				if (nodeJumpMap != null && nodeJumpMap.containsKey(actId)) {
					inst.setStatus("已执行");
				} else {
					inst.setStatus("未执行");
				}

				StringBuffer nodeIds = new StringBuffer();
				StringBuffer nodeNames = new StringBuffer();
				List<PvmTransition> trans = actNode.getOutgoingTransitions();
				for (PvmTransition pv : trans) {
					ActivityImpl destNode = (ActivityImpl) pv.getDestination();
					nodeIds.append(destNode.getId()).append(",");
					String destName = (String) destNode.getProperty("name");
					if (StringUtils.isEmpty(destName)) {
						destName = (String) destNode.getProperty("type");
						if ("startEvent".equals(destName)) {
							destName = "开始节点";
						} else if ("endEvent".equals(destName)) {
							destName = "结束节点";
						}
					}
					nodeNames.append(destName).append(",");
				}
				if (nodeIds.length() > 0) {
					nodeIds.deleteCharAt(nodeIds.length() - 1);
					nodeNames.deleteCharAt(nodeNames.length() - 1);
				}
				inst.setToNodeIds(nodeIds.toString());
				inst.setToNodeNames(nodeNames.toString());
				inst.setOrginalFullNames(exeUserNames);
			}
			nodeMap.put(actId, inst);
		}

		return nodeMap.values();
	}

	private String getNamesFromIdentifyInfos(Collection<TaskExecutor> infos) {
		StringBuffer sb = new StringBuffer();
		for (TaskExecutor info : infos) {
			sb.append(info.getName()).append(",");
		}
		if (sb.length() > 0) {
			sb.deleteCharAt(sb.length() - 1);
		}
		return sb.toString();
	}

	@RequestMapping("getInstTree")
	@ResponseBody
	public List<SysTree> listByCatKey(HttpServletRequest request, HttpServletResponse response) throws Exception {
		IUser user = ContextUtil.getCurrentUser();
		List<SysTree> treeList = null;
		if (user.isSuperAdmin()) {
			treeList = sysTreeManager.getByCatKeyTenantId(SysTree.CAT_BPM_SOLUTION, ContextUtil.getCurrentTenantId());
		} else {
			treeList = bpmInstManager.getInstTree();
		}
		return treeList;
	}

	@RequestMapping("flowChart")
	public ModelAndView flowChart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String solId = RequestUtil.getString(request, "solId");

		BpmSolution solution = bpmSolutionManager.get(solId);

		String actDefId = solution.getActDefId();
		ModelAndView mv = getPathView(request);
		mv.addObject("actDefId", actDefId);
		mv.addObject("solId", solId);
		return mv;
	}

	@RequestMapping("info")
	public ModelAndView info(HttpServletRequest request) {
		ModelAndView mv = getPathView(request);

		String actInstId = RequestUtil.getString(request, "actInstId");
		String instId = RequestUtil.getString(request, "instId");
		if (StringUtil.isEmpty(actInstId) && StringUtil.isNotEmpty(instId)) {
			BpmInst inst = bpmInstManager.get(instId);
			actInstId = inst.getActInstId();
		}

		mv.addObject("actInstId", actInstId);

		return mv;
	}

	/**
	 * 我发起的流程实例
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("myList")
	public ModelAndView myList(HttpServletRequest request) {
		ModelAndView mv = getPathView(request);
		String userId = ContextUtil.getCurrentUserId();
		mv.addObject("userId", userId);

		return mv;
	}

	@RequestMapping("listInstBySolId")
	@ResponseBody
	public JsonPageResult<BpmInst> listInstBySolId(HttpServletRequest request, HttpServletResponse response) {
		String solId = RequestUtil.getString(request, "solId");
		String userId = ContextUtil.getCurrentUserId();
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addParam("solId", solId);
		queryFilter.addParam("userId", userId);
		queryFilter.addParam("status", "SUCCESS_END");
		List<BpmInst> bpmInsts = bpmInstManager.getMyInstBySolutionId(queryFilter);
		for (BpmInst bpmInst : bpmInsts) {

			if (BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {
				List<Task> taskList = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();
				Set<String> taskUserSet = new HashSet<String>();
				Set<String> taskNodeSet = new HashSet<String>();
				for (Task task : taskList) {
					taskNodeSet.add(task.getName());
					if (StringUtils.isNotEmpty(task.getAssignee())) {
						IUser osUser = userService.getByUserId(task.getAssignee());
						if (osUser != null) {
							taskUserSet.add(osUser.getFullname());
						}
					}
				}
				// 当前环节
				bpmInst.setTaskNodes(StringUtil.getCollectionString(taskNodeSet, ","));
				// 当前执行人
				bpmInst.setTaskNodeUsers(StringUtil.getCollectionString(taskUserSet, ","));

			}
			// 分类
			BpmSolution sol = bpmSolutionManager.get(bpmInst.getSolId());
			if (sol != null && StringUtils.isNotEmpty(sol.getTreeId())) {
				SysTree sysTree = sysTreeManager.get(sol.getTreeId());
				bpmInst.setTreeName(sysTree.getName());
			}
		}

		JsonPageResult<BpmInst> jsonPageResult = new JsonPageResult<BpmInst>(bpmInsts,
				queryFilter.getPage().getTotalItems());
		return jsonPageResult;

	}

	@RequestMapping("dialog")
	public ModelAndView dialog(HttpServletRequest request, HttpServletResponse response) {
		return this.getPathView(request);
	}

	@RequestMapping("startFlow")
	public ModelAndView startFlow(HttpServletRequest request, HttpServletResponse response) {
		String solId = request.getParameter("solId");
		String instId = request.getParameter("instId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		String actDefId = bpmSolution.getActDefId();

		ProcessConfig processConfig = bpmNodeSetManager.getProcessConfig(solId, actDefId);
		BpmOpinionTemp opinionTemp = bpmOpinionTempManager.getByType(BpmOpinionTemp.TYPE_INST, instId);
		if (opinionTemp == null) {
			opinionTemp = new BpmOpinionTemp();
		}
		String skipFirst = processConfig.getIsSkipFirst();
		String startUser = processConfig.getStartUser();
		String selectUser = processConfig.getSelectUser();

		ModelAndView mv = getPathView(request);
		mv.addObject("actDefId", bpmSolution.getActDefId());
		mv.addObject("opinionTemp", opinionTemp);
		mv.addObject("skipFirst", skipFirst);
		mv.addObject("selectUser", processConfig.getSelectUser());
		mv.addObject("startUser", startUser);
		// 跳过并需要制定发起人。
		Collection<TaskExecutor> bpmIdenties = new ArrayList<>();
		String nodeId = "";
		if ("true".equals(skipFirst) && "true".equals(startUser)) {
			nodeId = bpmInstManager.getNextNode(actDefId, false);
			Map<String, Object> vars = new HashMap<>();
			vars.put("solId", solId);
			bpmIdenties = bpmIdentityCalService.calNodeUsersOrGroups(actDefId, nodeId, vars);
		}
		String users = getUsers(bpmIdenties);
		mv.addObject("nodeId", nodeId);
		mv.addObject("users", users);

		if ("true".equals(skipFirst) && "true".equals(selectUser)) {
			mv.addObject("showTab", true);
		} else {
			mv.addObject("showTab", false);
		}

		return mv;
	}

	private String getUsers(Collection<TaskExecutor> users) {
		if (BeanUtil.isEmpty(users))
			return "[]";
		JSONArray ary = new JSONArray();
		for (TaskExecutor id : users) {
			JSONObject obj = new JSONObject();
			obj.put("id", id.getId());
			obj.put("name", id.getName());
			if (TaskExecutor.IDENTIFY_TYPE_USER.equals(id.getType())) {
				obj.put("type", "user");
			} else {
				obj.put("type", "group");
			}
			ary.add(obj);
		}
		return ary.toJSONString();
	}

	private String getSecondNode(String actDefId) {
		ActProcessDef actDef = actRepService.getProcessDef(actDefId);
		String startNodeId = actDef.getStartNodeId();
		ActNodeDef startNode = actDef.getNodesMap().get(startNodeId);
		ActNodeDef firstNode = startNode.getOutcomeNodes().get(0);
		ActNodeDef secondNode = firstNode.getOutcomeNodes().get(0);

		return secondNode.getNodeId();
	}

	@RequestMapping("getPath")
	@ResponseBody
	public List<TaskNodeUser> getPath(HttpServletRequest request, HttpServletResponse response) {
		String solId = RequestUtil.getString(request, "solId", "");
		String json = RequestUtil.getString(request, "jsonData", "");
		List<TaskNodeUser> list = bpmInstManager.getRunPath(solId, json);
		return list;
	}

	@RequestMapping("doUrge")
	@ResponseBody
	public JsonResult doUrge(HttpServletRequest request) {
		JsonResult rtn = new JsonResult<>(true, "催办成功");
		try {

			String instId = RequestUtil.getString(request, "instId");
			String opinion = RequestUtil.getString(request, "opinion");
			String noticeTypes = RequestUtil.getString(request, "noticeTypes");
			bpmInstManager.doUrge(instId, opinion, noticeTypes);
		} catch (Exception ex) {
			rtn.setSuccess(false);
			rtn.setMessage("催办出错!");
			rtn.setData(ExceptionUtil.getExceptionMessage(ex));
		}

		return rtn;

	}

	@RequestMapping("getSubProcessFormData")
	@ResponseBody
	public JsonResult getSubProcessFormData(HttpServletRequest request) {
		JsonResult rtn = new JsonResult<>(true, "获取成功");
		try {
			String solKey = RequestUtil.getString(request, "solKey");
			String mainSolId = RequestUtil.getString(request, "mainSolId");
			String formData = RequestUtil.getString(request, "formData");

			DataHolder dataHolder = new DataHolder();
			dataHolder.setCurMain(JSONObject.parseObject(formData));
			BpmSolution bpmSolution = bpmSolutionManager.getByKey(solKey, ContextUtil.getCurrentTenantId());
			BpmSolution mainBpmSolution = bpmSolutionManager.get(mainSolId);
			BpmNodeSet set = bpmNodeSetManager.getBySolIdActDefIdNodeId(mainSolId, mainBpmSolution.getActDefId(),
					ProcessConfig.PROCESS_NODE_ID);
			JsonNode jsonObject = objectMapper.readTree(set.getSettings());
			JsonNode configsNode = jsonObject.get("configs");
			Map<String, Object> configMap = JSONUtil.jsonNode2Map(configsNode);
			JSONArray ary = JSONArray.parseArray((String) configMap.get("bpmDefs"));
			JSONObject data = new JSONObject();
			JSONObject jsonData = new JSONObject();
			JSONArray vars=new JSONArray();
			for (Object object : ary) {
				JSONObject obj = (JSONObject) object;
				if (bpmSolution.getKey().equals(obj.getString("alias"))) {
					JSONObject configData = obj.getJSONObject("config").getJSONObject("data");
					JSONArray array = configData.getJSONArray("subList");
					for (int i = 0; i < array.size(); i++) {
						JSONObject json = array.getJSONObject(i);
						jsonData.putAll(bpmTableFormulaManager.getTableFieldValueHandler(dataHolder, json,true));
					}
					vars.addAll(obj.getJSONObject("config").getJSONArray("varData"));
				}
			}
			data.put("vars", vars);
			data.put("formData", jsonData);
			rtn.setData(data);
		} catch (Exception ex) {
			rtn.setSuccess(false);
			rtn.setMessage("获取出错!");
			rtn.setData(ExceptionUtil.getExceptionMessage(ex));
		}

		return rtn;

	}

	@RequestMapping({ "saveDraftFormData" })
	@ResponseBody
	public JsonResult saveDraftFormData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String instIdTemp = request.getParameter("instIdTemp");
		String jsonData = request.getParameter("jsonData");
		request.getParameter("opinion");
		if (StringUtils.isNotEmpty(instIdTemp)) {
			BpmInstTmp tmp = (BpmInstTmp) this.bpmInstTmpManager.get(instIdTemp);
			String newJsonNode = JSONUtil.copyJsons(tmp.getFormJson(), jsonData);
			tmp.setFormJson(newJsonNode);

			this.bpmInstTmpManager.update(tmp);
		}
		return new JsonResult(true, "成功保存草稿");
	}

	@RequestMapping({ "updateInstNodeUserInfo" })
	@ResponseBody
	public JsonResult updateInstNodeUserInfo(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String taskId = request.getParameter("taskId");
		String tmpInstId = request.getParameter("tmpInstId");
		String solId = request.getParameter("solId");

		String excludeGateway = request.getParameter("excludeGateway");

		String instId = "";
		taskId = "";

		Map<String, Object> variables = null;

		Map<String, ActivityNodeInst> nodeMap = new LinkedHashMap();
		String actDefId = null;
		String actInstId = null;
		if (StringUtils.isNotEmpty(taskId)) {
			BpmTask bpmTask = (BpmTask) this.bpmTaskManager.get(taskId);
			actDefId = bpmTask.getProcDefId();
			actInstId = bpmTask.getProcInstId();
			variables = this.taskService.getVariables(taskId);
		} else if (StringUtils.isNotEmpty(instId)) {
			BpmInst bpmInst = (BpmInst) this.bpmInstManager.get(instId);
			if ("RUNNING".equals(bpmInst.getStatus())) {
				variables = this.runtimeService.getVariables(bpmInst.getActInstId());
			} else {
				variables = new HashMap();
				List<HistoricVariableInstance> varInsts = this.historyService.createHistoricVariableInstanceQuery()
						.processInstanceId(bpmInst.getActInstId()).list();
				for (HistoricVariableInstance var : varInsts) {
					variables.put(var.getVariableName(), var.getValue());
				}
			}
			actDefId = bpmInst.getActDefId();
			actInstId = bpmInst.getActInstId();
		} else {
			BpmSolution bpmSolution = (BpmSolution) this.bpmSolutionManager.get(solId);
			variables = new HashMap();
			variables.put("startUserId", ContextUtil.getCurrentUserId());
			variables.put("SIMULATE_CAL", "true");
			variables.put("solId", solId);

			BpmDef bpmDef = this.bpmDefManager.getValidBpmDef(bpmSolution.getActDefId(), bpmSolution.getDefKey());
			if (bpmDef != null) {
				actDefId = bpmDef.getActDefId();
			}
		}
		Map<String, BpmNodeJump> nodeJumpMap = null;
		if (actInstId != null) {
			nodeJumpMap = this.bpmNodeJumpManager.getMapByActInstId(actInstId);
		}
		List<ActivityImpl> activityNodes = this.actRepService.getActivityNodeImpls(actDefId);
		String nodesUserId = "";
		nodesUserId = nodesUserId + "[";
		String tempUserIdsJson = "";
		for (ActivityImpl actNode : activityNodes) {
			String actNodeId = actNode.getId();
			String type = (String) actNode.getProperty("type");

			String name = (String) actNode.getProperty("name");

			String multiInstance = (String) actNode.getProperty("multiInstance");
			if ((!"true".equals(excludeGateway)) || (type.indexOf("Gateway") == -1)) {
				if ((!"startEvent".equals(type)) && (!"endEvent".equals(type))) {
					Collection<TaskExecutor> infos = initUserInfo(solId, actDefId, tmpInstId, actNodeId);

					String fullName = "";
					if ((infos != null) && (infos.size() > 0)) {
						for (TaskExecutor identityInfo : infos) {
							fullName = fullName + identityInfo.getName() + ",";
						}
						if (StringUtils.isNotEmpty(fullName)) {
							fullName = fullName.substring(0, fullName.length() - 1);
							tempUserIdsJson = tempUserIdsJson + "{\"nodeId\":\"" + actNodeId + "\",\"userFullName\":\""
									+ fullName + "\"},";
						}
					}
				}
			}
		}
		if (StringUtils.isNotEmpty(tempUserIdsJson)) {
			tempUserIdsJson = tempUserIdsJson.substring(0, tempUserIdsJson.length() - 1);
			nodesUserId = nodesUserId + tempUserIdsJson;
		}
		nodesUserId = nodesUserId + "]";

		return new JsonResult(false, nodesUserId);
	}

	private Collection<TaskExecutor> initUserInfo(String solId, String actDefId, String tmpInstId, String mcNodeId) {
		Collection<TaskExecutor> identityInfos = null;
		if ((StringUtils.isNotEmpty(solId)) && (StringUtils.isNotEmpty(tmpInstId)) && (StringUtils.isNotEmpty(mcNodeId))
				&& (StringUtils.isNotEmpty(actDefId))) {
			Map<String, Object> variables = null;
			variables = new HashMap();

			variables.put("startUserId", ContextUtil.getCurrentUserId());
			variables.put("SIMULATE_CAL", "true");
			variables.put("solId", solId);

			BpmInstTmp bpmInstTmp = (BpmInstTmp) this.bpmInstTmpManager.get(tmpInstId);
			if (bpmInstTmp != null) {
				Map<String, Object> vars = this.bpmInstManager.handleTaskVarsFromJson(solId, actDefId,
						JSONObject.parseObject(bpmInstTmp.getFormJson()));
				variables.putAll(vars);
			}
			identityInfos = this.bpmIdentityCalService.calNodeUsersOrGroups(actDefId, mcNodeId, variables);
		}
		return identityInfos;
	}

	@RequestMapping({ "correctInstForm" })
	public void correctInstForm(HttpServletRequest request, HttpServletResponse response) {
		List<BpmInst> bpmInsts = this.bpmInstManager.getAll();
		for (BpmInst inst : bpmInsts) {
			BpmFormInst formInst = this.bpmFormInstManager.getByBpmInstId(inst.getInstId());
			String instForm = formInst.getJsonData();
			JSONObject instJson = JSONObject.parseObject(instForm);
			BpmInstTmp tmpInst = (BpmInstTmp) this.bpmInstTmpManager.get(inst.getInstId());
			String tmpForm = tmpInst.getFormJson();
			JSONObject tmpJson = JSONObject.parseObject(tmpForm);

			JSONArray ipm_pa_applypaycont = (JSONArray) instJson.get("pm_pa_applypaycont");
			JSONArray tpm_pa_applypaycont = (JSONArray) tmpJson.get("pm_pa_applypaycont");
			if ((ipm_pa_applypaycont != null) && (tpm_pa_applypaycont != null)
					&& ("[]".equals(ipm_pa_applypaycont.toString()))
					&& (!"[]".equals(tpm_pa_applypaycont.toString()))) {
				instJson.put("pm_pa_applypaycont", tpm_pa_applypaycont);
			}
			JSONArray ipm_pa_applypaycost = (JSONArray) instJson.get("pm_pa_applypaycost");
			JSONArray tpm_pa_applypaycost = (JSONArray) tmpJson.get("pm_pa_applypaycost");
			if ((ipm_pa_applypaycost != null) && (tpm_pa_applypaycost != null)
					&& ("[]".equals(ipm_pa_applypaycost.toString()))
					&& (!"[]".equals(tpm_pa_applypaycost.toString()))) {
				instJson.put("pm_pa_applypaycost", tpm_pa_applypaycost);
			}
			JSONArray ipm_cm_paydetail = (JSONArray) instJson.get("pm_cm_paydetail");
			JSONArray tpm_cm_paydetail = (JSONArray) tmpJson.get("pm_cm_paydetail");
			if ((ipm_cm_paydetail != null) && (tpm_cm_paydetail != null) && ("[]".equals(ipm_cm_paydetail.toString()))
					&& (!"[]".equals(tpm_cm_paydetail.toString()))) {
				instJson.put("pm_cm_paydetail", tpm_cm_paydetail);
			}
			JSONArray ipm_cm_sourplan = (JSONArray) instJson.get("pm_cm_sourplan");
			JSONArray tpm_cm_sourplan = (JSONArray) tmpJson.get("pm_cm_sourplan");
			if ((ipm_cm_sourplan != null) && (tpm_cm_sourplan != null) && ("[]".equals(ipm_cm_sourplan.toString()))
					&& (!"[]".equals(tpm_cm_sourplan.toString()))) {
				instJson.put("pm_cm_sourplan", tpm_cm_sourplan);
			}
			JSONArray ipm_cm_split = (JSONArray) instJson.get("pm_cm_split");
			JSONArray tpm_cm_split = (JSONArray) tmpJson.get("pm_cm_split");
			if ((ipm_cm_split != null) && (tpm_cm_split != null) && ("[]".equals(ipm_cm_split.toString()))
					&& (!"[]".equals(tpm_cm_split.toString()))) {
				instJson.put("pm_cm_split", tpm_cm_split);
			}
			JSONArray ipm_pa_non_content = (JSONArray) instJson.get("pm_pa_non_content");
			JSONArray tpm_pa_non_content = (JSONArray) tmpJson.get("pm_pa_non_content");
			if ((ipm_pa_non_content != null) && (tpm_pa_non_content != null)
					&& ("[]".equals(ipm_pa_non_content.toString())) && (!"[]".equals(tpm_pa_non_content.toString()))) {
				instJson.put("pm_pa_non_content", tpm_pa_non_content);
			}
			JSONArray ipm_pa_non_paycostdtl = (JSONArray) instJson.get("pm_pa_non_paycostdtl");
			JSONArray tpm_pa_non_paycostdtl = (JSONArray) tmpJson.get("pm_pa_non_paycostdtl");
			if ((ipm_pa_non_paycostdtl != null) && (tpm_pa_non_paycostdtl != null)
					&& ("[]".equals(ipm_pa_non_paycostdtl.toString()))
					&& (!"[]".equals(tpm_pa_non_paycostdtl.toString()))) {
				instJson.put("pm_pa_non_paycostdtl", tpm_pa_non_paycostdtl);
			}
			JSONArray ipm_pa_non_rsplan = (JSONArray) instJson.get("pm_pa_non_rsplan");
			JSONArray tpm_pa_non_rsplan = (JSONArray) tmpJson.get("pm_pa_non_rsplan");
			if ((ipm_pa_non_rsplan != null) && (tpm_pa_non_rsplan != null)
					&& ("[]".equals(ipm_pa_non_rsplan.toString())) && (!"[]".equals(tpm_pa_non_rsplan.toString()))) {
				instJson.put("pm_pa_non_rsplan", tpm_pa_non_rsplan);
			}
			instForm = instJson.toString();
			formInst.setJsonData(instForm);
			this.bpmFormInstManager.update(formInst);
		}
	}

	@RequestMapping({ "selectTemplate" })
	public ModelAndView selectTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tenantId = ContextUtil.getCurrentTenantId();
	    String catKey = request.getParameter("catKey");
		String solKey = request.getParameter("solKey");
		String instId = request.getParameter("instId");
		/*String billType = request.getParameter("billType");
		String sql="select * from W_PROBASECONFIG_ZB where 1=1 ";
		if(StringUtil.isNotEmpty(billType)) {
			sql += " and F_BILLTYPE="+billType;
		}
		SqlModel sqlModel=new SqlModel(sql);
		Map<String,Object> row=(Map<String,Object>) commonDao.queryForMap(sqlModel);
		catKey=(String) row.get("");
		solKey=(String) row.get("");
		*/
		
		if (StringUtils.isNotEmpty(instId)) {
			BpmInst bpmInst = (BpmInst) this.bpmInstManager.get(instId);
			if (bpmInst != null && (bpmInst.getCreateBy().equals(ContextUtil.getCurrentUserId()))) {
				if ("RUNNING".equals(bpmInst.getStatus())) {
					List<BpmTask> bpmTasks = this.bpmTaskManager.getByActInstId(bpmInst.getActInstId());

					List<ActNodeDef> endNodeDefs = this.actRepService.getStartFlowUserNodes(bpmInst.getActDefId(),
							false);
					for (ActNodeDef def : endNodeDefs) {
						for (BpmTask t : bpmTasks) {
							if (def.getNodeId().equals(t.getTaskDefKey())) {
								response.sendRedirect(
										request.getContextPath() + "/bpm/core/bpmTask/toStart.do?taskId=" + t.getId());
								return null;
							}
						}
					}
			}
		}
		}
		JSONObject obj = new JSONObject();
		if ((StringUtils.isEmpty(catKey)) || (!"null".equals(catKey)))
	    {
	      List<SysTree> sysTrees = new ArrayList();
	      SysTree sysTreeStartToFind = this.sysTreeManager.getByKey(catKey, "BPM_TEMPLATE_TREE", tenantId);
	      sysTrees.add(sysTreeStartToFind);
	      MyInteger myInteger = new MyInteger();
	      myInteger.setId(1);
	      List<VirtualBpmNode> myVirtualBpmNodes = new ArrayList<VirtualBpmNode>();
	      for (SysTree sysTree : sysTrees) {
	        if ((sysTree != null) && (sysTree.getParentId() != null))
	        {
	          String treeId = sysTree.getTreeId();
	          
	          VirtualBpmNode virtualBpmNode = new VirtualBpmNode();
	          virtualBpmNode.setId(0);
	          virtualBpmNode.setTreeId(treeId);
	          virtualBpmNode.setParentId(sysTree.getParentId());
	          virtualBpmNode.setLabel(sysTree.getName());
	          if (this.sysTreeManager.getByParentId(treeId).size() > 0)
	          {
	            virtualBpmNode.setSonNum(this.sysTreeManager.getByParentId(treeId).size());
	            virtualBpmNode.setType("folder");
	          }
	          else
	          {
	            virtualBpmNode.setType("link");
	          }
	          myVirtualBpmNodes.add(virtualBpmNode);
	          putTheSonToTheList(myVirtualBpmNodes, null, treeId, myInteger);
	        }
	      }
	      for (VirtualBpmNode virtualBpmNode : myVirtualBpmNodes)
	      {
	        VirtualNodeList virtualNodeList = new VirtualNodeList();
	        virtualNodeList.setId(virtualBpmNode.getId());
	        
	        JSONArray arr = new JSONArray();
	        for (VirtualBpmNode virtualBpmNode2 : myVirtualBpmNodes) {
	          if (virtualBpmNode.getTreeId().equals(virtualBpmNode2.getParentId()))
	          {
	            JSONObject o = JSONObject.parseObject(JSONObject.toJSONString(virtualBpmNode2));
	            arr.add(o);
	          }
	        }
	        obj.put(String.valueOf(virtualBpmNode.getId()), arr);
	      }
	    }
		if (StringUtils.isNotEmpty(solKey)) {
			BpmSolution bpmSolution = this.bpmSolutionManager.getByKey(solKey, "1");
			if (bpmSolution == null) {
				return getPathView(request).addObject("instId", instId).addObject("showNode", obj.toString());
			}
			String url = request.getContextPath() + "/bpm/core/bpmInst/start.do?solId="
					+ bpmSolution.getSolId() + "&tmpInstId=" + instId + "&from=template";
			response.sendRedirect(url);
			return null;
		}
		return getPathView(request).addObject("instId", instId).addObject("showNode", obj.toString());
	}
	
	public void putTheSonToTheList(List<VirtualBpmNode> virtualBpmNodes, VirtualBpmNode thisVirtualBpmNode, String treeId, MyInteger myInteger)
	  {
	    List<SysTree> sysTrees = this.sysTreeManager.getByParentId(treeId);
	    String userId = ContextUtil.getCurrentUserId();
	    List<OsGroup> osGroups = this.osGroupManager.getBelongGroups(userId);
	    for (SysTree sysTree : sysTrees)
	    {
	      VirtualBpmNode virtualBpmNode = new VirtualBpmNode();
	      String thisSysTreeId = sysTree.getTreeId();
	      virtualBpmNode.setId(myInteger.getId());
	      myInteger.setId(myInteger.getId() + 1);
	      
	      virtualBpmNode.setLabel(sysTree.getName());
	      virtualBpmNode.setParentId(treeId);
	      if (this.sysTreeManager.getByParentId(thisSysTreeId).size() > 0)
	      {
	        virtualBpmNode.setType("folder");
	        virtualBpmNode.setSonNum(this.sysTreeManager.getByParentId(thisSysTreeId).size());
	      }
	      else
	      {
	        virtualBpmNode.setType("link");
	        String bindSol = sysTree.getBindSolId();
	        if (StringUtils.isNotEmpty(bindSol)) {
	          virtualBpmNode.setUrl(bindSol);
	        } else {
	          virtualBpmNode.setUrl(null);
	        }
	      }
	      virtualBpmNode.setTreeId(thisSysTreeId);
	      if ("link".equals(virtualBpmNode.getType()))
	      {
	        String thistreeId = virtualBpmNode.getTreeId();
	        BpmSolTemplateRight bpmSolTemplateRight = this.bpmSolTemplateRightManager.getByTreeId(thistreeId);
	        if (bpmSolTemplateRight != null) {
	          if ("NO".equals(bpmSolTemplateRight.getIsAll()))
	          {
	            String userIds = bpmSolTemplateRight.getUserIds();
	            if ((StringUtils.isNotBlank(userIds)) && 
	              (userIds.contains(userId)) && 
	              (!virtualBpmNodes.contains(virtualBpmNode))) {
	              virtualBpmNodes.add(virtualBpmNode);
	            }
	            String groupIds = bpmSolTemplateRight.getGroupIds();
	            if (StringUtils.isNotBlank(groupIds)) {
	              for (OsGroup osGroup : osGroups) {
	                if (groupIds.contains(osGroup.getGroupId()))
	                {
	                  if (virtualBpmNodes.contains(virtualBpmNode)) {
	                    break;
	                  }
	                  virtualBpmNodes.add(virtualBpmNode);
	                  
	                  break;
	                }
	              }
	            }
	          }
	          else if ("YES".equals(bpmSolTemplateRight.getIsAll()))
	          {
	            virtualBpmNodes.add(virtualBpmNode);
	          }
	        }
	      }
	      else if ("folder".equals(virtualBpmNode.getType()))
	      {
	        virtualBpmNodes.add(virtualBpmNode);
	        putTheSonToTheList(virtualBpmNodes, thisVirtualBpmNode, thisSysTreeId, myInteger);
	      }
	    }
	  }
}
