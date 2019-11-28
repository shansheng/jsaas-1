package com.redxun.bpm.core.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.entity.ActivityNode;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmRemindDef;
import com.redxun.bpm.core.entity.BpmSolCtl;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmSolutionExt;
import com.redxun.bpm.core.entity.BpmTestSol;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmRemindDefManager;
import com.redxun.bpm.core.manager.BpmSolCtlManager;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.BpmSolUserManager;
import com.redxun.bpm.core.manager.BpmSolUsergroupManager;
import com.redxun.bpm.core.manager.BpmSolVarManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTestSolManager;
import com.redxun.bpm.core.manager.SolutionExpImpManager;
import com.redxun.bpm.enums.ProcessVarType;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.integrate.manager.BpmModuleBindManager;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.IJson;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.dao.SysBoAttrDao;
import com.redxun.sys.bo.dao.SysBoDefDao;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;
import com.thoughtworks.xstream.XStream;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 流程业务解决方案管理
 * 
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2016-2017 @Copyright (c) 2016-2017 广州红迅软件有限公司（http://www.redxun.cn） 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmSolution/")
public class BpmSolutionController extends TenantListController {
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmDefManager bpmDefManager;
	@Resource
	IJson iJson;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	ActRepService actRepService;
	@Resource
	BpmSolFvManager bpmSolFvManager;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmSolVarManager bpmSolVarManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmTestSolManager bpmTestSolManager;
	@Resource
	BpmSolUserManager bpmSolUserManager;
	@Resource
	BpmSolUsergroupManager bpmSolUserGroupManager;
	@Resource
	BpmRemindDefManager bpmRemindDefManager;

	@Resource
	BpmModuleBindManager bpmModuleBindManager;
	@Resource
	RepositoryService repositoryService;
	@Resource
	BpmSolCtlManager bpmSolCtlManager;
	@Resource
	SysBoDefDao boDefDao;
	@Resource
	SysBoAttrDao sysBoAttrDao;
	
	@Resource
	UserService userService;
	@Resource
	GroupService groupService;
	@Resource
	SolutionExpImpManager solutionExpImpManager;
	@Resource
	SysBoDefManager sysBoDefManager;
	@Resource
	SysBoEntManager sysBoEntManager;

	@Resource
	BpmFormRightManager bpmFormRightManager;
	
	
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		// 查找分类下的模型
		return queryFilter;
	}

	/**
	 * 流程解决方案删除
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("del")
	@ResponseBody
	@LogEnt(action = "del", module = "流程", submodule = "流程解决方案")
	public JsonResult del(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String uId = request.getParameter("ids");
		StringBuffer sb = new StringBuffer();
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				int counts = bpmInstManager.getCountsBySolId(id);
				if (counts > 0) {
					BpmSolution solution = bpmSolutionManager.get(id);
					sb.append("流程解决方案【").append(solution.getName()).append("】已经存在运行实例，不允许删除！");
				} else {
					bpmSolutionManager.delete(id);
					bpmModuleBindManager.delBySolId(id);
					sb.append("成功删除!");
				}
			}
		}
		return new JsonResult(true, sb.toString());
	}
	
	@RequestMapping("getTableNameByKey")
    @ResponseBody
    public JsonResult getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String key=RequestUtil.getString(request, "key");
    	String boDefId=RequestUtil.getString(request, "boDefId");
    	
    	BpmSolution solution = bpmSolutionManager.getByKey(key, ContextUtil.getCurrentTenantId());
    	//子流程业务实体数据
    	List<SysBoEnt> subList = sysBoEntManager.getEntitiesByBoDefId(solution.getBoDefId());
    	//主流程业务实体数据
    	List<SysBoEnt> mainList = sysBoEntManager.getEntitiesByBoDefId(boDefId);
    	com.alibaba.fastjson.JSONObject obj = new com.alibaba.fastjson.JSONObject();
    	obj.put("subList", subList);
    	obj.put("mainList", mainList);
    	
    	return new JsonResult(true,"获取成功",obj);
    }

	/**
	 * 进入解决方案中的流程变量处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("vars")
	public ModelAndView vars(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		//获得有效的绑定的节点Id
		BpmDef bpmDef = bpmDefManager.getByActDefId(actDefId);
		
		return getPathView(request).addObject("bpmDef", bpmDef).addObject(
				"bpmSolution", bpmSolution);
	}

	/**
	 * 获得前置的节点数
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("getPreNodes")
	@ResponseBody
	public List<ActivityNode> getPreNodes(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String nodeId = request.getParameter("nodeId");
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		//获得有效的绑定流程定义
		BpmDef bpmDef = bpmDefManager.getValidBpmDef(actDefId, bpmSolution.getActDefId());
		
		ProcessDefinition processDef = repositoryService.getProcessDefinition(bpmDef.getActDefId());
		ProcessDefinitionEntity processDefEntity = (ProcessDefinitionEntity) processDef;

		PvmActivity activityImpl = processDefEntity.findActivity(nodeId);

		List<ActivityNode> activityNodes = new ArrayList<ActivityNode>();
		if (activityImpl != null) {
			List<PvmTransition> pts = activityImpl.getIncomingTransitions();
			for (PvmTransition pt : pts) {
				PvmActivity act = pt.getSource();
				String id = act.getId();
				String nodeName = (String) act.getProperty("name");
				String nodeType = (String) act.getProperty("type");
				activityNodes.add(new ActivityNode(id, nodeName, nodeType, ""));
			}
		}
		return activityNodes;
	}

	/**
	 * 跳至表达式编辑器
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("expEditor")
	public ModelAndView expEditor(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		List<BpmSolVar> vars = bpmSolVarManager.getBySolIdActDefId(solId, actDefId);
		// 加上默认的流程变量
		for(ProcessVarType type:ProcessVarType.values()){
			String key="vars."+type.getKey();
			if("variables".equals(type.getKey())) {
				key = "vars";
			}
			BpmSolVar varDef = new BpmSolVar(type.getName(), key,BpmSolVar.TYPE_STRING, BpmSolVar.SCOPE_PROCESS);
			vars.add(varDef);
		}
		return getPathView(request).addObject("instVars", vars);
	}

	/**
	 * 授权处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("grant")
	public ModelAndView grant(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		ModelAndView v = getPathView(request);
		
		//阅读权限
		List<BpmSolCtl> bpmSolCtlsRead=bpmSolCtlManager.getBySolIdAndType(solId,"READ");
		if(bpmSolCtlsRead.size()>0){//如果之前有记录读的权限的话
			if("ALL".equals(bpmSolCtlsRead.get(0).getRight())){//如果读权限是ALL的话
				v.addObject("readUserNames", "");
				v.addObject("readUserIds", "");
				v.addObject("readGroupNames", "");
				v.addObject("readGroupIds", "");
				v.addObject("grantReadAllOrNot", 0);
			}else{
				String userIds=bpmSolCtlsRead.get(0).getUserIds();
				String groupIds=bpmSolCtlsRead.get(0).getGroupIds();
				if(StringUtils.isNotEmpty(userIds)){//假如有read权限的userIds
					Map<String, String> map = getNameByIds(userIds);
					String userNames=map.get("userNames");
					userIds=map.get("userIds");
					
					v.addObject("readUserNames", userNames.toString());
					v.addObject("readUserIds", userIds);
					v.addObject("grantReadAllOrNot", 1);
				}else{
					v.addObject("readUserNames", "");
					v.addObject("readUserIds", "");
					v.addObject("grantReadAllOrNot", 1);
				}/////////////////////////////////////////////
				if(StringUtils.isNotEmpty(groupIds)){//假如有read权限的userIds
					Map<String, String> map = getGroupNameByIds(groupIds);
					String groupNames=map.get("groupNames");
					groupIds=map.get("groupIds");
					
					v.addObject("readGroupNames", groupNames.toString());
					v.addObject("readGroupIds", groupIds);
					v.addObject("grantReadAllOrNot", 1);
				}else{
					v.addObject("readGroupNames", "");
					v.addObject("readGroupIds", "");
					v.addObject("grantReadAllOrNot", 1);
				}
			}
			v.addObject("alowReadStartor", bpmSolCtlsRead.get(0).getAllowStartor());
			v.addObject("alowReadAttend", bpmSolCtlsRead.get(0).getAllowAttend());
		}else {//若无记录读的权限则分配ALL
			v.addObject("grantReadAllOrNot", 0);
			v.addObject("alowReadStartor", "false");
		}
		
		
		//附件下载权限
		List<BpmSolCtl> bpmSolCtlsADown=bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "DOWN");
		if(bpmSolCtlsADown.size()>0){
			if("ALL".equals(bpmSolCtlsADown.get(0).getRight())){
				v.addObject("ADownUserNames", "");
				v.addObject("ADownUserIds", "");
				v.addObject("ADownGroupNames", "");
				v.addObject("ADownUserIds", "");
			}else{
				String userIds=bpmSolCtlsADown.get(0).getUserIds();
				String groupIds=bpmSolCtlsADown.get(0).getGroupIds();
				if(StringUtils.isNotEmpty(userIds)){//假如有read权限的userIds
					Map<String, String> map = getNameByIds(userIds);
					String userNames=map.get("userNames");
					userIds=map.get("userIds");
					
					v.addObject("ADownUserNames", userNames.toString());
					v.addObject("ADownUserIds", userIds);
				}else{
					v.addObject("ADownUserNames", "");
					v.addObject("ADownUserIds", "");
				}/////////////////////////////////////////////
				if(StringUtils.isNotEmpty(groupIds)){//假如有read权限的userIds
					Map<String, String> map = getGroupNameByIds(groupIds);
					String groupNames=map.get("groupNames");
					groupIds=map.get("groupIds");
					
					v.addObject("ADownGroupNames", groupNames);
					v.addObject("ADownGroupIds", groupIds);
				}else{
					v.addObject("ADownGroupNames", "");
					v.addObject("ADownGroupIds", "");
				}
			}
			v.addObject("alowAttachDownStartor", bpmSolCtlsADown.get(0).getAllowStartor());
		}else{
			v.addObject("ADownGroupNames", "");
			v.addObject("ADownGroupIds", "");
			v.addObject("ADownGroupNames", "");
			v.addObject("ADownGroupIds", "");
			v.addObject("alowAttachDownStartor", "false");
		}
		
		////////////////////////////////////////////
		//附件打印权限
				List<BpmSolCtl> bpmSolCtlsAPrint=bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "PRINT");
				if(bpmSolCtlsAPrint.size()>0){
					if("ALL".equals(bpmSolCtlsAPrint.get(0).getRight())){
						v.addObject("APrintUserNames", "");
						v.addObject("APrintUserIds", "");
						v.addObject("APrintGroupNames", "");
						v.addObject("APrintGroupIds", "");
					}else{
						String userIds=bpmSolCtlsAPrint.get(0).getUserIds();
						String groupIds=bpmSolCtlsAPrint.get(0).getGroupIds();
						if(StringUtils.isNotEmpty(userIds)){//假如有read权限的userIds
							Map<String, String> map = getNameByIds(userIds);
							String userNames=map.get("userNames");
							userIds=map.get("userIds");
							
							v.addObject("APrintUserNames", userNames.toString());
							v.addObject("APrintUserIds", userIds);
						}else{
							v.addObject("APrintUserNames", "");
							v.addObject("APrintUserIds", "");
						}/////////////////////////////////////////////
						if(StringUtils.isNotEmpty(groupIds)){//假如有read权限的userIds
							Map<String, String> map = getGroupNameByIds(groupIds);
							String groupNames=map.get("groupNames");
							groupIds=map.get("groupIds");
							
							v.addObject("APrintGroupNames", groupNames.toString());
							v.addObject("APrintGroupIds", groupIds);
						}else{
							v.addObject("APrintGroupNames", "");
							v.addObject("APrintGroupIds", "");
						}
					}
					v.addObject("alowAttachPrintStartor", bpmSolCtlsAPrint.get(0).getAllowStartor());
				}else{
					v.addObject("APrintGroupNames", "");
					v.addObject("APrintGroupIds", "");
					v.addObject("APrintGroupNames", "");
					v.addObject("APrintGroupIds", "");
					v.addObject("alowAttachPrintStartor", "false");
				}

				
		
		return v.addObject("bpmSolution", bpmSolution);
	}

	
	
	private Map<String, String> getGroupNameByIds(String groupIds) {
		List<String> listGroupId=new ArrayList<String>();
		List<String> listGroupName=new ArrayList<String>();
		String[] aryGroupId=groupIds.split(",");
		for (String groupId : aryGroupId) {
			IGroup group=groupService.getById(groupId);
			if(group!=null){
				listGroupId.add(groupId);
				listGroupName.add(group.getIdentityName());
			}
		}
		Map<String, String> map=new HashMap<String, String>();
		map.put("groupIds", StringUtil.join(listGroupId, ","));
		map.put("groupNames", StringUtil.join(listGroupName, ","));
		
		return map;
	}

	
	
	private Map<String, String> getNameByIds(String userIds) {
		List<String> listUserId=new ArrayList<String>();
		List<String> listUserName=new ArrayList<String>();
		String[] aryUserId=userIds.split(",");
		for (String userId : aryUserId) {
			IUser osUser=userService.getByUserId(userId);
			if(osUser!=null){
				listUserId.add(userId);
				listUserName.add(osUser.getFullname());
			}
		}
		Map<String, String> map=new HashMap<String, String>();
		map.put("userIds", StringUtil.join(listUserId, ","));
		map.put("userNames", StringUtil.join(listUserName, ","));
		
		return map;
	}

	/**
	 * 保存授权
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveGrant")
	@ResponseBody
	@LogEnt(action = "saveGrant", module = "流程", submodule = "流程解决方案")
	public JsonResult saveGrant(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String grantType = request.getParameter("grantType");
		
		String printAuserIds = request.getParameter("printAuserIds");// 打印权限
		String printAgroupIds = request.getParameter("printAgroupIds");
		String downAuserIds = request.getParameter("downAuserIds");// 下载权限
		String downAgroupIds = request.getParameter("downAgroupIds");

		String alowAttachPrintStartor = request.getParameter("alowAttachPrintStartor");

		String alowAttachDownStartor = request.getParameter("alowAttachDownStartor");

		String readGrantType = request.getParameter("readGrantType");
		String ruserIds = request.getParameter("ruserIds");// 阅读权限用户
		String rgroupIds = request.getParameter("rgroupIds");

		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
//		bpmSolution.setGrantType(new Short(grantType));
		bpmSolutionManager.update(bpmSolution);
		
		
		//////////////////////////////////////////////////////////////////
		BpmSolCtl bpmSolCtl;
		if (bpmSolCtlManager.getBySolIdAndType(solId, "READ").size() > 0) {// 如果有相应的bpmSolCtl存在则更新否则创建
			bpmSolCtl = bpmSolCtlManager.getBySolIdAndType(solId, "READ").get(0);
		} else {
			bpmSolCtl = new BpmSolCtl();
			bpmSolCtl.setRightId(idGenerator.getSID());
			bpmSolCtl.setCreateBy(ContextUtil.getCurrentUserId());
			bpmSolCtl.setCreateTime(new Date());
			bpmSolCtl.setSolId(solId);
		}
		bpmSolCtl.setType("READ");
		if ("0".equals(readGrantType)) {// 阅读权限范围选择了公共
			bpmSolCtl.setRight("ALL");
			bpmSolCtl.setUserIds(null);
			bpmSolCtl.setGroupIds(null);
		} else {
			bpmSolCtl.setGroupIds(rgroupIds);
			bpmSolCtl.setUserIds(ruserIds);
			bpmSolCtl.setRight("LIMIT");
		}
		bpmSolCtlManager.saveOrUpdate(bpmSolCtl);// 保存阅读权限的bpmSolCtl实体

		
		////////////////////////////////////////////////////////////
		BpmSolCtl bpmSolCtlAttachPrint;// 附件的PRINT权限
		if (bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "PRINT").size() > 0) {// 如果有相应的bpmSolCtl存在则更新否则创建
			bpmSolCtlAttachPrint = bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "PRINT").get(0);
		}  else if(bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "ALL").size()>0){
			bpmSolCtlAttachPrint=bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "ALL").get(0);
		}else {
			bpmSolCtlAttachPrint = new BpmSolCtl();
			bpmSolCtlAttachPrint.setRightId(idGenerator.getSID());
			bpmSolCtlAttachPrint.setCreateBy(ContextUtil.getCurrentUserId());
			bpmSolCtlAttachPrint.setCreateTime(new Date());
			bpmSolCtlAttachPrint.setSolId(solId);
		}
			bpmSolCtlAttachPrint.setType("FILE");
		if (StringUtils.isEmpty(printAuserIds)&&(StringUtils.isEmpty(printAgroupIds))) {// 附件权限范围选择了公共
			bpmSolCtlAttachPrint.setAllowStartor(alowAttachPrintStartor);
			bpmSolCtlAttachPrint.setRight("PRINT");
			bpmSolCtlAttachPrint.setUserIds(null);
			bpmSolCtlAttachPrint.setGroupIds(null);
		} else {
			bpmSolCtlAttachPrint.setRight("PRINT");
			bpmSolCtlAttachPrint.setAllowStartor(alowAttachPrintStartor);
			bpmSolCtlAttachPrint.setGroupIds(printAgroupIds);
			bpmSolCtlAttachPrint.setUserIds(printAuserIds);
		}
		bpmSolCtlManager.saveOrUpdate(bpmSolCtlAttachPrint);
		// //////////////////////////////////////////////////////////
		BpmSolCtl bpmSolCtlAttachDown;// 附件的DOWN权限
		if (bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "DOWN").size() > 0) {// 如果有相应的bpmSolCtl存在则更新否则创建
			bpmSolCtlAttachDown = bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "DOWN").get(0);
		}  else if(bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "ALL").size()>0){
			bpmSolCtlAttachDown=bpmSolCtlManager.getBySolAndTypeAndRight(solId, "FILE", "ALL").get(0);
		}else {
			bpmSolCtlAttachDown = new BpmSolCtl();
			bpmSolCtlAttachDown.setRightId(idGenerator.getSID());
			bpmSolCtlAttachDown.setCreateBy(ContextUtil.getCurrentUserId());
			bpmSolCtlAttachDown.setCreateTime(new Date());
			bpmSolCtlAttachDown.setSolId(solId);
		}
			bpmSolCtlAttachDown.setType("FILE");
		if (StringUtils.isEmpty(downAuserIds)&&(StringUtils.isEmpty(downAgroupIds))) {// 附件权限范围选择了公共
			bpmSolCtlAttachDown.setAllowStartor(alowAttachDownStartor);
			bpmSolCtlAttachDown.setRight("DOWN");
			bpmSolCtlAttachDown.setUserIds(null);
			bpmSolCtlAttachDown.setGroupIds(null);
		} else {
			bpmSolCtlAttachDown.setRight("DOWN");
			bpmSolCtlAttachDown.setAllowStartor(alowAttachDownStartor);
			bpmSolCtlAttachDown.setGroupIds(downAgroupIds);
			bpmSolCtlAttachDown.setUserIds(downAuserIds);
		}
		bpmSolCtlManager.saveOrUpdate(bpmSolCtlAttachDown);

		return new JsonResult(true, "成功保存授权");
	}

	@RequestMapping("delScopeVars")
	@ResponseBody
	@LogEnt(action = "delScopeVars", module = "流程", submodule = "流程解决方案")
	public JsonResult delScopeVars(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String varIds = request.getParameter("varIds");
		if (StringUtils.isNotEmpty(varIds)) {
			String[] vIds = varIds.split("[,]");
			for (String id : vIds) {
				bpmSolVarManager.delete(id);
			}
		}
		return new JsonResult(true, "成功删除变量！");
	}

	/**
	 * 流程解决方案中的模型的字段
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("modelFields")
	@ResponseBody
	public List<BpmSolVar> modelFields(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String boDefId=request.getParameter("boDefId");
		SysBoDef def = sysBoDefManager.get(boDefId);
		List<BpmSolVar> vars = new ArrayList<BpmSolVar>();		
		List<BpmFormView> bpmFormViews = bpmFormViewManager.getByBoId(boDefId);
		if (BeanUtil.isEmpty(bpmFormViews))  return vars;
		
		List<SysBoAttr> boAttrs= sysBoAttrDao.getByBoDefId(boDefId);
		for(SysBoAttr attr:boAttrs){
			BpmSolVar var = new BpmSolVar(attr.getComment(), attr.getName());
			var.setFormField(def.getAlais()+"."+attr.getName());
			vars.add(var);
		}
		return vars;
	}
	
	/**
	 * 流程解决方案中的模型的字段
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("boDefFields")
	@ResponseBody
	public List<SysBoDef> boDefFields(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		List<SysBoDef> vars = new ArrayList<SysBoDef>();
		BpmSolution sol = bpmSolutionManager.get(solId);
		String bodefIds = sol.getBoDefId();
		if(StringUtil.isEmpty(bodefIds)) return vars;
		String[] ids = bodefIds.split(",");
		for(String id:ids){
			SysBoDef def = sysBoDefManager.get(id);
			vars.add(def);
		}
		return vars;
	}
	
	
	@RequestMapping("getFormFields")
	@ResponseBody
	public List<KeyValEnt<String>> getFormFields(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		List<KeyValEnt<String>> vars = new ArrayList<>();
		BpmSolution sol = bpmSolutionManager.get(solId);
		String bodefIds = sol.getBoDefId();
		if(StringUtil.isEmpty(bodefIds)) return vars;
		String[] ids = bodefIds.split(",");
		for(String boDefId:ids){
			SysBoDef def = sysBoDefManager.get(boDefId);
			List<SysBoAttr> boAttrs= sysBoAttrDao.getByBoDefId(boDefId);
			for(SysBoAttr attr:boAttrs){
				String key=def.getAlais()+"."+attr.getName();
				vars.add(new KeyValEnt<String>(key, attr.getComment()));
			}
		}
		vars.add(new KeyValEnt<String>("processName", "流程方案名称"));
		vars.add(new KeyValEnt<String>("createTime", "创建时间"));
		vars.add(new KeyValEnt<String>("createUser", "创建人"));
		vars.add(new KeyValEnt<String>("curDate", "创建日期"));
	
		return vars;
	}
	

	/**
	 * 获得该流程方案下的测试方案
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listTestSolsBySolIdActDefId")
	@ResponseBody
	public JsonPageResult<BpmTestSol> listTestSolsBySolIdActDefId(
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		Page page = QueryFilterBuilder.createPage(request);
		List<BpmTestSol> solList = bpmTestSolManager.getBySolIdActDefId(solId, actDefId,page);
		return new JsonPageResult<BpmTestSol>(solList, page.getTotalItems());
	}

	/**
	 * 发布流程解决方案
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("deploy")
	@ResponseBody
	@LogEnt(action = "deploy", module = "流程", submodule = "流程解决方案")
	public JsonResult deploy(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		bpmSolution.setStatus(BpmSolution.STATUS_DEPLOYED);

		//获得流程定义的最新的版本
		BpmDef bpmDef=null;
		if(StringUtils.isNotEmpty(actDefId)){
			bpmDef=bpmDefManager.getByActDefId(actDefId);
		}else{
			bpmDef=bpmDefManager.getLatestBpmByKey(bpmSolution.getDefKey(), ContextUtil.getCurrentTenantId());
		}
		
		if(bpmDef!=null){
			bpmSolution.setActDefId(bpmDef.getActDefId());
		}
		bpmSolutionManager.update(bpmSolution);
		return new JsonResult(true, "成功发布！");
	}

	

	/**
	 * 节点数据交互配置
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("nodeSet")
	public ModelAndView nodeSet(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mv = getPathView(request);
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		mv.addObject("bpmSolution", bpmSolution);
		
		BpmDef bpmDef = bpmDefManager.getValidBpmDef(actDefId, bpmSolution.getDefKey());
		mv.addObject("bpmDef", bpmDef);

		return mv;
	}

	/**
	 * 流程解决方案中的业务表单配置
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("formView")
	public ModelAndView formView(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		
		
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		
		String bodefId=bpmSolution.getBoDefId();
		String dataSaveMode=bpmSolution.getDataSaveMode();
		
		
		ModelAndView mv = getPathView(request);

		BpmDef bpmDef=bpmDefManager.getByActDefId(actDefId);
		
		mv.addObject("bpmDef",bpmDef);
		
		mv.addObject("bodefId", bodefId);
		mv.addObject("dataSaveMode", dataSaveMode);
		
		if(StringUtils.isNotEmpty(bodefId)){
			String[] aryBoDefId=bodefId.split(",");
			String bodefName="";
			for(int i=0;i<aryBoDefId.length;i++){
				String name=getBoName(aryBoDefId[i]);
				if(i>0){
					bodefName+=",";
				}
				bodefName+=name;
			}
			mv.addObject("bodefName", bodefName);
		}
		
		return mv.addObject("bpmSolution", bpmSolution);
	}
	
	/**
	 * 获取BO名称。
	 * @param boDefId
	 * @return
	 */
	private String getBoName(String boDefId){
		if(StringUtil.isEmpty(boDefId)) return "";
		
		SysBoDef def= boDefDao.get(boDefId);
		if(def!=null){
				return def.getName();
		}
		return "";
	}

	/**
	 * 批量保存解决方案中的变量配置
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("batchSaveVars")
	@ResponseBody
	@LogEnt(action = "batchSaveVars", module = "流程", submodule = "流程解决方案")
	public JsonResult batchSaveVars(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String varMap = request.getParameter("varMap");
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		JSONArray jsonArr = JSONArray.fromObject(varMap);
		for (int i = 0; i < jsonArr.size(); i++) {
			JSONObject obj = jsonArr.getJSONObject(i);
			String nodeId = JSONUtil.getString(obj, "nodeId");
			String nodeName = JSONUtil.getString(obj, "nodeName");
			String vars = JSONUtil.getString(obj, "vars");
			if (StringUtils.isEmpty(vars)) continue;

			JSONArray varArr = JSONArray.fromObject(vars);
			Collection<BpmSolVar> bpmSolVars = JSONArray.toCollection(varArr, BpmSolVar.class);
			for (BpmSolVar var : bpmSolVars) {
				var.setScope(nodeId);
				var.setNodeName(nodeName);
				var.setActDefId(actDefId);
				var.setSolId(solId);
				if (StringUtils.isNotEmpty(var.getVarId())) {
					BpmSolVar bpmSolVar = bpmSolVarManager.get(var.getVarId());
					BeanUtil.copyNotNullProperties(bpmSolVar, var);
					bpmSolVarManager.update(bpmSolVar);
				} else {
					bpmSolVarManager.create(var);
				}
			}
		}
		return new JsonResult(true, "批量成功保存变量！");
	}

	/**
	 * 保存流程方案中的参数配置
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveScopeVars")
	@ResponseBody
	@LogEnt(action = "saveScopeVars", module = "流程", submodule = "流程解决方案")
	public JsonResult saveScopeVars(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String nodeId = request.getParameter("nodeId");
		String nodeName = request.getParameter("nodeName");
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		String vars = request.getParameter("vars");
		JSONArray jsonArr = JSONArray.fromObject(vars);
		Collection<BpmSolVar> bpmSolVars = JSONArray.toCollection(jsonArr,BpmSolVar.class);
		//校验变量的key是否重复
		List<String> keyList=new ArrayList<String>();
		List<String> repeatKey=new ArrayList<String>();
		StringBuffer sb=new StringBuffer();
		for(BpmSolVar var : bpmSolVars){
			String key=var.getKey();
			if(keyList.contains(key)&&!repeatKey.contains(key)){
				repeatKey.add(key);
				sb.append("变量key:"+key+"存在重复,忽略保存;");
			}else{
				keyList.add(key);
			}
		}
		for (BpmSolVar var : bpmSolVars) {
			var.setScope(nodeId);
			var.setNodeName(nodeName);
			var.setActDefId(actDefId);
			var.setSolId(solId);
			//重复不保存
			if(!repeatKey.contains(var.getKey())){
				if (StringUtils.isNotEmpty(var.getVarId())) {
					BpmSolVar bpmSolVar = bpmSolVarManager.get(var.getVarId());
					BeanUtil.copyNotNullProperties(bpmSolVar, var);
					bpmSolVarManager.update(bpmSolVar);
				} else {
					var.setVarId(IdUtil.getId());
					bpmSolVarManager.create(var);
				}
			}
		}
		return new JsonResult(true, "成功保存变量配置！"+sb.toString());
	}

	/**
	 * 保存表单视图至业务流程解决方案
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveFormView")
	@ResponseBody
	@LogEnt(action = "saveFormView", module = "流程", submodule = "流程解决方案")
	public JsonResult saveFormView(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		String boDefId=request.getParameter("boDefId");
		String dataSaveMode=request.getParameter("dataSaveMode");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		bpmSolFvManager.delBySolIdActDefId(solId, actDefId);
		String gridJson = request.getParameter("gridJson");
		JSONArray arr = JSONArray.fromObject(gridJson);
		boolean supportMobile=false;
		for (int i = 0; i < arr.size(); i++) {
			JSONObject obj = arr.getJSONObject(i);
			BpmSolFv fv  =com.alibaba.fastjson.JSONObject.parseObject(obj.toString(), BpmSolFv.class);			
			String condForm = fv.getCondForms();
			String nodeId = fv.getNodeId();
			//将删除的bo对应的表单清除
			String handledCondForm =  handleCondForms(solId,nodeId,condForm,boDefId);
			fv.setCondForms(handledCondForm);
			fv.setId(IdUtil.getId());
			fv.setActDefId(actDefId);
			fv.setSolId(solId);
			if(StringUtil.isNotEmpty(fv.getMobileForms())){
				supportMobile=true;
			}
			bpmSolFvManager.create(fv);
		}
		bpmSolution.setSupportMobile(supportMobile?1:0);
		bpmSolution.setBoDefId(boDefId);
		bpmSolution.setDataSaveMode(dataSaveMode);
		bpmSolutionManager.update(bpmSolution);
		
		return new JsonResult(true, "成功保存!");
	}
	
	
	/**
	 * 将不属于boDefIds里的节点表单、权限删除
	 * @param solId 解决方案ID
	 * @param nodeId 节点ID
	 * @param condForm 节点表单的JSON数组
	 * @param boDefIds 更改后的业务模型id
	 * @return
	 */
	private String handleCondForms(String solId,String nodeId,String condForm, String boDefIds) {
		if(StringUtil.isEmpty(condForm)) return "";
		//节点表单
		JSONArray jsonArray = JSONArray.fromObject(condForm);
		JSONArray resultArray = JSONArray.fromObject(condForm);
		List<String> boDefIdList = Arrays.asList(boDefIds.split(","));
		String tenantId = ContextUtil.getCurrentTenantId();
		String aliasBindBodefId = "";		
		for(Object obj : jsonArray){
			JSONObject formJson = JSONObject.fromObject(obj);
			String formAlias = formJson.getString("formAlias");
			//根据表单别名获取boDefId
			BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(formAlias,tenantId);
			aliasBindBodefId = bpmFormView.getBoDefId();
			if(boDefIdList.contains(aliasBindBodefId))continue;
			resultArray.remove(formJson);			
			//删除表单权限
			bpmFormRightManager.delBySolAndBodefId(solId,aliasBindBodefId);
		}
		return resultArray.toString();
	}

	/**
	 * 保存单个表单视图
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveSingleFormView")
	@ResponseBody
	@LogEnt(action = "saveSingleFormView", module = "流程", submodule = "流程解决方案")
	public JsonResult saveSingleFormView(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String nodeId = request.getParameter("nodeId");
		String actDefId=request.getParameter("actDefId");
		String formViewKey = request.getParameter("formViewKey");
		BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(
				formViewKey, ContextUtil.getCurrentTenantId());
		if (bpmFormView == null) {
			bpmFormView = new BpmFormView();
		}
		BpmSolFv orgFv = bpmSolFvManager.getBySolIdActDefIdNodeId(solId, actDefId,nodeId);
		if (orgFv != null) {
			orgFv.setFormUri(bpmFormView.getKey());
			orgFv.setFormType(bpmFormView.getType());
			orgFv.setFormName(bpmFormView.getName());
			bpmSolFvManager.update(orgFv);
		} else {
			orgFv = new BpmSolFv();
			orgFv.setSolId(solId);
			orgFv.setFormUri(bpmFormView.getKey());
			orgFv.setFormType(bpmFormView.getType());
			orgFv.setFormName(bpmFormView.getName());
			orgFv.setNodeId(nodeId);
			bpmSolFvManager.create(orgFv);
		}
		return new JsonResult(true, "成功保存节点表单视图!");
	}

	/**
	 * 获得流程解决方案中的节点表单配置
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getNodeFormView")
	@ResponseBody
	public JsonPageResult<BpmSolFv> getNodeFormView(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<BpmSolFv> fvList = new ArrayList<BpmSolFv>();
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		BpmDef bpmDef = bpmDefManager.getValidBpmDef(actDefId,bpmSolution.getDefKey());

		Collection<ActNodeDef> taskDefs = actRepService.getTaskNodes(bpmDef.getActDefId());

		List<ActNodeDef> allNodeDefs = new ArrayList<ActNodeDef>();
		allNodeDefs.add(new ActNodeDef(BpmFormView.SCOPE_PROCESS, "全局","Process"));
		allNodeDefs.add(new ActNodeDef(BpmFormView.SCOPE_START, "开始", "Start"));
		allNodeDefs.add(new ActNodeDef(BpmFormView.SCOPE_DETAIL, "明细", "Detail"));
		allNodeDefs.addAll(taskDefs);
		QueryFilter queryFilter=getQueryFilter(request);
		queryFilter.addParam("solId", solId);
		queryFilter.addParam("actDefId",actDefId);
		List<BpmSolFv> solFvList = bpmSolFvManager.getBySolutionId(solId,actDefId);
		
		Map<String,BpmSolFv> fvMap= convertToMap(solFvList);
		
		for (ActNodeDef def : allNodeDefs) {
			String nodeId=def.getNodeId();
			BpmSolFv fv=fvMap.get(nodeId);
			if(fv==null){
				fv = new BpmSolFv();
				fv.setNodeId(def.getNodeId());
				fv.setFormType(BpmFormView.FORM_TYPE_ONLINE_DESIGN);
			}
			fv.setNodeText(def.getNodeName());
			
			if (!"userTask".equals(def.getNodeType())) {
				fv.setGroupTitle(def.getNodeName() + "表单");
			} else {
				fv.setGroupTitle("节点表单");
			}
			fvList.add(fv);
		}
		return new JsonPageResult<BpmSolFv>(fvList, fvList.size());
	}
	
	/**
	 * 为改变solution的bo时加载一个有数据但是数据为空的grid
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getEmptyNodeFormView")
	@ResponseBody
	public JsonPageResult<BpmSolFv> getEmptyNodeFormView(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<BpmSolFv> fvList = new ArrayList<BpmSolFv>();
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		BpmDef bpmDef = bpmDefManager.getValidBpmDef(actDefId,bpmSolution.getDefKey());

		Collection<ActNodeDef> taskDefs = actRepService.getTaskNodes(bpmDef.getActDefId());

		List<ActNodeDef> allNodeDefs = new ArrayList<ActNodeDef>();
		allNodeDefs.add(new ActNodeDef(BpmFormView.SCOPE_PROCESS, "全局","Process"));
		allNodeDefs.add(new ActNodeDef(BpmFormView.SCOPE_START, "开始", "Start"));
		allNodeDefs.add(new ActNodeDef(BpmFormView.SCOPE_DETAIL, "明细", "Detail"));
		allNodeDefs.addAll(taskDefs);
		List<BpmSolFv> solFvList = new ArrayList<BpmSolFv>();
		
		Map<String,BpmSolFv> fvMap= convertToMap(solFvList);
		
		for (ActNodeDef def : allNodeDefs) {
			String nodeId=def.getNodeId();
			BpmSolFv fv=fvMap.get(nodeId);
			if(fv==null){
				fv = new BpmSolFv();
				fv.setNodeId(def.getNodeId());
				fv.setFormType(BpmFormView.FORM_TYPE_ONLINE_DESIGN);
			}
			fv.setNodeText(def.getNodeName());
			
			if (!"userTask".equals(def.getNodeType())) {
				fv.setGroupTitle(def.getNodeName() + "表单");
			} else {
				fv.setGroupTitle("节点表单");
			}
			fvList.add(fv);
		}
		return new JsonPageResult<BpmSolFv>(fvList, fvList.size());
	}
	
	private Map<String,BpmSolFv> convertToMap(List<BpmSolFv> solFvList){
		Map<String,BpmSolFv> map=new HashMap<String, BpmSolFv>();
		for(BpmSolFv fv:solFvList){
			map.put(fv.getNodeId(), fv);
		}
		return map;
		
	}

	/**
	 * 业务流程解决方案的人员配置
	 * 
	 * @param request
	 * 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("user")
	public ModelAndView user(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		BpmDef bpmDef = bpmDefManager.getValidBpmDef(actDefId,bpmSolution.getDefKey());
		
		return getPathView(request).addObject("bpmSolution", bpmSolution)
				.addObject("bpmDef", bpmDef);
	}

	
	

	@RequestMapping("nodeForm")
	public ModelAndView nodeForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mv = getPathView(request);
		String nodeId = request.getParameter("nodeId");
		String actDefId=request.getParameter("actDefId");
		String solId = request.getParameter("solId");

		BpmSolFv fv = bpmSolFvManager.getBySolIdActDefIdNodeId(solId, actDefId, nodeId);
		BpmFormView formView = null;
		if (fv != null && StringUtils.isNotEmpty(fv.getFormUri())) {
			formView = bpmFormViewManager.getLatestByKey(fv.getFormUri(),
					ContextUtil.getCurrentTenantId());
		} else {
			formView = new BpmFormView();
		}
		mv.addObject("formView", formView);
		mv.addObject("nodeId",nodeId);
		mv.addObject("solId",solId);
    	return mv;
    }
    
    /**
     * 显示流程定义的配置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("bpmDef")
    public ModelAndView bpmDef(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	BpmSolution bpmSolution=bpmSolutionManager.get(solId);
    	ModelAndView mv=getPathView(request);
    	
    	//查看指定流程定义的版本的流程图配置
    	if(StringUtils.isNotEmpty(actDefId)){
    		BpmDef bpmDef=bpmDefManager.getByActDefId(actDefId);
    		BpmDef oldBpmDef=bpmDefManager.getByActDefId(bpmSolution.getActDefId());
    		mv.addObject("bpmDef", bpmDef);
    		mv.addObject("oldBpmDef", oldBpmDef);
    	}else{
	    	//放置新版本的流程定义
	    	if(bpmSolution!=null && StringUtils.isNotEmpty(bpmSolution.getDefKey())){
	    		BpmDef bpmDef=bpmDefManager.getLatestBpmByKey(bpmSolution.getDefKey(),ContextUtil.getCurrentTenantId());
	    		BpmDef oldBpmDef=bpmDefManager.getByActDefId(bpmSolution.getActDefId());
	    		mv.addObject("bpmDef", bpmDef);
	    		mv.addObject("oldBpmDef", oldBpmDef);
	    	}
    	}
    	
    	return mv.addObject("bpmSolution", bpmSolution);
    }
    
    /**
     * 显示流程图
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("showDef")
    public ModelAndView showDef(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	BpmSolution bpmSolution=bpmSolutionManager.get(solId);
    	ModelAndView mv=getPathView(request);
    	BpmDef bpmDef=bpmDefManager.getValidBpmDef(actDefId,bpmSolution.getDefKey());
		mv.addObject("bpmDef", bpmDef);
    	return mv.addObject("bpmSolution", bpmSolution);
    }
    
    /**
     * 显示流程图
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("showDefInOnePage")
    @ResponseBody
    public JsonResult showDefInOnePage(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	BpmSolution bpmSolution=bpmSolutionManager.get(solId);
    	
    	BpmDef bpmDef=bpmDefManager.getValidBpmDef(actDefId,bpmSolution.getDefKey());
    	String defId = bpmDef.getActDefId();
		return new JsonResult(true,"",defId);
    	
    }
    
    /**
     * 保存流程定义设置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("saveBpmDef")
    @ResponseBody
    @LogEnt(action = "saveBpmDef", module = "流程", submodule = "流程解决方案")
    public JsonResult saveBpmDef(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String defKey=request.getParameter("defKey");
    	BpmSolution bpmSolution=bpmSolutionManager.get(solId);
    	bpmSolution.setDefKey(defKey);
    	bpmSolutionManager.saveOrUpdate(bpmSolution);
    	return new JsonResult(true,"成功保存流程定义配置");
    }
    
    /**
     * 查看明细
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("get")
    public ModelAndView get(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("pkId");
        BpmSolution bpmSolution=null;
        if(StringUtils.isNotBlank(pkId)){
           bpmSolution=bpmSolutionManager.get(pkId);
        }else{
        	bpmSolution=new BpmSolution();
        }
        return getPathView(request).addObject("bpmSolution",bpmSolution);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	ModelAndView mv= getPathView(request);
    	BpmSolution bpmSolution=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmSolution=bpmSolutionManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmSolution.setSolId(null);
    		}
    		
    		if(StringUtils.isNotEmpty(bpmSolution.getDefKey())){
    			BpmDef bindBpmDef=bpmDefManager.getLatestBpmByKey(bpmSolution.getDefKey(), ContextUtil.getCurrentTenantId());
    			mv.addObject("bindBpmDef",bindBpmDef);
    		}
    		
    		if(StringUtils.isNotEmpty(bpmSolution.getActDefId())){
    			BpmDef mainBpmDef=bpmDefManager.getByActDefId(bpmSolution.getActDefId());
    			mv.addObject("bpmDef",mainBpmDef);
    		} 
    	}else{
    		bpmSolution=new BpmSolution();
    	}
    	return mv.addObject("bpmSolution",bpmSolution);
    }
    
    /**
     * 从主版本拷贝配置属性
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("copyConfig")
    @ResponseBody
    @LogEnt(action = "copyConfig", module = "流程", submodule = "流程解决方案")
    public JsonResult copyConfig(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	BpmSolution bpmSolution=bpmSolutionManager.get(solId);
    	
    	if(StringUtils.isEmpty(bpmSolution.getActDefId())){
    		return new JsonResult(true,"主版本配置不存在！");
    	}
    	//清除原来的配置
    	bpmNodeSetManager.delBySolIdActDefId(solId, actDefId);
    	bpmSolUserGroupManager.delBySolIdActDefId(solId, actDefId);
    	bpmSolFvManager.delBySolIdActDefId(solId, actDefId);
    	bpmSolVarManager.delBySolIdActDefId(solId, actDefId);
    	bpmRemindDefManager.delBySolIdActDefId(solId, actDefId);

    	//拷贝新的配置至BpmNodeSet表中,BpmSolUser表中
		List<BpmNodeSet> bpmNodeSets= bpmNodeSetManager.getBySolIdActDefId(solId,bpmSolution.getActDefId());
		List<BpmSolUsergroup> bpmSolUserGroups = bpmSolUserGroupManager.getBySolActDefId(solId, bpmSolution.getActDefId());
		List<BpmSolFv> bpmSolFvs=bpmSolFvManager.getBySolIdActDefId(solId,bpmSolution.getActDefId());
		List<BpmSolVar> bpmSolVars=bpmSolVarManager.getBySolIdActDefId(solId, bpmSolution.getActDefId());
		List<BpmRemindDef> bpmRemindDefs=bpmRemindDefManager.getBySolId(solId, bpmSolution.getActDefId());
		Collection<ActivityNode> nodes= actRepService.getProcessNodes(bpmSolution.getActDefId());

		for(ActivityNode node:nodes){
			for(BpmNodeSet nodeSet:bpmNodeSets){
				if(node.getActivityId().equals(nodeSet.getNodeId())){
					BpmNodeSet newBpmNodeSet=new BpmNodeSet();
					BeanUtil.copyProperties(newBpmNodeSet, nodeSet);
					newBpmNodeSet.setSetId(IdUtil.getId());
					newBpmNodeSet.setActDefId(actDefId);
					bpmNodeSetManager.create(newBpmNodeSet);
				}
			}
			for(BpmSolUsergroup solUsergroup:bpmSolUserGroups){
				if(node.getActivityId().equals(solUsergroup.getNodeId())){
					BpmSolUsergroup newSolUsergroup=new BpmSolUsergroup();
					BeanUtil.copyProperties(newSolUsergroup, solUsergroup);
					newSolUsergroup.setId(IdUtil.getId());
					newSolUsergroup.setActDefId(actDefId);
					bpmSolUserGroupManager.create(newSolUsergroup);
					List<BpmSolUser> solUsers = bpmSolUserManager.getByGroupId(solUsergroup.getId());
					for (BpmSolUser bpmSolUser : solUsers) {
						BpmSolUser newBpmSolUser=new BpmSolUser();
						BeanUtil.copyProperties(newBpmSolUser, bpmSolUser);
						newBpmSolUser.setId(IdUtil.getId());
						newBpmSolUser.setActDefId(actDefId);
						newBpmSolUser.setGroupId(newSolUsergroup.getId());
						bpmSolUserManager.create(newBpmSolUser);
					}
				}
			}
			for(BpmSolFv fv:bpmSolFvs){
				if(node.getActivityId().equals(fv.getNodeId())){
					BpmSolFv newFv=new BpmSolFv();
					BeanUtil.copyProperties(newFv, fv);
					newFv.setId(IdUtil.getId());
					newFv.setActDefId(actDefId);
					bpmSolFvManager.create(newFv);
				}
			}
			
			for(BpmSolVar var:bpmSolVars){
				if(node.getActivityId().equals(var.getScope())){
					BpmSolVar newVar=new BpmSolVar();
					BeanUtil.copyProperties(newVar,var);
					newVar.setVarId(IdUtil.getId());
					newVar.setActDefId(actDefId);
					bpmSolVarManager.create(newVar);
				}
			}
			
			for(BpmRemindDef def:bpmRemindDefs){
				if(node.getActivityId().equals(def.getNodeId())){
					BpmRemindDef newBpmRemindDef=new BpmRemindDef();
					BeanUtil.copyProperties(newBpmRemindDef,def);
					newBpmRemindDef.setId(IdUtil.getId());
					newBpmRemindDef.setActDefId(actDefId);
					bpmRemindDefManager.create(newBpmRemindDef);
				}
			}
		}
		
		return new JsonResult(true,"成功复制主版流程属性配置！");
    }
    
	/**
	 * 管理某个解决方案
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mgr")
	public ModelAndView mgr(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		ModelAndView mv=getPathView(request);
		
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		BpmDef bpmDef=null;
		if(StringUtils.isNotEmpty(actDefId)){
			bpmDef=bpmDefManager.getByActDefId(actDefId);
			if(!bpmSolution.getActDefId().equals(actDefId)){
				//检查该定义是否已经存在，则不存在，则从当前版本中拷
				boolean isConfigExist=bpmSolUserManager.isExistConfig(solId, actDefId);
				if(!isConfigExist){
					mv.addObject("allowCopyConfig",true);
				}
			}
		}else if(StringUtils.isNotEmpty(bpmSolution.getActDefId())){
			bpmDef=bpmDefManager.getByActDefId(bpmSolution.getActDefId());
		}else if(StringUtils.isNotEmpty(bpmSolution.getDefKey())){
			bpmDef=bpmDefManager.getLatestBpmByKey(bpmSolution.getDefKey(), ContextUtil.getCurrentTenantId());
		}
		mv.addObject("bpmDef",bpmDef);
		String treeName="";
		String treeId=bpmSolution.getTreeId();
		if(StringUtil.isNotEmpty(treeId)){
			treeName=sysTreeManager.get(treeId).getName();
		}
		// 是否绑定了流程定义
		boolean isBindFlow = StringUtils.isNotEmpty(bpmSolution.getActDefId()) ? true: false;
		return mv.addObject("bpmSolution", bpmSolution)
				.addObject("isBindFlow", isBindFlow);
	}
	
	@RequestMapping("mgrFast")
	public ModelAndView mgrFast(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		ModelAndView mv=getPathView(request);
		
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		if(bpmSolution==null) {
			bpmSolution = new BpmSolution();
			bpmSolution.setStep(0);
		}else {
			if(StringUtil.isEmpty(actDefId)){
				actDefId=bpmSolution.getActDefId();
			}
		}
		BpmDef bpmDef=null;
		if(StringUtils.isNotEmpty(actDefId)&&!"null".equals(actDefId)){
			bpmDef=bpmDefManager.getByActDefId(actDefId);
			if(!actDefId.equals(bpmSolution.getActDefId())){
				//检查该定义是否已经存在，则不存在，则从当前版本中拷
				boolean isConfigExist=bpmSolUserManager.isExistConfig(solId, actDefId);
				if(!isConfigExist){
					mv.addObject("allowCopyConfig",true);
				}
			}
		}else if(StringUtils.isNotEmpty(bpmSolution.getActDefId())){
			bpmDef=bpmDefManager.getByActDefId(bpmSolution.getActDefId());
		}else if(StringUtils.isNotEmpty(bpmSolution.getDefKey())){
			bpmDef=bpmDefManager.getLatestBpmByKey(bpmSolution.getDefKey(), ContextUtil.getCurrentTenantId());
		}
		mv.addObject("bpmDef",bpmDef);
		String treeName="";
		String treeId=bpmSolution.getTreeId();
		if(StringUtil.isNotEmpty(treeId)){
			treeName=sysTreeManager.get(treeId).getName();
		}
		// 是否绑定了流程定义
		boolean isBindFlow = StringUtils.isNotEmpty(bpmSolution.getActDefId()) ? true: false;
		return mv.addObject("bpmSolution", bpmSolution)
				.addObject("isBindFlow", isBindFlow);
	}

	/**
	 * 更新解决方案中的步骤
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("updStep")
	@ResponseBody
	@LogEnt(action = "updStep", module = "流程", submodule = "流程解决方案")
	public JsonResult updStep(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String step = request.getParameter("step");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		if(bpmSolution!=null && step!=null){
			bpmSolution.setStep(new Integer(step));
			bpmSolutionManager.update(bpmSolution);
		}
		
		return new JsonResult(true, "成功更新步骤!");

	}

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmSolutionManager;
	}

	@RequestMapping("getPortalBpmSol")
	@ResponseBody
	public List<BpmSolution> getPortalBpmSol(
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List<BpmSolution> list = bpmSolutionManager.getDeployedSol();
		
		return list;
	}

	/**
	 * 导出流程解决方案
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doExport")
	// @ResponseBody
	public void doExport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String ids = request.getParameter("ids");
		// 导出选项
		String expStr = request.getParameter("expOptions");
		Set<String> expOptions = new HashSet<String>();
		expOptions.addAll(Arrays.asList(expStr.split("[,]")));

		String[] solIds = ids.split("[,]");
		
		List<BpmSolutionExt> list=solutionExpImpManager.getSolutionByIds(solIds, expOptions);
		
		response.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "Bpm-Solutions-" + sdf.format(new Date());
		response.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						response.getOutputStream());
		
		for (BpmSolutionExt ext : list) {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			// 生成XML
			String xml = xstream.toXML(ext);
			
			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(ext.getBpmSolution().getName() + ".xml"));
			InputStream is = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			IOUtils.copy(is, zipOutputStream);
			zipOutputStream.closeArchiveEntry();
			
		}
		zipOutputStream.close();
		
	}

	/**
	 * 直接导入,不进行结果检查,存在则更新，不存在则添加
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("importDirect")
	@LogEnt(action = "importDirect", module = "流程", submodule = "流程解决方案")
	public ModelAndView importDirect(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile f = request.getFile("zipFile");
		boolean isDeploy=RequestUtil.getBoolean(request, "deploy",false);
		ProcessHandleHelper.clearProcessMessage();
		
		ProcessHandleHelper.initProcessMessage();
		solutionExpImpManager.doImport(f,isDeploy);
		
		LinkedHashSet<String> differSet = ProcessHandleHelper.getProcessMessage().getDifferMsgs();
		Set<String> msgSet= ProcessHandleHelper.getProcessMessage().getErrorMsges();
		
		return getPathView(request).addObject("msgSet", msgSet).addObject("differSet", differSet);
	}
	
	@RequestMapping("getByDefId")
	@ResponseBody
	public JsonResult getByDefId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String defId = request.getParameter("defId");
		BpmDef bpmDef = bpmDefManager.get(defId);
		JsonResult result = new JsonResult(true);
		if (bpmDef == null)
			result.setMessage("该流程存在问题，请联系管理员！");
		else {
			Collection<ActNodeDef> taskDefs = actRepService.getTaskNodes(bpmDef
					.getActDefId());

			List<ActNodeDef> allNodeDefs = new ArrayList<ActNodeDef>();
			allNodeDefs.addAll(taskDefs);
			result.setData(allNodeDefs);
		}
		return result;
	}
	
	
	
	@RequestMapping("getBySolId")
	@ResponseBody
	public Collection<Map<String,String>> getBySolId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String solId = request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		
		BpmDef bpmDef = bpmDefManager.getValidBpmDef(actDefId, bpmSolution.getDefKey());
		
		Collection<ActNodeDef> taskDefs = actRepService.getTaskNodes(bpmDef.getActDefId());
		Collection<Map<String,String>> nodeMaps=new ArrayList<Map<String,String>>();
		for(ActNodeDef def:taskDefs){
			Map<String,String> nodeMap=new HashMap<String,String>();
			nodeMap.put("nodeId", def.getNodeId());
			nodeMap.put("nodeName", def.getNodeName());
			nodeMaps.add(nodeMap);
		}
		return  nodeMaps;
	}

	@RequestMapping("search")
	@ResponseBody
	public List<BpmSolution> search(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String name = request.getParameter("name");
		QueryFilter queryFilter = getQueryFilter(request);
		if (StringUtils.isNotEmpty(name)) {
			queryFilter.addLikeFieldParam("name", name + "%");
		}
		List<BpmSolution> list = bpmSolutionManager.getAll(queryFilter);
		return list;
	}
	
	@RequestMapping("nodeMessageSelect")
	public ModelAndView nodeMessageSelect(HttpServletRequest request,HttpServletResponse response){
		String solId=request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmSolution bpmSolution = bpmSolutionManager.get(solId);
		
		BpmDef bpmDef = bpmDefManager.getValidBpmDef(actDefId, bpmSolution.getDefKey());
		actDefId=bpmDef.getActDefId();
		ModelAndView  modelAndView=new ModelAndView("bpm/core/bpmNodeSelect.jsp");
		modelAndView.addObject("actDefId", actDefId);
		return modelAndView;
	}
	
	
	
	
	
	@RequestMapping("showSolutionName")
	@ResponseBody
	public JSONObject showSolutionName(HttpServletRequest request,HttpServletResponse response){
		String solId=request.getParameter("solId");
		BpmSolution bpmSolution=bpmSolutionManager.get(solId);
		String descp=bpmSolution.getDescp();
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("descp", descp);
		jsonObject.put("actDefId", bpmSolution.getActDefId());
		return jsonObject;
	}
	
	
	@RequestMapping("solutionList")
	@ResponseBody
	public JsonPageResult<BpmSolution> solutionList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter = getQueryFilter(request);
		String treeId=RequestUtil.getString(request, "treeId");
		if(StringUtil.isNotEmpty(treeId)){
			SysTree sysTree= sysTreeManager.get(treeId);
			if(sysTree!=null){
				String path=sysTree.getPath();
				queryFilter.addLeftLikeFieldParam("TREE_PATH_", path);
			}
		}
		List<BpmSolution> bpmSolutions=bpmSolutionManager.getSolutions(queryFilter,true);
		return new JsonPageResult<BpmSolution>(bpmSolutions,queryFilter.getPage().getTotalItems());
	}
	
	
	@RequestMapping("getCatTree")
	@ResponseBody
	public List<SysTree> listByCatKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
		boolean isAdmin=RequestUtil.getBoolean(request, "isAdmin",false);
		IUser user=ContextUtil.getCurrentUser();
		List<SysTree> treeList=null;
		if(user.isSuperAdmin()){
			treeList=sysTreeManager.getByCatKeyTenantId(SysTree.CAT_BPM_SOLUTION, ContextUtil.getCurrentTenantId());
		}
		else{
			treeList=bpmSolutionManager.getCategoryTree(isAdmin);
		}
		return treeList;
	}
	
	@RequestMapping("getAllSolutions")
	@ResponseBody
	public JsonPageResult<BpmSolution> getAllSolutions(HttpServletRequest request,HttpServletResponse response){
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		String tenantId=ContextUtil.getCurrentTenantId();
		queryFilter.addFieldParam("tenantId", tenantId);
		queryFilter.addFieldParam("status", "DEPLOYED");
		List<BpmSolution> bpmSolutions=bpmSolutionManager.getAll(queryFilter);
		JsonPageResult<BpmSolution> jsonPageResult=new JsonPageResult<BpmSolution>(bpmSolutions, queryFilter.getPage().getTotalItems());
		return jsonPageResult;
	}
	
	/**
	 * @author qinxinhua 2018年5月7日
	 * describe：清空测试相关数据
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("cleanTestInst")
	@ResponseBody
	@LogEnt(action = "cleanTestInst", module = "流程", submodule = "流程解决方案")
	public JsonResult cleanTestInst(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("solId");
		StringBuffer sb = new StringBuffer();
		
		if (StringUtils.isNotEmpty(id)) {
			
			List<BpmInst> bpmInstList = bpmInstManager.getBpmInstListBySolId(id);
			
			for (BpmInst bpmInst : bpmInstList) {
				bpmInstManager.doCleanByInstId(bpmInst);
			} 
			
			sb.append("测试数据已经清除!");
		}
		return new JsonResult(true, sb.toString());
	}
	
	/**
	 * 流程方案绑定流程定义
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveToBpmDef")
    @ResponseBody
    public JsonResult saveToBpmDef(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String defId=request.getParameter("defId");
    	BpmSolution bpmSolution=bpmSolutionManager.get(solId);
    	BpmDef def = bpmDefManager.get(defId);
    	String actDefId = def.getActDefId();
    	if(StringUtil.isEmpty(actDefId)) {
    		bpmDefManager.delete(def.getDefId());
    		return new JsonResult(false,"未保存流程定义配置");
    	}
    	bpmSolution.setDefKey(def.getKey());
    	bpmSolution.setActDefId(actDefId);
    	bpmSolutionManager.saveOrUpdate(bpmSolution);
    	return new JsonResult(true,"成功保存流程定义配置");
    }
	
	
}
