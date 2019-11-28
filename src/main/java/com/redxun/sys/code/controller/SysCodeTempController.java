
package com.redxun.sys.code.controller;

import java.io.File;

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
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.code.entity.SysCodeTemp;
import com.redxun.sys.code.manager.SysCodeTempManager;
import com.redxun.sys.code.util.CodeGenUtil;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 模板文件管理表控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/code/sysCodeTemp/")
public class SysCodeTempController extends MybatisListController{
    @Resource
    SysCodeTempManager sysCodeTempManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "模板文件管理表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysCodeTempManager.delete(id);
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
        SysCodeTemp sysCodeTemp=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysCodeTemp=sysCodeTempManager.get(pkId);
        }else{
        	sysCodeTemp=new SysCodeTemp();
        }
        return getPathView(request).addObject("sysCodeTemp",sysCodeTemp);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysCodeTemp sysCodeTemp=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysCodeTemp=sysCodeTempManager.get(pkId);
    	}else{
    		sysCodeTemp=new SysCodeTemp();
    	}
    	return getPathView(request).addObject("sysCodeTemp",sysCodeTemp);
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
    public SysCodeTemp getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        SysCodeTemp sysCodeTemp = sysCodeTempManager.getSysCodeTemp(uId);
        return sysCodeTemp;
    }
    
    /**
     * 查询系统中存在的模板文件
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getPathAll")
    @ResponseBody
    public JSONArray getPathAll(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String ftlPath = WebAppUtil.getAppAbsolutePath()+"template/";
    	return traverseFolder1(ftlPath);
    }
    
    private JSONArray traverseFolder1(String path) {
    	JSONArray array = new JSONArray();
        File file = new File(path);
        if (file.exists()) {
            File[] files = file.listFiles();
            for (File file2 : files) {
                if (file2.isFile()) {
                	String name = file2.getName();
                    JSONObject obj = new JSONObject();
                    obj.put("id", name);
                    obj.put("text", name);
                    array.add(obj);
                }
            }
        } 
        return array;
    }
    
    @RequestMapping(value = "generate")
    @ResponseBody
    public JsonResult generate(HttpServletRequest request, @RequestBody JSONObject json, BindingResult result) throws Exception  {
    	return CodeGenUtil.generate(json);
    }
    
    @RequestMapping(value = "download")
    @ResponseBody
    public JsonResult download(HttpServletRequest request, @RequestBody JSONObject json, BindingResult result) throws Exception  {
    	return CodeGenUtil.download(json);
    }

    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "模板文件管理表")
    public JsonResult save(HttpServletRequest request, @RequestBody SysCodeTemp sysCodeTemp, BindingResult result) throws Exception  {

    	if(sysCodeTempManager.isExist(sysCodeTemp.getAlias(),sysCodeTemp.getId(),ContextUtil.getCurrentTenantId())) {
    		return new JsonResult(false, "存在相同别名的模板");
    	}
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysCodeTemp.getId())) {
            sysCodeTempManager.create(sysCodeTemp);
            msg = getMessage("sysCodeTemp.created", new Object[]{sysCodeTemp.getIdentifyLabel()}, "[模板文件管理表]成功创建!");
        } else {
        	String id=sysCodeTemp.getId();
        	SysCodeTemp oldEnt=sysCodeTempManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysCodeTemp);
            sysCodeTempManager.update(oldEnt);
       
            msg = getMessage("sysCodeTemp.updated", new Object[]{sysCodeTemp.getIdentifyLabel()}, "[模板文件管理表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysCodeTempManager;
	}
}
