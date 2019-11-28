
package com.redxun.oa.ats.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.entity.AtsCalendarTempl;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.manager.AtsCalendarTemplManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 日历模版控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsCalendarTempl/")
public class AtsCalendarTemplController extends MybatisListController{
    @Resource
    AtsCalendarTemplManager atsCalendarTemplManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "日历模版")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
        	boolean flag = false;
            String[] ids=uId.split(",");
            for(String id:ids){
            	AtsCalendarTempl templ = atsCalendarTemplManager.get(id);
            	if(AtsConstant.YES==templ.getIsSys()) {
            		flag = true;
            		continue;
            	}
            	atsCalendarTemplManager.delete(id);
            }
            if(flag) {
            	return new JsonResult(false,"此为系统预置数据，不能删除");
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
        AtsCalendarTempl atsCalendarTempl=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsCalendarTempl=atsCalendarTemplManager.get(pkId);
        }else{
        	atsCalendarTempl=new AtsCalendarTempl();
        }
        return getPathView(request).addObject("atsCalendarTempl",atsCalendarTempl);
    }
    
    /**
     * 查看明细
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("getDetail")
    public void getDetail(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	response.setContentType("application/json");
		QueryFilter queryFilter=getQueryFilter(request);
		
		List<?> list=atsCalendarTemplManager.getDetail(queryFilter);
		JsonPageResult<?> result=new JsonPageResult(list,queryFilter.getPage().getTotalItems());
		String jsonResult=iJson.toJson(result);
		PrintWriter pw=response.getWriter();
		pw.println(jsonResult);
		pw.close();
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsCalendarTempl atsCalendarTempl=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsCalendarTempl=atsCalendarTemplManager.get(pkId);
    	}else{
    		atsCalendarTempl=new AtsCalendarTempl();
    	}
    	return getPathView(request).addObject("atsCalendarTempl",atsCalendarTempl);
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
        AtsCalendarTempl atsCalendarTempl = atsCalendarTemplManager.getAtsCalendarTempl(uId);
        String json = JSON.toJSONString(atsCalendarTempl);
        return json;
    }
    

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsCalendarTemplManager;
	}

}
