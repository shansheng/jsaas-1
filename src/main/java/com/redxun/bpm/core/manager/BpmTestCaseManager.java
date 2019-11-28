package com.redxun.bpm.core.manager;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.dao.BpmTestCaseDao;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmTestCase;
import com.redxun.bpm.core.entity.ProcessMessage;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.core.dao.IDao;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
/**
 * <pre> 
 * 描述：BpmTestCase业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmTestCaseManager extends BaseManager<BpmTestCase>{
	@Resource
	private BpmTestCaseDao bpmTestCaseDao;
	@Resource
	private UserService userService;
	@Resource
	private BpmInstManager bpmInstManager;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmTestCaseDao;
	}
	/**
	 * 通过测试方案Id获得测试用例列表
	 * @param testSolId
	 * @return
	 */
	public List<BpmTestCase> getByTestSolId(String testSolId){
		return bpmTestCaseDao.getByTestSolId(testSolId);
	}
	
	public void delByInstId(String instId){
		bpmTestCaseDao.delByInstId(instId);
	}
	
	 /**
     * 运行流程测试用例
     * @param request
     * @param response
     * @return
     * @throws Exception
     */

    @ResponseBody
    public JsonResult doRun(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String testId=request.getParameter("testId");
    	String startUserId=request.getParameter("startUserId");
    	String varArr=request.getParameter("vars");
    	//获得设置的当前执行用户
    	String userConf=request.getParameter("userConf");
    	//更新执行
    	BpmTestCase testCase=get(testId);
    	testCase.setParamsConf(varArr);
    	testCase.setUserConf(userConf);
    	testCase.setStartUserId(startUserId);
 
		//加上处理的消息提示
    	ProcessMessage handleMessage=new ProcessMessage();
    	IUser user=userService.getByUserId(startUserId);
    	if(BeanUtil.isEmpty(user)){
    		handleMessage.getErrorMsges().add("用户(Id:"+startUserId+")没有配置处理账号!");
    	}
    	
    	JsonResult result=new JsonResult();
    	try{
    		ContextUtil.setCurUser(user);
	    	ProcessHandleHelper.setProcessMessage(handleMessage);
	    	ProcessStartCmd startCmd=new ProcessStartCmd();
			startCmd.setSolId(testCase.getTestSolId());
			startCmd.setJsonData("{}");
			Map<String,Object> vars=JSONUtil.jsonArr2Map(varArr);
			startCmd.setVars(vars);
			BpmInst inst= bpmInstManager.doStartProcess(startCmd);
			testCase.setInstId(inst.getInstId());
			update(testCase);
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
    			result.setMessage("成功启动流程！");
    		}
    		ProcessHandleHelper.clearProcessMessage();
    		ContextUtil.clearCurLocal(); 
    	}
		
    	return new JsonResult(true,"成功运行！");
    }
	
}