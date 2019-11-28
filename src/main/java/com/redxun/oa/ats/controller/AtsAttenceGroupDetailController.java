
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
import com.redxun.oa.ats.entity.AtsAttenceGroupDetail;
import com.redxun.oa.ats.manager.AtsAttenceGroupDetailManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 考勤组明细控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceGroupDetail/")
public class AtsAttenceGroupDetailController extends MybatisListController{
    @Resource
    AtsAttenceGroupDetailManager atsAttenceGroupDetailManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "考勤组明细")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsAttenceGroupDetailManager.delete(id);
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
        AtsAttenceGroupDetail atsAttenceGroupDetail=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsAttenceGroupDetail=atsAttenceGroupDetailManager.get(pkId);
        }else{
        	atsAttenceGroupDetail=new AtsAttenceGroupDetail();
        }
        return getPathView(request).addObject("atsAttenceGroupDetail",atsAttenceGroupDetail);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsAttenceGroupDetail atsAttenceGroupDetail=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsAttenceGroupDetail=atsAttenceGroupDetailManager.get(pkId);
    	}else{
    		atsAttenceGroupDetail=new AtsAttenceGroupDetail();
    	}
    	return getPathView(request).addObject("atsAttenceGroupDetail",atsAttenceGroupDetail);
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
        AtsAttenceGroupDetail atsAttenceGroupDetail = atsAttenceGroupDetailManager.getAtsAttenceGroupDetail(uId);
        String json = JSON.toJSONString(atsAttenceGroupDetail);
        return json;
    }
    
    /**
     * 查看用户所属组织
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("getUserGroup")
    @ResponseBody
    public String getUserGroup(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "userId");    	
        String orgName = atsAttenceGroupDetailManager.getUserGroup(uId);
        return orgName;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsAttenceGroupDetailManager;
	}

}
