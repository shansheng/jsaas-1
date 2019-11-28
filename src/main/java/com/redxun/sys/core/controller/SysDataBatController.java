
package com.redxun.sys.core.controller;

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
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.core.entity.SysDataBat;
import com.redxun.sys.core.manager.SysDataBatManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.core.util.BeanUtil;

/**
 * 数据批量录入控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/core/sysDataBat/")
public class SysDataBatController extends MybatisListController{
    @Resource
    SysDataBatManager sysDataBatManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "数据批量录入")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysDataBatManager.delete(id);
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
        SysDataBat sysDataBat=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysDataBat=sysDataBatManager.get(pkId);
        }else{
        	sysDataBat=new SysDataBat();
        }
        return getPathView(request).addObject("sysDataBat",sysDataBat);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysDataBat sysDataBat=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysDataBat=sysDataBatManager.get(pkId);
    	}else{
    		sysDataBat=new SysDataBat();
    	}
    	return getPathView(request).addObject("sysDataBat",sysDataBat);
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
    public SysDataBat getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        SysDataBat sysDataBat = sysDataBatManager.getSysDataBat(uId);
        return sysDataBat;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "数据批量录入")
    public JsonResult save(HttpServletRequest request, @RequestBody SysDataBat sysDataBat, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysDataBat.getId())) {
            sysDataBatManager.create(sysDataBat);
            msg = getMessage("sysDataBat.created", new Object[]{sysDataBat.getIdentifyLabel()}, "[数据批量录入]成功创建!");
        } else {
        	String id=sysDataBat.getId();
        	SysDataBat oldEnt=sysDataBatManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysDataBat);
            sysDataBatManager.update(oldEnt);
       
            msg = getMessage("sysDataBat.updated", new Object[]{sysDataBat.getIdentifyLabel()}, "[数据批量录入]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysDataBatManager;
	}
}
