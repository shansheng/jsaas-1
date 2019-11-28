package com.redxun.bpm.core.controller;

import java.util.ArrayList;
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
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.manager.BpmSolVarManager;
import com.redxun.bpm.enums.ProcessVarType;

/**
 * [BpmSolVar]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmSolVar/")
public class BpmSolVarController extends BaseListController{
    @Resource
    BpmSolVarManager bpmSolVarManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程解决方案变量")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmSolVarManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
    }
    
    /**
     * 获得某个解决方案中的变量定义
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getBySolIdActDefIdNodeId")
    @ResponseBody
    public List<BpmSolVar> getBySolIdActDefIdNodeId(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	String nodeId=request.getParameter("nodeId");
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	List<BpmSolVar> vars=bpmSolVarManager.getBySolIdActDefIdNodeId(solId, actDefId, nodeId);
    	return vars;
    }
    
    /**
     * 获得流程解决方案的变量配置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getBySolIdActDefId")
    @ResponseBody
    public List<BpmSolVar> getBySolIdActDefId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	List<BpmSolVar> vars=new ArrayList<BpmSolVar>();
    	//加上默认的流程变量
    	BpmSolVar startUserVar=new BpmSolVar("发起人ID","startUserId",BpmSolVar.TYPE_STRING,BpmSolVar.SCOPE_PROCESS);
    	BpmSolVar startDepVar=new BpmSolVar("发起部门ID",ProcessVarType.START_DEP_ID.getKey(),BpmSolVar.TYPE_STRING,BpmSolVar.SCOPE_PROCESS);
    	BpmSolVar subjectVar=new BpmSolVar(ProcessVarType.PROCESS_SUBJECT.getName(),ProcessVarType.PROCESS_SUBJECT.getKey(),BpmSolVar.TYPE_STRING,BpmSolVar.SCOPE_PROCESS);
    	BpmSolVar preUserVar=new BpmSolVar(ProcessVarType.PRE_NODE_USERID.getName(),ProcessVarType.PRE_NODE_USERID.getKey(),BpmSolVar.TYPE_STRING);
    	BpmSolVar solIdVar=new BpmSolVar("解决方案ID","solId",BpmSolVar.TYPE_STRING,BpmSolVar.SCOPE_PROCESS);
    	BpmSolVar instIdVar=new BpmSolVar("流程实例ID","instId",BpmSolVar.TYPE_STRING,BpmSolVar.SCOPE_PROCESS);
    	vars.add(startUserVar);
    	vars.add(startDepVar);
    	vars.add(subjectVar);
    	vars.add(preUserVar);
    	vars.add(solIdVar);
    	vars.add(instIdVar);
    	List<BpmSolVar> varDefs=bpmSolVarManager.getBySolIdActDefId(solId, actDefId);
    	vars.addAll(varDefs);
    	return vars;
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
        BpmSolVar bpmSolVar=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmSolVar=bpmSolVarManager.get(pkId);
        }else{
        	bpmSolVar=new BpmSolVar();
        }
        return getPathView(request).addObject("bpmSolVar",bpmSolVar);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmSolVar bpmSolVar=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmSolVar=bpmSolVarManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmSolVar.setVarId(null);
    		}
    	}else{
    		bpmSolVar=new BpmSolVar();
    	}
    	return getPathView(request).addObject("bpmSolVar",bpmSolVar);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmSolVarManager;
	}

}
