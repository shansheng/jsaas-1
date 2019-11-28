package com.redxun.sys.org.controller;

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

import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsUserType;
import com.redxun.sys.org.manager.OsUserTypeManager;

/**
 * 用户类型控制器
 * @author mansan
 */
@Controller
@RequestMapping("/sys/org/osUserType/")
public class OsUserTypeController extends MybatisListController{
    @Resource
    OsUserTypeManager osUserTypeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "用户类型")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
            	OsUserType osUserType=osUserTypeManager.get(id);
            	if(osUserType!=null && StringUtils.isNotEmpty(osUserType.getGroupId())){
            		osUserTypeManager.delete(osUserType.getGroupId());
            	}
                osUserTypeManager.delete(id);
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
        OsUserType osUserType=null;
        if(StringUtils.isNotEmpty(pkId)){
           osUserType=osUserTypeManager.get(pkId);
        }else{
        	osUserType=new OsUserType();
        }
        return getPathView(request).addObject("osUserType",osUserType);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	OsUserType osUserType=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osUserType=osUserTypeManager.get(pkId);
    	}else{
    		osUserType=new OsUserType();
    	}
    	return getPathView(request).addObject("osUserType",osUserType);
    }
    
    /**
     * 返回所有的用户类型
     * @param request
     * @param respnse
     * @return
     * @throws Exception
     */
    @RequestMapping("getAllTypes")
    @ResponseBody
    public List<OsUserType> getAllTypes(HttpServletRequest request,HttpServletResponse respnse) throws Exception{
    	String tenantId=request.getParameter("tenantId");
    	if(StringUtils.isEmpty(tenantId)){
    		tenantId=ContextUtil.getCurrentTenantId();
    	}
    	return osUserTypeManager.getAllByTenantId(tenantId);
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
    public OsUserType getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        OsUserType osUserType = osUserTypeManager.getOsUserType(uId);
        return osUserType;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "用户类型")
    public JsonResult save(HttpServletRequest request, @RequestBody OsUserType osUserType, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        boolean rtn=osUserTypeManager.isCodeExist(osUserType);
        if(rtn){
        	return new JsonResult(false, "用户类型编码重复!");
        }
        String msg = null;
        if (StringUtils.isEmpty(osUserType.getId())) {
            osUserTypeManager.create(osUserType);
            msg = getMessage("osUserType.created", new Object[]{osUserType.getIdentifyLabel()}, "[用户类型]成功创建!");
        } else {
        	String id=osUserType.getId();
        	OsUserType oldEnt=osUserTypeManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, osUserType);
            osUserTypeManager.update(oldEnt);
       
            msg = getMessage("osUserType.updated", new Object[]{osUserType.getIdentifyLabel()}, "[用户类型]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return osUserTypeManager;
	}
}
