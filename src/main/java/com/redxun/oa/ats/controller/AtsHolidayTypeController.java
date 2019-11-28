
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
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsHolidayType;
import com.redxun.oa.ats.manager.AtsHolidayTypeManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 假期类型控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsHolidayType/")
public class AtsHolidayTypeController extends MybatisListController{
    @Resource
    AtsHolidayTypeManager atsHolidayTypeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "假期类型")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
        	boolean flag = false;
            String[] ids=uId.split(",");
            for(String id:ids){
            	AtsHolidayType type = atsHolidayTypeManager.get(id);
            	if(AtsConstant.YES==type.getIsSys()) {
            		flag = true;
            		continue;
            	}
            	atsHolidayTypeManager.delete(id);
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
        AtsHolidayType atsHolidayType=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsHolidayType=atsHolidayTypeManager.get(pkId);
        }else{
        	atsHolidayType=new AtsHolidayType();
        }
        return getPathView(request).addObject("atsHolidayType",atsHolidayType);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsHolidayType atsHolidayType=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsHolidayType=atsHolidayTypeManager.get(pkId);
    	}else{
    		atsHolidayType=new AtsHolidayType();
    	}
    	return getPathView(request).addObject("atsHolidayType",atsHolidayType);
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
        AtsHolidayType atsHolidayType = atsHolidayTypeManager.getAtsHolidayType(uId);
        String json = JSON.toJSONString(atsHolidayType);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsHolidayTypeManager;
	}

}
