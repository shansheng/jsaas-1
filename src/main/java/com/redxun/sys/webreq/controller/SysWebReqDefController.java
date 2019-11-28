
package com.redxun.sys.webreq.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.webreq.entity.SysWebReqDef;
import com.redxun.sys.webreq.manager.SysWebReqDefManager;

/**
 * 流程数据绑定表控制器
 * @author mansan
 */
@Controller
@RequestMapping("/sys/webreq/sysWebReqDef/")
public class SysWebReqDefController extends MybatisListController{
    @Resource
    SysWebReqDefManager sysWebReqDefManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "流程数据绑定表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
            	sysWebReqDefManager.delete(id);
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
        SysWebReqDef sysWebReqDef=null;
        if(StringUtils.isNotEmpty(pkId)){
        	sysWebReqDef=sysWebReqDefManager.get(pkId);
        }else{
        	sysWebReqDef=new SysWebReqDef();
        }
        return getPathView(request).addObject("bpmDataBind",sysWebReqDef);
    }
    
    /**
     * 通过key查询对象
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("getKey")
    @ResponseBody
    public SysWebReqDef getKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String key=RequestUtil.getString(request, "key");
        SysWebReqDef sysWebReqDef=null;
        if(StringUtils.isNotEmpty(key)){
        	sysWebReqDef=sysWebReqDefManager.getKey(key);
        }else{
        	sysWebReqDef=new SysWebReqDef();
        }
        return sysWebReqDef;
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysWebReqDef sysWebReqDef=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysWebReqDef=sysWebReqDefManager.get(pkId);
    	}else{
    		sysWebReqDef=new SysWebReqDef();
    	}
    	return getPathView(request).addObject("bpmDataBind",sysWebReqDef);
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
    public SysWebReqDef getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
    	SysWebReqDef sysWebReqDef = sysWebReqDefManager.getBpmDataBind(uId);
        return sysWebReqDef;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "流程数据绑定表")
    public JsonResult save(HttpServletRequest request, @RequestBody SysWebReqDef sysWebReqDef, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        if(sysWebReqDefManager.isExist(sysWebReqDef)){
        	return new JsonResult(false, "key已经存在!");
        }
        String msg = null;
        if (StringUtils.isEmpty(sysWebReqDef.getId())) {
        	sysWebReqDefManager.create(sysWebReqDef);
            msg = getMessage("bpmDataBind.created", new Object[]{sysWebReqDef.getIdentifyLabel()}, "[流程数据绑定表]成功创建!");
        } else {
        	String id=sysWebReqDef.getId();
        	SysWebReqDef oldEnt=sysWebReqDefManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysWebReqDef);
        	sysWebReqDefManager.update(oldEnt);
       
            msg = getMessage("bpmDataBind.updated", new Object[]{sysWebReqDef.getIdentifyLabel()}, "[流程数据绑定表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
    /**
     * 获取请求方式、请求类型、状态等下拉值
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getSelectData")
    @ResponseBody
    public JSONArray getSelectData(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String key=RequestUtil.getString(request, "key");
        JSONArray json = sysWebReqDefManager.getSelectData(key);
        return json;
    }
    
    @RequestMapping(value="start",method={RequestMethod.POST})
    @ResponseBody
    public JsonResult<String> start(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String key=RequestUtil.getString(request, "key");
    	String paramsData=RequestUtil.getString(request, "paramsData");
    	
    	return sysWebReqDefManager.executeStart(key,paramsData,RequestUtil.getParameterValueMap(request, false));
    }
    
    @RequestMapping("soap")
    @ResponseBody
    public JsonResult<String> soap(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String url=RequestUtil.getString(request, "url");
    	String header=RequestUtil.getString(request, "header");
    	String body=RequestUtil.getString(request, "body");
    	String temp=RequestUtil.getString(request, "temp");
    	JsonResult<String> result = sysWebReqDefManager.executeReq(url,"POST",sysWebReqDefManager.parseParamsMap(header),sysWebReqDefManager.parseParamsMap(body),temp);
    	return result;
    }

    @RequestMapping("restful")
    @ResponseBody
    public JsonResult<String> restful(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String url=RequestUtil.getString(request, "url");
    	String type=RequestUtil.getString(request, "type");
    	String header=RequestUtil.getString(request, "header");
    	String body=RequestUtil.getString(request, "body");
    	String temp=RequestUtil.getString(request, "temp");
    	
    	return sysWebReqDefManager.executeReq(url, type, sysWebReqDefManager.parseParamsMap(header), sysWebReqDefManager.parseParamsMap(body), temp);
    }
    

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysWebReqDefManager;
	}
}
