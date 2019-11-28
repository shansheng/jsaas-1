package com.redxun.bpm.core.controller;

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
import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.bpm.core.manager.BpmAgentSolManager;

/**
 * [BpmAgentSol]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmAgentSol/")
public class BpmAgentSolController extends BaseListController{
    @Resource
    BpmAgentSolManager bpmAgentSolManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "部分代理的流程方案")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmAgentSolManager.delete(id);
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
        BpmAgentSol bpmAgentSol=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmAgentSol=bpmAgentSolManager.get(pkId);
        }else{
        	bpmAgentSol=new BpmAgentSol();
        }
        return getPathView(request).addObject("bpmAgentSol",bpmAgentSol);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmAgentSol bpmAgentSol=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmAgentSol=bpmAgentSolManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmAgentSol.setAsId(null);
    		}
    	}else{
    		bpmAgentSol=new BpmAgentSol();
    	}
    	return getPathView(request).addObject("bpmAgentSol",bpmAgentSol);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmAgentSolManager;
	}

}
