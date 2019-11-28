
package com.redxun.sys.log.controller;

import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEntScanner;
import com.redxun.sys.log.entity.LogModule;
import com.redxun.sys.log.manager.LogModuleManager;

/**
 * 日志模块控制器
 * @author 陈茂昌
 */
@Controller
@RequestMapping("/sys/log/logModule/")
public class LogModuleController extends MybatisListController{
    @Resource
    LogModuleManager logModuleManager;
    @Resource
    LogEntScanner logEntScanner;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                logModuleManager.delete(id);
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
        LogModule logModule=null;
        if(StringUtils.isNotEmpty(pkId)){
           logModule=logModuleManager.get(pkId);
        }else{
        	logModule=new LogModule();
        }
        return getPathView(request).addObject("logModule",logModule);
    }
    
    @RequestMapping("initLogModel")
    @ResponseBody
	public JsonResult initLogModel() throws Exception{
		JsonResult result=new JsonResult<>();
		//删除
		logModuleManager.removeAll();
		Set<String> set= logEntScanner.getModule();
		for(String str:set){
			String[] ary=str.split("<##>");
			LogModule module=new LogModule();
			module.setId(IdUtil.getId());
			module.setModule(ary[0]);
			module.setSubModule(ary[1]);
			module.setEnable("TRUE");
			logModuleManager.create(module);
			
		}
		return result;
	}
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	LogModule logModule=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		logModule=logModuleManager.get(pkId);
    		if("true".equals(forCopy)){
    			logModule.setId(null);
    		}
    	}else{
    		logModule=new LogModule();
    	}
    	return getPathView(request).addObject("logModule",logModule);
    }
    
    @RequestMapping("disableModule")
    @ResponseBody
    public JSONObject disableModule(HttpServletRequest request,HttpServletResponse response){
    	String ids=RequestUtil.getString(request, "ids");
    	String enable=RequestUtil.getString(request, "enable");
    	String idArray[] = ids.split(",");
    	for (String id : idArray) {
    		LogModule logModule=logModuleManager.get(id);
        	logModule.setEnable(enable);
        	logModuleManager.update(logModule);
		}
    	JSONObject jsonObject=new JSONObject();
    	jsonObject.put("success", true);
    	return jsonObject;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return logModuleManager;
	}

}
