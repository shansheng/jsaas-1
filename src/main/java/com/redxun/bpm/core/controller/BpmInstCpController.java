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
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmInstCp;
import com.redxun.bpm.core.manager.BpmInstCpManager;
import com.redxun.bpm.core.manager.BpmInstManager;

/**
 * [BpmInstCp]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstCp/")
public class BpmInstCpController extends BaseListController{
    @Resource
    BpmInstCpManager bpmInstCpManager;
    @Resource
    BpmInstManager bpmInstManager;

   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "抄送人员")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmInstCpManager.delete(id);
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
        BpmInstCp bpmInstCp=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmInstCp=bpmInstCpManager.get(pkId);
        }else{
        	bpmInstCp=new BpmInstCp();
        }
        return getPathView(request).addObject("bpmInstCp",bpmInstCp);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmInstCp bpmInstCp=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmInstCp=bpmInstCpManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmInstCp.setId(null);
    		}
    	}else{
    		bpmInstCp=new BpmInstCp();
    	}
    	return getPathView(request).addObject("bpmInstCp",bpmInstCp);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmInstCpManager;
	}
	
	/**
	 * 打开抄送界面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("toCarbonCopy")
	public ModelAndView toCarbonCopy(HttpServletRequest request,HttpServletResponse response){
		String bpmInstId=request.getParameter("bpmInstId");
		String nodeId=request.getParameter("nodeId");
		String nodeName=request.getParameter("nodeName");
		BpmInst bpmInst= bpmInstManager.get(bpmInstId);
		return this.getPathView(request).addObject("bpmInstId", bpmInstId).addObject("nodeId", nodeId).addObject("nodeName2", nodeName);
	}
	
	/**
	 * 通过cpId获取BpmInstCp修改IsRead属性为YES
	 * @param request
	 * @param response
	 * @return 
	 */
	@RequestMapping("cpRead")
	@ResponseBody
	@LogEnt(action = "cpRead", module = "流程", submodule = "抄送人员")
	public JsonResult cpRead(HttpServletRequest request,HttpServletResponse response){
		String cpId=request.getParameter("cpId");
		
		bpmInstCpManager.updRead(cpId);
		return new JsonResult(true,"更新为已读！");
	}

}
