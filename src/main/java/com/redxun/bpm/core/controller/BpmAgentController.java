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

import com.redxun.bpm.core.entity.BpmAgent;
import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.bpm.core.manager.BpmAgentManager;
import com.redxun.bpm.core.manager.BpmAgentSolManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmAgent]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmAgent/")
public class BpmAgentController extends BaseListController{
    @Resource
    BpmAgentManager bpmAgentManager;
    @Resource
    BpmAgentSolManager bpmAgentSolManager;

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter= QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("CREATE_BY_", ContextUtil.getCurrentUserId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "方案代理")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmAgentManager.delete(id);
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
        BpmAgent bpmAgent=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmAgent=bpmAgentManager.get(pkId);
        }else{
        	bpmAgent=new BpmAgent();
        }
        return getPathView(request).addObject("bpmAgent",bpmAgent);
    }
    
    /**
     * 
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getAgentSol")
    @ResponseBody
    public List<BpmAgentSol> getAgentSol(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String agentId=request.getParameter("agentId");
    	return bpmAgentSolManager.getByAgentId(agentId);
    }
    
    /**
     * 删除流程代理中指定的流程解决方案
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("delSols")
    @ResponseBody
    @LogEnt(action = "delSols", module = "流程", submodule = "方案代理")
    public JsonResult delSols(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String asIds=request.getParameter("asIds");
    	String[]asIdArr=asIds.split("[,]");
    	for(String asId:asIdArr){
    		bpmAgentSolManager.delete(asId);
    	}
    	return new JsonResult(true,"成功删除指定的流程方案!");
    }

    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	ModelAndView mv=getPathView(request);
    	
    	BpmAgent bpmAgent=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmAgent=bpmAgentManager.get(pkId);
    		
    		if("true".equals(forCopy)){
    			bpmAgent.setAgentId(null);
    		}
    	}else{
    		bpmAgent=new BpmAgent();
    		bpmAgent.setType(BpmAgent.TYPE_ALL);
    	}
    	mv.addObject("bpmAgent",bpmAgent);
    	return mv;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmAgentManager;
	}

}
