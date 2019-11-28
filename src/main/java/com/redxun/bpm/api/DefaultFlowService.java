package com.redxun.bpm.api;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;

/**
 * 流程服务对外接口
 * @author mansan
 *
 */
public class DefaultFlowService implements IFlowService{

	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	UserService userService;

	@Override
	public JsonResult<BpmInst> startProcess(String json) {
		JSONObject jsonObj=JSONObject.parseObject(json);
		String acc=jsonObj.getString(IFlowService.ACC_ACCOUNT);
		String startUserId=null;
		JsonResult<BpmInst> result=new JsonResult<BpmInst>();
		//检查用户账号是否存在
		if(StringUtils.isNotEmpty(acc)){
			IUser user=userService.getByUsername(acc);
			if(user!=null){
				startUserId=user.getUserId();
			}else{
				result.setSuccess(false);
				result.setMessage("用户账号["+acc+"]对应的用户不存在！");
				return result;
			}
		}
		
		if(StringUtils.isEmpty(startUserId)){
			startUserId=ContextUtil.getCurrentUserId();
		}
		
		String solKey=jsonObj.getString(IFlowService.SOL_KEY);
		//检查对应的账号是否存在
		if(StringUtils.isEmpty(solKey)){
			result.setSuccess(false);
			result.setMessage("solKey参数属性不能为空！");
			return result;
		}
		
		String busKey=jsonObj.getString(IFlowService.BUS_KEY);
		String jsonData=jsonObj.getString(IFlowService.JSON_DATA);
		String vars=jsonObj.getString(IFlowService.VARS);
		
		return startProcessByUserId(startUserId,solKey,busKey,jsonData,vars);
	}
	
	@Override
	public JsonResult<BpmInst> startProcessByAccount(String account,
			String solKey, String busKey, String jsonData, String vars) {
		String startUserId=null;
		JsonResult<BpmInst> result=new JsonResult<BpmInst>();
		//检查用户账号是否存在
		if(StringUtils.isNotEmpty(account)){
			IUser user=userService.getByUsername(account);
			if(user!=null){
				startUserId=user.getUserId();
			}else{
				result.setSuccess(false);
				result.setMessage("用户账号["+account+"]对应的用户不存在！");
				return result;
			}
		}
		if(StringUtils.isEmpty(startUserId)){
			startUserId=ContextUtil.getCurrentUserId();
		}
		return startProcessByUserId(startUserId,solKey,busKey,jsonData,vars);
	}
	
	@Override
	public JsonResult<BpmInst> startProcessByUserId(String userId, String solKey,
			String busKey, String jsonData, String vars) {
		IUser user=userService.getByUserId(userId);
		String tenantId=user.getTenant().getTenantId();
		BpmSolution bpmSolution=bpmSolutionManager.getByKey(solKey, tenantId);
		JsonResult<BpmInst> result= startProcess(userId,bpmSolution.getSolId(),busKey,jsonData,vars,true,"");
		return result;
	}
	
	@Override
	public JsonResult<BpmInst> startProcess(String userId, String solId, String busKey, String jsonData, String vars,boolean startFlow,String from) {
		JsonResult<BpmInst> result=new JsonResult<BpmInst>();
		try{
			
			IUser user=userService.getByUserId(userId);
    		ContextUtil.setCurUser(user);
			ProcessStartCmd startCmd=new ProcessStartCmd();
			//忽略任务的处理
			startCmd.setSkipHandler(true);
			startCmd.setSolId(solId);
			startCmd.setJsonData(jsonData);
			startCmd.setBusinessKey(busKey);
			startCmd.setFrom(from);
			if(StringUtil.isEmpty(vars)){
				vars="[]";
			}
			Map<String,Object> varsArr=JSONUtil.jsonArr2Map(vars);
			startCmd.setVars(varsArr);
			
			if(StringUtil.isNotEmpty(busKey)){
				BpmInst bpmInst=bpmInstManager.getByBusKey(busKey);
				if(bpmInst!=null){
					startCmd.setBpmInstId(bpmInst.getInstId());
				}
			}
			
			BpmInst inst= null;
			String msg="成功启动流程";
			if(startFlow){
				inst= bpmInstManager.doStartProcess(startCmd);
			}
			else{
				inst= bpmInstManager.doSaveDraft(startCmd);
			}
			 
			result.setSuccess(true);
			result.setMessage(msg);
			result.setData(inst);
    	}catch(Exception ex){
    		result.setSuccess(false);
    		result.setMessage("启动流程出错！"+ ex.getMessage());
    		ex.printStackTrace();
    	}finally{
    		ContextUtil.clearCurLocal();
    	}
		return result;
	}

	@Override
	public List<BpmTask> getTaskByUser(String account) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BpmTask> getTaskByUser(String account, String solId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<JSONObject> getTaskMapByInsts(String account,
			List<String> instIds) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public JsonResult<Void> complete(String json) {
		// TODO Auto-generated method stub
		return null;
	}

	

	



}
