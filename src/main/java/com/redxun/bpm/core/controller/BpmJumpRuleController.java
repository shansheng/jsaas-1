
package com.redxun.bpm.core.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.core.entity.BpmJumpRule;
import com.redxun.bpm.core.manager.BpmJumpRuleManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseMybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 流程跳转规则控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmJumpRule/")
public class BpmJumpRuleController extends BaseMybatisListController{
    @Resource
    BpmJumpRuleManager bpmJumpRuleManager;
    @Resource
    ActRepService actRepService;
    //@Autowired
    //BpmSolVarManager bpmSolVarManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		String tenantId=ContextUtil.getCurrentTenantId();
		
		QueryFilter filter= QueryFilterBuilder.createQueryFilter(request);
		filter.addFieldParam("TENANT_ID_", tenantId);
		return filter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "流程跳转规则")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmJumpRuleManager.delete(id);
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
        BpmJumpRule bpmJumpRule=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmJumpRule=bpmJumpRuleManager.get(pkId);
        }else{
        	bpmJumpRule=new BpmJumpRule();
        }
        return getPathView(request).addObject("bpmJumpRule",bpmJumpRule);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	BpmJumpRule bpmJumpRule=null;
    	
    	String solId=null;
    	String nodeId=null;
    	String actDefId=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmJumpRule=bpmJumpRuleManager.get(pkId);
    		solId=bpmJumpRule.getSolId();
    		nodeId=bpmJumpRule.getNodeId();
    		actDefId=bpmJumpRule.getActdefId();
    	}else{
    		bpmJumpRule=new BpmJumpRule();
    		actDefId=RequestUtil.getString(request, "actDefId");
    		solId=RequestUtil.getString(request, "solId");
    		nodeId=RequestUtil.getString(request, "nodeId");
    		
    		ActNodeDef actNodeDef= actRepService.getByNode(actDefId, nodeId);
    		
    		bpmJumpRule.setNodeName(actNodeDef.getNodeName());
    		bpmJumpRule.setActdefId(actDefId);
    		bpmJumpRule.setSolId(solId);
    		bpmJumpRule.setNodeId(nodeId);
    		
    	}
    	
    	/*
		List<BpmSolVar> vars = bpmSolVarManager.getBySolIdActDefId(solId, actDefId);
		// 加上默认的流程变量
		for(ProcessVarType type:ProcessVarType.values()){
			BpmSolVar varDef = new BpmSolVar(type.getName(), type.getKey(),BpmSolVar.TYPE_STRING, BpmSolVar.SCOPE_PROCESS);
			vars.add(varDef);
		}*/
    	
    	return getPathView(request).addObject("bpmJumpRule",bpmJumpRule);
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
        BpmJumpRule bpmJumpRule = bpmJumpRuleManager.getBpmJumpRule(uId);
        String json = JSONObject.toJSONString(bpmJumpRule);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public ExtBaseManager getBaseManager() {
		return bpmJumpRuleManager;
	}

}
