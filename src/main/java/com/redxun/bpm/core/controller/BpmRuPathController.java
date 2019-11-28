package com.redxun.bpm.core.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.input.BOMInputStream;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.BpmTaskManager;

/**
 * [BpmRuPath]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmRuPath/")
public class BpmRuPathController extends BaseListController{
    @Resource
    BpmRuPathManager bpmRuPathManager;
    @Resource
    BpmDefManager bpmDefManager;
    @Resource
    BpmInstManager bpmInstManager;
    @Resource
    BpmTaskManager bpmTaskManager;
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程实例运行路线")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmRuPathManager.delete(id);
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
        BpmRuPath bpmRuPath=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmRuPath=bpmRuPathManager.get(pkId);
        }else{
        	bpmRuPath=new BpmRuPath();
        }
        return getPathView(request).addObject("bpmRuPath",bpmRuPath);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmRuPath bpmRuPath=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmRuPath=bpmRuPathManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmRuPath.setPathId(null);
    		}
    	}else{
    		bpmRuPath=new BpmRuPath();
    	}
    	return getPathView(request).addObject("bpmRuPath",bpmRuPath);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmRuPathManager;
	}
	
	@RequestMapping("calculateNode")
	@ResponseBody
	public List<BpmRuPath> calculateNode(HttpServletRequest request,HttpServletResponse response){
		String instId=request.getParameter("instId");
		String solId=request.getParameter("solId");
		String taskId=request.getParameter("taskId");
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		if(StringUtils.isNotBlank(taskId)){
			BpmTask bpmTask=bpmTaskManager.get(taskId);
			BpmInst bpmInst=bpmInstManager.getByActInstId(bpmTask.getProcInstId());
			String actInstId=bpmInst.getActInstId();
			queryFilter.addFieldParam("act_Inst_Id_", actInstId);
		}
		if(StringUtils.isNotBlank(instId)){
			queryFilter.addFieldParam("inst_Id_", instId);
		}	
		if(StringUtils.isNotBlank(solId)){
			queryFilter.addFieldParam("sol_Id_", solId);
		}
		List<BpmRuPath> list=bpmRuPathManager.getAll(queryFilter);
		return list;
		
	}
	
	@RequestMapping("getBackNodes/{actInstId}/{nodeId}")
	@ResponseBody
	public List<BpmRuPath> getBackNodes(@PathVariable(value="actInstId")String actInstId,@PathVariable(value="nodeId")String nodeId){
		List<BpmRuPath> list=bpmRuPathManager.getBackNodes(actInstId,nodeId);
		return list;
	}

}
