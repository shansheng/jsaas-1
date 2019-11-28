
package com.redxun.sys.core.controller;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.cache.ICache;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.dao.mybatis.domain.PageList;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.GridHeader;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.Base64Util;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.PdfUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.security.provider.ISecurityDataProvider;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.entity.SysBoList;
import com.redxun.sys.core.entity.SysDataSource;
import com.redxun.sys.core.manager.SysBoListManager;
import com.redxun.sys.core.manager.SysDataSourceManager;
import com.redxun.sys.core.util.DbUtil;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.customform.entity.SysCustomFormSetting;
import com.redxun.sys.customform.manager.SysCustomFormSettingManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.ui.grid.column.render.MiniGridColumnRender;
import com.redxun.ui.grid.column.render.MiniGridColumnRenderConfig;
import com.redxun.ui.view.model.ExportFieldColumn;
import com.thoughtworks.xstream.XStream;

import freemarker.template.TemplateHashModel;

/**
 * 系统自定义业务管理列表控制器
 * @author mansan
 */
@Controller
@RequestMapping("/sys/core/sysBoList/")
public class SysBoListController extends TenantListController{
    @Resource
    SysBoListManager sysBoListManager;
    @Resource
    SysDataSourceManager sysDataSourceManager;
    @Resource
    FreemarkEngine freemarkEngine;
    @Resource
    SysCustomFormSettingManager sysCustomFormSettingManager;
    @Resource
    GroovyEngine groovyEngine;
    @Resource
    BpmFormViewManager bpmFormViewManager;
    @Resource
    SysBoDefManager sysBoDefManager;
    @Resource
    SysBoEntManager sysBoEntManager;
    @Resource
	MiniGridColumnRenderConfig miniGridColumnRenderConfig;
    @Resource
    CommonDao commonDao;
    
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter filter=QueryFilterBuilder.createQueryFilter(request);
		filter.addFieldParam("IS_DIALOG_", "NO");
		String treeId=request.getParameter("treeId");
		if(StringUtils.isNotEmpty(treeId)){
			filter.addFieldParam("TREE_ID_",treeId);
		}
		String tenantId=ContextUtil.getCurrentTenantId();
		filter.addFieldParam("TENANT_ID_", tenantId);
		return filter;
	}
	
	@RequestMapping("listDialogJsons")
	@ResponseBody
	public JsonPageResult<SysBoList> listDialogJsons(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter filter=QueryFilterBuilder.createQueryFilter(request);
		String name=RequestUtil.getString(request, "name");
		String treeId=request.getParameter("treeId");
		if(StringUtils.isNotEmpty(treeId)){
			filter.addFieldParam("tree_id_",treeId);
		}
		if (StringUtils.isNotBlank(name)){
			filter.addFieldParam("NAME_", name);
		}
		String key=RequestUtil.getString(request, "key");
		if (StringUtils.isNotBlank(key)){
			filter.addFieldParam("KEY_", key);
		}
		filter.addFieldParam("IS_DIALOG_", "YES");
		String select=request.getParameter("select");
		if("true".equals(select)){
			filter.addFieldParam("IS_GEN_", "YES");
		}
		String tenantId=ContextUtil.getCurrentTenantId();
		filter.addFieldParam(SysBoEnt.FIELD_TENANT, tenantId);
		filter.addSortParam(SysBoEnt.FIELD_CREATE_TIME, "desc");
		List<SysBoList> list=sysBoListManager.getAll(filter);

		
		JsonPageResult<SysBoList> result=new JsonPageResult<SysBoList>(list,filter.getPage().getTotalItems());
		return result;
	}
	

	
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysBoListManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
    
    /**
     * 显示查询的数据
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getData")
    @ResponseBody
    public JsonPageResult getData(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String sql=request.getParameter("sql");
    	String ds=request.getParameter("ds");
    	String isPage=request.getParameter("isPage");
    	JsonPageResult result=new JsonPageResult(true);
    	String orgSql=Base64Util.decodeUtf8(sql);
    	QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    	try{
    		DbContextHolder.setDataSource(ds);
    		if("YES".equals(isPage)){
    			Page page=QueryFilterBuilder.createPage(request);
    			PageList list=sysBoListManager.getPageDataBySql(orgSql, page);
    			result.setData(list);
    			result.setTotal(list.getPageResult().getTotalCount());
    		}else{
    			List list=sysBoListManager.getDataBySql(orgSql,queryFilter);
    			result.setData(list);
    		}
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	return result;
    }
  
    /**
     * 成功保存搜索条件
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("saveConfigJson")
    @ResponseBody
    public JsonResult saveConfigJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	String colsJson=request.getParameter("colsJson");
    	String isLeftTree=request.getParameter("isShowLeft");
    	String isDialog=request.getParameter("isDialog");
    	String fieldJson=request.getParameter("fieldJson");
    	String searchJson=request.getParameter("searchJson");
    	String topBtnsJson=request.getParameter("topBtnsJson");
    	String dataRightJson=request.getParameter("dataRightJson");
    	String bodyScript=request.getParameter("bodyScript");
    	String drawCellScript=request.getParameter("drawCellScript");
    	String idField=request.getParameter("idField");
    	String textField=request.getParameter("textField");
    	String parentField=request.getParameter("parentField");
    	
    	String startFroCol=request.getParameter("startFroCol");
    	String endFroCol=request.getParameter("endFroCol");

    	SysBoList sysBoList=sysBoListManager.get(id);
    	
    	Integer iStartFroCol=0;
    	if(StringUtils.isNotEmpty(startFroCol)){
    		iStartFroCol=new Integer(startFroCol);
    	}
    	sysBoList.setStartFroCol(iStartFroCol);
    	
    	Integer iEndFroCol=0;
    	if(StringUtils.isNotEmpty(endFroCol)){
    		iEndFroCol=new Integer(endFroCol);
    	}
    	sysBoList.setEndFroCol(iEndFroCol);
    	
    	if(handlerColsJson(colsJson)) {
    		return new JsonResult(false,"列头设置有重复字段key");
    	}
    	sysBoList.setColsJson(colsJson);
    	if("YES".equals(isLeftTree)){
	    	String leftTreeJson=request.getParameter("leftTreeJson");
	    	sysBoList.setLeftTreeJson(leftTreeJson);
    	}
    	if("NO".equals(isDialog)){
    		sysBoList.setTopBtnsJson(topBtnsJson);
    	}else{
    		sysBoList.setFieldsJson(fieldJson);
    	}
    	
    	sysBoList.setIdField(idField);
    	
    	sysBoList.setTextField(textField);
    	
    	sysBoList.setParentField(parentField);
    	
    	sysBoList.setSearchJson(searchJson);
    	sysBoList.setBodyScript(bodyScript);
    	sysBoList.setDataRightJson(dataRightJson);
    	sysBoList.setDrawCellScript(drawCellScript);
    	sysBoListManager.update(sysBoList);
    	
    	updateSysBoListCache(sysBoList);
    	
    	return new JsonResult(true,"成功保存列表配置！");
    }
    
    private boolean handlerColsJson(String colsJson) {
    	Map<String,Integer> fieldCount = new HashMap<String,Integer>();
		JSONArray ary = JSONArray.parseArray(colsJson);
		for (Object object : ary) {
			JSONObject obj = (JSONObject) object;
			Integer count = fieldCount.get(obj.getString("field"));
    		if(count==null) {
    			count=0;
    		}
			fieldCount.put(obj.getString("field"), count+1);
		}
		
		for(Integer count : fieldCount.values()) {
			if(count>1) {
				return true;
			}
		}
		return false;
    }
    
    private void updateSysBoListCache(SysBoList sysBoList){
    	String cacheKey=ICache.SYS_BO_LIST_CACHE+sysBoList.getKey()+"_" + ContextUtil.getTenant().getDomain();
    	//清除旧的
    	CacheUtil.delCache(cacheKey);
    	
    }
    
    
    @RequestMapping("getJson")
    @ResponseBody
    public SysBoList getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=RequestUtil.getString(request, "pkId");
        SysBoList sysBoList=sysBoListManager.get(pkId);
        return sysBoList;
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
        SysBoList sysBoList=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysBoList=sysBoListManager.get(pkId);
        }else{
        	sysBoList=new SysBoList();
        }
        return getPathView(request).addObject("sysBoList",sysBoList);
    }
    
    /**
     * 树型对话框编辑
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("treeDlgEdit")
    public ModelAndView treeDlgEdit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	String dsName=null;
    	SysBoList sysBoList=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysBoList=sysBoListManager.get(pkId);
    		if(StringUtils.isNotEmpty(sysBoList.getFormAlias())){
    			SysCustomFormSetting scf=sysCustomFormSettingManager.getByAlias(sysBoList.getFormAlias());
    			if(scf!=null){
    				sysBoList.setFormName(scf.getName());
    			}
    		}
    		if(StringUtils.isNotEmpty(sysBoList.getDbAs())){
	    		SysDataSource sysDataSource=sysDataSourceManager.getByAlias(sysBoList.getDbAs());
	    		if(sysDataSource!=null){
	    			dsName=sysDataSource.getName();
	    		}
    		}
    	}else{
    		sysBoList=new SysBoList();
    		sysBoList.setHeight(350);
    		sysBoList.setWidth(650);
    		
    		sysBoList.setIsPage(MBoolean.YES.name());
    		sysBoList.setIsLeftTree(MBoolean.NO.name());
    		sysBoList.setIsExport(MBoolean.NO.name());
    	}
    	return getPathView(request).addObject("sysBoList",sysBoList)
    			.addObject("dsName",dsName);
    }
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	String isDialog=request.getParameter("isDialog");
    	if(StringUtils.isEmpty(isDialog)){
    		isDialog=MBoolean.NO.name();
    	}
    	String dsName=null;
    	SysBoList sysBoList=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysBoList=sysBoListManager.get(pkId);
    		if("true".equals(forCopy)){
    			sysBoList.setId(null);
    		}
    		
    		if(StringUtils.isNotEmpty(sysBoList.getFormAlias())){
    			SysCustomFormSetting scf=sysCustomFormSettingManager.getByAlias(sysBoList.getFormAlias());
    			if(scf!=null){
    				sysBoList.setFormName(scf.getName());
    			}
    		}
    		if(StringUtils.isNotEmpty(sysBoList.getFormDetailAlias())){
    			if(sysBoList.getFormDetailAlias().equals(sysBoList.getFormAlias())){
    				sysBoList.setFormDetailName(sysBoList.getFormName());
    			}
    			else{
    				SysCustomFormSetting scf=sysCustomFormSettingManager.getByAlias(sysBoList.getFormDetailAlias());
        			if(scf!=null){
        				sysBoList.setFormDetailName(scf.getName());
        			}
    			}
    		}
    		
    		if(StringUtils.isNotEmpty(sysBoList.getDbAs())){
	    		SysDataSource sysDataSource=sysDataSourceManager.getByAlias(sysBoList.getDbAs());
	    		if(sysDataSource!=null){
	    			dsName=sysDataSource.getName();
	    		}
    		}
    	}else{
    		sysBoList=new SysBoList();
    		sysBoList.setHeight(350);
    		sysBoList.setWidth(650);
    		sysBoList.setIsDialog(isDialog);
    		sysBoList.setIsPage(MBoolean.YES.name());
    		sysBoList.setIsLeftTree(MBoolean.NO.name());
    		sysBoList.setIsExport(MBoolean.NO.name());
    		sysBoList.setDataStyle("list");
    		sysBoList.setRowEdit("NO");
    		sysBoList.setEnableFlow("NO");
    		sysBoList.setUseCondSql("NO");
    		sysBoList.setCondSqls("String sql=\"\";\n return sql;");
    	}
    	return getPathView(request).addObject("sysBoList",sysBoList)
    			.addObject("dsName",dsName);
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
    	SysBoList sysBoList=sysBoListManager.get(id);
    	String[] listHtml=sysBoListManager.genHtmlPage(sysBoList, model);
    	sysBoList.setListHtml(listHtml[0]);
    	sysBoList.setMobileHtml(listHtml[1]);
    	sysBoList.setIsGen(MBoolean.YES.name());
    	sysBoListManager.update(sysBoList);
    	updateSysBoListCache(sysBoList);
    	return new JsonResult(true,"成功生成Html");
    }
    
    /**
     * 生成列表页面。
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("genFormHtml")
    @ResponseBody
    public JSONObject genFormHtml(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=RequestUtil.getString(request, "id") ;
    	String gridMode=RequestUtil.getString(request, "gridMode") ;
    	
    	
    	SysBoList sysBoList=sysBoListManager.get(id);
    	
    	Map<String,Object> params =new HashMap<>();
    	params.put("gridMode", gridMode);
    	
    	String listHtml=sysBoListManager.genFormHtmlPage(sysBoList,params);
    	
    	JSONObject result= new JSONObject();
    	result.put("html", listHtml);
    	result.put("fields", JSONArray.parseArray(sysBoList.getColsJson()));
    	
    	String searchJson=sysBoList.getSearchJson();
    	if(StringUtil.isEmpty(searchJson)){
    		searchJson="[]";
    	}
    	
    	JSONArray ary=JSONArray.parseArray(searchJson);
    	JSONArray searchFields=new JSONArray();
    	for(int i=0;i<ary.size();i++){
    		JSONObject json=ary.getJSONObject(i);
    		String type=json.getString("type");
    		if("income".equals(type)){
    			searchFields.add(json);
    		}
    	}
    	
    	result.put("searchFields", searchFields);
    	
    	return result;
    }
    
    @RequestMapping("onGenTreeDlg")
    @ResponseBody
    public JsonResult onGenTreeDlg(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	String fieldsJson=request.getParameter("fieldsJson");
    	SysBoList sysBoList=sysBoListManager.get(id);
    	sysBoList.setFieldsJson(fieldsJson);
    	sysBoListManager.update(sysBoList);
    	
    	Map<String,Object> model=new HashMap<String, Object>();
    	model.put("ctxPath",request.getContextPath());
 
    	String listHtml=sysBoListManager.genTreeDlgHtmlPage(sysBoList, model);
    	sysBoList.setListHtml(listHtml);
    	sysBoList.setIsGen(MBoolean.YES.name());
    	sysBoListManager.update(sysBoList);
    	updateSysBoListCache(sysBoList);
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
    
    /**
     * 当前Url是否允许访问
     * @param url
     * @return
     */
    public static String isAllowBtn(String url){
    	int index=url.indexOf("?");
    	if(index!=-1){
    		url=url.substring(0,index);
    	}
    	ISecurityDataProvider securityDataProvider=(ISecurityDataProvider)AppBeanUtil.getBean("securityDataProvider");
    	IUser user = ContextUtil.getCurrentUser();
		// 是否为管理机构的超级管理员
		if (WebAppUtil.isSaasMgrUser() && user.isSuperAdmin()) {
			return "YES";
		}
		// 如果不包括在配置的菜单访问地址中,则默认允许访问
		if (!securityDataProvider.getMenuGroupIdsMap().containsKey(url)) {
			return "YES";
		}
		Authentication auth= SecurityContextHolder.getContext().getAuthentication();
		Set<String> groupIdSet = securityDataProvider.getMenuGroupIdsMap().get(url);
		boolean isIncludeGroupId = false;
		for (GrantedAuthority au : auth.getAuthorities()) {
			if (groupIdSet!=null&&groupIdSet.contains(au.getAuthority())) {
				isIncludeGroupId = true;
				break;
			}
		}
		if (isIncludeGroupId) {
			return "YES";
		}
    	return "NO";
    }
    
    /**
     * 导出Excel
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("{alias}/exportXLSDialog")
    public void exportXLSDialog(HttpServletRequest request,HttpServletResponse response,@PathVariable(value="alias") String alias) throws Exception{
    	SysBoList sysBoList=sysBoListManager.getBoList(alias);
    	
    	Map<String, Object> model=new HashMap<String, Object>();
    	model.put("ctxPath", request.getContextPath());
    	
    	Map<String,Boolean> rightMap= getRight(sysBoList);
    	model.put("right", rightMap);
    	
    	//接收页面传入参数进行查询。
    	Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
    	model.put("params", params);
    	
    	String html=freemarkEngine.parseByStringTemplate(model, sysBoList.getListHtml());
    	ServletOutputStream out = response.getOutputStream();  
        out.write(html.getBytes("UTF-8"));
        out.flush();
    }
    
    /**
     * 预览
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/share/{alias}/list")
    public void shareList(HttpServletRequest request,HttpServletResponse response,@PathVariable(value="alias") String alias) throws Exception{
    	getList( request, response, alias, true);
    }
    
    private void getList(HttpServletRequest request,HttpServletResponse response,String alias,boolean isShare) throws Exception{
    	response.setContentType("text/html;charset=utf-8");
    	SysBoList sysBoList=sysBoListManager.getBoList(alias);
    	
    	Map<String, Object> model=new HashMap<String, Object>();
    	model.put("ctxPath", request.getContextPath());
    	
    	String version=SysPropertiesUtil.getGlobalProperty("static_res_ver","1");
    	
    	Map<String,Boolean> rightMap= getRight(sysBoList);
    	model.put("right", rightMap);
    	
    	Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
    	model.put("params", params);
    	model.put("version", version);
    	

    	
    	//加上freemark的按钮地址解析
    	TemplateHashModel sysBoListModel=FreemakerUtil.getTemplateModel(this.getClass());
    	model.put("SysBoListUtil", sysBoListModel);
    	
    	String html=freemarkEngine.parseByStringTemplate(model, sysBoList.getListHtml());
    	ServletOutputStream out = response.getOutputStream();  
        out.write(html.getBytes("UTF-8"));
        out.flush();
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
    	//[{\"type\":\"user\",\"name\":\"用户\",\"ids\":\"240000004178008\",\"names\":\"朱海威\"}]
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

     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("onRun")
    @ResponseBody
    public JsonResult onRun(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String ds=request.getParameter("ds");
    	String sql=request.getParameter("sql");
    	JSONObject result=new JSONObject();
    	try{
    		DbContextHolder.setDataSource(ds);
    		
    		String newSql=getHeaderSql(request, sql);
	    	List<GridHeader> headers=DbUtil.getGridHeaders(newSql);
	    	
			JSONArray fieldCols=new JSONArray();
			for(GridHeader gh:headers){
				JSONObject fieldObj=new JSONObject();
				fieldObj.put("field", gh.getFieldName());
				fieldObj.put("header", gh.getFieldLabel());
				fieldObj.put("width", 100);
				fieldCols.add(fieldObj);
			}
			result.put("headers", headers);
			result.put("fields", fieldCols);
    	}catch(Exception e){
    		return new JsonResult(false,"执行SQL失败："+e.getMessage());
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	return new JsonResult(true,"成功执行SQL",result);
    }
    
    /**
     * 通过SQL获得数据
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
	@RequestMapping("getDataBySql")
    @ResponseBody
    public JsonPageResult getDataBySql(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String ds=request.getParameter("ds");
    	String sql=request.getParameter("sql");
    	Page page=QueryFilterBuilder.createPage(request);
    	JsonPageResult jsonPageResult=new JsonPageResult();
    	try{
    		DbContextHolder.setDataSource(ds);
    		String newSql=getHeaderSql(request, sql);
	    	PageList dataList=sysBoListManager.getPageDataBySql(newSql, page);
	    	jsonPageResult.setData(dataList);
	    	jsonPageResult.setTotal(dataList.getPageResult().getTotalCount());
    	}catch(Exception e){
    		e.printStackTrace();
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	return jsonPageResult;
    }
    private Map<String,JSONObject> getFieldJsonMap(String fieldJson){
    	
    	Map<String,JSONObject> map=new HashMap<String, JSONObject>();
    	if(StringUtils.isEmpty(fieldJson)){
    		return map;
    	}
    	JSONArray jsonArray=JSONArray.parseArray(fieldJson);
    	for(int i=0;i<jsonArray.size();i++){
    		JSONObject jsonObj=jsonArray.getJSONObject(i);
    		String field=jsonObj.getString("field");
    		map.put(field, jsonObj);
    	}
    	return map;
    }
    
    
    /**
     * 树型对话框编辑2
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("treeDlgEdit2")
    public ModelAndView treeDlgEdit2(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	SysBoList sysBoList=sysBoListManager.get(id);
    	String fieldJson=sysBoList.getFieldsJson();
    	JSONArray fieldArray=JSONArray.parseArray(fieldJson);//isReturn
    	JSONArray newArray=new JSONArray();
    	for (int i = 0; i < fieldArray.size(); i++) {
			JSONObject jsonObject=fieldArray.getJSONObject(i);
			jsonObject.put("isReturn", "YES");
			newArray.add(i, jsonObject);
		}
    	sysBoList.setFieldsJson(newArray.toJSONString());
    	return getPathView(request).addObject("sysBoList",sysBoList);
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
    	SysBoList sysBoList=sysBoListManager.get(id);
    	
    	if(sysBoList.getEndFroCol()==null){
    		sysBoList.setEndFroCol(0);
    	}
    	String errorMsg=null;
    	ModelAndView mv=getPathView(request);
    	mv.addObject("sysBoList",sysBoList);
    	//是否允许进行权限数据的授权
    	Boolean isAllowDataGrant=false;
    	try{
    		DbContextHolder.setDataSource(sysBoList.getDbAs());
    		//若旧的表头已经存在
    		JSONArray headerCols=JSONArray.parseArray(sysBoList.getColsJson());
    		
    		List<GridHeader> headers=DbUtil.getGridHeaders(getHeaderSql(request,sysBoList));
    		JSONArray fieldCols=new JSONArray();
    		boolean isNeedAdd=(headerCols==null || headerCols.size()==0)?true:false;
    		
    		if(headerCols==null){
    			headerCols=new JSONArray();
    		}
    		//获得其原来的字段映射配置
    		Map<String,JSONObject> jsonFieldMap=getFieldJsonMap(sysBoList.getFieldsJson());
    		for(GridHeader gh:headers){
    			JSONObject fieldObj=new JSONObject();
    			//设置为允许数据权限的配置
    			if(!isAllowDataGrant && ( SysBoEnt.FIELD_CREATE_BY .equals(gh.getFieldName()))){
    				isAllowDataGrant=true;
    			}
    			
    			//若为对话框，为其返回值作显示的原数据作准备
    			if("YES".equals(sysBoList.getIsDialog())){
        			JSONObject fieldJson=jsonFieldMap.get(gh.getFieldName());
        			if(fieldJson==null){
        				fieldObj.put("header", gh.getFieldLabel());
        			}else{
        				fieldObj.put("header", fieldJson.getString("header"));
        				fieldObj.put("isReturn",fieldJson.getString("isReturn"));
        				fieldObj.put("visible",fieldJson.getString("visible"));
        			}
    			}else{
        			fieldObj.put("header", gh.getFieldLabel());
        		}
    			fieldObj.put("field", gh.getFieldName());
    			
    			//为创建时间设置默认的格式
    			if(gh.getFieldName().equals("CREATE_TIME_") || gh.getFieldName().equals("UPDATE_TIME_")){
    				fieldObj.put("dataType", "date");
    				fieldObj.put("format", "yyyy-MM-dd");
    			}else{
    				fieldObj.put("dataType", gh.getDataType());
    			}
    			fieldObj.put("queryDataType", gh.getQueryDataType());
    			fieldObj.put("width", 100);
    			fieldObj.put("mobileShowMode", "unhost");
    			fieldCols.add(fieldObj);
    			if(isNeedAdd){
    				headerCols.add(fieldObj);
    			}
    		}
    		String headerColumns=iJson.toJson(headerCols);
    		String fieldColumns=iJson.toJson(fieldCols);
    		//第一次进来则保存其表头及字段的配置
    		DbContextHolder.setDefaultDataSource();
    		
    		if(StringUtils.isEmpty(sysBoList.getColsJson())){
    			sysBoList.setColsJson(headerColumns);
    			sysBoList.setFieldsJson(fieldColumns);
    			sysBoListManager.update(sysBoList);
    		}
    		mv.addObject("headerColumns",headerColumns);
    		mv.addObject("fieldColumns",fieldColumns);
    		mv.addObject("isAllowDataGrant",isAllowDataGrant);
    	}catch(Exception ex){
    		errorMsg=ex.getMessage();
    		mv.addObject("errorMsg",errorMsg);
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	return mv;
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
    	SysBoList sysBoList=sysBoListManager.get(id);
    	return getPathView(request).addObject("sysBoList",sysBoList);
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
    	String mobileHtml=request.getParameter("mobileHtml");
    	
    	SysBoList sysBoList=sysBoListManager.get(id);
    	sysBoList.setListHtml(html);
    	sysBoList.setMobileHtml(mobileHtml);
    	sysBoListManager.update(sysBoList);
    	updateSysBoListCache(sysBoList);
    	return new JsonResult(true,"成功保存HTML");
    }
    

    /**
     * 重新加载表头
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("reloadColumns")
    @ResponseBody
    public JsonPageResult reloadColumns(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	SysBoList sysBoList=sysBoListManager.get(id);
    	JsonPageResult result=new JsonPageResult(true);
    	DbContextHolder.setDataSource(sysBoList.getDbAs());
    	try{
    		//若旧的表头已经存在
    		JSONArray headerCols=JSONArray.parseArray(sysBoList.getColsJson());
    		
    		String sql=getHeaderSql( request, sysBoList);
    		
    		List<GridHeader> headers=DbUtil.getGridHeaders(sql);
    		JSONArray fieldCols=new JSONArray();
    		if(headerCols==null){
    			headerCols=new JSONArray();
    		}
    		for(GridHeader gh:headers){
    			JSONObject fieldObj=new JSONObject();
    			fieldObj.put("field", gh.getFieldName());
    			fieldObj.put("header", gh.getFieldLabel());
    			fieldObj.put("width", 100);
    			fieldCols.add(fieldObj);
    			
				//是否找到
				boolean isFound=false;
				for(int i=0;i<headerCols.size();i++){
					String field=headerCols.getJSONObject(i).getString("field");
					if(field==null) continue;
					if(field.equals(gh.getFieldName())){
						isFound=true;
						break;
					}
				}
				if(!isFound){
					headerCols.add(fieldObj);
				}
    		}
    		result.setData(headerCols);
    		result.setMessage("成功合并加载！");
    	}catch(Exception ex){
    		ex.printStackTrace();
    		result.setMessage("加载出错！");
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    	
    	return result;
    }

    
    private String getHeaderSql(HttpServletRequest request,SysBoList sysBoList) throws Exception{
    	Map<String, Object> params = getParams(request);
    	String newSql=null;
    	if("YES".equals(sysBoList.getUseCondSql())){
    		String sql=freemarkEngine.parseByStringTemplate(params, sysBoList.getCondSqls());
    		newSql=(String)groovyEngine.executeScripts(sql, params);
    	}else{
    		newSql=freemarkEngine.parseByStringTemplate(params, sysBoList.getSql());
    	}
    	
    	//return StringUtil.replaceVariableMap(newSql,params);
    	return newSql;
    }
    
    private String getHeaderSql(HttpServletRequest request,String sql) throws Exception{
    	Map<String, Object> params = getParams(request);
    	String newSql=null;
    	String useCondSql=request.getParameter("useCondSql");
    	if("YES".equals(useCondSql)){
    		sql=freemarkEngine.parseByStringTemplate(params, sql);
    		newSql=(String)groovyEngine.executeScripts(sql,params);
    	}else{
    		newSql=freemarkEngine.parseByStringTemplate(params, sql);
    	}
    	//return StringUtil.replaceVariableMap(newSql,params);
    	return newSql;
    }
    
    /**
     * 根据sql返回其对应的数据
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getSampleData")
    public void getSampleData(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String id=request.getParameter("id");
    	SysBoList sysBoList=sysBoListManager.get(id);
    	response.setContentType("application/json");
		PrintWriter pw=response.getWriter();
		if(sysBoList==null){
			pw.println("[]");
			pw.close();
			return;
		}
		JsonPageResult pageResult=new JsonPageResult(true);
    	try{
    		DbContextHolder.setDataSource(sysBoList.getDbAs());
    		Page page=QueryFilterBuilder.createPage(request);
    		PageList pageList=sysBoListManager.getPageDataBySql(getHeaderSql(request,sysBoList),page);
    		pageResult.setData(pageList);
    		pageResult.setTotal(pageList.getPageResult().getTotalCount());
    		pw.println(FastjsonUtil.toJSON(pageResult));
    		pw.close();
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
    
    }

	
	@RequestMapping("getByKey")
	@ResponseBody
	public JSONObject getByKey(HttpServletRequest request,HttpServletResponse response){
		String key=RequestUtil.getString(request, "key");
		SysBoList sysBoList=sysBoListManager.getByKey(key);
		String fieldsJson=sysBoList.getFieldsJson();
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("fieldsJson", fieldsJson);
		return jsonObject;
	}
	
	/**
	 * 导出当前页记录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/exportExcel")
	public void exportExcel(@PathVariable(value="boKey") String boKey,HttpServletRequest request, HttpServletResponse response) throws Exception {
		expExcel(request,response,boKey);
	}
	
	/**
	 * 导出当前页记录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boKey = RequestUtil.getString(request, "boKey");
		expExcel(request,response,boKey);
	}
	
	public void expExcel(HttpServletRequest request,HttpServletResponse response,String boKey) throws Exception{
		//是否导出多表头
		Boolean isMuti = RequestUtil.getBoolean(request, "isMuti");
		// 根据前台的列来生成列表
		String columns = RequestUtil.getString(request, "columns");
		List<ExportFieldColumn> gridcolumns = new ArrayList<ExportFieldColumn>();
		if(isMuti){
			gridcolumns = poiTableBuilder.constructMutiExportFieldColumns(columns);
		}else{
			gridcolumns = poiTableBuilder.constructSingleExportFieldColumns(columns,gridcolumns);
		}
		SysBoList sysBoList=sysBoListManager.getBoList(boKey);
		if(sysBoList ==null) return;
		DbContextHolder.setDataSource(sysBoList.getDbAs());
		 
		Map<String, Object> params = getParams(request);
    	
    	QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
    	
		String sql=sysBoListManager.getValidSql(sysBoList, params);
		
		List list=commonDao.queryForList( sql,  queryFilter,params);
		
		Map<String,GridHeader> headerMap=sysBoListManager.getGridHeaderMap(sysBoList.getColsJson());
		
		//处理后端的数据格式化及展示的问题
		for(int i=0;i<list.size();i++){
			Map<String,Object> row=(Map)list.get(i);
			for(GridHeader gd:headerMap.values()){
				 Object val=row.get(gd.getFieldName());
				 MiniGridColumnRender render=miniGridColumnRenderConfig.getColumnRenderMap().get(gd.getRenderType());
				 Object ival=render.render(gd,row,val, true);
				 row.put(gd.getFieldName(), ival);
			}
		}
		
		JSONArray ja = new JSONArray();//获取业务数据集
        if (list!=null &&list.size()>0) {
        	for (Object object : list) {
        		ja.add(object);
            }
        }
        String title = sysBoList.getName();
        ExcelUtil.downloadExcelFile(title,gridcolumns,ja,response);
	}

	private Map<String, Object> getParams(HttpServletRequest request) {
		Map<String, Object> params=RequestUtil.getParameterValueMap(request, false);
		IUser curUser=ContextUtil.getCurrentUser();
		//加上上下文的Context变量
    	params.put(SysBoEnt.FIELD_CREATE_BY, curUser.getUserId());
    	params.put("DEP_ID_", curUser.getMainGroupId());
    	params.put(SysBoEnt.FIELD_TENANT, curUser.getTenant().getTenantId());
		return params;
	}
	
	/**
	 * 导出当前页记录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/exportExcelDialog")
	public ModelAndView exportExcelDialog(@PathVariable(value="boKey") String boKey,HttpServletRequest request, HttpServletResponse response) throws Exception {
		return exportExcelDialog(boKey,request);
	}
	
	/**
	 * 导出当前页记录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportExcelDialog")
	public ModelAndView exportExcelDialog(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boKey=request.getParameter("boKey");
		return exportExcelDialog(boKey,request);
	}
	
	public ModelAndView exportExcelDialog(String boKey,HttpServletRequest request){
		//String boKey = RequestUtil.getString(request,"boKey");
		SysBoList sysBoList = sysBoListManager.getByKey(boKey);
		
		ModelAndView mv=new ModelAndView("sys/core/sysBoListExportExcelDialog.jsp");
		
		mv.addObject("sysBoList", sysBoList);
		try{
    		DbContextHolder.setDataSource(sysBoList.getDbAs());
    		//若旧的表头已经存在
    		JSONArray headerCols=JSONArray.parseArray(sysBoList.getColsJson());
    		
    		List<GridHeader> headers=DbUtil.getGridHeaders(getHeaderSql(request,sysBoList));
    		JSONArray fieldCols=new JSONArray();
    		boolean isNeedAdd=(headerCols==null || headerCols.size()==0)?true:false;
    		
    		if(headerCols==null){
    			headerCols=new JSONArray();
    		}
    		//获得其原来的字段映射配置
    		Map<String,JSONObject> jsonFieldMap=getFieldJsonMap(sysBoList.getFieldsJson());
    		for(GridHeader gh:headers){
    			JSONObject fieldObj=new JSONObject();
    			//若为对话框，为其返回值作显示的原数据作准备
    			if("YES".equals(sysBoList.getIsDialog())){
        			JSONObject fieldJson=jsonFieldMap.get(gh.getFieldName());
        			if(fieldJson==null){
        				fieldObj.put("header", gh.getFieldLabel());
        			}else{
        				fieldObj.put("header", fieldJson.getString("header"));
        				fieldObj.put("isReturn",fieldJson.getString("isReturn"));
        			}
    			}else{
        			fieldObj.put("header", gh.getFieldLabel());
        		}
    			fieldObj.put("field", gh.getFieldName());
    			
    			//为创建时间设置默认的格式
    			if(gh.getFieldName().equals("CREATE_TIME_") || gh.getFieldName().equals("UPDATE_TIME_")){
    				fieldObj.put("dataType", "date");
    				fieldObj.put("format", "yyyy-MM-dd");
    			}else{
    				fieldObj.put("dataType", gh.getDataType());
    			}
    			fieldObj.put("queryDataType", gh.getQueryDataType());
    			fieldObj.put("width", 100);
    			
    			fieldCols.add(fieldObj);
    			if(isNeedAdd){
    				headerCols.add(fieldObj);
    			}
    		}
    		String headerColumns=iJson.toJson(headerCols);
    		String fieldColumns=iJson.toJson(fieldCols);
    		//第一次进来则保存其表头及字段的配置
    		DbContextHolder.setDefaultDataSource();
    		
    		if(StringUtils.isEmpty(sysBoList.getColsJson())){
    			sysBoList.setColsJson(headerColumns);
    			sysBoList.setFieldsJson(fieldColumns);
    			sysBoListManager.update(sysBoList);
    		}
    		mv.addObject("headerColumns",headerColumns);
    		mv.addObject("fieldColumns",fieldColumns);
    	}catch(Exception ex){

    	}finally{
    		DbContextHolder.setDefaultDataSource();
    	}
		
		mv.addObject("boKey", boKey);
		return mv;
	}
	
	/**
	 * 导入Excel到数据库
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/importExcelDialog")
	public ModelAndView importExcelDialog(@PathVariable(value="boKey") String boKey,HttpServletRequest request, HttpServletResponse response) throws Exception {

		SysBoList sysBoList = sysBoListManager.getByKey(boKey);
		ModelAndView mv=new ModelAndView("sys/core/sysBoListImportExcelDialog.jsp");
		mv.addObject("sysBoList", sysBoList);
		
		mv.addObject("boKey", boKey);
        return mv;
	}
	
	/**
	 * 导入Excel到数据库
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("importExcelDialog")
	public ModelAndView importExcelDialog(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boKey=RequestUtil.getString(request, "boKey");
		SysBoList sysBoList = sysBoListManager.getByKey(boKey);
		ModelAndView mv=new ModelAndView("sys/core/sysBoListImportExcelDialog.jsp");
		mv.addObject("sysBoList", sysBoList);
		mv.addObject("boKey", boKey);
        return mv;
	}
	
	@RequestMapping("{boKey}/exportRowDialog")
	public ModelAndView exportRowDialog(@PathVariable(value="boKey") String boKey,HttpServletRequest request, HttpServletResponse response) throws Exception {
		return getExportRowDlgView(boKey,request);
	}

	/**
	 * 导入excel
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/importExcel")
    @ResponseBody
	public Long importExcel(@PathVariable(value="boKey") String boKey,MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {
		
		SysBoList sysBoList=sysBoListManager. getBoList(boKey);
		if(sysBoList ==null) return null;
		//获取该表所有字段
		String sysFormAlias = sysBoList.getFormAlias();
		SysCustomFormSetting scfs = sysCustomFormSettingManager.getByAlias(sysFormAlias);
		BpmFormView fv = bpmFormViewManager.getLatestByKey(scfs.getFormAlias(), ContextUtil.getCurrentTenantId());
		String boDefId = fv.getBoDefId();
		SysBoDef bodef = sysBoDefManager.get(boDefId);
		SysBoEnt boent = sysBoEntManager.getByBoDefId(bodef.getId());
		List<SysBoAttr> attrs = new ArrayList<SysBoAttr>();
		JSONArray ary = JSONArray.parseArray(sysBoList.getColsJson());
		for (Object object : ary) {
			JSONObject obj = (JSONObject) object;
			SysBoAttr attr = new SysBoAttr();
			attr.setComment(obj.getString("header"));
			attr.setFieldName(obj.getString("field"));
			attr.setDataType(obj.getString("dataType"));
			attrs.add(attr);
		}
		
		Map<String, MultipartFile> files = request.getFileMap();
		Iterator<MultipartFile> it = files.values().iterator();
		long l = 0;
		
		while(it.hasNext()){
			MultipartFile f = it.next();
			InputStream is = f.getInputStream();
			Workbook wookbook = null;
			wookbook = WorkbookFactory.create(is);
			List<Map<String,Object>> dataList = ExcelUtil.importExcel(attrs, f);
			l += sysBoListManager.insertData(dataList,boent);			
		}
		return l;
	}
	
	
	/**
	 * PDF模板
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportRowDialog")
	public ModelAndView exportRowDialog(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boKey = RequestUtil.getString(request, "boKey");
		return getExportRowDlgView(boKey,request);
	}
	
	private ModelAndView getExportRowDlgView(String boKey,HttpServletRequest request) throws Exception{
		ModelAndView mv=new ModelAndView("sys/core/exportRowDialog.jsp");
		//String boKey = RequestUtil.getString(request, "boKey");
		Map<String,Object> params = new HashMap<String, Object>();
		SysBoList sysBoList=sysBoListManager. getBoList(boKey);
		if(sysBoList ==null) return mv;
		//获取该表所有字段
		String sysFormAlias = sysBoList.getFormAlias();
		SysCustomFormSetting scfs = sysCustomFormSettingManager.getByAlias(sysFormAlias);
		BpmFormView fv = bpmFormViewManager.getLatestByKey(scfs.getFormAlias(), ContextUtil.getCurrentTenantId());
		String boDefId = fv.getBoDefId();
		List<SysBoEnt> boents = sysBoEntManager.getListByBoDefId(boDefId,true);
		List<SysBoEnt> subEnts = new ArrayList<SysBoEnt>();
		SysBoEnt mainEnt = new SysBoEnt();
		for(SysBoEnt boent:boents){
			if(SysBoRelation.RELATION_MAIN.equals(boent.getRelationType())){
				mainEnt=boent;
			}else{
				subEnts.add(boent);
			}
		}
		params.put("mainEnt", mainEnt);
		params.put("subEnts", subEnts);
		params.put("boKey", boKey);
		String tempHtml=freemarkEngine.mergeTemplateIntoString("list/exportRowTemp.ftl", params);
		

		mv.addObject("dataHtml", tempHtml);
		mv.addObject("boKey", boKey);
		mv.addObject("key", fv.getKey());
		return mv;
	}
    
    /**
     * 根据别名获取手机列表配置。
     * @param alias
     * @return
     */
    @RequestMapping("{alias}/mobile")
    @ResponseBody
    public SysBoList getMobileBoList(@PathVariable(value="alias") String alias){
    
    	SysBoList sysBoList=sysBoListManager.getBoList(alias);
    	SysBoList rtn=new SysBoList();
    	rtn.setIdField(sysBoList.getIdField());
    	rtn.setMobileHtml(sysBoList.getMobileHtml());
    	rtn.setIsDialog(sysBoList.getIsDialog());
    	rtn.setIsShare(sysBoList.getIsShare());
    	rtn.setFormAlias(sysBoList.getFormAlias());
    	rtn.setKey(sysBoList.getKey());
    	
    	//手机端权限按钮
    	String topBtnsJson=sysBoList.getTopBtnsJson();
    	if(StringUtil.isNotEmpty(topBtnsJson)){
    		JSONArray topBtns=JSONArray.parseArray(topBtnsJson);
        	JSONObject allowBtns=new JSONObject();
        	for(int i=0,j=topBtns.size();i<j;i++){
        		JSONObject topBtn=(JSONObject)topBtns.get(i);
        		String btnName=topBtn.getString("btnName");
        		String url=topBtn.getString("url");
        		if(StringUtil.isNotEmpty(url)){
            		String isAllow=isAllowBtn(url);
            		allowBtns.put(btnName, isAllow);

        		}
        	}
        	rtn.setTopBtnsJson(allowBtns.toString());
    	}
    	
    	return rtn;
    }
    
    
	
	
	/**
	 * 导出 导入模板
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("downTemp")
	public void downTemp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boKey = RequestUtil.getString(request, "boKey");
		SysBoList sysBoList=sysBoListManager. getBoList(boKey);
		if(sysBoList ==null) return;
		/*//获取该表所有字段
		String sysFormAlias = sysBoList.getFormAlias();
		SysCustomFormSetting scfs = sysCustomFormSettingManager.getByAlias(sysFormAlias);
		BpmFormView fv = bpmFormViewManager.getLatestByKey(scfs.getFormAlias(), ContextUtil.getCurrentTenantId());
		String boDefId = fv.getBoDefId();
		SysBoDef bodef = sysBoDefManager.get(boDefId);
		SysBoEnt boent = sysBoEntManager.getByBoDefId(bodef.getId());
		List<SysBoAttr> attrs = sysBoEntManager.getAttrsByEntId(boent.getId());*/
		JSONArray attrs = JSONArray.parseArray(sysBoList.getColsJson());
		List<ExportFieldColumn> gridcolumns = new ArrayList<ExportFieldColumn>();
		for(Object obj:attrs){
			JSONObject attr = (JSONObject) obj;
			ExportFieldColumn gridcolumn = new ExportFieldColumn();
			gridcolumn.setHeader(attr.getString("header"));
			gridcolumn.setField(attr.getString("field"));
			gridcolumn.setChildColumn(new ArrayList<ExportFieldColumn>());
			gridcolumns.add(gridcolumn);
			gridcolumn.setColspan(1);
		}
        
        
        String title = sysBoList.getName();
        ExcelUtil.downloadImportTemp(title,gridcolumns,response);
	}
	
	/**
	 * 导出 单行数据
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportRow")
	public void exportRow(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String dataHtml = RequestUtil.getString(request, "html");
		String boKey = RequestUtil.getString(request, "boKey");
		Map<String,Object> params = new HashMap<String, Object>();
		String fileName=FileUtil.getWebRootPath()+File.separator+"exportRow"+File.separator+boKey+".pdf";
		File file = new File(fileName);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		params.put("data", dataHtml);
		String tempHtml=freemarkEngine.mergeTemplateIntoString("list/exportRowTemp2.ftl", params);

    	PdfUtil.convertHtmlToPdf(tempHtml, fileName);//将html转换成pdf
    		
		String downloadFileName = URLEncoder.encode(file.getName(),"UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=" +downloadFileName);
		FileUtil.downLoad(file, response);		
	}
	
	/**
	 * 导出业务列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doExport")
	// @ResponseBody
	public void doExport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String boKeys = request.getParameter("boKeys");
		// 导出选项
		String isDialog = request.getParameter("isDialog");

		String[] boKey = boKeys.split("[,]");
		
		List<SysBoList> list=sysBoListManager.getSysBoListByIds(boKey, isDialog);
		
		response.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "Sys-Bo-List-" + sdf.format(new Date());
		response.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						response.getOutputStream());
		
		for (SysBoList bo : list) {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			// 生成XML
			String xml = xstream.toXML(bo);
			
			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(bo.getName() + ".xml"));
			InputStream is = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			IOUtils.copy(is, zipOutputStream);
			zipOutputStream.closeArchiveEntry();
			
		}
		zipOutputStream.close();
		
	}
	
	/**
	 * 直接导入,不进行结果检查,存在则更新，不存在则添加
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("importDirect")
	@LogEnt(action = "importDirect", module = "对话框", submodule = "对话框设计")
	public ModelAndView importDirect(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile f = request.getFile("zipFile");
		ProcessHandleHelper.clearProcessMessage();
		
		sysBoListManager.doImport(f);
		
		Set<String> msgSet= ProcessHandleHelper.getProcessMessage().getErrorMsges();
		
		return getPathView(request).addObject("msgSet", msgSet);
	}

	@Override
	public BaseManager getBaseManager() {
		return sysBoListManager;
	}
	
	
	
}
