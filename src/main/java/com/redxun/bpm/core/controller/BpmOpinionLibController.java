package com.redxun.bpm.core.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.activemq.filter.function.makeListFunction;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.core.entity.BpmOpinionLib;
import com.redxun.bpm.core.manager.BpmOpinionLibManager;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;

/**
 * 审批意见管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmOpinionLib/")
public class BpmOpinionLibController extends BaseListController{
    @Resource
    BpmOpinionLibManager bpmOpinionLibManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "用户审批意见表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmOpinionLibManager.delete(id);
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
        BpmOpinionLib bpmOpinionLib=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmOpinionLib=bpmOpinionLibManager.get(pkId);
        }else{
        	bpmOpinionLib=new BpmOpinionLib();
        }
        return getPathView(request).addObject("bpmOpinionLib",bpmOpinionLib);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	String userId = ContextUtil.getCurrentUserId();
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmOpinionLib bpmOpinionLib=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmOpinionLib=bpmOpinionLibManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmOpinionLib.setOpId(null);
    		}
    	}else{
    		bpmOpinionLib=new BpmOpinionLib();
    	}
    	return getPathView(request).addObject("bpmOpinionLib",bpmOpinionLib).addObject("userId", userId);
    }

    @RequestMapping("getUserText")
    @ResponseBody
    public List<BpmOpinionLib> getUserText(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId = ContextUtil.getCurrentUserId();
    	List<BpmOpinionLib> list = bpmOpinionLibManager.getByUserId(userId);
    	return list;
    }
    
    @RequestMapping("saveOpinion")
    @ResponseBody
    @LogEnt(action = "saveOpinion", module = "流程", submodule = "用户审批意见表")
    public JsonResult saveOpinion(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String opText =request.getParameter("opText");
    	String userId = ContextUtil.getCurrentUserId();
      	if(bpmOpinionLibManager.isOpinionSaved(userId, opText)){
      		return new JsonResult(true, "已经收藏过了！");
      	}else{
      		BpmOpinionLib lib = new BpmOpinionLib();
      		lib.setOpId(idGenerator.getSID());
      		lib.setUserId(userId);
      		lib.setOpText(opText);
      		bpmOpinionLibManager.create(lib);
      		return new JsonResult(true,"成功收藏！");
      	}
    }
    
	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmOpinionLibManager;
	}

}
