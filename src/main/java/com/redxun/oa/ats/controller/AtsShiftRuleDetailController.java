
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
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.entity.AtsShiftRuleDetail;
import com.redxun.oa.ats.manager.AtsShiftRuleDetailManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 轮班规则明细控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftRuleDetail/")
public class AtsShiftRuleDetailController extends MybatisListController{
    @Resource
    AtsShiftRuleDetailManager atsShiftRuleDetailManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "轮班规则明细")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsShiftRuleDetailManager.delete(id);
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
        AtsShiftRuleDetail atsShiftRuleDetail=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsShiftRuleDetail=atsShiftRuleDetailManager.get(pkId);
        }else{
        	atsShiftRuleDetail=new AtsShiftRuleDetail();
        }
        return getPathView(request).addObject("atsShiftRuleDetail",atsShiftRuleDetail);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsShiftRuleDetail atsShiftRuleDetail=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsShiftRuleDetail=atsShiftRuleDetailManager.get(pkId);
    	}else{
    		atsShiftRuleDetail=new AtsShiftRuleDetail();
    	}
    	return getPathView(request).addObject("atsShiftRuleDetail",atsShiftRuleDetail);
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
        AtsShiftRuleDetail atsShiftRuleDetail = atsShiftRuleDetailManager.getAtsShiftRuleDetail(uId);
        String json = JSON.toJSONString(atsShiftRuleDetail);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsShiftRuleDetailManager;
	}

}
