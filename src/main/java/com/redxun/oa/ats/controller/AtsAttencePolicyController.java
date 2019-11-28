
package com.redxun.oa.ats.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.entity.AtsAttencePolicy;
import com.redxun.oa.ats.manager.AtsAttencePolicyManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 考勤制度控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttencePolicy/")
public class AtsAttencePolicyController extends MybatisListController{
    @Resource
    AtsAttencePolicyManager atsAttencePolicyManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "考勤制度")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsAttencePolicyManager.delete(id);
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
        AtsAttencePolicy atsAttencePolicy=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsAttencePolicy=atsAttencePolicyManager.get(pkId);
        }else{
        	atsAttencePolicy=new AtsAttencePolicy();
        }
        return getPathView(request).addObject("atsAttencePolicy",atsAttencePolicy);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsAttencePolicy atsAttencePolicy=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsAttencePolicy=atsAttencePolicyManager.get(pkId);
    	}else{
    		atsAttencePolicy=new AtsAttencePolicy();
    	}
    	return getPathView(request).addObject("atsAttencePolicy",atsAttencePolicy);
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
    public String getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        AtsAttencePolicy atsAttencePolicy = atsAttencePolicyManager.getAtsAttencePolicy(uId);
        String json = JSON.toJSONString(atsAttencePolicy);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsAttencePolicyManager;
	}

}
