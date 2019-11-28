
package com.redxun.oa.ats.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.entity.AtsLegalHolidayDetail;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.oa.ats.manager.AtsLegalHolidayDetailManager;
import com.redxun.oa.ats.manager.AtsShiftInfoManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 班次设置控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftInfo/")
public class AtsShiftInfoController extends MybatisListController{
    @Resource
    AtsShiftInfoManager atsShiftInfoManager;
    @Resource
    AtsLegalHolidayDetailManager atsLegalHolidayDetailManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "班次设置")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsShiftInfoManager.delete(id);
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
        AtsShiftInfo atsShiftInfo=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsShiftInfo=atsShiftInfoManager.get(pkId);
        }else{
        	atsShiftInfo=new AtsShiftInfo();
        }
        return getPathView(request).addObject("atsShiftInfo",atsShiftInfo);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsShiftInfo atsShiftInfo=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsShiftInfo=atsShiftInfoManager.get(pkId);
    	}else{
    		atsShiftInfo=new AtsShiftInfo();
    	}
    	return getPathView(request).addObject("atsShiftInfo",atsShiftInfo);
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
        AtsShiftInfo atsShiftInfo = atsShiftInfoManager.getAtsShiftInfo(uId);
        String json = JSON.toJSONString(atsShiftInfo);
        return json;
    }
    
    @RequestMapping("replace")
    public ModelAndView replace(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	Date start = RequestUtil.getDate(request, "start");
    	QueryFilter queryFilter = getQueryFilter(request);
    	List<AtsLegalHolidayDetail> holidayNameList = atsLegalHolidayDetailManager.getMybatisAll(queryFilter);
    	
    	Set<String> holidayNameSet = new HashSet<String>();
    	for (AtsLegalHolidayDetail atsLegalHolidayDetail : holidayNameList) {
    		Date startTime = atsLegalHolidayDetail.getStartTime();
    		Date endTime = atsLegalHolidayDetail.getEndTime();
    		int a = startTime.compareTo(start);
    		int b = endTime.compareTo(start);
    		if(a<=0 && b>=0) {
    			holidayNameSet.add(atsLegalHolidayDetail.getName());
    		}
		}
    	
    	boolean isHoliday = true;
    	if(BeanUtil.isEmpty(holidayNameSet)) {
    		isHoliday = false;
    	}
    	
    	return getPathView(request).addObject("holidayNameSet",holidayNameSet).addObject("isHoliday",isHoliday);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsShiftInfoManager;
	}

}
