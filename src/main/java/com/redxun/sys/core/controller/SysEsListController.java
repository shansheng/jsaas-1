
package com.redxun.sys.core.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.elastic.JestService;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysEsList;
import com.redxun.sys.core.manager.SysEsListManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.log.LogEnt;

import freemarker.template.TemplateHashModel;

/**
 * SYS_ES_LIST控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/core/sysEsList/")
public class SysEsListController extends MybatisListController{
    @Resource
    SysEsListManager sysEsListManager;
    @Resource
    FreemarkEngine freemarkEngine;
    @Resource
    JestService jestService;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "SYS_ES_LIST")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysEsListManager.delete(id);
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
        SysEsList sysEsList=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysEsList=sysEsListManager.get(pkId);
        }else{
        	sysEsList=new SysEsList();
        }
        return getPathView(request).addObject("sysEsList",sysEsList);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysEsList sysEsList=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysEsList=sysEsListManager.get(pkId);
    	}else{
    		sysEsList=new SysEsList();
    	}
    	return getPathView(request).addObject("sysEsList",sysEsList);
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
    public SysEsList getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        SysEsList sysEsList = sysEsListManager.getSysEsList(uId);
        return sysEsList;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "SYS_ES_LIST")
    public JsonResult save(HttpServletRequest request, @RequestBody SysEsList sysEsList, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysEsList.getId())) {
            sysEsListManager.create(sysEsList);
            msg = getMessage("sysEsList.created", new Object[]{sysEsList.getIdentifyLabel()}, "[es单据列表]成功创建!");
        } else {
        	String id=sysEsList.getId();
        	SysEsList oldEnt=sysEsListManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysEsList);
            sysEsListManager.update(oldEnt);
       
            msg = getMessage("sysEsList.updated", new Object[]{sysEsList.getIdentifyLabel()}, "[es单据列表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg,sysEsList);
    }
    
    /**
     * 第二步编辑对话框及列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("edit2")
    public ModelAndView edit2(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	SysEsList sysEsList=null;
    	if(StringUtils.isNotEmpty(id)){
    		sysEsList=sysEsListManager.get(id);
    	}else{
    		sysEsList=new SysEsList();
    	}
    	return getPathView(request).addObject("sysEsList",sysEsList);
    }
    
    /**
     * 第三步编辑对话框及列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("edit3")
    public ModelAndView edit3(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	SysEsList sysEsList=sysEsListManager.get(id);
    	return getPathView(request).addObject("sysEsList",sysEsList);
    }
    
    /**
     * 在线修改HTML
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("saveHtml")
    @ResponseBody
    public JsonResult saveHtml(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	String html=request.getParameter("html");
    	
    	SysEsList sysEsList=sysEsListManager.get(id);
    	sysEsList.setListHtml(html);
    	sysEsListManager.update(sysEsList);
    	return new JsonResult(true,"成功保存HTML");
    }
    
    /**
     * 生成页面
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("genHtml")
    @ResponseBody
    public JsonResult genHtml(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	Map<String,Object> model=new HashMap<String, Object>();
    	model.put("ctxPath",request.getContextPath());
    	//生成模板时，不替换${ctxPath},解析真正页面时，才替换
    	SysEsList sysEsList=sysEsListManager.get(id);
    	
    	String[] listHtml=sysEsListManager.genHtmlPage(sysEsList, model);
    	sysEsList.setListHtml(listHtml[0]);
    	sysEsListManager.update(sysEsList);
    	return new JsonResult(true,"成功生成Html");
    }
    
    /**
     * 预览
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("{alias}/list")
    public void list(HttpServletRequest request,HttpServletResponse response,@PathVariable(value="alias") String alias) throws Exception{
    	getList( request, response, alias, false);
    }
    
    private void getList(HttpServletRequest request,HttpServletResponse response,String alias,boolean isShare) throws Exception{
    	response.setContentType("text/html;charset=utf-8");
    	SysEsList sysEsList=sysEsListManager.getEsList(alias);
    	
    	Map<String, Object> model=new HashMap<String, Object>();


    	model.put("ctxPath", request.getContextPath());

    	String version=SysPropertiesUtil.getGlobalProperty("static_res_ver","1");
    	
    	Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
    	model.put("params", params);
    	model.put("version", version);
    	

    	
    	//加上freemark的按钮地址解析
    	TemplateHashModel sysBoListModel=FreemakerUtil.getTemplateModel(this.getClass());
    	model.put("SysBoListUtil", sysBoListModel);
    	
    	String html=freemarkEngine.parseByStringTemplate(model, sysEsList.getListHtml());
    	ServletOutputStream out = response.getOutputStream();  
        out.write(html.getBytes("UTF-8"));
        out.flush();
    }
    
    /**
	 * 执行自定义查询。
	 * <pre>
	 *  如果做分页查询。
	 *  需要传入当前页数，页数从1开始计数。
	 * </pre>
	 * @param request
	 * @return
     * @throws Exception 
	 */
	@RequestMapping(value = "{alias}/getData")
	@ResponseBody
	public void queryDataEs(HttpServletRequest request,HttpServletResponse response,@PathVariable(value="alias") String alias) throws Exception {
		SysEsList sysEsList = sysEsListManager.getEsList(alias);
		response.setContentType("application/json");
		QueryFilter queryFilter=getQueryFilter(request);
		Map<String,Object> searchMap = buildWhere(sysEsList,request);
		
		queryFilter.setParams(searchMap);
		List rtn = new ArrayList();
		if(sysEsList.getIsPage()==1){
			rtn=sysEsListManager.queryForPage(sysEsList,queryFilter);
		}
		else{
			rtn=sysEsListManager.queryForList(sysEsList, queryFilter);
		}
		JsonPageResult result=new JsonPageResult(rtn,queryFilter.getPage().getTotalItems());
		String jsonResult=iJson.toJson(result);
		PrintWriter pw=response.getWriter();
		pw.println(jsonResult);
		pw.close();
	}
	
	private Map<String,Object> buildWhere(SysEsList sysEsList,HttpServletRequest request) {
		Map<String,Object> searchMap = new HashMap<String,Object>();
		JSONArray ary = JSONArray.parseArray(sysEsList.getConditionFields());
		Iterator<Object> it = ary.iterator();
		while(it.hasNext()) {
			JSONObject obj = (JSONObject) it.next();
			String key = obj.getString("name");
			String value = request.getParameter(key+"_search");
			if(StringUtil.isEmpty(value))continue;
			searchMap.put(key, value);
		}
		return searchMap;
	}

	@Override
	public MybatisBaseManager getBaseManager() {
		return sysEsListManager;
	}
}
