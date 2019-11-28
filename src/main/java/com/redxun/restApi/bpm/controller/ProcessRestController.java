package com.redxun.restApi.bpm.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmDestNode;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.entity.config.DestNodeUsers;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.core.identity.service.BpmIdentityCalService;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.form.api.FormHandlerFactory;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonCount;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.script.PortalScript;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsUserManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RestController
@RequestMapping("/bpm/process/")
public class ProcessRestController {
	
	protected  Logger logger=LogManager.getLogger(PortalScript.class);
	@Resource 
	BpmInstManager bpmInstManager;
	@Resource 
	BpmTaskManager bpmTaskManager;
	@Resource 
	ActRepService actRepService;
	@Resource
	UserService  userService;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmNodeJumpManager bpmNodeJumpManager;
	@Resource
	OsUserManager osUserManager;
	@Resource
	TaskService taskService;
	@Resource
	RuntimeService runtimeService;
	@Resource
	BpmIdentityCalService bpmIdentityCalService;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	SysInstManager sysInstManager;
	@Resource
	OsGroupManager osGroupManager;
	@Resource
	FormHandlerFactory formHandlerFactory;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	
	
	/**
	 * 获取我的已办数量
	 * @param cmdObj
	 * @return
	 */
	@RequestMapping("getMyAttendCount")
	@ResponseBody
	public JsonCount getMyAttendCount(@RequestBody JSONObject cmdObj){
		
		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
		IUser osUser=userService.getByUsername(userAccount);
		if(osUser==null){
			return new JsonCount(true,0L,"userAccount不存在！");
		}
		
		SqlQueryFilter filter=QueryFilterBuilder.createSqlQueryFilter(cmdObj);
		
		filter.addFieldParam("userId", osUser.getUserId());
		
		Long counts=bpmInstManager.getMyCheckInstCounts(filter);
		
		return new JsonCount(true,counts,"get data success!");
	}

	/**
	 * {userAccount:'admin@redxun.cn',pageIndex:1,pageSize:20,Q_KEY__S_LK:'xxx', params:{Q_NAME__S_LK:""}}
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getMySolutions", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonPageResult getMySolutions(@RequestBody JSONObject cmdObj) throws Exception{
		JsonPageResult<BpmTask> result=new JsonPageResult<BpmTask>();

		if(cmdObj.isEmpty()){
			result.setSuccess(false);
			result.setMessage("没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',pageIndex:1,pageSize:20,sortField:'createTime',sortOrder:'asc',Q_name_S_LK:'xxx'}");
			return result;
		}
		
		
		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			result.setSuccess(false);
			result.setMessage("没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',pageIndex:1,pageSize:20,sortField:'createTime',sortOrder:'asc',params:{Q_name_S_LK:'xxx'}}");
			return result;
		}
		
		IUser sysUser=userService.getByUsername(userAccount);
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
    
    	QueryFilter filter=QueryFilterBuilder.createQueryFilter(cmdObj);
    	List<BpmSolution> bpmSolutions=null;
    	ContextUtil.setCurUser(sysUser);
    	try{
    		bpmSolutions=bpmSolutionManager.getSolutions(filter,false);
    	}catch(Exception e){
    		return new JsonPageResult(false,bpmSolutions,0,"error:"+ e.getMessage());
    	}
	
		return new JsonPageResult<BpmSolution>(bpmSolutions,filter.getPage().getTotalItems());
	}
	
	/**
	 * 取得任务当前的跳出节点列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getTaskOutNodes", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonResult getTaskOutNodes(@RequestBody JSONObject cmdObj) throws Exception{
		if(cmdObj.isEmpty()) 
			return new JsonResult(false,"没有提交正确参数！");
		String taskId=cmdObj.getString("taskId");
		BpmTask bpmTask=bpmTaskManager.get(taskId);
		ActNodeDef actNodeDef=actRepService.getActNodeDef(bpmTask.getProcDefId(), bpmTask.getTaskDefKey());
		return new JsonResult(true,"",actNodeDef.getOutcomeNodes());
	}

	/**
	 * 获得任务列表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getTasksByInstId", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonResult getTasksByInstId(@RequestBody JSONObject cmdObj)throws Exception{
		if(cmdObj.isEmpty()) 
			return new JsonResult(false,"没有提交正确参数！");
		String instId=cmdObj.getString("instId");
		BpmInst bpmInst=bpmInstManager.get(instId);
		if(bpmInst==null)
			return new JsonResult(false,"流程实例为空！");
		List<BpmTask> tasks=bpmTaskManager.getByActInstId(bpmInst.getActInstId());
		for(BpmTask task:tasks){
			if(StringUtils.isEmpty(task.getSolKey()) && StringUtils.isNotEmpty(task.getSolId())){
				BpmSolution bpmSol=bpmSolutionManager.get(task.getSolId());
				if(bpmSol!=null){
					task.setSolKey(bpmSol.getKey());
				}
			}
		}
		return new JsonResult(true,"",tasks);
	}
	
	
	
	
	/**
	 * 获得审批意见
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getNodejumpByInstId", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonResult getNodejumpByInstId(@RequestBody JSONObject cmdObj)throws Exception{
		if(cmdObj.isEmpty()) 
			return new JsonResult(false,"没有提交正确参数！");
		
		String instId=cmdObj.getString("instId");
		if(StringUtil.isEmpty(instId))
			return new JsonResult(false,"流程实例ID为空");
		BpmInst inst=bpmInstManager.get(instId);
		if(inst==null)
			return new JsonResult(false,"流程实例为空");
		List<BpmNodeJump> nodejumps=bpmNodeJumpManager.getNodeJumpByInstId(instId);
		for (BpmNodeJump bpmNodeJump : nodejumps) {
			OsUser osUser=osUserManager.get(bpmNodeJump.getHandlerId());
			if(osUser!=null)			
				bpmNodeJump.setHandler(osUser.getFullname());
		}
		return new JsonResult(true,"获取成功！",nodejumps);
	}
	
	/**
     * 处理任务跳下一步
     * 传入参数，参数格式如下:
     * {
			taskId:'10000303',
			userAccount:'admin@redxun.cn',
			jsonData:{},
			jumpType:'AGREE',//REFUSE，BACK，BACK_TO_STARTOR
			opinion:'同意',
			destNodeId:'Task2',
			destNodeUsers:[
				{
				 nodeId:'UserTask1'
				 userIds:'1,2',
				 priority:50,
				 expiretime:'2016-03-04'
				},{
				 nodeId:'UserTask2'
				 userIds:'1,2',
				 priority:50,
				 expiretime:'2016-03-04'
				}
			]
	 }
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "doNext", produces = "application/json;charset=UTF-8")
    @ResponseBody
    @LogEnt(action = "doNext", module = "流程", submodule = "流程接口")
    public JsonResult doNext(@RequestBody JSONObject cmdObj) throws Exception{
		if(cmdObj.isEmpty())
			return new JsonResult(false,"没有提交正确参数！");
    	//加上处理的消息提示
    	ProcessMessage handleMessage=null;
    	
    	ProcessHandleHelper.clearBackPath();
    	
    	String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数！");
		}
		
    	IUser user=userService.getByUsername(userAccount);
    	
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
    	JsonResult result=new JsonResult();
    	try{
    		ContextUtil.setCurUser(user);
	    	handleMessage=new ProcessMessage();
	    	ProcessHandleHelper.setProcessMessage(handleMessage);
	    	ProcessNextCmd processNextCmd=getNextCmdFromJson(cmdObj); 
	    	bpmTaskManager.doNext(processNextCmd);
    	}catch(Exception ex){
    		String msg=ExceptionUtil.getExceptionMessage(ex);
    		logger.error(msg);
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
    		ContextUtil.clearCurLocal();
    	}
    	return result;
    }
	
	
	
	/**
	 * 沟通任务
	 * @param cmdObj ，格式如下：
	 * 
	 * 接口：commuteTask
		{
			userAccount:'323242',
			taskId:'1111111111',
			opinion:''//沟通意见
			cmmUserIds:''//沟通的用户Ids,如1,2,3,
			noticeTypes:''//通知方式,可不传,可直接传值 ：sfMsg
		}
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "commuteTask", produces = "application/json;charset=UTF-8")
    @ResponseBody
    @LogEnt(action = "commuteTask", module = "流程", submodule = "流程接口")
	public JsonResult commuteTask(@RequestBody JSONObject cmdObj) throws Exception{
		String taskId=JSONUtil.getString(cmdObj, "taskId","");
		String commuteUserId=JSONUtil.getString(cmdObj, "cmmUserIds","");
		String opinion=JSONUtil.getString(cmdObj, "opinion","");
		String noticeTypes=JSONUtil.getString(cmdObj,"noticeTypes");
	
		
		JsonResult result=new JsonResult(true);
		
		if(StringUtils.isEmpty(taskId)){
			result.setSuccess(false);
			result.setMessage("任务ID不能为空！，格式如：{userAccount:'111',taskId:'1111',opinion:'请给意见',cmmUserIds:'1001,1002',noticeTypes:'sfMsg'}");
			return result;
		}
		
		if(StringUtils.isEmpty(commuteUserId)){
			result.setSuccess(false);
			result.setMessage("沟通用户Ids不能为空！，格式如：{userAccount:'111',taskId:'1111',opinion:'请给意见',cmmUserIds:'1001,1002',noticeTypes:'sfMsg'}");
			return result;
		}
		//当前用户账号
		String userAccount=JSONUtil.getString(cmdObj, "userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数！");
		}
		
    	IUser user=userService.getByUsername(userAccount);
    	
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}

		BpmTask bpmTask =bpmTaskManager.get(taskId);
		
		if(bpmTask==null){
			return new JsonResult(false,"任务已经完成！");
		}
		
		ProcessNextCmd cmd=new ProcessNextCmd();
		cmd.setTaskId(taskId);
		cmd.setOpinion(opinion);
		cmd.setCommunicateUserId(commuteUserId);
		ContextUtil.setCurUser(user);
		//产生沟通任务及记录
		try{
			bpmTaskManager.createCommuteTask(bpmTask, cmd,noticeTypes);
			result.setMessage("已成功能发送沟通！");
		}catch(Exception ex){
			result.setSuccess(false);
			result.setMessage("发送沟通失败："+ ex.getMessage());
			logger.error(ExceptionUtil.getExceptionMessage(ex));
		}finally{
			ContextUtil.clearCurLocal();
		}
		return result;
	}
	
	
	/**
	 * 回复沟通任务
	 * @param cmdObj ，格式如下：
	 * 
	 * 接口：commuteTask
		{
			userAccount:'111',
			taskId:'1111111111',
			opinion:'',//回复沟通意见
			noticeTypes:''//通知方式,可不传,可直接传值 ：sfMsg
	    }
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "replyCommuteTask", produces = "application/json;charset=UTF-8")
    @ResponseBody
    @LogEnt(action = "replyCommuteTask", module = "流程", submodule = "流程接口")
	public JsonResult replyCommuteTask(@RequestBody JSONObject cmdObj) throws Exception{
		String taskId=JSONUtil.getString(cmdObj, "taskId");
		String opinion=JSONUtil.getString(cmdObj, "opinion");
		String noticeTypes=JSONUtil.getString(cmdObj,"noticeTypes");
		JsonResult result=new JsonResult(true);
		
		if(StringUtils.isEmpty(taskId)){
			result.setSuccess(false);
			result.setMessage("任务ID不能为空！，格式如：{userAccount:'111',taskId:'1111',opinion:'同意',noticeTypes:'sfMsg'}");
			return result;
		}
		
		if(StringUtils.isEmpty(opinion)){
			result.setSuccess(false);
			result.setMessage("意见不能为空！，格式如：{userAccount:'111',taskId:'1111',opinion:'同意',noticeTypes:'sfMsg'}");
			return result;
		}

		BpmTask bpmTask =bpmTaskManager.get(taskId);
		if(bpmTask==null){
			return new JsonResult(false,"任务已经完成！");
		}
		
		ProcessNextCmd cmd=new ProcessNextCmd();
		cmd.setTaskId(taskId);
		cmd.setJsonData("{}");
		cmd.setOpinion(opinion);
		//当前用户账号
		String userAccount=JSONUtil.getString(cmdObj, "userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数！");
		}
		
    	IUser user=userService.getByUsername(userAccount);
    	
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
    	
		try{
			ContextUtil.setCurUser(user);
			//产生沟通任务及记录
			bpmTaskManager.doReplyCommunicateTask(cmd,noticeTypes);
			result.setMessage("已成功回复沟通！");
		}catch(Exception ex){
			logger.error(ExceptionUtil.getExceptionMessage(ex));
			result.setSuccess(false);
			result.setMessage("回复沟通失败！原因："+ ex.getMessage());
		}finally{
			ContextUtil.clearCurLocal();
		}
		return result;
	}
	
	/**
	 * 撤回沟通
	 * @param cmdObj
	 * {
	     userAccount:'111',
	 	 taskId:'3003033',
	 	 opinion:'不处理，我撤回来处理'
	   }
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "revokeCommuk", produces = "application/json;charset=UTF-8")
    @ResponseBody
    @LogEnt(action = "revokeCommuk", module = "流程", submodule = "流程接口")
	public JsonResult revokeCommuk(@RequestBody JSONObject cmdObj) throws Exception{
		String taskId=JSONUtil.getString(cmdObj, "taskId");
		String opinion=JSONUtil.getString(cmdObj, "opinion");
		
		JsonResult result=new JsonResult(true);
		
		if(StringUtils.isEmpty(taskId)){
			result.setSuccess(false);
			result.setMessage("任务ID不能为空！，格式如：{userAccount:'111',taskId:'1111',opinion:'撤回'}");
			return result;
		}
		
		//当前用户账号
		String userAccount=JSONUtil.getString(cmdObj, "userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数！");
		}
    	IUser user=userService.getByUsername(userAccount);
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
    	BpmTask bpmTask =bpmTaskManager.get(taskId);
		if(bpmTask==null){
			return new JsonResult(false,"任务已经完成！");
		}
		
		ProcessNextCmd processNextCmd = new ProcessNextCmd();
		processNextCmd.setTaskId(taskId);
		processNextCmd.setOpinion(opinion);
		
		try{
			ContextUtil.setCurUser(user);
			bpmTaskManager.doCancelCommuteTask(processNextCmd);
			result.setMessage("撤销沟通成功!");
		}catch(Exception ex){
			logger.error(ExceptionUtil.getExceptionMessage(ex));
			result.setMessage("撤销沟通失败! 原因：" + ex.getMessage());
			result.setSuccess(false);
		}finally{
			ContextUtil.clearCurLocal();
		}
		
		return result;
		
	}
    
    /**
     * 通过json参数获得执行下一步的处理对象
     * @param cmdJson，格式如下:
     * 
     * @return
     */
    private ProcessNextCmd getNextCmdFromJson(JSONObject cmdJson){
    	String taskId=JSONUtil.getString(cmdJson,"taskId");
    	String jsonData=JSONUtil.getString(cmdJson,"jsonData","{}");
    	String jumpType=JSONUtil.getString(cmdJson,"jumpType");
    	String opinion=JSONUtil.getString(cmdJson,"opinion");
    	String destNodeId=JSONUtil.getString(cmdJson,"destNodeId");
    	String destNodeUsers=JSONUtil.getString(cmdJson,"destNodeUsers");
    	String nextJumpType=JSONUtil.getString(cmdJson,"nextJumpType");
    	
    	ProcessNextCmd cmd=new ProcessNextCmd();
    	cmd.setTaskId(taskId);
    	
    	//设置表单字段值
    	cmd.setJsonData(jsonData);
    
		
    	cmd.setJumpType(jumpType);
    	cmd.setOpinion(opinion);
    	
    	cmd.setNextJumpType(nextJumpType);
    	
    	if(StringUtils.isNotEmpty(destNodeId)){
    		cmd.setDestNodeId(destNodeId);
    	}
    	
    	if(StringUtils.isNotEmpty(destNodeUsers)){
    		JSONArray jsonArray=JSONArray.fromObject(destNodeUsers);
    		for(int i=0;i<jsonArray.size();i++){
    			JSONObject obj=jsonArray.getJSONObject(i);
    			String nodeId=obj.getString("nodeId");
    			String userIds=obj.getString("userIds");
    			
    			BpmDestNode dn=new BpmDestNode(nodeId,userIds);
    			
    			cmd.getNodeUserMap().put(nodeId, dn);
    		}
    	}
    	return cmd;
    }
    /**
     * 通过任务Id获得表单的数据
     * @param taskCmdData 格式如： {taskId:'11111111111111'}
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "getFormDataByTaskId", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public JsonResult getFormDataByTaskId(@RequestBody JSONObject taskCmdData) throws Exception{
    	String taskId=JSONUtil.getString(taskCmdData,"taskId","");
    	JsonResult jsonResult=new JsonResult();
    	if(StringUtils.isEmpty(taskId)){
    		jsonResult.setSuccess(false);
    		jsonResult.setMessage("请传入taskId,格式如:{taskId:'030030303'}");
    		return jsonResult;
    	}
    	String userAccount=JSONUtil.getString(taskCmdData, "userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数！");
		}
		
		IUser user=userService.getByUsername(userAccount);
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
		ContextUtil.setCurUser(user);
		
		
		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels= formHandler.getByTaskId(taskId,"");
		JSONObject cmdData=new JSONObject();
		if( formModels!=null &&formModels.size()>0 ){
			JSONArray boArr=new JSONArray();
			for(FormModel fm:formModels){
				JSONObject bo=new JSONObject();
				bo.put("boDefId", fm.getBoDefId());
				bo.put("formKey", fm.getFormKey());
				bo.put("data", fm.getJsonData());
				boArr.add(bo);
			}
			cmdData.put("bos", boArr);
		}
		jsonResult.setData(cmdData);
    	return jsonResult;
    	
    }
    
    /**
     * 通过实例获得表单的数据
     * @param taskCmdData 格式如： {instId:'11111111111111'}
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "getFormDataByInstId", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public JsonResult getFormDataByInstId(@RequestBody JSONObject json) throws Exception{
    	String instId=JSONUtil.getString(json,"instId","");
    	JsonResult jsonResult=new JsonResult(true);
    	if(StringUtils.isEmpty(instId)){
    		jsonResult.setSuccess(false);
    		jsonResult.setMessage("请传入instId,格式如:{instId:'030030303'}");
    		return jsonResult;
    	}
    	String userAccount=JSONUtil.getString(json, "userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数！");
		}
		
		IUser user=userService.getByUsername(userAccount);
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
		ContextUtil.setCurUser(user);
    	
		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels= formHandler.getByInstId(instId);
		
		JSONObject cmdData=new JSONObject();
		if( formModels!=null &&formModels.size()>0 ){
			JSONArray boArr=new JSONArray();
			for(FormModel fm:formModels){
				JSONObject bo=new JSONObject();
				bo.put("boDefId", fm.getBoDefId());
				bo.put("formKey", fm.getFormKey());
				bo.put("data", fm.getJsonData());
				boArr.add(bo);
			}
			cmdData.put("bos", boArr);
		}
		jsonResult.setData(cmdData);
		
		jsonResult.setMessage("获取表单数据成功!");
		
    	return jsonResult;
    }
	
	/**
	 * 取得用户任务待办列表
	 * @param request  cmd 参数格式:{userAccount:'abc@redxun.cn',params:{pageIndex:1,pageSize:20,sortField:'createTime',sortOrder:'asc',Q_name_S_LK:'xxx'}}
	 * @param response
	 * @return
	 * @throws Excepion
	 */
    
    @RequestMapping(value = "getTasksByUserAccount", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonPageResult getTasksByUserAccount(@RequestBody JSONObject cmdObj) throws Exception{
		
		JsonPageResult<BpmTask> result=new JsonPageResult<BpmTask>();
		
		if(cmdObj.isEmpty()){
			result.setSuccess(false);
			result.setMessage("没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',pageIndex:1,pageSize:20,sortField:'createTime',sortOrder:'asc',Q_name_S_LK:'xxx'}");
			return result;
		}

		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
		if(StringUtils.isEmpty(userAccount)){
			result.setSuccess(false);
			result.setMessage("没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',pageIndex:1,pageSize:20,sortField:'createTime',sortOrder:'asc',Q_name_S_LK:'xxx'}");
			return result;
		}
		
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(cmdObj);
		
		String treeId=JSONUtil.getString(cmdObj,"treeId","");
		if(StringUtil.isNotEmpty(treeId))
			queryFilter.addFieldParam("treeId", treeId);
		
		String solKeys=JSONUtil.getString(cmdObj,"solKeys","");
		if(StringUtil.isNotEmpty(solKeys))
			queryFilter.addFieldParam("keyList", Arrays.asList(solKeys.split(",")));
		
		
		IUser sysUser=userService.getByUsername(userAccount);
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
    	
		queryFilter.addFieldParam("TENANT_ID_", sysUser.getTenant().getInstId());
		
		List<BpmTask> tasks=null;
		
    	String msg=null;
    	try{
    		ContextUtil.setCurUser(sysUser);
    		tasks=bpmTaskManager.getByUserId(queryFilter);
    		
    		
	    	msg="成功获得任务列表";
    	}catch(Exception ex){
    		msg=ex.getMessage();
    	}finally{
    		ContextUtil.clearCurLocal();
    	}
    	return new JsonPageResult(true,tasks,queryFilter.getPage().getTotalItems(),msg);
	}
    
    /**
     *
     * 获得我发起的流程实例
     * {
		   "userAccount":"admin@redxun.cn",
		   "pageIndex":"1",
		   "pageSize":"20", 
		   "sortField":"create_time_",
		   "sortOrder":"asc",
		   "showTasks":"false",
		   "params":{
		       "Q_subject__S_LK":"xxxxxxxxx"
		   }
		}
     * @return
     */
    @RequestMapping(value = "getMyStartInsts", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public JsonPageResult<BpmInst> getMyStartInsts(@RequestBody JSONObject cmdObjs){
    	String userAccount=JSONUtil.getString(cmdObjs,"userAccount");
    	JsonPageResult result=new JsonPageResult();
		if(StringUtils.isEmpty(userAccount)){
			result.setSuccess(false);
			result.setMessage("没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',pageIndex:1,pageSize:20,sortField:'create_time_',sortOrder:'asc',params:{}}");
			return result;
		}
		
		IUser sysUser=userService.getByUsername(userAccount);
    	String showTasks=JSONUtil.getString(cmdObjs,"showTasks","false");
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
    	QueryFilter filter=QueryFilterBuilder.createQueryFilter(cmdObjs);
    	
    	filter.getParams().put("CREATE_BY_", sysUser.getUserId());
    	List<BpmInst> list=null;
    	try{
		    list=bpmInstManager.getMyInst(filter);
		    if("true".equals(showTasks)){
		    	setTaskNodes(list);
		    }
	    }catch(Exception e){
	    	return new JsonPageResult(false,list,0,"error:"+ e.getMessage());
	    }
		
		return new JsonPageResult<BpmInst>(true,list, filter.getPage().getTotalItems(),"get data success!");
    }
    
    /**
     * 计算流程实例的环节和人员。
     * @param insts
     */
    private void setTaskNodes(List<BpmInst> insts){
    	for(BpmInst bpmInst:insts){
			if(!BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())) {continue;}
			
			List<Task> taskList = taskService.createTaskQuery().processInstanceId(bpmInst.getActInstId()).list();
			//[{nodeId:"",nodeName:"",users:[{userId:"",name:""}]}]
			com.alibaba.fastjson.JSONArray jsonAry=new com.alibaba.fastjson.JSONArray();
			
			for(Task task:taskList){
				com.alibaba.fastjson.JSONObject json=new com.alibaba.fastjson.JSONObject();
				json.put("nodeId", task.getTaskDefinitionKey());
				json.put("nodeName", task.getName());
				com.alibaba.fastjson.JSONArray userAry=new com.alibaba.fastjson.JSONArray();
				if(StringUtils.isEmpty(task.getAssignee())) {
					jsonAry.add(json);
					continue;
				}
				
				IUser osUser=userService.getByUserId(task.getAssignee());
				if(osUser==null)  {continue;}
				
				com.alibaba.fastjson.JSONObject userJson=new com.alibaba.fastjson.JSONObject();
				userJson.put("userId", osUser.getUserId());
				userJson.put("name", osUser.getFullname());
				userAry.add(userJson);
				
				json.put("users", userAry);
				jsonAry.add(json);
			}
			//当前环节
			bpmInst.setTaskNodes(jsonAry.toJSONString());
			
    	}
	
    }
	
	/**
	 * 启动流程的API,并以JSON格式返回,
	 * 提交参数格式如：{userAccount:'abc@xce.com',solId:'111',jsonData:'{}',vars:'[{name:\'a\',type:\'String\',value:\'abc\'}]'}
	 * 
	 * jsonData:
	 * 
	 * {
			boDefId:'2610000001170023',//可不传
			formKey:'exMaterInfo',//可不传
			data:{
				ajbh:'',
				ajmc:'',
				cl1:'',
				cl2:'',
				cl3:''
			}
		}
	 *
	 * 返回格式：{success:'true',data:[],errorMsg:'xxxxx'}
	 * @param request
	 * @param response
	 */
    
    @RequestMapping(value = "startProcess", produces = "application/json;charset=UTF-8")
	@ResponseBody
	@LogEnt(action = "startProcess", module = "流程", submodule = "流程接口")
	public JsonResult startProcess(@RequestBody JSONObject cmdObj){
		
		ContextUtil.clearCurLocal();
		
		if(cmdObj.isEmpty()){
			return new JsonResult(false,"没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',businessKey:'2222',jsonData:'{}',vars:'[{name:\'a\',type:\'String\',value:\'abc\'}]'");
		}

		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
		if(StringUtil.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数：{userAccount:'abc@redxun.cn',businessKey:'2222',jsonData:'{}',vars:'[{name:\'a\',type:\'String\',value:\'abc\'}]'");
		}
    	IUser user=userService.getByUsername(userAccount);
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}

    	String solId=JSONUtil.getString(cmdObj,"solId");
		String solKey=JSONUtil.getString(cmdObj, "solKey");
		if(StringUtil.isEmpty(solId) && StringUtils.isEmpty(solKey)){
			return new JsonResult(false,"没有提交流程解决方案ID(solId)或Key(solKey)!");
		}
		
    	String msg=null;
    	//获得流程启动相关信息
    	ProcessMessage handleMessage=new ProcessMessage();
    	try{
    		ContextUtil.setCurUser(user);
			ProcessStartCmd startCmd=new ProcessStartCmd();
			ProcessHandleHelper.setProcessMessage(handleMessage);
            BpmSolution bpmSolution=null;
			//传入非solKey
			if(StringUtils.isNotEmpty(solKey)){
				bpmSolution=bpmSolutionManager.getByKey(solKey, user.getTenant().getTenantId());
				if(bpmSolution==null) {
                    return new JsonResult(false, "没有找到（" + solKey + "）对应的流程解决方案！");
                }
			}else{
                bpmSolution=bpmSolutionManager.get(solId);
                if(bpmSolution==null){
                    return new JsonResult(false,"没有找到（"+solId+"）对应的流程解决方案！");
                }
            }
            solId=bpmSolution.getSolId();
			startCmd.setSolId(solId);
			startCmd.setJsonData(JSONUtil.getString(cmdObj, "jsonData","{}"));
			
			startCmd.setBusinessKey(JSONUtil.getString(cmdObj, "businessKey"));
			String varArr=JSONUtil.getString(cmdObj, "vars");
			if(StringUtil.isNotEmpty(varArr)){
				Map<String,Object> vars=JSONUtil.jsonArr2Map(varArr);
				startCmd.setVars(vars);
			}
			Object destNodeUsers= cmdObj.get("destNodeUsers");
			if(destNodeUsers!=null){
				if(destNodeUsers instanceof String){
					if(StringUtil.isNotEmpty(destNodeUsers.toString())){
						setDestUser( cmdObj, startCmd);
					}
				}
				else{
					setDestUser( cmdObj, startCmd);
				}
				
			}
    		
			BpmInst inst= bpmInstManager.doStartProcess(startCmd);
			
			return new JsonResult(true,"成功启动流程！",inst);
    		
    	}catch(Exception ex){
    		msg=handleMessage.getErrors();
    		if(StringUtils.isEmpty(msg)){
    			msg=ex.getMessage();
    		}
    		logger.error(ExceptionUtil.getExceptionMessage(ex));
    	}finally{
    		ProcessHandleHelper.clearProcessCmd();
    		ProcessHandleHelper.clearProcessMessage();
    	}
		return new JsonResult(false,msg);
	}
    
    private void setDestUser(JSONObject cmdObj,IExecutionCmd startCmd){
    	JSONArray jsonArray=cmdObj.getJSONArray("destNodeUsers");
		if(jsonArray==null) {return;}
		
		for(int i=0;i<jsonArray.size();i++){
			JSONObject obj=jsonArray.getJSONObject(i);
			String nodeId=obj.getString("nodeId");
			String userIds=obj.getString("userIds");
			startCmd.getNodeUserMap().put(nodeId,new BpmDestNode(nodeId, userIds));
		}
    }
	
	/**
	 * 撤销流程接口。
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
    
    @RequestMapping(value = "recoverInst", produces = "application/json;charset=UTF-8")
	@ResponseBody
	@LogEnt(action = "recoverInst", module = "流程", submodule = "流程接口")
	public JsonResult recoverInst(@RequestBody JSONObject cmdObj)throws Exception{
		JsonResult result=new JsonResult();
		
		if(cmdObj.isEmpty()){
			return new JsonResult(false,"没有正确提交参数！");
		}
		
		String userAccount=cmdObj.getString("account");
		String instId=cmdObj.getString("instId");
		
		if(StringUtils.isEmpty(userAccount)){
			result.setSuccess(false);
			result.setMessage("没有输入帐号");
			return result;
		}
			
		if(StringUtils.isEmpty(instId)){
			result.setSuccess(false);
			result.setMessage("没有传入实例ID");
			return result;
		}
		IUser sysUser=userService.getByUsername(userAccount);
    	
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
        ContextUtil.setCurUser(sysUser);
		result= bpmInstManager.recoverInst(instId);
		return result;
	}
	
	/**
	 * 获取代理给我的任务。
	 * {userAccount:'abc@redxun.cn',Q_createtime_D_GE:'1001',Q_createtime_D_LE:'',Q_name_S_LK:'',Q_description_S_LK:''}
	 * @param request
	 * @return
	 */
    
    @RequestMapping(value = "getMyAgentTasks", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonPageResult getMyAgentTasks(@RequestBody JSONObject cmdObj){
		JsonPageResult result=new JsonPageResult();
		
		if(cmdObj.isEmpty()){
			result.setSuccess(false);
			result.setMessage("没有正确提交cmd参数！cmd参数格式如：{userAccount:'abc@redxun.cn',Q_createtime1_D_GE:'1001',Q_createtime2_D_LE:'',Q_name_S_LK:'',Q_description_S_LK:''}");
			return result;
		}
		
		
		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
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
		
		QueryFilter filter=  QueryFilterBuilder.createQueryFilter(cmdObj);
		filter.addFieldParam("userId", sysUser.getUserId());
		filter.addSortParam("CREATE_TIME_", "DESC");
		List<BpmTask> bpmTasks  = bpmTaskManager.getAgentToTasks(filter);
		return new JsonPageResult(bpmTasks, filter.getPage().getTotalItems());
	}
    
    
    /**
     * 获取单个流程实例的明细 
     * @param cmdObj
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "getInstDetailByInstId", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonResult getInstDetailByInstId(@RequestBody JSONObject cmdObj)throws Exception{
		if(cmdObj.isEmpty()) 
			return new JsonResult(false,"没有提交正确参数！");
		
		String instId=cmdObj.getString("instId");
		
		BpmInst inst=bpmInstManager.get(instId);
		
		if(inst==null)
			return new JsonResult(false,"流程实例为空");
		//兼顾旧数据
		if(StringUtils.isEmpty(inst.getSolKey())){
			BpmSolution bpmSol=bpmSolutionManager.get(inst.getSolId());
			if(bpmSol!=null){
				inst.setSolKey(bpmSol.getKey());
			}
		}
		return new JsonResult(true,"获取成功！",inst);
	}
    
    /** 
	 * 返回我已审批的事项实例
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "getMyAttend", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonPageResult getMyAttend(@RequestBody JSONObject cmdObj){
		
		String userAcc=JSONUtil.getString(cmdObj,"userAccount");
		String showTasks=JSONUtil.getString(cmdObj,"showTasks","false");
		
		if(StringUtils.isEmpty(userAcc)){
			return new JsonPageResult<BpmTask>(true,new ArrayList(),0,"用户参数为空!");
		}
		
		IUser sysUser=userService.getByUsername(userAcc);
		if(sysUser==null){
			return new JsonPageResult<BpmTask>(true,new ArrayList(),0,"用户为空!");
		}
		SqlQueryFilter filter=QueryFilterBuilder.createSqlQueryFilter(JSONUtil.getString(cmdObj,"params"));
		
		filter.addFieldParam("userId", sysUser.getUserId());
		if(StringUtil.isNotEmpty(JSONUtil.getString(cmdObj, "treeId", "")))
			filter.addFieldParam("treeId", JSONUtil.getString(cmdObj, "treeId", ""));
		String solKeys=JSONUtil.getString(cmdObj,"solKeys","");
		if(StringUtil.isNotEmpty(solKeys))
			filter.addFieldParam("keyList", Arrays.asList(solKeys.split(",")));
		List<BpmInst> bpmInstList=null;
		try{
			bpmInstList=bpmInstManager.getMyInsts(filter);	
			if("true".equals(showTasks)){
				//设置节点数据。
				setTaskNodes(bpmInstList);
			}
			
		}catch (Exception e) {
			return new JsonPageResult(false,new ArrayList(),0,"error:"+ e.getMessage());
		}
		JsonPageResult<BpmInst> result=new JsonPageResult(true,bpmInstList,filter.getPage().getTotalItems(),"get data success!");
		return result;
		
	}
	
	/**
	 * 删除流程实例
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "delInst", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonResult delInst(@RequestBody JSONObject cmdObj){
		
		String instId=JSONUtil.getString(cmdObj,"instId");
		if(StringUtils.isEmpty(instId)){
			return new JsonResult(true,"实例ID为空!");
		}
		
		BpmInst inst=bpmInstManager.get(instId);
		if(inst==null)	return new JsonResult(true,"流程实例为空!"); 
		String reason=StringUtil.isEmpty(JSONUtil.getString(cmdObj,"reason"))?"":JSONUtil.getString(cmdObj,"reason");
		bpmInstManager.deleteCascade(instId, reason);
		return new JsonResult(true,"删除流程实例成功!"); 
	}
	
	/**
	 * 保存流程草稿
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "saveDraft", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonResult saveDraft(@RequestBody JSONObject cmdObj){
		
		if(cmdObj.isEmpty()){
			return new JsonResult(false,"没有正确提交参数!");
		}

		ContextUtil.clearCurLocal();
	
		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
		if(StringUtil.isEmpty(userAccount)){
			return new JsonResult(false,"没有正确提交参数!");
		}

		String solId=JSONUtil.getString(cmdObj,"solId");
		String solKey=JSONUtil.getString(cmdObj, "solKey");
		if(StringUtil.isEmpty(solId) && StringUtils.isEmpty(solKey)){
			return new JsonResult(false,"没有提交流程解决方案ID(solId)或Key(solKey)!");
		}
		
    	IUser user=userService.getByUsername(userAccount);
    	
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
    	
    	try{
    		ContextUtil.setCurUser(user);
			ProcessStartCmd startCmd=new ProcessStartCmd();
			//传入非solKey
			if(StringUtils.isEmpty(solId) && StringUtils.isNotEmpty(solKey)){
				BpmSolution bpmSolution=bpmSolutionManager.getByKey(solKey, user.getTenant().getTenantId());
				if(bpmSolution==null){
					return new JsonResult(false,"没有找到（"+solKey+"）对应的流程解决方案！");
				}
				solId=bpmSolution.getSolId();
			}
			startCmd.setSolId(solId);
			startCmd.setJsonData(JSONUtil.getString(cmdObj, "jsonData","{}"));
			BpmInst bpmInst=bpmInstManager.doSaveDraft(startCmd);
			
			return new JsonResult(true,"成功保存草稿！",bpmInst);
    	}catch(Exception ex){
    		logger.error(ExceptionUtil.getExceptionMessage(ex));
    		return new JsonResult(false,"error:"+ ex.getMessage());
    	}
	}
	
	/**
	 * 获得我的流程草稿
	 * @param request
	 * {
		   "userAccount":"admin@redxun.cn",
		   "params":{
   	   		   "pageIndex":"0",
			   "pageSize":"1", 
			   "sortField":"create_time_",
			   "sortOrder":"asc",
		       "Q_SUBJECT__S_LK":"[测试]请假审批--管理员"
		   }
		}
	 * @return
	 */
	@RequestMapping(value = "getMyDrafts", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonPageResult getMyDrafts(@RequestBody JSONObject cmdObj){
		JsonPageResult result=new JsonPageResult();
		if(cmdObj.isEmpty()){
			return result;
		}
		ContextUtil.clearCurLocal();
		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		
		if(StringUtil.isEmpty(userAccount)){
			result.setMessage("没有正确提交参数!");
			result.setSuccess(false);
			return result;
		}
		IUser sysUser=userService.getByUsername(userAccount);
    	if(sysUser==null){
    		result.setSuccess(false);
			result.setMessage("用户账号"+userAccount+"不存在！");
			return result;
    	}
    	QueryFilter filter=QueryFilterBuilder.createQueryFilter(cmdObj);
    	filter.getParams().put("CREATE_BY_", sysUser.getUserId());
    	filter.getParams().put("STATUS_", BpmInst.STATUS_DRAFTED);
    	List<BpmInst> list=null;
    	try{
		    	 list=bpmInstManager.getMyInst(filter);
		    	 result.setSuccess(true);
		    	 result.setData(list);
		    	 result.setTotal(filter.getPage().getTotalItems());
		    	result.setMessage("get data success!");
		    	return result;
    	}catch(Exception ex){
    		result.setSuccess(false);
    		result.setMessage("error:"+ex.getMessage());
    		return result;
    	}
	}
	
	
	/**
	 * 从流程草稿中启动
	 * @param request
	 * {
		   "userAccount":"admin@redxun.cn",
		   "bpmInstId":"1000001",
		   "solId":"1"
		   "jsonData":{
		      "bos": [{
					"boDefId": "2610000000400004",
					"formKey": "demo",
					"data": {
						"d1": "a",
						"d2": "s"
					}
				}]
		   }
		}
	 * @return
	 */
	@RequestMapping(value = "startFromDraft", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public JsonResult startFromDraft(@RequestBody JSONObject cmdObj){
		ContextUtil.clearCurLocal();
		
		if(cmdObj.isEmpty()){
			return new JsonResult(false,"没有正确提交参数！");
		}
		String userAccount=JSONUtil.getString(cmdObj,"userAccount");
		if(StringUtil.isEmpty(userAccount)){
			return new JsonResult(false,"没有提交用户账号参数userAccount");
		}
		String bpmInstId=JSONUtil.getString(cmdObj,"bpmInstId");
		if(StringUtil.isEmpty(bpmInstId)){
			return new JsonResult(false,"没有提交草稿ID");
		}
		
		BpmInst draftInst=bpmInstManager.get(bpmInstId);

    	IUser user=userService.getByUsername(userAccount);
    	
    	if(user==null){
    		return new JsonResult(false,"用户账号"+userAccount+"不存在！");
    	}
    	String msg=null;
    	
    	try{
    		ContextUtil.setCurUser(user);
			ProcessStartCmd startCmd=new ProcessStartCmd();
			startCmd.setBpmInstId(bpmInstId);
			
			startCmd.setSolId(draftInst.getSolId());
			startCmd.setJsonData(JSONUtil.getString(cmdObj, "jsonData","{}"));
			startCmd.setBusinessKey(JSONUtil.getString(cmdObj, "businessKey"));
			
			String varArr=JSONUtil.getString(cmdObj, "vars");
			if(StringUtil.isNotEmpty(varArr)){
				Map<String,Object> vars=JSONUtil.jsonArr2Map(varArr);
				startCmd.setVars(vars);
			}
			BpmInst inst= bpmInstManager.doStartProcess(startCmd);
			
			return new JsonResult(true,"成功启动流程！",inst);
    	}catch(Exception ex){
    		msg=ex.getMessage();
    		logger.error(ExceptionUtil.getExceptionMessage(ex));
    	}
		return new JsonResult(false,msg);
	}
	
	/**
	 * 根据任务ID获取任务详细信息。
	 * <pre>
	 * 	1.任务对象信息
	 * 	2.流程变量信息
	 *  3.allowTask 任务是否允许执行
	 * </pre>
	 * @param taskId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getTaskInfo/{taskId}")
	@ResponseBody
	public com.alibaba.fastjson.JSONObject  getTaskInfo(@PathVariable String taskId) throws Exception{
		BpmTask task=bpmTaskManager.get(taskId);
		UserTaskConfig taskConfig = bpmNodeSetManager.getTaskConfig(task.getSolId(), task.getProcDefId(),task.getTaskDefKey());
		
		JsonResult<String> allowTask= bpmTaskManager.handAllowTask(task,taskConfig,null);
		
		Map<String, Object> vars= runtimeService.getVariables(task.getProcInstId());
		
		com.alibaba.fastjson.JSONObject data=new com.alibaba.fastjson.JSONObject();
		data.put("task", task);
		data.put("vars", vars);
		data.put("allowTask", allowTask);
		
		
		return data;
		
	}
	
	
	/**
	 * 获取下一步节点情况。
	 * @param taskId
	 * @return
	 */
	@RequestMapping(value = "getTaskNextInfo/{taskId}")
	@ResponseBody
	public JsonResult  getTaskNextInfo(@PathVariable String taskId){
		JsonResult result=new JsonResult<>(true);
		BpmTask task=bpmTaskManager.get(taskId);
		if(task==null){
			result.setSuccess(false);
			result.setMessage("任务已经结束!");
			return result;
		}
		BpmInst bpmInst = bpmInstManager.getByActInstId(task.getProcInstId());
		com.alibaba.fastjson.JSONObject rtn=new com.alibaba.fastjson.JSONObject();
		rtn.put("task", task);
		UserTaskConfig taskConfig = bpmNodeSetManager.getTaskConfig(bpmInst.getSolId(), task.getProcDefId(),task.getTaskDefKey());
		rtn.put("taskConfig", taskConfig);
		// 获得任务的下一步的人员映射列表
		List<DestNodeUsers> destNodeUserList = bpmTaskManager.getDestnationUsers(taskId);
		// 是否到达结束事件节点
		boolean isReachEndEvent = bpmTaskManager.isReachEndEvent(destNodeUserList);
		
		rtn.put("destNodeUserList", destNodeUserList);
		rtn.put("isReachEndEvent", isReachEndEvent);
		
		result.setData(rtn);
		
		return result;
		
	}

    
	
}
