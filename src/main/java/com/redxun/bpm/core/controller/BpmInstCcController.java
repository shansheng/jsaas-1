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

import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.manager.BpmInstCcManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SqlQueryFilter;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.manager.OsGroupManager;

/**
 * [BpmInstCc]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstCc/")
public class BpmInstCcController extends BaseListController{
    @Resource
    BpmInstCcManager bpmInstCcManager;
    @Resource
    OsGroupManager osGroupManager;
    @Resource
    BpmInstManager bpmInstManager;
	@Resource
	SysTreeManager sysTreeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter filter = QueryFilterBuilder.createQueryFilter(request);
		filter.addFieldParam("from_User_Id_", ContextUtil.getCurrentUserId());
		return filter;
	}
	
	@RequestMapping("toMeJson")
	@ResponseBody
	public JsonPageResult<BpmInstCc> ccToMe(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		QueryFilter sqlFilter=QueryFilterBuilder.createQueryFilter(request);
		String isRead = RequestUtil.getString(request, "isRead");
  		String treeId=request.getParameter("treeId");
  		if(StringUtils.isNotEmpty(treeId)){
  			SysTree sysTree=sysTreeManager.get(treeId);
  			sqlFilter.addFieldParam("treeId",  sysTree.getTreeId());
  		}
		sqlFilter.addFieldParam("userId", ContextUtil.getCurrentUserId());
		if(StringUtil.isNotEmpty(isRead)) {
			sqlFilter.addFieldParam("isRead", isRead);
		}
		List<BpmInstCc> lists= bpmInstCcManager.getToMeInsts(sqlFilter);
		
		return new JsonPageResult<BpmInstCc>(lists,sqlFilter.getPage().getTotalItems());
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程抄送")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmInstCcManager.delete(id);
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
        BpmInstCc bpmInstCc=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmInstCc=bpmInstCcManager.get(pkId);
        }else{
        	bpmInstCc=new BpmInstCc();
        }
        return getPathView(request).addObject("bpmInstCc",bpmInstCc);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmInstCc bpmInstCc=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmInstCc=bpmInstCcManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmInstCc.setCcId(null);
    		}
    	}else{
    		bpmInstCc=new BpmInstCc();
    	}
    	return getPathView(request).addObject("bpmInstCc",bpmInstCc);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmInstCcManager;
	}
	

	

}
