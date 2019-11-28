package com.redxun.microsvc.bpm.impl.bpm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmDestNode;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.microsvc.bpm.BpmService;
import com.redxun.microsvc.bpm.entity.ActivitiNode;
import com.redxun.microsvc.bpm.entity.ApproveModel;
import com.redxun.microsvc.bpm.entity.BpmSolutionModel;
import com.redxun.microsvc.bpm.entity.PageParamsModel;
import com.redxun.microsvc.bpm.entity.StartModel;
import com.redxun.microsvc.bpm.entity.VarModel;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.QueryFilterBuilder;



public class BpmServiceImpl implements BpmService {
	
	@Resource
	BpmInstManager bpmInstManager; 
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	UserService userService; 
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	ActRepService actRepService;

	@Override
	public JsonResult<BpmTask> getTasksByInstId(String instId) {
		BpmInst bpmInst=bpmInstManager.get(instId);
		List<BpmTask> tasks=bpmTaskManager.getByActInstId(bpmInst.getActInstId());
		return new JsonResult(true,"",tasks);
	}

	

	@Override
	public JsonResult<List<ActivitiNode>> getTaskOutNodes(String taskId) {
		BpmTask bpmTask=bpmTaskManager.get(taskId);
		ActNodeDef actNodeDef=actRepService.getActNodeDef(bpmTask.getProcDefId(), bpmTask.getTaskDefKey());
		List<ActNodeDef> list= actNodeDef.getOutcomeNodes();
		List<ActivitiNode> nodes=new ArrayList<>();
		for(ActNodeDef def:list){
			ActivitiNode node=new ActivitiNode();
			node.setMultiInstance(def.getMultiInstance());
			node.setNodeId(def.getNodeId());
			node.setNodeName(def.getNodeName());
			node.setNodeType(def.getNodeType());
			nodes.add(node);
		}
		return new JsonResult(true,"",nodes);
		
	}

	@Override
	public JsonPageResult getMySolutions(PageParamsModel model) {
		String json=model.toString();
		
		JsonPageResult<BpmSolutionModel> result=new JsonPageResult<BpmSolutionModel>();
		
		String userAccount=model.getUserAccount();
		
		if(StringUtils.isEmpty(userAccount)){
			result.setSuccess(false);
			result.setMessage("没有填写账号!");
			return result;
		}
		
		IUser sysUser=userService.getByUsername(userAccount);
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
    	net.sf.json.JSONObject cmdObj=net.sf.json.JSONObject.fromObject(json);
    	
    	//{userAccount:'admin@redxun.cn',pageIndex:0,pageSize:20,Q_KEY__S_LK:'demo',Q_NAME__S_LK:""}
    	QueryFilter filter=QueryFilterBuilder.createQueryFilter(cmdObj);
		
    	ContextUtil.setCurUser(sysUser);

		List<BpmSolution> bpmSolutions=bpmSolutionManager.getSolutions(filter,false);
		return new JsonPageResult<BpmSolution>(bpmSolutions,filter.getPage().getTotalItems());
	}

	@Override
	public JsonResult recoverInst(String account, String instId) {
		JsonResult result=new JsonResult();
		
		if(StringUtils.isEmpty(account)){
			result.setSuccess(false);
			result.setMessage("没有输入帐号");
			return result;
		}
			
		if(StringUtils.isEmpty(instId)){
			result.setSuccess(false);
			result.setMessage("没有传入实例ID");
			return result;
		}
		IUser sysUser=userService.getByUsername(account);
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+account+"不存在！");
			return result;
    	}
		ContextUtil.setCurUser(sysUser);
		try{
			result= bpmInstManager.recoverInst(instId);
		}
		catch(Exception ex){
			result.setSuccess(false);
			result.setMessage(ExceptionUtil.getExceptionMessage(ex));
		}
		
		return result;
	}

	@Override
	public JsonPageResult<BpmTask> getMyAgentTasks(PageParamsModel model) {
		String json=model.toString();
		JsonPageResult result=new JsonPageResult();
		
		String userAccount=model.getUserAccount();
		
		if(StringUtils.isEmpty(userAccount)){
			result.setSuccess(false);
			result.setMessage("没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',Q_createtime1_D_GE:'1001',Q_createtime2_D_LE:'',Q_name_S_LK:'',Q_description_S_LK:''}");
			return result;
		}
		IUser sysUser=userService.getByUsername(userAccount);
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
		net.sf.json.JSONObject cmdObj=net.sf.json.JSONObject.fromObject(json);
		
		QueryFilter filter=  QueryFilterBuilder.createQueryFilter(cmdObj);
		filter.addFieldParam("userId", sysUser.getUserId());
		filter.addSortParam("CREATE_TIME_", "DESC");
		List<BpmTask> bpmTasks  = bpmTaskManager.getAgentToTasks(filter);
		return new JsonPageResult(bpmTasks, filter.getPage().getTotalItems());
	}

	@Override
	public JsonResult<BpmInst> startProcess(StartModel model) {
		ContextUtil.clearCurLocal();
		String userAccount=model.getUserAccount();
		IUser user=userService.getByUsername(userAccount);
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
    	try{
    		ContextUtil.setCurUser(user);
			ProcessStartCmd startCmd=new ProcessStartCmd();
			startCmd.setSolId(model.getSolId());
			startCmd.setJsonData(model.getJsonData());
			startCmd.setBusinessKey(model.getBusinessKey());
			List<VarModel> listVars= model.getVars();
			
			if(BeanUtil.isNotEmpty(listVars)){
				Map<String,Object> vars=new HashMap<>();
				for(VarModel var:listVars){
					vars.put(var.getName(), var.getValue());
				}
				startCmd.setVars(vars);
			}
			BpmInst inst= bpmInstManager.doStartProcess(startCmd);
			
			return new JsonResult(true,"成功启动流程！",inst);
    	}catch(Exception ex){
    		return new JsonResult(false,"启动流程失败！");
    	}
	}

	@Override
	public JsonResult doNext(ApproveModel model) {
		ContextUtil.clearCurLocal();
		String userAccount=model.getUserAccount();
		
		if(StringUtils.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数！");
		}
		
    	IUser user=userService.getByUsername(userAccount);
    	
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
    	JsonResult result=new JsonResult();
    	ProcessMessage handleMessage=null;
    	try{
    		ContextUtil.setCurUser(user);
	    	handleMessage=new ProcessMessage();
	    	ProcessHandleHelper.setProcessMessage(handleMessage);
	    	ProcessNextCmd cmd=new ProcessNextCmd();
	    	cmd.setTaskId(model.getTaskId());
	    	cmd.setJsonData(model.getJsonData());
	    	cmd.setJumpType(model.getJumpType());
	    	cmd.setDestNodeId(model.getDestNodeId());
	    	cmd.setOpinion(model.getOpinion());
	    	
	    	String destNodeUsers=model.getDestNodeUsers();
	    	if(StringUtils.isNotEmpty(destNodeUsers)){
	    		JSONArray jsonArray=JSONArray.parseArray(destNodeUsers);
	    		for(int i=0;i<jsonArray.size();i++){
	    			JSONObject obj=jsonArray.getJSONObject(i);
	    			String nodeId=obj.getString("nodeId");
	    			String userIds=obj.getString("userIds");
	    			BpmDestNode dn=new BpmDestNode(nodeId,userIds);
	    			cmd.getNodeUserMap().put(nodeId, dn);
	    		}
	    	}
	    	bpmTaskManager.doNext(cmd);
    	}catch(Exception ex){
    		if(handleMessage.getErrorMsges().size()==0){
    			handleMessage.getErrorMsges().add(ex.getMessage());
    		}
    	}finally{
    		//在处理过程中，是否有错误的消息抛出
    		if(handleMessage.getErrorMsges().size()>0){
    			result.setSuccess(false);
    			result.setMessage(handleMessage.getErrors());
    		}else{
    			result.setSuccess(true);
    			result.setMessage("成功处理任务！");
    		}
    		ProcessHandleHelper.clearProcessMessage();
    		
    	}
    	return result;
	}

	@Override
	public JsonPageResult<BpmTask> getTasksByUserAccount(PageParamsModel model) {
		String json=model.toString();
		JsonPageResult<BpmTask> result=new JsonPageResult<BpmTask>();
		
		 
		
		net.sf.json.JSONObject cmdObj=net.sf.json.JSONObject.fromObject(json);
		
		String userAccount=model.getUserAccount();
		
		if(StringUtils.isEmpty(userAccount)){
			result.setSuccess(false);
			result.setMessage("没有提交账号!");
			return result;
		}
		
		IUser sysUser=userService.getByUsername(userAccount);
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
    	String msg=null;
    	
    	
    	QueryFilter filter=QueryFilterBuilder.createQueryFilter(cmdObj);
    	
    	List<BpmTask> bpmTasks=null;
    	try{
    		ContextUtil.setCurUser(sysUser);
    		bpmTasks=bpmTaskManager.getByUserId(filter);
	    	msg="成功获得任务列表";
    	}catch(Exception ex){
    		msg=ex.getMessage();
    	}finally{
    		ContextUtil.clearCurLocal();
    	}
    	return new JsonPageResult(true,bpmTasks,filter.getPage().getTotalItems(),msg);
	}

	

	
}
