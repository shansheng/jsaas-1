
package com.redxun.oa.ats.controller;

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
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.ats.entity.AtsShiftRule;
import com.redxun.oa.ats.entity.AtsShiftRuleDetail;
import com.redxun.oa.ats.manager.AtsShiftRuleManager;
import com.redxun.oa.ats.manager.AtsShiftTimeManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 轮班规则控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftRule/")
public class AtsShiftRuleController extends MybatisListController{
    @Resource
    AtsShiftRuleManager atsShiftRuleManager;
    @Resource
    AtsShiftTimeManager atsShiftTimeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "轮班规则")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsShiftRuleManager.delete(id);
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
        AtsShiftRule atsShiftRule=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsShiftRule=atsShiftRuleManager.get(pkId);
        }else{
        	atsShiftRule=new AtsShiftRule();
        }
        return getPathView(request).addObject("atsShiftRule",atsShiftRule);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsShiftRule atsShiftRule=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsShiftRule=atsShiftRuleManager.get(pkId);
    	}else{
    		atsShiftRule=new AtsShiftRule();
    	}
    	return getPathView(request).addObject("atsShiftRule",atsShiftRule);
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
        AtsShiftRule atsShiftRule = atsShiftRuleManager.getAtsShiftRule(uId);
        
        List<AtsShiftRuleDetail> list = atsShiftRule.getAtsShiftRuleDetails();
        for (AtsShiftRuleDetail atsShiftRuleDetail : list) {
        	String time = atsShiftTimeManager.getShiftTime(atsShiftRuleDetail.getShiftId());
        	atsShiftRuleDetail.setShiftTime(time);
        }
        
        String json = JSON.toJSONString(atsShiftRule);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsShiftRuleManager;
	}

	@RequestMapping("detail")
	@ResponseBody
	public String detail(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String id = RequestUtil.getString(request, "id");

		return atsShiftRuleManager.getDetailList(id);
	}
	
	@Override
	public List<?> getPage(QueryFilter queryFilter) {
		String tenantId=ContextUtil.getCurrentTenantId();
		queryFilter.addFieldParam("a.TENANT_ID_", tenantId);
		return getBaseManager().getMybatisAll(queryFilter);
	}
}
