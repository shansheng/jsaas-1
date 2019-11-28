
package com.redxun.bpm.form.controller;

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

import com.redxun.bpm.form.entity.BpmFormCmp;
import com.redxun.bpm.form.manager.BpmFormCmpManager;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 复合表单控制器
 * @author mansan
 */
@Controller
@RequestMapping("/bpm/form/bpmFormCmp/")
public class BpmFormCmpController extends MybatisListController{
    @Resource
    BpmFormCmpManager bpmFormCmpManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "复合表单")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmFormCmpManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
    
    @RequestMapping("getByViewId")
    @ResponseBody
    public List<BpmFormCmp> getByViewId(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String viewId=request.getParameter("viewId");
    	if(StringUtils.isNotEmpty(viewId)){
    		List<BpmFormCmp> cmpList= bpmFormCmpManager.getByViewId(viewId);
    		return cmpList;
    	}else{
    		return new ArrayList<BpmFormCmp>();
    	}
    }
    /**
     * 根据ID删除后及其下的目录
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("delByCmpIds")
    @ResponseBody
    public JsonResult delByCmpIds(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String cmpIds=request.getParameter("cmpIds");
    	if(StringUtils.isNotEmpty(cmpIds)){
    		String[] ids=cmpIds.split("[,]");
    		for(String id:ids){
    			BpmFormCmp cmp=bpmFormCmpManager.get(id);
    			if(cmp!=null && StringUtils.isNotEmpty(cmp.getPath())){
    				bpmFormCmpManager.delByPath(cmp.getPath());
    			}else{
    				bpmFormCmpManager.delete(id);
    			}
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
        String pkId=RequestUtil.getString(request, "pkId");
        BpmFormCmp bpmFormCmp=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmFormCmp=bpmFormCmpManager.get(pkId);
        }else{
        	bpmFormCmp=new BpmFormCmp();
        }
        return getPathView(request).addObject("bpmFormCmp",bpmFormCmp);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	BpmFormCmp bpmFormCmp=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmFormCmp=bpmFormCmpManager.get(pkId);
    	}else{
    		bpmFormCmp=new BpmFormCmp();
    	}
    	return getPathView(request).addObject("bpmFormCmp",bpmFormCmp);
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
    public BpmFormCmp getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        BpmFormCmp bpmFormCmp = bpmFormCmpManager.getBpmFormCmp(uId);
        return bpmFormCmp;
    }
    
   

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmFormCmpManager;
	}
}
