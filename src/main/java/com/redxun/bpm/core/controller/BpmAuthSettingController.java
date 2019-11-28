package com.redxun.bpm.core.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.log.LogEnt;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmAuthSetting;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;

/**
 * [BpmAuthSetting]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmAuthSetting/")
public class BpmAuthSettingController extends BaseListController{
    @Resource
    BpmAuthSettingManager bpmAuthSettingManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
	
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程定义授权管理")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmAuthSettingManager.delete(id);
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
        BpmAuthSetting bpmAuthSetting=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmAuthSetting=bpmAuthSettingManager.get(pkId);
        }else{
        	bpmAuthSetting=new BpmAuthSetting();
        }
        return getPathView(request).addObject("bpmAuthSetting",bpmAuthSetting);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String grantType=BpmAuthSettingManager.getGrantType();
    	String pkId=request.getParameter("pkId");
    	BpmAuthSetting bpmAuthSetting=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmAuthSetting=bpmAuthSettingManager.get(pkId);
    	}else{
    		bpmAuthSetting=new BpmAuthSetting();
    	}
    	String rightJson=BpmAuthSettingManager.getDefaultRightJson().toJSONString();
    	
    	return getPathView(request)
    			.addObject("bpmAuthSetting",bpmAuthSetting)
    			.addObject("rightJson", rightJson).addObject("grantType",grantType);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmAuthSettingManager;
	}
	
	@RequestMapping("saveAuth")
	@ResponseBody
	@LogEnt(action = "saveAuth", module = "流程", submodule = "流程定义授权管理")
    public JsonResult saveAuth(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String authSetting=RequestUtil.getString(request, "authSetting");
        String rightsJson=RequestUtil.getString(request, "rightsJson");
        String defJson=RequestUtil.getString(request, "defJson");
        try{
        	bpmAuthSettingManager.saveAuth(authSetting, defJson, rightsJson);
        	return new JsonResult(true,"成功保存！");
        }
        catch(Exception ex){
        	return new JsonResult(false,"保存失败！");
        }
    }
	
	@RequestMapping("getSetting")
	@ResponseBody
    public JSONObject getSetting(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String settingId=request.getParameter("settingId");
        JSONObject jsonOut= bpmAuthSettingManager.getById(settingId);
        return jsonOut;
        
    }
	
	@RequestMapping("listJson")
	@ResponseBody
    public JsonPageResult<BpmAuthSetting> listJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		
		String tenantId=ContextUtil.getCurrentTenantId();
		
		queryFilter.addFieldParam("TENANT_ID_", tenantId);
		queryFilter.addFieldParam("TYPE_", "BPM");
		List<BpmAuthSetting> list=bpmAuthSettingManager.getAll(queryFilter);
		return new JsonPageResult<BpmAuthSetting>(list,queryFilter.getPage().getTotalItems());
        
    }

}
