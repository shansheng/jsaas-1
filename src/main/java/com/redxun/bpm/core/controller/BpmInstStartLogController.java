
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
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.bpm.core.entity.BpmInstStartLog;
import com.redxun.bpm.core.manager.BpmInstStartLogManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.core.util.BeanUtil;

/**
 * 启动流程日志控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmInstStartLog/")
public class BpmInstStartLogController extends MybatisListController{
    @Resource
    BpmInstStartLogManager bpmInstStartLogManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "启动流程日志")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmInstStartLogManager.delete(id);
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
        BpmInstStartLog bpmInstStartLog=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmInstStartLog=bpmInstStartLogManager.get(pkId);
        }else{
        	bpmInstStartLog=new BpmInstStartLog();
        }
        return getPathView(request).addObject("bpmInstStartLog",bpmInstStartLog);
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
    public BpmInstStartLog getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        BpmInstStartLog bpmInstStartLog = bpmInstStartLogManager.getBpmInstStartLog(uId);
        return bpmInstStartLog;
    }
    
  

	

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmInstStartLogManager;
	}
}
