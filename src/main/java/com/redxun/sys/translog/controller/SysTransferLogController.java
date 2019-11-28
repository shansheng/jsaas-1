
package com.redxun.sys.translog.controller;

import java.io.PrintWriter;
import java.util.List;

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
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.translog.entity.SysTransferLog;
import com.redxun.sys.translog.manager.SysTransferLogManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.core.util.BeanUtil;

/**
 * 权限转移日志表控制器
 * @author mansan
 */
@Controller
@RequestMapping("/sys/translog/sysTransferLog/")
public class SysTransferLogController extends MybatisListController{
	@Resource
    SysTransferLogManager sysTransferLogManager;
	@Resource
	OsUserManager osUserManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "权限转移日志表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysTransferLogManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
    
    @RequestMapping("removeAll")
    @ResponseBody
    @LogEnt(action = "removeAll", module = "sys", submodule = "权限转移日志表")
    public JsonResult removeAll(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String tenantId = ContextUtil.getCurrentTenantId();
        sysTransferLogManager.deleteTenantId(tenantId);
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
        SysTransferLog sysTransferLog=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysTransferLog=sysTransferLogManager.get(pkId);
        }else{
        	sysTransferLog=new SysTransferLog();
        }
        return getPathView(request).addObject("sysTransferLog",sysTransferLog);
    }
    
    /**
     * 查看列表
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception{
        return getPathView(request).addObject("tenantId",ContextUtil.getCurrentTenantId());
    }
    
    @RequestMapping("listDataUser")
	public void listData(HttpServletRequest request,HttpServletResponse response) throws Exception{
		response.setContentType("application/json");
		QueryFilter queryFilter=getQueryFilter(request);
		
		List<?> list=getPage(queryFilter);
		for (Object object : list) {
			SysTransferLog obj = (SysTransferLog) object;
			obj.setAuthorPersonName(osUserManager.get(obj.getAuthorPerson()).getFullname());
			obj.setTargetPersonName(osUserManager.get(obj.getTargetPerson()).getFullname());
		}
		JsonPageResult<SysTransferLog> result=new JsonPageResult(list,queryFilter.getPage().getTotalItems());
		String jsonResult=iJson.toJson(result);
		PrintWriter pw=response.getWriter();
		pw.println(jsonResult);
		pw.close();
	}
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysTransferLog sysTransferLog=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysTransferLog=sysTransferLogManager.get(pkId);
    	}else{
    		sysTransferLog=new SysTransferLog();
    	}
    	return getPathView(request).addObject("sysTransferLog",sysTransferLog);
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
    public SysTransferLog getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        SysTransferLog sysTransferLog = sysTransferLogManager.getSysTransferLog(uId);
        return sysTransferLog;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "权限转移日志表")
    public JsonResult save(HttpServletRequest request, @RequestBody SysTransferLog sysTransferLog, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysTransferLog.getId())) {
            sysTransferLogManager.create(sysTransferLog);
            msg = getMessage("sysTransferLog.created", new Object[]{sysTransferLog.getIdentifyLabel()}, "[权限转移日志表]成功创建!");
        } else {
        	String id=sysTransferLog.getId();
        	SysTransferLog oldEnt=sysTransferLogManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysTransferLog);
            sysTransferLogManager.update(oldEnt);
       
            msg = getMessage("sysTransferLog.updated", new Object[]{sysTransferLog.getIdentifyLabel()}, "[权限转移日志表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysTransferLogManager;
	}
}
