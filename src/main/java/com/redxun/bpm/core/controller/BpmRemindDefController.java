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

import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmRemindDef;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmRemindDefManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;

/**
 * [BpmRemindDef]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmRemindDef/")
public class BpmRemindDefController extends BaseListController{
    @Resource
    BpmRemindDefManager bpmRemindDefManager;
    @Resource
    BpmSolutionManager bpmSolutionManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "催办定义")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmRemindDefManager.delete(id);
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
        BpmRemindDef bpmRemindDef=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmRemindDef=bpmRemindDefManager.get(pkId);
        }else{
        	bpmRemindDef=new BpmRemindDef();
        }
        return getPathView(request).addObject("bpmRemindDef",bpmRemindDef);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	BpmSolution solution=bpmSolutionManager.get(solId);
    	String nodeId=request.getParameter("nodeId");
    	String nodeName=request.getParameter("nodeName");
    
    	
    	return getPathView(request)
    			.addObject("solId", solId)
    			.addObject("actDefId", solution.getActDefId())
    			.addObject("nodeId", nodeId)
    			.addObject("nodeName", nodeName);
    }
    
    @RequestMapping("globalEdit")
    public ModelAndView editGolobal(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String nodeName=request.getParameter("nodeName");
    
    	
    	return getPathView(request)
    			.addObject("solId", solId)
    			.addObject("nodeName", nodeName);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmRemindDefManager;
	}
	
	@RequestMapping("listJson")
	@ResponseBody
    public List<BpmRemindDef> listJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String solId=request.getParameter("solId");
        String nodeId=request.getParameter("nodeId");
        BpmSolution solution=bpmSolutionManager.get(solId);
        String actDefId=solution.getActDefId();
        
        List<BpmRemindDef> list= bpmRemindDefManager.getBySolNode(solId,actDefId, nodeId);
        
        return list;
    }

}
