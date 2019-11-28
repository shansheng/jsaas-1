
package com.redxun.bpm.core.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.bpm.core.entity.BpmOvertimeNode;
import com.redxun.bpm.core.manager.BpmOvertimeNodeManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.core.util.BeanUtil;

/**
 * 流程超时节点表控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmOvertimeNode/")
public class BpmOvertimeNodeController extends MybatisListController{
    @Resource
    BpmOvertimeNodeManager bpmOvertimeNodeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "流程超时节点表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmOvertimeNodeManager.delete(id);
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
        BpmOvertimeNode bpmOvertimeNode=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmOvertimeNode=bpmOvertimeNodeManager.get(pkId);
        }else{
        	bpmOvertimeNode=new BpmOvertimeNode();
        }
        return getPathView(request).addObject("bpmOvertimeNode",bpmOvertimeNode);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	BpmOvertimeNode bpmOvertimeNode=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmOvertimeNode=bpmOvertimeNodeManager.get(pkId);
    	}else{
    		bpmOvertimeNode=new BpmOvertimeNode();
    	}
    	return getPathView(request).addObject("bpmOvertimeNode",bpmOvertimeNode);
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
    public BpmOvertimeNode getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        BpmOvertimeNode bpmOvertimeNode = bpmOvertimeNodeManager.getBpmOvertimeNode(uId);
        return bpmOvertimeNode;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "流程超时节点表")
    public JsonResult save(HttpServletRequest request, @RequestBody BpmOvertimeNode bpmOvertimeNode, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmOvertimeNode.getId())) {
            bpmOvertimeNodeManager.create(bpmOvertimeNode);
            msg = getMessage("bpmOvertimeNode.created", new Object[]{bpmOvertimeNode.getIdentifyLabel()}, "[流程超时节点表]成功创建!");
        } else {
        	String id=bpmOvertimeNode.getId();
        	BpmOvertimeNode oldEnt=bpmOvertimeNodeManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, bpmOvertimeNode);
            bpmOvertimeNodeManager.update(oldEnt);
       
            msg = getMessage("bpmOvertimeNode.updated", new Object[]{bpmOvertimeNode.getIdentifyLabel()}, "[流程超时节点表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmOvertimeNodeManager;
	}
}
