
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
import com.redxun.oa.ats.entity.AtsBaseItem;
import com.redxun.oa.ats.manager.AtsBaseItemManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 基础数据控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsBaseItem/")
public class AtsBaseItemController extends MybatisListController{
    @Resource
    AtsBaseItemManager atsBaseItemManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "基础数据")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
        	boolean flag = false;
            String[] ids=uId.split(",");
            for(String id:ids){
            	AtsBaseItem item = atsBaseItemManager.get(id);
            	if(atsBaseItemManager.ISSYS==item.getIsSys()) {
            		flag = true;
            		continue;
            	}
                atsBaseItemManager.delete(id);
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
        AtsBaseItem atsBaseItem=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsBaseItem=atsBaseItemManager.get(pkId);
        }else{
        	atsBaseItem=new AtsBaseItem();
        }
        return getPathView(request).addObject("atsBaseItem",atsBaseItem);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsBaseItem atsBaseItem=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsBaseItem=atsBaseItemManager.get(pkId);
    	}else{
    		atsBaseItem=new AtsBaseItem();
    	}
    	return getPathView(request).addObject("atsBaseItem",atsBaseItem);
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
        AtsBaseItem atsBaseItem = atsBaseItemManager.getAtsBaseItem(uId);
        String json = JSON.toJSONString(atsBaseItem);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsBaseItemManager;
	}

}
