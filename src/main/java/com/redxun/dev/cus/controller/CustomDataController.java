package com.redxun.dev.cus.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SimpleDateFormatSerializer;
import com.redxun.core.dao.mybatis.domain.PageList;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.GridHeader;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.Base64Util;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.core.controller.SysBoListController;
import com.redxun.sys.core.entity.SysBoList;
import com.redxun.sys.core.entity.SysBoTopButton;
import com.redxun.sys.core.entity.TreeConfig;
import com.redxun.sys.core.manager.SysBoListManager;
import com.redxun.ui.grid.column.render.MiniGridColumnRender;
import com.redxun.ui.grid.column.render.MiniGridColumnRenderConfig;

import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;

/**
 * 客户化开发时，其数据的展示放置在此
 * @author mansan
 *
 */
@Controller
@RequestMapping("/dev/cus/customData")
public class CustomDataController {
	@Resource
	SysBoListManager sysBoListManager;
	@Resource
	FreemarkEngine freemarkEngine;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	MiniGridColumnRenderConfig miniGridColumnRenderConfig;
	@Resource
	SysBoDefManager sysBoDefManager;
	
	/**
     * 获得树的JSON
     * replace with getTabTreeJson
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getTreeJson")
    @ResponseBody
    public List getTreeJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String ds=request.getParameter("ds");
    	String sql=request.getParameter("sql");
    	String orgSql=new String(Base64Util.decode(sql.getBytes("UTF-8")));
    	List list=null;
    	try{
    		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    		DbContextHolder.setDataSource(ds);
    		list=sysBoListManager.getDataBySql(getHeaderSql(request,orgSql),queryFilter);
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	return list;
    }
    
    @RequestMapping("{boKey}/{treeId}/getTabTreeJson")
    @ResponseBody
    public void getTabTreeJson(@PathVariable("boKey")String boKey,@PathVariable("treeId")String treeId,HttpServletRequest request,HttpServletResponse response)throws Exception{
    	SysBoList sysBoList=getBoList(boKey);

		PrintWriter pw=response.getWriter();
		if(sysBoList==null){
			pw.println("[]");
			pw.close();
			return;
		}
		
		TreeConfig treeConfig=sysBoList.getLeftTreeMap().get(treeId);
		if(treeConfig==null){
			pw.println("[]");
			pw.close();
			return;
		}
		String sql="YES".equals(treeConfig.getUseCondSql())?treeConfig.getCondSqls():treeConfig.getSql();
		
		List list=null;
    	try{
    		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    		DbContextHolder.setDataSource(treeConfig.getDs());
    		list=sysBoListManager.getDataBySql(getHeaderSql(request,sql,treeConfig.getUseCondSql()),queryFilter);
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	
    	if(list==null){
    		pw.println("[]");
    	}else{
    		pw.println(toJSON(list));
    	}
    	pw.close();
    }
   
    /**
     * 展示对话框
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("{boKey}/dialog.do")
    public void dialog(@PathVariable("boKey")String boKey,HttpServletRequest request,HttpServletResponse response) throws Exception{
    	SysBoList sysBoList=getBoList(boKey);
    	showDialog(request, response, sysBoList);
    }
    
   
    
    private void showDialog(HttpServletRequest request,HttpServletResponse response,SysBoList sysBoList) throws TemplateException, IOException{
    	//获取参数进行查询。
    	Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
    	
    	Map<String, Object> model=new HashMap<String, Object>();
    	model.put("ctxPath", request.getContextPath());
    	if(BeanUtil.isEmpty(params.get("single"))) {
    		params.put("single", "true".equals(sysBoList.getMultiSelect())?"false":"true");
    	}
    	model.put("params", params);
    	
    	Map<String,Boolean> rightMap= getRight(sysBoList);
    	model.put("right", rightMap);
    	//加上freemark的按钮地址解析
    	TemplateHashModel sysBoListModel=FreemakerUtil.getTemplateModel(SysBoListController.class);
    	model.put("SysBoListUtil", sysBoListModel);
    	String html=freemarkEngine.parseByStringTemplate(model, sysBoList.getListHtml());
    	ServletOutputStream out = response.getOutputStream();  
        out.write(html.getBytes("UTF-8"));
        out.flush();
    }
    
    private void addContextVar(Map<String, Object> params){
    	IUser curUser=ContextUtil.getCurrentUser();
    	params.put(SysBoEnt.FIELD_CREATE_BY, curUser.getUserId());
    	params.put("DEP_ID_", curUser.getMainGroupId());
    	params.put(SysBoEnt.FIELD_TENANT, curUser.getTenant().getTenantId());
    }
    
    private String getHeaderSql(HttpServletRequest request,String sql) throws Exception{
    	Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
    	//加上上下文的Context变量
    	addContextVar(params);
    	
    	String newSql=null;
    	String useCondSql=request.getParameter("useCondSql");
    	if("YES".equals(useCondSql)){
    		sql=freemarkEngine.parseByStringTemplate(params, sql);
    		newSql=(String)groovyEngine.executeScripts(sql,params);
    	}else{
    		newSql=freemarkEngine.parseByStringTemplate(params, sql);
    	}
    	return newSql;
    }
    
    private String getHeaderSql(HttpServletRequest request,String sql,String useCondSql) throws Exception{
    	Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
    	//加上上下文的Context变量
    	addContextVar(params);
    	
    	String newSql=null;
    
    	if("YES".equals(useCondSql)){
    		sql=freemarkEngine.parseByStringTemplate(params, sql);
    		newSql=(String)groovyEngine.executeScripts(sql,params);
    	}else{
    		newSql=freemarkEngine.parseByStringTemplate(params, sql);
    	}
    	
    	return newSql;
    }
    
    
    /**
     * 计算按钮的权限。
     * @param sysBoList
     * @return
     */
    private Map<String,Boolean> getRight(SysBoList sysBoList){
    	Map<String,Boolean> map=new HashMap<String, Boolean>();
    	String jsonBtn=sysBoList.getTopBtnsJson();
    	if(StringUtil.isEmpty(jsonBtn)) return map;
    	
    	Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
    	JSONArray aryJson=JSONArray.parseArray(jsonBtn);
    	for(Object obj:aryJson){
    		JSONObject btnJson=(JSONObject)obj;

    		String btnName=btnJson.getString("btnName");
    		String permission=btnJson.getString("permission");
    		Boolean rtn=hasRight(permission, profileMap);
    		
    		map.put(btnName, rtn);
    	}
    	
    	return map;
    }
    
    /**
     * 计算权限。
     * @param permission
     * @param profileMap
     * @return
     */
    private Boolean hasRight(String permission,Map<String, Set<String>> profileMap){
    	if(StringUtil.isEmpty(permission) || permission.equals("[]")) return true;
    	JSONArray jsonAry=JSONArray.parseArray(permission);
    	for(Object obj:jsonAry){
    		JSONObject btnJson=(JSONObject)obj;
    		String type=btnJson.getString("type");
    		String ids=btnJson.getString("ids");
    		Set<String> set=profileMap.get(type);
    		boolean rtn=hasRight(ids, set);
    		if(rtn) return true;
    	}
    	return false;
    }

    /**
     * 判断是否有权限。
     * @param ids
     * @param set
     * @return
     */
    private boolean hasRight(String ids,Set<String> set){
    	String[] aryId=ids.split(",");
    	for(int i=0;i<aryId.length;i++){
    		String id=aryId[i];
    		if(set.contains(id)){
    			return true;
    		}
    	}
    	return false;
    }
    
	/**
	 * 取得业务数据
	 * @param boKey
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/getTreeJson.do")
    public void getTreeJson(@PathVariable("boKey")String boKey,HttpServletRequest request,HttpServletResponse response) throws Exception{
		SysBoList sysBoList=getBoList(boKey);
		response.setContentType("application/json");
		PrintWriter pw=response.getWriter();
		if(sysBoList==null){
			pw.println("[]");
			pw.close();
			return;
		}
    	try{
    		DbContextHolder.setDataSource(sysBoList.getDbAs());
    		String sql=getHeaderSql(request, sysBoList);
    		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    		if("YES".equals(sysBoList.getIsPage())){
    			
    			PageList list=sysBoListManager.getPageDataBySql(sql,queryFilter);
    			pw.println(toJSON(list));
    		}else{
    			List list=sysBoListManager.getDataBySql(sql,queryFilter);
    			pw.println(toJSON(list));
    		}
    		pw.close();
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	
    }

	/**
	 * 取得业务数据
	 * @param boKey
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/getData.do")
    public void getData(@PathVariable("boKey")String boKey,HttpServletRequest request,HttpServletResponse response) throws Exception{
		SysBoList sysBoList=getBoList(boKey);
		response.setContentType("application/json");
		PrintWriter pw=response.getWriter();
		if(sysBoList==null){
			pw.println(toJSON(new JsonPageResult(false)));
			pw.close();
			return;
		}
    	JsonPageResult result=new JsonPageResult(true);
    
    	try{
    		DbContextHolder.setDataSource(sysBoList.getDbAs());
    		Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
    		//加上上下文的Context变量
        	addContextVar(params);
    		String sql=sysBoListManager.getValidSql(sysBoList, params);
    		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    		if("YES".equals(sysBoList.getIsPage())){
    			
    			PageList list=sysBoListManager.getPageDataBySql(sql,queryFilter);
    			Map<String,GridHeader> gridHeaderMap=sysBoListManager.getGridHeaderMap(sysBoList.getColsJson());
    			//处理后端的数据格式化及展示的问题
    			for(int i=0;i<list.size();i++){
    				Map<String,Object> row=(Map)list.get(i);
    				for(GridHeader gd:gridHeaderMap.values()){
    					 Object val=row.get(gd.getFieldName());
	    				 MiniGridColumnRender render=miniGridColumnRenderConfig.getColumnRenderMap().get(gd.getRenderType());
	    				 if(render!=null){
		    				 Object ival=render.render(gd,row,val, false);
		    				 row.put(gd.getFieldName(), ival);
	    				 }
    				}
    			}
    			//若为树型控件,则直接返回列表数据
    			if("tree".equals(sysBoList.getDataStyle())){
    				Page page=QueryFilterBuilder.createPage(request);
    		    	page.setPageSize(20000);
    		    	queryFilter.setPage(page);
    				list=sysBoListManager.getPageDataBySql(sql,queryFilter);
    				pw.println(toJSON(list));
    	    		pw.close();
    	    		return;
    			}
    			result.setData(list);
    			result.setTotal(list.getPageResult().getTotalCount());
    		}else{
    			List list=sysBoListManager.getDataBySql(sql,queryFilter);
    			result.setData(list);
    		}
    		
    		pw.println(toJSON(result));
    		pw.close();
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	
    }
	
	
	
	@RequestMapping("/config/{boKey}.do")
	@ResponseBody
    public SysBoList getConfigByKey(@PathVariable("boKey")String boKey) throws Exception{
		SysBoList sysBoList= getBoList(boKey);
		SysBoList rtn=new SysBoList();
		rtn.setId(sysBoList.getId());
		rtn.setKey(sysBoList.getKey());
		rtn.setName(sysBoList.getName());
		rtn.setWidth(sysBoList.getWidth());
		rtn.setHeight(sysBoList.getHeight());
		rtn.setIsTreeDlg(sysBoList.getIsTreeDlg());
		rtn.setMultiSelect(sysBoList.getMultiSelect());

		return rtn;
		
	}
	
	private SysBoList getBoList(String boKey){
		SysBoList sysBoList=sysBoListManager.getBoList(boKey);
		//获得列头大小
		if(sysBoList.getColumnHeaderMap().size()==0){
			Map<String,GridHeader> headerMap=sysBoListManager.getGridHeaderMap(sysBoList.getColsJson());
			sysBoList.setColumnHeaderMap(headerMap);
		}
		
		if(sysBoList.getTopButtonMap().size()==0){
			//在Bo中增加缓存的按钮处理
			if(StringUtils.isNotEmpty(sysBoList.getTopBtnsJson())){
				List<SysBoTopButton> buttons=JSONArray.parseArray(sysBoList.getTopBtnsJson(), SysBoTopButton.class);
				sysBoList.getTopButtonMap().clear();
				for(SysBoTopButton btn:buttons){
					sysBoList.getTopButtonMap().put(btn.getBtnName(), btn);
				}
			}
		}
		
		if(sysBoList.getLeftTreeMap().size()==0){
			if(StringUtils.isNotEmpty(sysBoList.getLeftTreeJson())){
				List<TreeConfig> configs=JSONArray.parseArray(sysBoList.getLeftTreeJson(), TreeConfig.class);
				sysBoList.getLeftTreeMap().clear();
				for(TreeConfig config:configs){
					sysBoList.getLeftTreeMap().put(config.getTreeId(),config);
				}
			}
		}
		return sysBoList;
	}
	
	
	
	
	private String getHeaderSql(HttpServletRequest request,SysBoList sysBoList) throws Exception{
		Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
		//加上上下文的Context变量
    	addContextVar(params);
    	
		String newSql=null;
		
		if("YES".equals(sysBoList.getUseCondSql())){
			String sql=freemarkEngine.parseByStringTemplate(params, sysBoList.getCondSqls());
			newSql=(String)groovyEngine.executeScripts(sql, params);
		}else{
			newSql=freemarkEngine.parseByStringTemplate(params, sysBoList.getSql());
		}
		return newSql;
	}
	 
	/**
	 * 动态执行按钮的自定义脚本
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/selfButtonExe/{funKey}")
	@ResponseBody
	public JsonResult selfButtonExe(HttpServletRequest request,@PathVariable("boKey")String boKey,@PathVariable("funKey")String funKey) throws Exception{
		
		SysBoList sysBoList=sysBoListManager.getBoList(boKey);
		if(sysBoList==null){
			return new JsonResult(false,"不存在标识键为："+ boKey+"的业务对象的配置");
		}
		SysBoTopButton sysBoTopButton=sysBoList.getTopButtonMap().get(funKey);
		if(sysBoTopButton==null ||StringUtils.isEmpty(sysBoTopButton.getServerHandleScript())){
			return new JsonResult(false,"不存在标识键为："+ funKey+"按钮的后端代码配置！");
		}
		JdbcTemplate jdbcTemplate=AppBeanUtil.getBean(JdbcTemplate.class);
		
		Object result=null;
		String pScript=null;
		try{
			Map<String,Object> variables=RequestUtil.getParameterValueMap(request, true);
			//TODO,传入ov数组还是Json数值
			String data=request.getParameter("data");
			JSONArray ary=JSONArray.parseArray(data);
			
			variables.put("variables", variables);
			variables.put("rows", ary);
			//动态解析脚本
			pScript=freemarkEngine.parseByStringTemplate(variables, sysBoTopButton.getServerHandleScript());
			//动态执行脚本
			result=groovyEngine.executeScripts(pScript, variables);
		}catch(Exception ex){
			ex.printStackTrace();
			String errMsg=pScript+"执行有错误！错误如下："+ex.getMessage();
			return new JsonResult(false,errMsg);
		}
		
		return new JsonResult(true,"成功执行！",result);
	}
	
	
	
	private String toJSON(Object obj){
		SerializeConfig mapping = new SerializeConfig();
		String dateFormat = "yyyy-MM-dd HH:mm:ss";
		
		mapping.put(Date.class, new SimpleDateFormatSerializer(dateFormat));
		mapping.put(java.sql.Date.class, new SimpleDateFormatSerializer(dateFormat));
	    mapping.put(Timestamp.class, new SimpleDateFormatSerializer(dateFormat));
	  
        String text = JSON.toJSONString(obj, mapping);
      
        return text;
	}
	
	
	@RequestMapping("getBoData/{alias}/{id}")
	@ResponseBody 
	public JSONObject getBoData(@PathVariable(value="alias") String alias, @PathVariable(value="id") String id){
		SysBoDef def= sysBoDefManager.getByAlias(alias);
		JSONObject json= sysBoDefManager.getDataByBoDef(def.getId(), id);
		return json;
	}
	
}
