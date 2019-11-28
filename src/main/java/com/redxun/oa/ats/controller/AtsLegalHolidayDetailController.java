
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
import com.redxun.oa.ats.entity.AtsLegalHolidayDetail;
import com.redxun.oa.ats.manager.AtsLegalHolidayDetailManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 法定节假日明细控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsLegalHolidayDetail/")
public class AtsLegalHolidayDetailController extends MybatisListController{
    @Resource
    AtsLegalHolidayDetailManager atsLegalHolidayDetailManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "法定节假日明细")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsLegalHolidayDetailManager.delete(id);
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
        AtsLegalHolidayDetail atsLegalHolidayDetail=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsLegalHolidayDetail=atsLegalHolidayDetailManager.get(pkId);
        }else{
        	atsLegalHolidayDetail=new AtsLegalHolidayDetail();
        }
        return getPathView(request).addObject("atsLegalHolidayDetail",atsLegalHolidayDetail);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsLegalHolidayDetail atsLegalHolidayDetail=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsLegalHolidayDetail=atsLegalHolidayDetailManager.get(pkId);
    	}else{
    		atsLegalHolidayDetail=new AtsLegalHolidayDetail();
    	}
    	return getPathView(request).addObject("atsLegalHolidayDetail",atsLegalHolidayDetail);
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
        AtsLegalHolidayDetail atsLegalHolidayDetail = atsLegalHolidayDetailManager.getAtsLegalHolidayDetail(uId);
        String json = JSON.toJSONString(atsLegalHolidayDetail);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsLegalHolidayDetailManager;
	}

}
