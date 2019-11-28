
package com.redxun.oa.info.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.oa.info.entity.OaRemindDef;
import com.redxun.oa.info.manager.OaRemindDefManager;
import com.redxun.oa.info.manager.SysObjectAuthPermissionManager;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.saweb.controller.BaseMybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 消息提醒控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/info/oaRemindDef/")
public class OaRemindDefController extends BaseMybatisListController{
    @Resource
    OaRemindDefManager oaRemindDefManager;
    
    @Resource
	private SysObjectAuthPermissionManager sysObjectAuthPermissionManager;
    
    @SuppressWarnings("rawtypes")
	@Override
	public ExtBaseManager getBaseManager() {
		return oaRemindDefManager;
	}
   
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "消息提醒")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                oaRemindDefManager.delete(id);
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
        OaRemindDef oaRemindDef=null;
        if(StringUtils.isNotEmpty(pkId)){
           oaRemindDef=oaRemindDefManager.get(pkId);
        }else{
        	oaRemindDef=new OaRemindDef();
        }
        return getPathView(request).addObject("oaRemindDef",oaRemindDef);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	OaRemindDef oaRemindDef=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		oaRemindDef=oaRemindDefManager.get(pkId);
    	}else{
    		oaRemindDef=new OaRemindDef();
    	}
    	return getPathView(request).addObject("oaRemindDef",oaRemindDef);
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
    public OaRemindDef getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        OaRemindDef oaRemindDef = oaRemindDefManager.getOaRemindDef(uId);
        return oaRemindDef;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "oa", submodule = "消息提醒")
    public JsonResult save(HttpServletRequest request, @RequestBody OaRemindDef oaRemindDef, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(oaRemindDef.getId())) {
            oaRemindDefManager.create(oaRemindDef);
            msg = getMessage("oaRemindDef.created", new Object[]{oaRemindDef.getIdentifyLabel()}, "[消息提醒]成功创建!");
        } else {
        	oaRemindDefManager.update(oaRemindDef);
            msg = getMessage("oaRemindDef.updated", new Object[]{oaRemindDef.getIdentifyLabel()}, "[消息提醒]成功更新!");
        }
        return new JsonResult(true, msg);
    }

	
	
	
	@RequestMapping("profileDialog")
	public ModelAndView profileDialog(HttpServletRequest request){
		ModelAndView mv=getPathView(request);
		String pkId=request.getParameter("pkId");
		String authType=request.getParameter("authType");
		JSONObject typeJson=ProfileUtil.getProfileTypeJson();
		//Set<Entry<String, Object>> set= typeJson.entrySet();
		mv.addObject("typeJson", typeJson).addObject("pkId", pkId).addObject("authType", authType);
		return mv;
		
	}
	
	/**
	 * 获得我的提醒消息，并且进行权限过滤
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("myRemind")
	@ResponseBody
	public JsonResult myRemind(HttpServletRequest request) throws Exception {
		List<OaRemindDef> oaRemindList = oaRemindDefManager.getMyRemindDef();
		List<Object> list = new ArrayList<>();
		for (OaRemindDef remind : oaRemindList) {
			Long count= oaRemindDefManager.getRemindCountByType(remind);
			if(count==0) continue;			
			HashMap<String, Object> map = new HashMap<String, Object>();
			String url = remind.getUrl();
			String description = remind.getDescription();
			description=description.replace("[count]",count.toString());
			if(StringUtils.isNotEmpty(url)&& !url.startsWith("http")){
				url=url.replace("${ctxPath}", request.getContextPath());
			}
			map.put("url", url);
			map.put("str", description);
			list.add(map);
		}
		return new JsonResult(true, "", list);
	}
	
	@RequestMapping("saveRight")
	@ResponseBody
	public JsonResult saveRight(@RequestBody JSONObject remindJson) {
		JsonResult jsonResult=sysObjectAuthPermissionManager.saveRight(remindJson);
		return jsonResult;
	}
	
	

}
