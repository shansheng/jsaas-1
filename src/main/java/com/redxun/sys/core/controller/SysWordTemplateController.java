
package com.redxun.sys.core.controller;

import java.lang.reflect.InvocationTargetException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysWordTemplate;
import com.redxun.sys.core.manager.SysWordTemplateManager;
import com.redxun.sys.log.LogEnt;

/**
 * SYS_WORD_TEMPLATE【模板表】控制器
 * @author mansan
 */
@Controller
@RequestMapping("/sys/core/sysWordTemplate/")
public class SysWordTemplateController extends MybatisListController{
	@Resource
	SysWordTemplateManager sysWordTemplateManager;
	

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}

	@RequestMapping("del")
	@ResponseBody
	@LogEnt(action = "del", module = "sys", submodule = "WORD模版")
	public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String uId=RequestUtil.getString(request, "ids");
		if(StringUtils.isNotEmpty(uId)){
			String[] ids=uId.split(",");
			for(String id:ids){
				sysWordTemplateManager.delete(id);
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
		SysWordTemplate sysWordTemplate=null;
		if(StringUtils.isNotEmpty(pkId)){
			sysWordTemplate=sysWordTemplateManager.get(pkId);
		}else{
			sysWordTemplate=new SysWordTemplate();
		}
		return getPathView(request).addObject("sysWordTemplate",sysWordTemplate);
	}


	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String pkId=RequestUtil.getString(request, "pkId");
		SysWordTemplate sysWordTemplate=null;
		if(StringUtils.isNotEmpty(pkId)){
			sysWordTemplate=sysWordTemplateManager.get(pkId);
		}else{
			sysWordTemplate=new SysWordTemplate();
		}
		return getPathView(request).addObject("sysWordTemplate",sysWordTemplate);
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
	public SysWordTemplate getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String uId=RequestUtil.getString(request, "ids");    	
		SysWordTemplate sysWordTemplate = sysWordTemplateManager.get(uId);
		return sysWordTemplate;
	}

	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	@LogEnt(action = "save", module = "sys", submodule = "WORD模版")
	public JsonResult save(HttpServletRequest request, @RequestBody SysWordTemplate sysWordTemplate, BindingResult result) throws IllegalAccessException, InvocationTargetException {
		boolean isExist=sysWordTemplateManager.isAliasExist(sysWordTemplate);
		if(isExist){
			return new JsonResult(false, "WORD模版已存在!");
		}
		if (result.hasFieldErrors()) {
			return new JsonResult(false, getErrorMsg(result));
		}
		String msg = null;
		if (StringUtils.isEmpty(sysWordTemplate.getId())) {
			sysWordTemplateManager.create(sysWordTemplate);
			            msg = getMessage("sysWordTemplate.created", new Object[]{sysWordTemplate.getIdentifyLabel()}, "WORD模版成功创建!");
		} else {
			SysWordTemplate orignTemplate=sysWordTemplateManager.get(sysWordTemplate.getId());
			BeanUtil.copyNotNullProperties(orignTemplate, sysWordTemplate);
			sysWordTemplateManager.update(orignTemplate);
			            msg = getMessage("sysWordTemplate.updated", new Object[]{sysWordTemplate.getIdentifyLabel()}, "WORD模版成功更新!");
		}
		return new JsonResult(true, msg, sysWordTemplate);
	}

	@RequestMapping("office")
	public ModelAndView office(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String pkId=RequestUtil.getString(request, "pkId");
		SysWordTemplate sysWordTemplate=null;
		if(StringUtils.isNotEmpty(pkId)){
			sysWordTemplate=sysWordTemplateManager.get(pkId);
		}else{
			sysWordTemplate=new SysWordTemplate();
		}
		return getPathView(request).addObject("sysWordTemplate",sysWordTemplate);
	}

	
	@ResponseBody
	@RequestMapping("getTableInfo")
	public JSONArray getMetaData(HttpServletRequest request,HttpServletResponse response) throws Exception{
		//主表
		String pkId=RequestUtil.getString(request, "pkId");
		SysWordTemplate sysWordTemplate=  sysWordTemplateManager.get(pkId);
		JSONArray jsonAry=sysWordTemplateManager.getMetaData(sysWordTemplate);
		return jsonAry;
	}
	

	@RequestMapping("updTemplateId")
	public void updTemplateId(HttpServletRequest request,HttpServletResponse response, Model model) throws Exception{
		String pkId=RequestUtil.getString(request, "pkId");
		String templateId=RequestUtil.getString(request, "templateId");
		SysWordTemplate sysWordTemplate=sysWordTemplateManager.get(pkId);
		sysWordTemplate.setTemplateId(templateId);
		sysWordTemplateManager.update(sysWordTemplate);
	}
	
	@RequestMapping(value={"preview/{alias}/{id}"})
	public ModelAndView preview(HttpServletRequest request,@PathVariable(value="alias") String alias
			,@PathVariable(value="id") String id) throws Exception{
		SysWordTemplate sysWordTemplate = sysWordTemplateManager.getByAlias(alias);
		ModelAndView mv=new ModelAndView();
		mv.setViewName("sys/core/sysWordTemplatePreview.jsp");
		return mv.addObject("templateId", sysWordTemplate.getTemplateId())
				.addObject("pk", id).addObject("pkId", sysWordTemplate.getPkId());
	}

	@ResponseBody
	@RequestMapping("getData")
	public JSONObject getData(HttpServletRequest request,HttpServletResponse response, Model model) throws Exception{
		String pkId = RequestUtil.getString(request, "pkId");
		String pk = RequestUtil.getString(request, "pk");
		SysWordTemplate sysWordTemplate = sysWordTemplateManager.get(pkId);
		JSONObject json=sysWordTemplateManager.getData(sysWordTemplate, pk);
		return json;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysWordTemplateManager;
	}
}
