package com.redxun.bpm.core.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.IdentityLink;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.BpmTaskUser;
import com.redxun.bpm.core.entity.BpmTestCase;
import com.redxun.bpm.core.entity.BpmTestSol;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.ProcessNextCmd;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmSolVarManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.core.manager.BpmTestCaseManager;
import com.redxun.bpm.core.manager.BpmTestSolManager;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * [BpmTestCase]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmTestCase/")
public class BpmTestCaseController extends BaseListController{
    @Resource
    BpmTestCaseManager bpmTestCaseManager;
    @Resource
    BpmTestSolManager bpmTestSolManager;
    @Resource
    BpmSolVarManager bpmSolVarManager;
    
    @Resource
    BpmInstManager bpmInstManager;
   
    @Resource
    BpmTaskManager bpmTaskManager;
    @Resource
    TaskService taskService;
    @Resource
    UserService userService;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "测试用例")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
            	BpmTestCase bpmTestCase=bpmTestCaseManager.get(id);
            	if(StringUtils.isNotEmpty(bpmTestCase.getInstId())){
            		try{
            			bpmInstManager.deleteCascade(bpmTestCase.getInstId(), "");
            		}catch(Exception ex){
            			logger.error(ex.getMessage());
            		}
            	}else{
            		bpmTestCaseManager.delete(id);
            	}
            }
        }
        return new JsonResult(true,"成功删除！");
    }
    
    /**
     * 添加新的测试用例
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("addNew")
    @ResponseBody
    @LogEnt(action = "addNew", module = "流程", submodule = "测试用例")
    public JsonResult addNew(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	String caseName=request.getParameter("caseName");
    	String testSolId=request.getParameter("testSolId");
    	//BpmTestSol bpmTestSol=bpmTestSolManager.get(testSolId);
    	BpmTestCase testCase=new BpmTestCase();
    	testCase.setCaseName(caseName);
    	testCase.setTestSolId(testSolId);
    	bpmTestCaseManager.create(testCase);
    	return new JsonResult(true,"成功添加测试用例！");
    }
    
    /**
     * 获得解决方案及测试方案中的变量列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getBySolIdTestId")
    @ResponseBody
    public List<BpmSolVar> getBySolIdTestId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String testId=request.getParameter("testId");
    	BpmTestCase testCase=bpmTestCaseManager.get(testId);
    	String solId = testCase.getTestSolId();
    	BpmTestSol testSol=bpmTestSolManager.get(solId);
    	String actDefId=testSol.getActDefId();
    	List<BpmSolVar> vars=bpmSolVarManager.getBySolIdActDefId(solId, actDefId);
    	
    	if(StringUtils.isNotEmpty(testCase.getParamsConf())){
    		JSONArray varArr=JSONArray.fromObject(testCase.getParamsConf());
    		for(int i=0;i<varArr.size();i++){
    			JSONObject varJson=varArr.getJSONObject(i);
    			String key=JSONUtil.getString(varJson, "name");
    			String defVal=JSONUtil.getString(varJson,"value");
    			if(StringUtils.isEmpty(key)) continue;
    			for(BpmSolVar var:vars){
    				if(var.getKey().equals(key)){
    					var.setDefVal(defVal);
    					break;
    				}
    			}
    		}
    	}
    	return vars;
    }
    
    /**
     * 运行流程测试用例
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("run")
    @ResponseBody
    @LogEnt(action = "run", module = "流程", submodule = "测试用例")
    public JsonResult run(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	return bpmTestCaseManager.doRun(request, response);
    }
    
    /**
     * 处理任务的跳转
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("runNext")
    @ResponseBody
    @LogEnt(action = "runNext", module = "流程", submodule = "测试用例")
    public JsonResult runNext(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	//String testId=request.getParameter("testId");
    	String cmdData=request.getParameter("cmdData");
    	JSONArray jsonArr=JSONArray.fromObject(cmdData);
    	JsonResult jsonResult=new JsonResult(true);
    	String vars=request.getParameter("vars");
		Map<String,Object> varMaps=JSONUtil.jsonArr2Map(vars);
		ProcessHandleHelper.clearBackPath();
    	for(int i=0;i<jsonArr.size();i++){
    		JSONObject jsonObj=jsonArr.getJSONObject(i);
    		String userId=jsonObj.getString("userId");
    		String taskId=jsonObj.getString("taskId");
    		String jumpType=jsonObj.getString("jumpType");
    		String opinion=jsonObj.getString("opinion");
	    	ProcessMessage handleMessage=new ProcessMessage();
	    	IUser user=userService.getByUserId(userId);
	    	if(BeanUtil.isEmpty(user)){
	    		handleMessage.getErrorMsges().add("用户(Id:"+userId+")没有配置处理账号!");
	    	}
	    	try{
	    		ContextUtil.setCurUser(user);
		    	ProcessHandleHelper.setProcessMessage(handleMessage);
		    	ProcessNextCmd processNextCmd=new ProcessNextCmd();
		    	processNextCmd.setJumpType(jumpType);
		    	processNextCmd.setTaskId(taskId);
		    	processNextCmd.setOpinion(opinion);
		    	processNextCmd.setVars(varMaps);
		    	bpmTaskManager.doNext(processNextCmd);
	    	}catch(Exception ex){
	    		ex.printStackTrace();
	    		if(handleMessage.getErrorMsges().size()==0){
	    			handleMessage.getErrorMsges().add(ex.getMessage());
	    		}
	    	}finally{
	    		ProcessHandleHelper.clearProcessMessage();
	    		ContextUtil.clearCurLocal();
	    		//在处理过程中，是否有错误的消息抛出
	    		if(handleMessage.getErrorMsges().size()>0){
	    			jsonResult.setMessage(jsonResult.getMessage()+"/n"+ handleMessage.getErrors());
	    		}else{
	    			jsonResult.setMessage(jsonResult.getMessage()+"/n 成功处理任务！");
	    		}
	    	}
    	}
    	return jsonResult;
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
        
        BpmTestCase bpmTestCase=null;
        
        if(StringUtils.isNotEmpty(pkId)){
           bpmTestCase=bpmTestCaseManager.get(pkId);
        }else{
        	bpmTestCase=new BpmTestCase();
        }
        ModelAndView mv=getPathView(request);
        
        if(StringUtils.isNotEmpty(bpmTestCase.getInstId())){
        	BpmInst bpmInst=bpmInstManager.get(bpmTestCase.getInstId());
        	//实例已经删除
        	List<BpmTask> taskList=bpmTaskManager.getByActInstId(bpmInst.getActInstId());
        	List<BpmTaskUser> taskUserList=new ArrayList<BpmTaskUser>();
        	for(BpmTask task:taskList){
        		BpmTaskUser taskUser=new BpmTaskUser();
        		taskUser.setNodeId(task.getTaskDefKey());
        		taskUser.setTaskName(task.getName());
        		taskUser.setTaskId(task.getId());
        		List<IUser> jsonUsers=new ArrayList<IUser>();
        		
        		if(StringUtils.isNotEmpty(task.getAssignee())){
        			IUser user=userService.getByUserId(task.getAssignee());
        			jsonUsers.add(user);
        		}else{//获得候选用户列表
        				//取得候选的用户详细信息 
        		       List<IdentityLink> idLinks=taskService.getIdentityLinksForTask(task.getId());
        		       for(IdentityLink idLink:idLinks){
        		    	   if(StringUtils.isNotEmpty(idLink.getGroupId()) && "candidate".equals(idLink.getType())){
        		    		  List<IUser> osUsers=userService.getByGroupIdAndType(idLink.getGroupId(), idLink.getType()) ;
        		    		  jsonUsers.addAll(osUsers);
        		    	   }else if(StringUtils.isNotEmpty(idLink.getUserId())&& "candidate".equals(idLink.getType())){
        		    		   IUser user=userService.getByUserId(idLink.getUserId());
        		    		   jsonUsers.add(user);
        		    	   }
        		       }
        		}
        		taskUser.setUserJsons(iJson.toJson(jsonUsers));
        		taskUserList.add(taskUser);
        	}
        	mv.addObject("taskUserList",taskUserList);
        	mv.addObject("bpmInst",bpmInst);
        }
        if(StringUtils.isNotEmpty(bpmTestCase.getStartUserId())){
        	IUser user=userService.getByUserId(bpmTestCase.getStartUserId());
        	mv.addObject("startUser",user);
        }else{
        	IUser user=ContextUtil.getCurrentUser();
        	mv.addObject("startUser",user);
        	bpmTestCase.setStartUserId(user.getUserId());
        }
        return mv.addObject("bpmTestCase",bpmTestCase);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmTestCase bpmTestCase=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmTestCase=bpmTestCaseManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmTestCase.setTestId(null);
    		}
    	}else{
    		bpmTestCase=new BpmTestCase();
    	}
    	return getPathView(request).addObject("bpmTestCase",bpmTestCase);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmTestCaseManager;
	}

}
