package com.redxun.bpm.core.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.core.entity.BpmRemindInst;
import com.redxun.bpm.core.manager.BpmRemindInstManager;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmRemindInst]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmRemindInst/")
public class BpmRemindInstController extends BaseListController{
    @Resource
    BpmRemindInstManager bpmRemindInstManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "催办实例")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmRemindInstManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
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
        String pkId=request.getParameter("pkId");
        BpmRemindInst bpmRemindInst=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmRemindInst=bpmRemindInstManager.get(pkId);
        }else{
        	bpmRemindInst=new BpmRemindInst();
        }
        return getPathView(request).addObject("bpmRemindInst",bpmRemindInst);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmRemindInst bpmRemindInst=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmRemindInst=bpmRemindInstManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmRemindInst.setId(null);
    		}
    	}else{
    		bpmRemindInst=new BpmRemindInst();
    	}
    	return getPathView(request).addObject("bpmRemindInst",bpmRemindInst);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmRemindInstManager;
	}
	
	@RequestMapping("listJson")
	@ResponseBody
	public  JsonPageResult listJson(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		List<BpmRemindInst> list= getBaseManager().getAll(queryFilter);
		JsonPageResult<?> result=new JsonPageResult(list,queryFilter.getPage().getTotalItems());
		return result;
		
	}

}
