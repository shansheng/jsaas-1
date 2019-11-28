
package com.airdrop.wxrepair.core.controller;

import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireType;
import com.airdrop.wxrepair.core.manager.PatrolQuestionnaireTypeManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
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
 * 问卷类型控制器
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolQuestionnaireType/")
public class PatrolQuestionnaireTypeController extends MybatisListController{
    @Resource
    PatrolQuestionnaireTypeManager patrolQuestionnaireTypeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "问卷类型")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                patrolQuestionnaireTypeManager.delete(id);
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
        PatrolQuestionnaireType patrolQuestionnaireType=null;
        if(StringUtils.isNotEmpty(pkId)){
           patrolQuestionnaireType=patrolQuestionnaireTypeManager.get(pkId);
        }else{
        	patrolQuestionnaireType=new PatrolQuestionnaireType();
        }
        return getPathView(request).addObject("patrolQuestionnaireType",patrolQuestionnaireType);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	PatrolQuestionnaireType patrolQuestionnaireType=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		patrolQuestionnaireType=patrolQuestionnaireTypeManager.get(pkId);
    	}else{
    		patrolQuestionnaireType=new PatrolQuestionnaireType();
    	}
    	return getPathView(request).addObject("patrolQuestionnaireType",patrolQuestionnaireType);
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
    public PatrolQuestionnaireType getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        PatrolQuestionnaireType patrolQuestionnaireType = patrolQuestionnaireTypeManager.getPatrolQuestionnaireType(uId);
        return patrolQuestionnaireType;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "问卷类型")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolQuestionnaireType patrolQuestionnaireType, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(patrolQuestionnaireType.getId())) {
            patrolQuestionnaireTypeManager.create(patrolQuestionnaireType);
            msg = getMessage("patrolQuestionnaireType.created", new Object[]{patrolQuestionnaireType.getIdentifyLabel()}, "[问卷类型]成功创建!");
        } else {
        	String id=patrolQuestionnaireType.getId();
        	PatrolQuestionnaireType oldEnt=patrolQuestionnaireTypeManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, patrolQuestionnaireType);
            patrolQuestionnaireTypeManager.update(oldEnt);
       
            msg = getMessage("patrolQuestionnaireType.updated", new Object[]{patrolQuestionnaireType.getIdentifyLabel()}, "[问卷类型]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return patrolQuestionnaireTypeManager;
	}

    @RequestMapping("getAllType")
    @ResponseBody
    public List<PatrolQuestionnaireType> getAllType(HttpServletRequest request,HttpServletResponse response)throws Exception{
        List<PatrolQuestionnaireType> allType = patrolQuestionnaireTypeManager.getAllType();
        return allType;
    }
}
