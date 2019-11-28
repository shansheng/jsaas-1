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

import com.redxun.bpm.core.entity.BpmTestCase;
import com.redxun.bpm.core.entity.BpmTestSol;
import com.redxun.bpm.core.manager.BpmTestCaseManager;
import com.redxun.bpm.core.manager.BpmTestSolManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmTestSol]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmTestSol/")
public class BpmTestSolController extends BaseListController{
    @Resource
    BpmTestSolManager bpmTestSolManager;
    @Resource
    BpmTestCaseManager bpmTestCaseManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "测试方案")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmTestSolManager.deleteCascade(id);
            }
        }
        return new JsonResult(true,"成功删除！");
    }
    
    /**
     * 获得测试方案中的测试用例列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("testCases")
    public ModelAndView testCases(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String testSolId=request.getParameter("testSolId");
    	List<BpmTestCase> testCases=bpmTestCaseManager.getByTestSolId(testSolId);
    	return getPathView(request).addObject("testCases",testCases);
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
        BpmTestSol bpmTestSol=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmTestSol=bpmTestSolManager.get(pkId);
        }else{
        	bpmTestSol=new BpmTestSol();
        }
        return getPathView(request).addObject("bpmTestSol",bpmTestSol);
    }
    
    
    @RequestMapping("edit")
    @LogEnt(action = "del", module = "流程", submodule = "测试方案")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmTestSol bpmTestSol=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmTestSol=bpmTestSolManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmTestSol.setTestSolId(null);
    		}
    	}else{
    		bpmTestSol=new BpmTestSol();
    		bpmTestSol.setSolId(solId);
    		bpmTestSol.setActDefId(actDefId);
    	}
    	return getPathView(request).addObject("bpmTestSol",bpmTestSol);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmTestSolManager;
	}

}
