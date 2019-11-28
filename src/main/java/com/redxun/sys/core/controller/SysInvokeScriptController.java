
package com.redxun.sys.core.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.core.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysInvokeScript;
import com.redxun.sys.core.manager.SysInvokeScriptManager;
import com.redxun.sys.log.LogEnt;

/**
 * 执行脚本配置控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/core/sysInvokeScript/")
public class SysInvokeScriptController extends MybatisListController{
    @Resource
    SysInvokeScriptManager sysInvokeScriptManager;
    
    @Resource
    GroovyEngine groovyEngine;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "执行脚本配置")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysInvokeScriptManager.delete(id);
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
        SysInvokeScript sysInvokeScript=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysInvokeScript=sysInvokeScriptManager.get(pkId);
        }else{
        	sysInvokeScript=new SysInvokeScript();
        }
        return getPathView(request).addObject("sysInvokeScript",sysInvokeScript);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysInvokeScript sysInvokeScript=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysInvokeScript=sysInvokeScriptManager.get(pkId);
    	}else{
    		sysInvokeScript=new SysInvokeScript();
    	}
    	return getPathView(request).addObject("sysInvokeScript",sysInvokeScript);
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
    public SysInvokeScript getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        SysInvokeScript sysInvokeScript = sysInvokeScriptManager.get(uId);
        return sysInvokeScript;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "执行脚本配置")
    public JsonResult save(HttpServletRequest request, @RequestBody SysInvokeScript sysInvokeScript, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysInvokeScript.getId())) {
        	sysInvokeScript.setId(IdUtil.getId());
            sysInvokeScriptManager.create(sysInvokeScript);
            msg = getMessage("sysInvokeScript.created", new Object[]{sysInvokeScript.getIdentifyLabel()}, "[执行脚本配置]成功创建!");
        } else {
        	String id=sysInvokeScript.getId();
        	SysInvokeScript oldEnt=sysInvokeScriptManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysInvokeScript);
            sysInvokeScriptManager.update(oldEnt);
       
            msg = getMessage("sysInvokeScript.updated", new Object[]{sysInvokeScript.getIdentifyLabel()}, "[执行脚本配置]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysInvokeScriptManager;
	}
	
	
	/**
	 * 执行服务端脚本。
	 * <pre>
	 * 调用时可以传递参数 params。
	 * 脚本执行结果通过 jsonresult 的data 属性返回。
	 * </pre>
	 * @param request
	 * @param alias
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/invoke/{alias}")
	@ResponseBody
	public JsonResult invoke(HttpServletRequest request, @PathVariable("alias")String alias) throws Exception{
		String tenantId=ContextUtil.getCurrentTenantId();
		SysInvokeScript invokeScript=sysInvokeScriptManager.getByAlias(alias, tenantId);
		if(invokeScript==null){
			return new JsonResult(false,"不存在标识键为："+ alias+"脚本配置");
		}
		String params=RequestUtil.getString(request,"params", "");
		Map<String,Object>  model=new HashMap<>();
		Map<String,Object> variables=RequestUtil.getParameterValueMap(request, true);
		try{
			variables.put("params", params);
			Object obj=groovyEngine.executeScripts(invokeScript.getContent(), variables);
			JsonResult result= new JsonResult(true,"成功执行!");
			result.setData(obj);
			return result;
		}
		catch(Exception ex){
			ex.printStackTrace();
			String errMsg="执行有错误！错误如下："+ex.getMessage();
			JsonResult result= new JsonResult(false,errMsg);
			result.setData(ExceptionUtil.getExceptionMessage(ex));
			return result;
		}
	}

	@RequestMapping("preview")
	public ModelAndView preview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		SysInvokeScript invokeScript = sysInvokeScriptManager.get(pkId);
		return getPathView(request).addObject("name", invokeScript.getAlias());
	}

	@RequestMapping("help")
	public ModelAndView help(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		SysInvokeScript invokeScript = null;
		if (StringUtil.isNotEmpty(pkId)) {
			invokeScript = sysInvokeScriptManager.get(pkId);
		} else {
			invokeScript = new SysInvokeScript();
		}
		return getPathView(request).addObject("name", invokeScript.getAlias());
	}
}
