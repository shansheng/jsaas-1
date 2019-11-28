
package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireInfo;
import com.airdrop.wxrepair.core.manager.PatrolQuestionnaireInfoManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 问卷信息控制器
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolQuestionnaireInfo/")
public class PatrolQuestionnaireInfoController extends MybatisListController{
    @Resource
    PatrolQuestionnaireInfoManager patrolQuestionnaireInfoManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "问卷信息")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                patrolQuestionnaireInfoManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
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
        String pkId=RequestUtil.getString(request, "pkId");
        PatrolQuestionnaireInfo patrolQuestionnaireInfo=null;
        if(StringUtils.isNotEmpty(pkId)){
           patrolQuestionnaireInfo=patrolQuestionnaireInfoManager.get(pkId);
        }else{
        	patrolQuestionnaireInfo=new PatrolQuestionnaireInfo();
        }
        return getPathView(request).addObject("patrolQuestionnaireInfo",patrolQuestionnaireInfo);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	PatrolQuestionnaireInfo patrolQuestionnaireInfo=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		patrolQuestionnaireInfo=patrolQuestionnaireInfoManager.get(pkId);
    	}else{
    		patrolQuestionnaireInfo=new PatrolQuestionnaireInfo();
    	}
        IUser curUser = ContextUtil.getCurrentUser();
    	return getPathView(request).addObject("patrolQuestionnaireInfo",patrolQuestionnaireInfo).addObject("user",curUser);
    }
    
    /**
     * 有子表的情况下编辑明细的json
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("getJson")
    @ResponseBody
    public PatrolQuestionnaireInfo getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        PatrolQuestionnaireInfo patrolQuestionnaireInfo = patrolQuestionnaireInfoManager.getPatrolQuestionnaireInfo(uId);
        return patrolQuestionnaireInfo;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "问卷信息")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolQuestionnaireInfo patrolQuestionnaireInfo, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(patrolQuestionnaireInfo.getId())) {
            patrolQuestionnaireInfoManager.create(patrolQuestionnaireInfo);
            msg = getMessage("patrolQuestionnaireInfo.created", new Object[]{patrolQuestionnaireInfo.getIdentifyLabel()}, "[问卷信息]成功创建!");
        } else {
        	String id=patrolQuestionnaireInfo.getId();
        	PatrolQuestionnaireInfo oldEnt=patrolQuestionnaireInfoManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, patrolQuestionnaireInfo);
            patrolQuestionnaireInfoManager.update(oldEnt);
       
            msg = getMessage("patrolQuestionnaireInfo.updated", new Object[]{patrolQuestionnaireInfo.getIdentifyLabel()}, "[问卷信息]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return patrolQuestionnaireInfoManager;
	}

    /**
     * 获取到所有问卷
     * @return
     * @throws Exception
     */
    @RequestMapping("getAllQuestionnaire")
    @ResponseBody
    public ResResult getAllQuestionnaire() throws Exception {
        ResResult result = new ResResult();
        ResultMap resultMap = new ResultMap();
        List<PatrolQuestionnaireInfo> list = patrolQuestionnaireInfoManager.getAllQuestionnaire();
        resultMap.setResCode(0);
        resultMap.setResMsg("获取全部巡检单信息");
        resultMap.setData(list);
        result.setResCode(0);
        result.setResMsg("请求成功");
        result.setResult(resultMap);
        return result;
    }
}
