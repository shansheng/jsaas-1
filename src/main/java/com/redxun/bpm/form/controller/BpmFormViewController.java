package com.redxun.bpm.form.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.core.util.*;

import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.BpmAuthDef;
import com.redxun.bpm.core.entity.BpmAuthRights;
import com.redxun.bpm.core.entity.BpmAuthSetting;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmAuthDefManager;
import com.redxun.bpm.core.manager.BpmAuthRightsManager;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmInstTmpManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.form.api.FormHandlerFactory;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.api.IPreviewFormHandler;
import com.redxun.bpm.form.dao.BpmFormViewDao;
import com.redxun.bpm.form.entity.BpmFormCmp;
import com.redxun.bpm.form.entity.BpmFormTemplate;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.BpmTableFormula;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.entity.OpinionDef;
import com.redxun.bpm.form.manager.BpmFormCmpManager;
import com.redxun.bpm.form.manager.BpmFormTemplateManager;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.FormConstants;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.exception.LicenseException;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.dao.SysBoAttrDao;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.bo.manager.SysBoRelationManager;
import com.redxun.sys.bo.manager.parse.BoAttrParseFactory;
import com.redxun.sys.core.entity.SysFormulaMapping;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.customform.entity.SysCustomFormSetting;
import com.redxun.sys.customform.manager.SysCustomFormSettingImportHandlerManager;
import com.redxun.sys.customform.manager.SysCustomFormSettingManager;
import com.redxun.sys.log.LogEnt;
import com.redxun.ui.view.model.GridFieldConfig;

import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;


/**
 * 业务表单视图管理
 * 
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/form/bpmFormView/")
public class BpmFormViewController extends MybatisListController {
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	SysTreeManager sysTreeManager;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	FreemarkEngine freemarkEngine;
	@Resource
	BpmSolFvManager bpmSolFvManager;
	@Resource
	BpmInstTmpManager bpmInstTmpManager;
	@Resource
	BpmFormViewDao bpmFormViewDao;
	@Resource
	SysBoDefManager sysBoDefManager;
	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	BoAttrParseFactory boAttrParseFactory;
	@Resource
	SysBoAttrDao sysBoAttrDao;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	IPreviewFormHandler previewFormHandler;
	@Resource
	FormHandlerFactory formHandlerFactory;
	@Resource
	BpmAuthSettingManager bpmAuthSettingManager;
	@Resource
	BpmAuthDefManager bpmAuthDefManager;
	@Resource
	BpmAuthRightsManager bpmAuthRightsManager;
	@Resource
	BpmFormTemplateManager bpmFormTemplateManager;
	@Autowired
	BpmFormCmpManager bpmFormCmpManager;
	@Resource
	SysCustomFormSettingManager sysCustomFormSettingManager;
	@Resource
    SysCustomFormSettingImportHandlerManager importHandlerManager;
	@Resource
    SysBoAttrManager sysBoAttrManager;
    @Resource
    SysBoRelationManager sysBoRelationManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return bpmFormViewManager;
	}
	
	/**
	 * 进行组合表单
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("formCmp")
	public ModelAndView formCmp(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String viewId=request.getParameter("viewId");
		BpmFormView formView=null;
		if(StringUtils.isNotEmpty(viewId)){
			formView=bpmFormViewManager.get(viewId);
		}else{
			formView=new BpmFormView();
		}
		return getPathView(request).addObject("bpmFormView",formView);
	}
	
	/**
	 * 保存组合表单
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveFormCmp")
	@ResponseBody
	public JsonResult saveFormCmp(HttpServletRequest request,HttpServletResponse response) throws Exception{
		JsonResult result=new JsonResult(true,"成功保存！");
		String cmpData=request.getParameter("cmpData");
		String linkData=request.getParameter("linkData");
		
		BpmFormView bpmFormView=JSONObject.parseObject(cmpData, BpmFormView.class);
		Map<String,BpmFormCmp> cmpMap=new HashMap<String,BpmFormCmp>();
		JSONArray cmpJsonArr=JSONObject.parseArray(linkData);
		if(StringUtils.isEmpty(bpmFormView.getViewId())){
			bpmFormView.setViewId(idGenerator.getSID());
			bpmFormView.setVersion(1);
			bpmFormView.setIsMain(MBoolean.YES.name());
			bpmFormView.setType("CMP");
			bpmFormView.setStatus("DRAFT");
			bpmFormView.setVersion(1);
			bpmFormView.setType(BpmFormView.FORM_TYPE_CMP);
			bpmFormViewManager.create(bpmFormView);
			getDataMap(bpmFormView.getViewId(),cmpJsonArr,cmpMap);
		}else{
			BpmFormView tmpView=(BpmFormView)bpmFormViewManager.get(bpmFormView.getViewId());
			BeanUtil.copyNotNullProperties(tmpView, bpmFormView);
			bpmFormViewManager.update(tmpView);
			getDataMap(tmpView.getViewId(),cmpJsonArr,cmpMap);
		}
		
		return result;
	}
	
	
	public void getDataMap(String viewId,JSONArray dataObjArr,
			Map<String,BpmFormCmp> capMap) throws IllegalAccessException, InvocationTargetException{
		for(int i=0;i<dataObjArr.size();i++){
			JSONObject dataObject=dataObjArr.getJSONObject(i);
			//取得Id是否已经存于映射中
			String id=dataObject.getString("_id");
			//表示映射中已经存在这个值
			if(capMap.get(id)!=null){
				continue;
			}
			String pId=dataObject.getString("_pid");
			//父对象
			BpmFormCmp parentCmp=capMap.get(pId);
			
			BpmFormCmp cmp=dataObject.toJavaObject(BpmFormCmp.class);
			if(cmp.getPkId()==null){
				cmp.setCmpId(idGenerator.getSID());
				cmp.setViewId(viewId);
				if(StringUtils.isEmpty(cmp.getStatus())){
					cmp.setStatus(MBoolean.ENABLED.name());
				}
				if(parentCmp!=null){
					cmp.setPath(parentCmp.getPath()+ cmp.getCmpId()+".");
					cmp.setParentId(parentCmp.getCmpId());
				}else{
					cmp.setPath("0."+ cmp.getCmpId()+".");
					cmp.setParentId("0");
				}
				bpmFormCmpManager.create(cmp);
				capMap.put(id, cmp);
			}else{
				BpmFormCmp tmp=bpmFormCmpManager.get((String)cmp.getPkId());
				if(tmp!=null){
					BeanUtil.copyNotNullProperties(tmp, cmp);
					if(parentCmp!=null){
						cmp.setPath(parentCmp.getPath()+ cmp.getCmpId()+".");
						cmp.setParentId(parentCmp.getCmpId());
					}else{
						cmp.setPath("0."+ cmp.getCmpId()+".");
						cmp.setParentId("0");
					}
					bpmFormCmpManager.update(tmp);
					capMap.put(id, tmp);
				}else{
					cmp.setCmpId(idGenerator.getSID());
					cmp.setViewId(viewId);
					if(StringUtils.isEmpty(cmp.getStatus())){
						cmp.setStatus(MBoolean.ENABLED.name());
					}
					if(parentCmp!=null){
						cmp.setPath(parentCmp.getPath()+ cmp.getCmpId()+".");
						cmp.setParentId(parentCmp.getCmpId());
					}else{
						cmp.setPath("0."+ cmp.getCmpId()+".");
						cmp.setParentId("0");
					}
					bpmFormCmpManager.create(cmp);
					capMap.put(id, cmp);
				}
			}
			//递归其子类类
			JSONArray childrens=dataObject.getJSONArray("children");
			if(childrens==null){
				continue;
			}
			getDataMap(viewId,childrens,capMap);
		}
	}
	

	/**
	 * 流程表单的权限管理页
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("rights")
	public ModelAndView rights(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewId = request.getParameter("viewId");
		String viewKey = request.getParameter("viewKey");
		String solId=request.getParameter("solId");
		String actDefId=request.getParameter("actDefId");
		BpmFormView bpmFormView = null;
		if (StringUtils.isNotEmpty(viewId)) {
			bpmFormView = bpmFormViewManager.get(viewId);
		} else {
			bpmFormView = bpmFormViewManager.getLatestByKey(viewKey, ContextUtil.getCurrentTenantId());
		}
		return this.getPathView(request).addObject("bpmFormView", bpmFormView)
				.addObject("solId",solId).addObject("actDefId",actDefId);
	}
	


	
	


	

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter filter=  QueryFilterBuilder.createQueryFilter(request);
		String treeId=request.getParameter("treeId");
		String tenantId=ContextUtil.getCurrentTenantId();
		
		filter.addFieldParam("TENANT_ID_", tenantId);
		if(StringUtil.isNotEmpty(treeId)){
			filter.addFieldParam("TREE_ID_", treeId);
		}
		filter.addFieldParam("TENANT_ID_", tenantId);
		filter.addFieldParam("IS_MAIN_", MBoolean.YES.toString());
		filter.addSortParam("CREATE_TIME_", "desc");
		return filter;
	}

	/**
	 * 通过模板内容及json数据获得详细的模板内容
	 * 
	 * @return
	 * @throws IOException
	 * @throws UnsupportedEncodingException
	 * @throws JsonProcessingException
	 */
	@RequestMapping("parseFormTemplate")
	@ResponseBody
	public JsonResult parseFormTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templatHtml = request.getParameter("templateHtml");
		String tabsTitle=request.getParameter("tabsTitle");
		String displayType=request.getParameter("displayType");
		String viewId = request.getParameter("viewId");
		String html="";
		try{
			html=previewFormHandler.previewForm(viewId, tabsTitle, displayType, templatHtml);
		}
		catch (InvocationTargetException e) {
        	Throwable ex= e.getTargetException();
			return  new JsonResult(false, ex.getMessage());
		}
		JsonResult jsonResult = new JsonResult(true);
		jsonResult.setData(html);
		return jsonResult;
	}

	

	/**
	 * 返回模板的视图
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getTemplateView")
	@ResponseBody
	public JsonResult getTemplateView(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewId = request.getParameter("viewId");
		BpmFormView bpmFormView = bpmFormViewManager.get(viewId);
		JsonResult result = new JsonResult(true);
		String title=bpmFormView.getTitle();
		if(StringUtil.isEmpty(title)){
			title="";
		}
		result.setMessage(title);
		result.setData(bpmFormView.getTemplateView());
		
		return result;
	}
	
	@RequestMapping("editTemplate")
	public ModelAndView editTemplate(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String pkId=request.getParameter("pkId");
		BpmFormView bpmFormView= bpmFormViewManager.get(pkId);
		ModelAndView mv = getPathView(request).addObject("bpmFormView",bpmFormView);
		return mv;
	}
	
	@RequestMapping("getTemplate")
	@ResponseBody
	public JsonResult getTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewId = request.getParameter("viewId");
		BpmFormView bpmFormView = bpmFormViewManager.get(viewId);
		JsonResult result = new JsonResult(true);
		result.setData(bpmFormView);
		
		return result;
	}

	@RequestMapping("saveTemplate")
	@ResponseBody
	public JsonResult saveTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewId=request.getParameter("viewId");
		String template=request.getParameter("template");
        String templateDecode=StringUtil.decodeBase64(template);
        BpmFormView bpmFormView=bpmFormViewManager.get(viewId);
        bpmFormView.setTemplate(templateDecode);
        bpmFormViewManager.update(bpmFormView);
        return new JsonResult(true,"成功保存");
	}

	/**
	 * 表单视图选择对话框
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("dialog")
	public ModelAndView dialog(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String single = request.getParameter("single");
		String multiSelect = "true".equals(single) ? "false" : "true";
		return getPathView(request).addObject("multiSelect", multiSelect);
	}
	
	/**
	 * 选择在线表单
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("onlineDialog")
	public ModelAndView onlineDialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String single = request.getParameter("single");
		String multiSelect = "true".equals(single) ? "false" : "true";
		return getPathView(request).addObject("multiSelect", multiSelect);
	}
	
	@RequestMapping("onlineSearch")
	@ResponseBody
	public JsonPageResult<BpmFormView> onlineSearch(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter filter=  QueryFilterBuilder.createQueryFilter(request);
		String treeId = request.getParameter("treeId");
		if (StringUtils.isNotEmpty(treeId)) {
			filter.addFieldParam("TREE_ID_", treeId);
		}
		List<BpmFormView> formViews = bpmFormViewManager.getOnlineForms(filter);
		return new JsonPageResult<BpmFormView>(formViews, filter.getPage().getTotalItems());
	}

	/**
	 * 搜索查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("search")
	@ResponseBody
	public JsonPageResult<BpmFormView> getByViewId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		QueryFilter filter=  QueryFilterBuilder.createQueryFilter(request);
		String[] boDefIds=RequestUtil.getStringAryByStr(request, "boDefIds");
		
		String treeId = request.getParameter("treeId");
		if (StringUtils.isNotEmpty(treeId)) {
			filter.addFieldParam("TREE_ID_", treeId);
		}
		if(!BeanUtil.isEmpty(boDefIds)){
			filter.addFieldParam("boDefIds", boDefIds);
		}
		
		List<BpmFormView> formViews = bpmFormViewManager.getByFilter(filter);
		return new JsonPageResult<BpmFormView>(formViews, filter.getPage().getTotalItems());
	}
	
	/**
	 * 搜索查询
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("dlgSearch")
	@ResponseBody
	public JsonPageResult<BpmFormView> dlgSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		QueryFilter filter=  QueryFilterBuilder.createQueryFilter(request);

		String treeId = request.getParameter("treeId");
		if (StringUtils.isNotEmpty(treeId)) {
			filter.addFieldParam("TREE_ID_", treeId);
		}
		
		List<BpmFormView> formViews = bpmFormViewManager.getAll(filter);
		return new JsonPageResult<BpmFormView>(formViews, filter.getPage().getTotalItems());
	}
	
	
	@RequestMapping("listJson")
	@ResponseBody
	public JsonPageResult<BpmFormView> listJson(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QueryFilter queryFilter = getQueryFilter(request);
		List<BpmFormView> formViews = bpmFormViewManager.getAll(queryFilter);
		return new JsonPageResult<BpmFormView>(formViews, queryFilter.getPage().getTotalItems());
	}
	

	@RequestMapping("del")
	@ResponseBody
	@LogEnt(action = "del", module = "流程", submodule = "业务表单视图")
	public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uId = request.getParameter("ids");
		String tenantId=ContextUtil.getCurrentTenantId();
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				BpmFormView bpmFormView =bpmFormViewManager.get(id);
				bpmFormViewManager.deletByKey(bpmFormView.getKey(), tenantId);
			}
		}
		return new JsonResult(true, "成功删除！");
	}
	
	@RequestMapping("delByVersion")
	@ResponseBody
	@LogEnt(action = "delByVersion", module = "流程", submodule = "业务表单视图")
	public JsonResult delByVersion(HttpServletRequest request,HttpServletResponse response){
		String id=RequestUtil.getString(request, "id");
		String tenantId=ContextUtil.getCurrentTenantId();
		String version=RequestUtil.getString(request, "version");
		bpmFormViewManager.delete(id);
		return new JsonResult(true, "成功删除！");
	}

	
	/**
	 * 返回表单视图的生成模板
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getDetailTemplates")
	@ResponseBody
	public ArrayNode getDetailTemplates(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ObjectMapper mapper = (ObjectMapper) iJson;
		ArrayNode arrayNode = mapper.createArrayNode();
		org.springframework.core.io.Resource resource = new ClassPathResource("templates/form/formTemplate.xml");
		Document doc = Dom4jUtil.load(resource.getInputStream());

		List<Node> nodes = doc.getRootElement().selectNodes("/templates/detailTemplate/template");
		for (Node template : nodes) {
			Element el = (Element) template;
			String id = el.attributeValue("id");
			String name = el.attributeValue("name");
			String file = el.attributeValue("file");

			ObjectNode node = mapper.createObjectNode();
			node.put("id", id);
			node.put("name", name);
			node.put("file", file);
			arrayNode.add(node);
		}
		return arrayNode;
	}

	

	/**
	 * 获得模板的内容
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getTemplateHtml")
	@ResponseBody
	public JsonResult getTemplateHtml(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String templateId = request.getParameter("templateId");
		String columns=request.getParameter("columns");
		/** columns的row格式如下：
		 *  name
			key
			displayfield
			editcontrol
			width
			datatype
			format
			cellStyle
		 */
		Map<String, Object> model = new HashMap<String, Object>();
		List<GridFieldConfig> controls=JSONArray.parseArray(columns, GridFieldConfig.class);
		model.put("controls", controls);
		String template = freemarkEngine.mergeTemplateIntoString("form/view/" + templateId + ".ftl", model);
		JsonResult result = new JsonResult(true);
		result.setData(template);
		return result;
	}

	/**
	 * 展示版本
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listForVersions")
	@ResponseBody
	public JsonPageResult<BpmFormView> listForVersions(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Page page = QueryFilterBuilder.createPage(request);
		String key = request.getParameter("key");
		String tenantId=ContextUtil.getCurrentTenantId();
		List<BpmFormView> list = bpmFormViewManager.getAllVersionsByKey(key, tenantId, page);
		return new JsonPageResult<BpmFormView>(list, page.getTotalItems());
	}

	@RequestMapping("setMain")
	@ResponseBody
	@LogEnt(action = "setMain", module = "流程", submodule = "业务表单视图")
	public JsonResult setMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewId = request.getParameter("viewId");
		bpmFormViewManager.doSetMain(viewId);
		return new JsonResult(true, "成功更新！");
	}

	/**
	 * 查看明细
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = request.getParameter("pkId");
		BpmFormView bpmFormView = null;
		if (StringUtils.isNotBlank(pkId)) {
			bpmFormView = bpmFormViewManager.get(pkId);
		} else {
			bpmFormView = new BpmFormView();
		}
		return getPathView(request).addObject("bpmFormView", bpmFormView);
	}
	
	@RequestMapping("getJsonById")
	@ResponseBody
	public BpmFormView getJsonById(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewId = request.getParameter("viewId");
		BpmFormView bpmFormView = bpmFormViewManager.get(viewId);
		return bpmFormView;
	}

	@RequestMapping("getFormViewByIdAgain")
	@ResponseBody
	public BpmFormView getFormViewByIdAgain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewId = request.getParameter("viewId");
		String boDefId=RequestUtil.getString(request, "boDefId");
		String color=RequestUtil.getString(request, "color");
		String templates=RequestUtil.getString(request, "templates");
		boolean genTab=RequestUtil.getBoolean(request, "genTab", false);

		BpmFormView bpmFormView = bpmFormViewManager.get(viewId);

		JSONObject jsonObj=JSONObject.parseObject(templates);

		SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);

		String mainAlias=jsonObj.getJSONObject("main").getString(boEnt.getName());

		StringBuffer sb=new StringBuffer();

		BpmFormTemplate formTemplate= bpmFormTemplateManager.getTemplateByAlias(mainAlias, FormConstants.FORM_PC);
		BpmFormTemplate fieldTemplate= bpmFormTemplateManager.getFieldTemplateByType(FormConstants.FORM_PC);

		List<String> titleList=new ArrayList<>();
		List<String> contentList=new ArrayList<>();

		Map<String,Object> model=new HashMap<String,Object>();

		model.put("ctxPath", request.getContextPath());
		//删除引用字段。
		sysBoEntManager.removeEntRefFields(boEnt);

		model.put("ent", boEnt);
		model.put("color", color);



		TemplateHashModel util=FreemakerUtil.getTemplateModel(StringUtil.class);
		model.put("util", util);

		titleList.add(boEnt.getComment());
		String mainHtml=freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + formTemplate.getTemplate());
		contentList.add(mainHtml);

		JSONArray ary= jsonObj.getJSONArray("sub");
		if(BeanUtil.isEmpty(ary)){
			JsonResult<String> result= new JsonResult<String>(true);
			result.setMessage("");
			result.setData(mainHtml);
			bpmFormView.setTemplateView(mainHtml);
			return bpmFormView;
		}

		List<SysBoEnt> entList=boEnt.getBoEntList();
		for(int i=0;i<ary.size();i++){
			JSONObject json=ary.getJSONObject(i);
			for(SysBoEnt ent:entList){
				String key=ent.getName();
				if(!json.containsKey(key)) continue;

				String template=json.getString(key);
				BpmFormTemplate subTemplate= bpmFormTemplateManager.getTemplateByAlias(template, FormConstants.FORM_PC);
				model.put("ent", ent);

				String html=freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + subTemplate.getTemplate());

				sb.append(html);

				titleList.add(ent.getComment());
				contentList.add(html);
			}
		}
		String tag=genTab?BpmFormView.PAGE_TAG:"";
		String title=genTab? StringUtil.join(titleList, tag):"";
		String content=StringUtil.join(contentList, tag);
		bpmFormView.setTitle(title);
		bpmFormView.setTemplateView(content);

		return bpmFormView;
	}
	
	@RequestMapping("urlGet")
	public ModelAndView urlGet(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = request.getParameter("pkId");
		BpmFormView bpmFormView = bpmFormViewManager.get(pkId);;
		return getPathView(request).addObject("bpmFormView", bpmFormView);
	}

	@RequestMapping("edit")
	@LogEnt(action = "edit", module = "流程", submodule = "业务表单视图")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Boolean isSuperAdmin =ContextUtil.getCurrentUser().isSuperAdmin();
		String pkId = request.getParameter("pkId");
		ModelAndView mv = getPathView(request);
		// 复制添加
		String forCopy = request.getParameter("forCopy");
		BpmFormView bpmFormView = null;
		if (StringUtils.isNotEmpty(pkId)) {
			bpmFormView = bpmFormViewManager.get(pkId);
			if ("true".equals(forCopy)) {
				bpmFormView.setViewId(null);
			}
			
		} else {
			bpmFormView = new BpmFormView();
		}
		return mv.addObject("bpmFormView", bpmFormView).addObject("isSuperAdmin", isSuperAdmin);
	}
	
	/**
	 * 编辑最新的版本
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("editNewestByKey")
	public ModelAndView editNewestByKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String key=request.getParameter("key");
		BpmFormView formView=bpmFormViewManager.getLatestByKey(key, ContextUtil.getCurrentTenantId());
		if(formView==null){
			return new ModelAndView("bpm/form/bpmFormViewNoFormFound.jsp").addObject("formKey",key);
		}
		return new ModelAndView("redirect:/bpm/form/bpmFormView/edit.do?pkId="+formView.getViewId()+"&from=solution");
	}

	

	
	@RequestMapping("getBoEntInfo")
	@ResponseBody
	public com.alibaba.fastjson.JSONObject getBoEntInfo(HttpServletRequest request,HttpServletResponse response){
		String viewId=RequestUtil.getString(request, "viewId");
		String html=RequestUtil.getString(request, "templateView");
		String key=RequestUtil.getString(request, "key");
		String name=RequestUtil.getString(request, "name");
		JSONObject json=new JSONObject();
		
		
		SysBoEnt curEnt=sysBoEntManager.parseHtml(html);
		//解析表单意见。
		List<OpinionDef> opinions=bpmFormViewManager.parseOpinion(html);
		
		curEnt.setTableName(SysBoEntManager.getTableName(key) );
		curEnt.setName(key);
		curEnt.setComment(name);
		//表示数据为新增。
		if(StringUtil.isNotEmpty(viewId)){
			BpmFormView formView= bpmFormViewManager.get(viewId);
			//只是保存了草稿
			String boDefId=formView.getBoDefId();
			if(StringUtil.isNotEmpty( boDefId)){
				SysBoEnt baseEnt= sysBoEntManager.getByBoDefId(boDefId,true);
				sysBoEntManager.merageBoEnt(baseEnt, curEnt);
				curEnt=baseEnt;
				//是否已经生成物理表。
				json.put("hasGenDb", baseEnt.getGenTable());
			}
		}
		List<SysBoEnt> list= sysBoEntManager.getListByBoEnt(curEnt,true);
		json.put("list", list);
		//存放表单意见。
		json.put("opinions", opinions);
		
		return json;
	}
	
	
	
	@RequestMapping("saveFormAndBo")
	@ResponseBody
	@LogEnt(action = "saveFormAndBo", module = "流程", submodule = "业务表单视图")
	public JsonResult saveFormAndBo(HttpServletRequest request,HttpServletResponse response,BpmFormView view) {
		String genTable=RequestUtil.getString(request, "genTable", SysBoDef.BO_YES);
		String deployOrNot=RequestUtil.getString(request, "deployOrNot");
		if("YES".equals(deployOrNot)){
			view.setStatus(BpmFormView.STATUS_DEPLOYED);
		}
		boolean rtn=bpmFormViewManager.isAliasExist(view);
        if(rtn){
        	return new JsonResult(false, "表单key重复!");
        }
		try{
			JsonResult result= bpmFormViewManager.saveFormAndBo(view, genTable);
			return result;
		}
		catch (InvocationTargetException e) {
        	Throwable ex= e.getTargetException();
			return  new JsonResult(false, ex.getMessage());
		}
		catch(Exception ex){
			ex.printStackTrace();
			String msg=ExceptionUtil.getExceptionMessage(ex);
			JsonResult result =new JsonResult(false,msg);
			return result;
		}
	}
	
	@RequestMapping("previewById/{viewId}")
	public ModelAndView previewById(HttpServletRequest request,HttpServletResponse response,@PathVariable(value="viewId")String viewId ) throws Exception {
		return getByViewId(viewId);
	}
	
	private ModelAndView getByViewId(String viewId) throws Exception{
		String html= previewFormHandler.previewFormById(viewId);
		ModelAndView mv = new ModelAndView("bpm/form/bpmFormViewPreviewById.jsp");
		BpmFormView formView=bpmFormViewManager.get(viewId);
		mv.addObject("boDefId", formView.getBoDefId());
		mv.addObject("formKey", formView.getKey());
		mv.addObject("html", html);
		return mv;
	}
	
	@RequestMapping("previewByKey/{key}")
	public ModelAndView previewByKey(HttpServletRequest request,HttpServletResponse response,@PathVariable(value="key")String key ) throws Exception {
		
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmFormView formView= bpmFormViewManager.getLatestByKey(key, tenantId);
		String viewId=formView.getViewId();
		
		return getByViewId(viewId);
	}
	
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
		Boolean isSuperAdmin =ContextUtil.getCurrentUser().isSuperAdmin();
		return this.getPathView(request).addObject("isSuperAdmin", isSuperAdmin);
	}
	
	
	@RequestMapping("copy")
	public ModelAndView copy(HttpServletRequest request,HttpServletResponse response) {
		String viewId=RequestUtil.getString(request, "viewId");
		BpmFormView view =bpmFormViewManager.get(viewId);
		ModelAndView mv = getPathView(request);
		mv.addObject("view", view);
		return mv;
	}
	
	
	
	@RequestMapping("copyNew")
	@ResponseBody
	@LogEnt(action = "copyNew", module = "流程", submodule = "业务表单视图")
	public JsonResult copyNew(HttpServletRequest request,HttpServletResponse response,@RequestBody BpmFormView formView) {
		JsonResult result=new JsonResult(true, "表单保存成功!");
		
		String viewId=formView.getViewId();
		
		formView.setViewId("");
		
		boolean isExist= bpmFormViewManager.isAliasExist(formView);
		
		if(isExist) return new JsonResult(false, "指定别名已存在!");
		
		formView.setViewId(viewId);
		
		bpmFormViewManager.copyNew(formView);
		
		
		return result;
		
		
	}
	
	@RequestMapping("saveEnt")
	public ModelAndView saveEnt(HttpServletRequest request,HttpServletResponse response) {
		com.alibaba.fastjson.JSONObject json= boAttrParseFactory.getPluginDesc();
		ModelAndView mv = getPathView(request);
		mv.addObject("json", json);
		return mv;
	}
	
	
	@RequestMapping("saveUrlForm")
	@ResponseBody
	@LogEnt(action = "saveUrlForm", module = "流程", submodule = "业务表单视图")
	public JsonResult saveUrlForm(HttpServletRequest request,HttpServletResponse response,@RequestBody BpmFormView formView) {
		boolean rtn=bpmFormViewManager.isAliasExist(formView);
        if(rtn) return new JsonResult(false, "表单key重复!");
        
		JsonResult result=new JsonResult(true, "保存表单成功!");
		try{
			bpmFormViewManager.saveFormView(formView);
			return result;
		}
		catch (LicenseException e) {
			return  new JsonResult(false,e.getMessage());
		}
		catch(Exception ex){
			ex.printStackTrace();
			String msg=ExceptionUtil.getExceptionMessage(ex);
			return  new JsonResult(false,msg);
		}
	}
	
	
	@RequestMapping("urlEdit")
	public ModelAndView urlEdit(HttpServletRequest request,HttpServletResponse response) {
		String viewId=RequestUtil.getString(request, "viewId");
		BpmFormView view =bpmFormViewManager.get(viewId);
		ModelAndView mv = getPathView(request);
		mv.addObject("bpmFormView", view);
		return mv;
	}
	
	
	@RequestMapping("deploy")
	@ResponseBody
	@LogEnt(action = "deploy", module = "流程", submodule = "业务表单视图")
	public JsonResult<Void> deploy(HttpServletRequest request,HttpServletResponse response) {
		String viewId=RequestUtil.getString(request, "viewId");
		JsonResult<Void> result=new JsonResult<Void>(true,"发布表单成功!");
		try{
			
			BpmFormView view =bpmFormViewManager.get(viewId);
			if(StringUtil.isEmpty(view.getBoDefId())){
				result.setMessage("还没有生成元数据!");
				result.setSuccess(false);
			}
			else{
				view.setStatus(BpmFormView.STATUS_DEPLOYED);
				bpmFormViewManager.update(view);
			}
		}
		catch(Exception ex){
			result.setSuccess(false);
			result.setMessage(ExceptionUtil.getExceptionMessage(ex));
		}
		return result;
		
		
	}
	
	
	@RequestMapping("grant")
	@ResponseBody
	@LogEnt(action = "grant", module = "流程", submodule = "业务表单视图")
	public ModelAndView grant(HttpServletResponse response,HttpServletRequest request){
		String treeId=RequestUtil.getString(request, "treeId");
		BpmAuthSetting bpmAuthSetting=bpmAuthSettingManager.getSettingByDefTreeId(treeId);
		StringBuffer userName=new StringBuffer("");
		StringBuffer userId=new StringBuffer("");
		StringBuffer groupName=new StringBuffer("");
		StringBuffer groupId=new StringBuffer("");
		String delete="";
		String add="";
		String read="";
		String edit="";
		BpmAuthDef bpmAuthDef=new BpmAuthDef();
		bpmAuthDef.setName("表单分类权限");
		if(bpmAuthSetting!=null){
			bpmAuthDef=bpmAuthDefManager.getUniqueByTreeIdAndSettingId(treeId,bpmAuthSetting.getId());
			if(bpmAuthDef!=null){
				String rightJson=bpmAuthDef.getRightJson();
				JSONObject jsonObject=(JSONObject) JSONObject.parse(rightJson);
				delete=(String) jsonObject.get("delete");
				add=(String) jsonObject.get("add");
				edit=(String) jsonObject.get("edit");
				read=(String) jsonObject.get("read");
			}
			List<BpmAuthRights> bpmAuthRights=bpmAuthRightsManager.getBySettingId(bpmAuthSetting.getId());
			for (BpmAuthRights right : bpmAuthRights) {
				String type=right.getType();
				if("group".equals(type)){
					groupName.append(right.getAuthName());
					groupName.append(",");
					groupId.append(right.getAuthId());
					groupId.append(",");
				}else{
					userName.append(right.getAuthName());
					userName.append(",");
					userId.append(right.getAuthId());
					userId.append(",");
				}
			}
		}else{
			bpmAuthSetting=new BpmAuthSetting();
			bpmAuthSetting.setId(idGenerator.getSID());
			bpmAuthSetting.setTenantId(ContextUtil.getCurrentTenantId());
			bpmAuthSetting.setCreateBy(ContextUtil.getCurrentUserId());
			bpmAuthSetting.setCreateTime(new Date());
			bpmAuthSetting.setType("FORM");
			bpmAuthSetting.setEnable("yes");
			bpmAuthSetting.setName("【表单分类权限】");
			bpmAuthSettingManager.create(bpmAuthSetting);
		}
		return this.getPathView(request).addObject("treeId", treeId).addObject("bpmAuthDef",bpmAuthDef).addObject("bpmAuthSetting", bpmAuthSetting).addObject("groupName", slicingComma(groupName)).addObject("groupId", slicingComma(groupId)).addObject("userName", slicingComma(userName)).addObject("userId", slicingComma(userId)).addObject("read", read).addObject("add", add).addObject("edit", edit).addObject("delete", delete);
	}
	
	@RequestMapping("saveFormViewRight")
	@ResponseBody
	@LogEnt(action = "saveFormViewRight", module = "流程", submodule = "业务表单视图")
	public JSONObject saveFormViewRight(HttpServletRequest request,HttpServletResponse response){
		String settingId=RequestUtil.getString(request, "settingId");
		String treeId=RequestUtil.getString(request, "treeId");
		String userId=RequestUtil.getString(request, "userId");
		String userName=RequestUtil.getString(request, "userName");
		String groupId=RequestUtil.getString(request, "groupId");
		String groupName=RequestUtil.getString(request, "groupName");
		String read=RequestUtil.getString(request, "read");
		String edit=RequestUtil.getString(request, "edit");
		String add=RequestUtil.getString(request, "add");
		String delete=RequestUtil.getString(request, "delete");
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("read", read);
		jsonObject.put("edit", edit);
		jsonObject.put("add", add);
		jsonObject.put("delete", delete);
		BpmAuthDef bpmAuthDef=bpmAuthDefManager.getUniqueByTreeIdAndSettingId(treeId,settingId);
		if(bpmAuthDef!=null){
			bpmAuthDef.setRightJson(jsonObject.toString());
			bpmAuthDefManager.update(bpmAuthDef);
		}else{
			bpmAuthDef=new BpmAuthDef();
			bpmAuthDef.setSettingId(settingId);
			bpmAuthDef.setName("表单分类授权");
			bpmAuthDef.setTreeId(treeId);
			bpmAuthDef.setId(idGenerator.getSID());
			bpmAuthDef.setRightJson(jsonObject.toString());
			bpmAuthDefManager.create(bpmAuthDef);
			
		}
		
		bpmAuthRightsManager.delBySettingId(settingId);//删除之前此处设定的权限

		createAllRightArray("user", userId, userName,settingId);
		createAllRightArray("group", groupId, groupName,settingId);
		
		return new JSONObject();
	}
	
	/**
	 * 
	 * @param type "user/group"
	 * @param idArrayString 以逗号分隔的id字符串
	 * @param nameArrayString 以逗号分隔的name字符串
	 */
	private void createAllRightArray(String type,String idArrayString,String nameArrayString,String settingId){
		String[] idArray=idArrayString.split(",");
		String[] nameArray=nameArrayString.split(",");
		for (int i = 0; i < idArray.length; i++) {
			if(StringUtils.isBlank(idArray[i])){
				continue;
			}
			BpmAuthRights bpmAuthRights=new BpmAuthRights();
			bpmAuthRights.setId(idGenerator.getSID());
			bpmAuthRights.setType(type);
			bpmAuthRights.setAuthId(idArray[i]);
			bpmAuthRights.setAuthName(nameArray[i]);
			bpmAuthRights.setSettingId(settingId);
			bpmAuthRightsManager.create(bpmAuthRights);
		}
	}
	
	/**
	 * 切割末尾逗号返回string
	 * @param sb
	 * @return
	 */
	public String slicingComma(StringBuffer sb){
		if(sb.length()>=1){
			return  sb.substring(0, sb.length()-1);
		}else{
			return sb.toString();
		}
	}
	/**
	 * 从以逗号切割的字符串中得到数组
	 * @param sa
	 * @return
	 */
	public String[] splitWithComma(String sa){
		if(sa.length()==0){
			return null;
		}else{
			String[] strArray=sa.split(",");
			return strArray;
		}
	}
	
	@RequestMapping("saveGrantToOthers")
	@LogEnt(action = "saveGrantToOthers", module = "流程", submodule = "业务表单视图")
	public JSONObject saveGrantToOthers(HttpServletRequest request,HttpServletResponse response){
		JSONObject rtObj=new JSONObject();
		String trees=request.getParameter("trees");
		String formData=request.getParameter("formData");
		JSONObject jsonObject=(JSONObject) JSONObject.parse(formData);
		
		/*权限人员*/
		String userName=jsonObject.getString("userName");
		String userId=jsonObject.getString("userId");
		String groupName=jsonObject.getString("groupName");
		String groupId=jsonObject.getString("groupId");
		
		/*权限json*/
		String read=jsonObject.getString("read");
		String edit=jsonObject.getString("edit");
		String add=jsonObject.getString("add");
		String delete=jsonObject.getString("delete");
		JSONObject rightObj=new JSONObject();
		rightObj.put("read", read);
		rightObj.put("add", add);
		rightObj.put("edit", edit);
		rightObj.put("delete", delete);
		
		/*遍历所选的树,挨个覆盖更新或者生成权限*/
		JSONArray jsonArray=JSONArray.parseArray(trees);
		for(int i=0;i<jsonArray.size();i++){
			 JSONObject object=(JSONObject) jsonArray.get(i);
			String treeId=(String) object.get("treeId");
			BpmAuthSetting bpmAuthSetting=bpmAuthSettingManager.getSettingByDefTreeId(treeId);
			if(bpmAuthSetting==null){
				bpmAuthSetting=new BpmAuthSetting();
				bpmAuthSetting.setId(idGenerator.getSID());
				bpmAuthSetting.setCreateBy(ContextUtil.getCurrentUserId());
				bpmAuthSetting.setCreateTime(new Date());
				bpmAuthSetting.setType("FORM");
				bpmAuthSetting.setEnable("yes");
				bpmAuthSetting.setName("【表单分类权限】");
				bpmAuthSetting.setTenantId(ContextUtil.getCurrentTenantId());
				bpmAuthSettingManager.create(bpmAuthSetting);
			}else{
				bpmAuthSetting.setUpdateBy(ContextUtil.getCurrentUserId());
				bpmAuthSetting.setUpdateTime(new Date());
				bpmAuthSettingManager.update(bpmAuthSetting);
			}
			BpmAuthDef bpmAuthDef=bpmAuthDefManager.getUniqueByTreeIdAndSettingId(treeId, bpmAuthSetting.getId());
			if(bpmAuthDef==null){
				bpmAuthDef=new BpmAuthDef();
				bpmAuthDef.setId(idGenerator.getSID());
				bpmAuthDef.setTreeId(treeId);
				bpmAuthDef.setSettingId(bpmAuthSetting.getId());
				bpmAuthDef.setRightJson(rightObj.toString());
				bpmAuthDefManager.create(bpmAuthDef);
			}else{
				bpmAuthDef.setRightJson(rightObj.toString());
				bpmAuthDefManager.update(bpmAuthDef);
			}
			String settingId=bpmAuthSetting.getId();
			bpmAuthRightsManager.delBySettingId(settingId);//删除之前此处设定的权限

			createAllRightArray("user", userId, userName,settingId);
			createAllRightArray("group", groupId, groupName,settingId);
			
		}
		rtObj.put("success", true);
		return rtObj;
	}
	
	@RequestMapping("listAll")
	@ResponseBody
	public JsonPageResult<BpmFormView> listAll(HttpServletRequest request,HttpServletResponse response){
		Map<String, Set<String>> proFileMap = ProfileUtil.getCurrentProfile();

		List<SysTree> treeList = sysTreeManager.getByCatKeyTenantId("CAT_FORM_VIEW", ContextUtil.getCurrentTenantId());
		
		for (int i = 0; i < treeList.size(); i++) {
			SysTree sysTree = treeList.get(i);
			BpmAuthSetting bpmAuthSetting = bpmAuthSettingManager.getSettingByDefTreeId(sysTree.getTreeId());
			Boolean leftOrNot = false;
			if (bpmAuthSetting != null&&"YES".equals(ContextUtil.getCurrentUser().isSuperAdmin())) {
				String settingId = bpmAuthSetting.getId();
				BpmAuthDef bpmAuthDef = bpmAuthDefManager.getUniqueByTreeIdAndSettingId(sysTree.getTreeId(), settingId);
				sysTree.setRight(bpmAuthDef.getRightJson());// 这里不需要判断bpmAuthDef非空,因为前面判断了setting非空,本质上setting不为空,def就不为空,因为是同步save的
				List<BpmAuthRights> bpmAuthRights = bpmAuthRightsManager.getBySettingId(settingId);
				AuthRightLoop: for (BpmAuthRights bpmAuthRights2 : bpmAuthRights) {
					String authType = bpmAuthRights2.getType();
					String authId = bpmAuthRights2.getAuthId();
					if (proFileMap.get(authType).contains(authId)||ContextUtil.getCurrentUser().isSuperAdmin()) {
						leftOrNot = true;
						break AuthRightLoop;// 一旦存在则说明至少有身份在内,则不过滤,跳出此处循环
					}
				}
				if (!leftOrNot) {
					treeList.remove(i);
					i--;
				}
			}
		}
		List<String> list=new ArrayList<String>();
		for (int i = 0; i < treeList.size(); i++) {
			list.add(treeList.get(i).getTreeId());
		}
		if(list.size()>=1){
			QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
			queryFilter.addParam("list", list);
			queryFilter.addFieldParam("IS_MAIN_", "YES");
			List<BpmFormView> bpmFormViews=bpmFormViewManager.getByTreeFilter(queryFilter);
			JsonPageResult<BpmFormView> jsonPageResult=new JsonPageResult<BpmFormView>(bpmFormViews, queryFilter.getPage().getTotalItems());
			return jsonPageResult;
		}else{
			JsonPageResult<BpmFormView> jsonPageResult=new JsonPageResult<BpmFormView>();
			return jsonPageResult;
		}
	}
	
	/**
	 * 显示表单。
	 * @param alias
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/form/{alias}")
	public ModelAndView getFormByAlias(HttpServletRequest request,  @PathVariable(value="alias") String alias ) throws Exception{
		ModelAndView mv=new ModelAndView();
		Map<String,Object> params=RequestUtil.getParameterValueMap(request, false);
		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		FormModel formModel= formHandler.getFormByFormAlias(alias, "",false,params);
		mv.addObject("formModel", formModel);
		mv.setViewName("bpm/form/bpmFormViewForm.jsp");
		return mv;
	}
	
	/**
	 * 清除bo定义。
	 * @param formViewId
	 * @return
	 */
	@RequestMapping("/clearBoDef")
	@ResponseBody
	@LogEnt(action = "clearBoDef", module = "流程", submodule = "业务表单视图")
	public JsonResult<Void> clearBoDef(@RequestParam(value="formViewId") String formViewId){
		JsonResult<Void> result=new JsonResult<Void>(true,"清除BO定义成功!");
		BpmFormView formView=bpmFormViewManager.get(formViewId);
		String boDefId=formView.getBoDefId();
		if(StringUtil.isEmpty(boDefId)) return new JsonResult<Void>(false, "没有生成BO定义"); 
		
		try{
			bpmFormViewManager.cleanBoDef(boDefId);
		}
		catch(Exception ex){
			ex.printStackTrace();
			String str=ExceptionUtil.getExceptionMessage(ex);
			result=new JsonResult<Void>(false,str);
		}
		return result;
	}
	
	/**
	 * 保存
	 * @param request
	 * @param response
	 */
	@RequestMapping("savePDFTemp")
	@ResponseBody
	public JsonResult savePDFTemp(HttpServletRequest request,HttpServletResponse response){
		String pdfTemp =RequestUtil.getString(request, "pdfTemp");
		String viewId = RequestUtil.getString(request, "viewId");
		BpmFormView form = bpmFormViewManager.get(viewId);
		form.setPdfTemp(pdfTemp);
		bpmFormViewManager.update(form);
		return new JsonResult(true, "成功保存！");
	}
	
	 
		
		/**
		 * PDF模板
		 * @param request
		 * @param response
		 * @throws Exception
		 */
		@RequestMapping("pdfTempEdit")
		public ModelAndView pdfTempEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {

	        
			String viewId = RequestUtil.getString(request, "viewId");
	        String boDefId=RequestUtil.getString(request, "boDefId") ;
	        String templates=RequestUtil.getString(request, "templates") ;
	        ModelAndView mv= getPathView(request);

	        String html= genTemplate(boDefId,templates);
	        
	        mv.addObject("dataHtml", html);
			mv.addObject("viewId", viewId);

	        
	        return mv;
		}
		
		private String genTemplate(String boDefId,String templates) throws TemplateException, IOException{
			
			SysBoDef boDef=sysBoDefManager.get(boDefId);
			SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
			
	        
	        JSONObject jsonObj=JSONObject.parseObject(templates);
	        
	        //获取主模版
	        String mainAlias=jsonObj.getJSONObject("main").getString(boEnt.getName());
	        
	        StringBuffer sb=new StringBuffer();
	        BpmFormTemplate fieldTemplate= bpmFormTemplateManager.getTemplateByAlias("field", FormConstants.FORM_PRINT);
	        BpmFormTemplate formTemplate= bpmFormTemplateManager.getTemplateByAlias(mainAlias, FormConstants.FORM_PRINT);
	        //BpmFormTemplate fieldTemplate= bpmFormTemplateManager.getFieldTemplateByType(FormConstants.FORM_PC);
	        
	        Map<String,Object> model=new HashMap<String,Object>();
	        
	        model.put("ent", boEnt);
	        
	        sb.append(freemarkEngine.parseByStringTemplate( model,fieldTemplate.getTemplate() + formTemplate.getTemplate()));
	        
	        //子表处理
	        JSONArray ary= jsonObj.getJSONArray("sub");

	        List<SysBoEnt> entList=boEnt.getBoEntList();
	        if(BeanUtil.isNotEmpty(entList)){
	        	for(SysBoEnt subEnt:entList){
	        		String name=subEnt.getName();
	        		String template=getTemplate(name,ary);
	        		BpmFormTemplate subTemplate= bpmFormTemplateManager.getTemplateByAlias(template, FormConstants.FORM_PRINT);
	        		
	        		model.put("ent", subEnt);
	                
	                sb.append(freemarkEngine.parseByStringTemplate(model,fieldTemplate.getTemplate() + subTemplate.getTemplate()));
	        	}
	        }
	        
	        String opinionDef=boDef.getOpinionDef();
	        if(jsonObj.containsKey("_opinion_") && StringUtil.isNotEmpty(opinionDef)){
	        	String opinionTemplateName=jsonObj.getString("_opinion_");
	        	BpmFormTemplate opinionTemplate= bpmFormTemplateManager.getTemplateByAlias(opinionTemplateName, FormConstants.FORM_PRINT);
	        	
	        	JSONArray opinionAry=JSONArray.parseArray(opinionDef);
	        	model=new HashMap<String,Object>();
	        	model.put("opinions", opinionAry);
	        	
	        	sb.append(freemarkEngine.parseByStringTemplate( model,opinionTemplate.getTemplate() ));
	        }
	        
	        
	        
	        return sb.toString();
		}
		
		private String getTemplate(String name,JSONArray ary){
			for(Object obj:ary){
	        	JSONObject subObj=(JSONObject)obj;
	        	if(subObj.containsKey(name)){
	        		return subObj.getString(name);
	        	}
	        }
			return "";
		}
	
		
		/**
		 * PDF模板
		 * @param request
		 * @param response
		 * @throws Exception
		 */
		@RequestMapping("genPdfTemplate")
		public ModelAndView genPdfTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
			ModelAndView mv=getPathView(request);
			String viewId = RequestUtil.getString(request, "viewId");
			String reload = RequestUtil.getString(request, "reload");
			BpmFormView fv = bpmFormViewManager.get(viewId);
			if(StringUtils.isEmpty(reload)&&StringUtils.isNotEmpty(fv.getPdfTemp())){
				return new ModelAndView("bpm/form/bpmFormViewPdfTempEdit.jsp")
						.addObject("dataHtml", fv.getPdfTemp()).addObject("viewId", viewId);
			}
			
			String boDefId = fv.getBoDefId();
			
			SysBoDef sysBoDef=sysBoDefManager.get(boDefId);
			
	        SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
	        
	        List<BpmFormTemplate> mainForms=bpmFormTemplateManager
	        		.getTemplateByType(SysBoRelation.RELATION_MAIN, FormConstants.FORM_PRINT);
	        
	        List<BpmFormTemplate> oneToOneForms=bpmFormTemplateManager
	        		.getTemplateByType(SysBoRelation.RELATION_ONETOONE, FormConstants.FORM_PRINT);
	        
	        List<BpmFormTemplate> oneToManyForms=bpmFormTemplateManager
	        		.getTemplateByType(SysBoRelation.RELATION_ONETOMANY, FormConstants.FORM_PRINT);
	        
	        List<BpmFormTemplate> opinionForms=bpmFormTemplateManager
	        		.getTemplateByType(FormConstants.FORM_TEMPLATE_OPINION, FormConstants.FORM_PRINT);
	        
	        JSONArray mainAry= getJsonByTemplates(mainForms);
	        
	        
	        JSONArray rtnJson=new JSONArray();
	        
	        JSONObject mainJson=new JSONObject();
	        mainJson.put("type", SysBoRelation.RELATION_MAIN);
	        mainJson.put("key", boEnt.getName());
	        mainJson.put("name", boEnt.getComment());
	        mainJson.put("template", mainAry);
	        
	        rtnJson.add(mainJson);
	        
	        if(BeanUtil.isNotEmpty( boEnt.getBoEntList())){
	        	for(SysBoEnt subEnt: boEnt.getBoEntList()){
	        		JSONObject subJson=new JSONObject();
	            	JSONArray subAry=null;
	        		if(subEnt.getRelationType().equals(SysBoRelation.RELATION_ONETOONE)){
	        			subAry= getJsonByTemplates(oneToOneForms);
		            	subJson.put("type", SysBoRelation.RELATION_ONETOONE);
	        		}
	        		else{
	        			subAry= getJsonByTemplates(oneToManyForms);
		            	subJson.put("type", SysBoRelation.RELATION_ONETOMANY);
	        		}
	        		subJson.put("key", subEnt.getName());
	            	subJson.put("name", subEnt.getComment());
	        		subJson.put("template", subAry);
	        		rtnJson.add(subJson);
	            }
	        }
	        String opinionDef=sysBoDef.getOpinionDef();
	        if(StringUtil.isNotEmpty(opinionDef)){
	        	JSONArray opinionAry=JSONArray.parseArray(opinionDef);
	        	if(opinionAry.size()>0){
	        		JSONArray opinionTmpAry= getJsonByTemplates(opinionForms);
	            	JSONObject opinionJson=new JSONObject();
	            	opinionJson.put("type", FormConstants.FORM_TEMPLATE_OPINION);
	            	opinionJson.put("key","opinion");
	            	opinionJson.put("name", "意见");
	            	opinionJson.put("template", opinionTmpAry);
	            	rtnJson.add(opinionJson);
	        	}
        		
	        }
	        
	        return mv.addObject("data", rtnJson).addObject("boDefId", boDefId).addObject("viewId", viewId);
		}
		
		/**
	     * 根据模版获取
	     * @param forms
	     * @return
	     */
	    private JSONArray getJsonByTemplates(List<BpmFormTemplate> forms){
	    	JSONArray ary=new JSONArray();
	    	for(BpmFormTemplate template:forms){
	    		JSONObject obj=new JSONObject();
	    		obj.put("alias", template.getAlias());
	    		obj.put("name", template.getName());
	    		ary.add(obj);
	    	}
	    	return ary;
	    }
	    
	    
	    /**
		 * 跳至表单打印页
		 * @param request
		 * @param response
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("getPrintForm")
		@ResponseBody
		public List<FormModel> getPrintForm(HttpServletRequest request,HttpServletResponse response) throws Exception{
			String instId=request.getParameter("instId");
			String solId=request.getParameter("solId");
			String taskId=request.getParameter("taskId");
			String formAlias=request.getParameter("formAlias");
			
			String json=request.getParameter("json");
			IFormHandler formHandler= formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PRINT);
			
			List<FormModel> list=null;
			//开始
			if(StringUtil.isNotEmpty(solId)){
				list= formHandler.getStartForm(solId, instId,json);
			}else if(StringUtil.isNotEmpty(taskId)){
				list= formHandler.getByTaskId(taskId, json);
			}else if(StringUtil.isNotEmpty(instId)){
				list= formHandler.getByInstId(instId);
			}
			else if(StringUtil.isNotEmpty(formAlias)){
				list=new ArrayList<FormModel>();
				JSONObject jsonData=JSONObject.parseObject(json);
				jsonData = jsonData.getJSONArray("bos").getJSONObject(0).getJSONObject("data");
				FormModel formModel= formHandler.getFormByFormAlias(formAlias, jsonData, true, new HashMap<String,Object>());
				list.add(formModel);
			}
			return list;
		}
		
		
		/**
		 * 用于显示PDF表单。
		 * @param request
		 * @param response
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("getPdfForm")
		@ResponseBody
		public String getPdfForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String instId=request.getParameter("instId");
			String solId=request.getParameter("solId");
			String taskId=request.getParameter("taskId");
			String json=request.getParameter("json");
			String formAlias=request.getParameter("formAlias");
			
			String html="";
			//启动流程表单
			if(StringUtil.isNotEmpty(solId)){
				JSONObject jsonObject=JSONObject.parseObject(json);
				html=bpmFormViewManager.getPdfHtmlBySolId(solId, jsonObject, true);
			}
			else if(StringUtil.isNotEmpty(taskId)){
				JSONObject jsonObject=JSONObject.parseObject(json);
				html=bpmFormViewManager.getPdfHtmlByTask(taskId, jsonObject, true);
			}
			else if(StringUtil.isNotEmpty(instId)){
				html=bpmFormViewManager.getPdfHtmlByInstId(instId,  true);
			}
			else if(StringUtil.isNotEmpty(formAlias)){
				html=bpmFormViewManager.getPdfHtmlByAlias(formAlias,json,  true);
			}
			return html;
		}
		
		/**
		 * 下载表单PDF。
		 * @param request
		 * @param response
		 * @throws Exception
		 */
		@RequestMapping("downloadPdf")
		public void downloadPdf(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String instId=request.getParameter("instId");
			String solId=request.getParameter("solId");
			String taskId=request.getParameter("taskId");
			String json=request.getParameter("json");
			String formAlias=request.getParameter("formAlias");
			String html="";
			//启动流程表单
			if(StringUtil.isNotEmpty(solId)){
				JSONObject jsonObject=JSONObject.parseObject(json);
				html=bpmFormViewManager.getPdfHtmlBySolId(solId, jsonObject, false);
			}
			else if(StringUtil.isNotEmpty(taskId)){
				JSONObject jsonObject=JSONObject.parseObject(json);
				html=bpmFormViewManager.getPdfHtmlByTask(taskId, jsonObject, false);
			}
			else if(StringUtil.isNotEmpty(instId)){
				html=bpmFormViewManager.getPdfHtmlByInstId(instId,  false);
			}
			else if(StringUtil.isNotEmpty(formAlias)){
				html=bpmFormViewManager.getPdfHtmlByAlias(formAlias, json, false);
			}
			String downloadFileName = "printPdf_"+DateUtil.formatDate(new Date(), "yyyy-MM-dd") +".doc";
			response.setHeader("Content-Disposition", "attachment;filename=" +downloadFileName);
			html=html.replace("&nbsp;", "");
			html=html.replace("<br>", "\n");

			InputStream is = new ByteArrayInputStream(html.getBytes());

			FileUtil.downLoad(is,response);
			
		}
		
		/**
		 * 打印表单。
		 * 程序逻辑
		 * 1.查找是否有pdf表单，找到的话，显示表单，并可以下载PDF。
		 * 2.如果没有则直接显示配置的表单。
		 * @param request
		 * @param response
		 * @return
		 * @throws Exception
		 */
	    @RequestMapping("print")
		public ModelAndView print(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	ModelAndView mv=getPathView(request);
	    	
	    	String instId=request.getParameter("instId");
			String solId=request.getParameter("solId");
			String taskId=request.getParameter("taskId");
			String formAlias=request.getParameter("formAlias");
			
			String tenantId=ContextUtil.getCurrentTenantId();
			
			List<BpmFormView> bpmFormViews=null;
			//开始
			if(StringUtil.isNotEmpty(solId)){
				BpmSolution bpmSolution=bpmSolutionManager.get(solId);
				bpmFormViews = bpmFormViewManager.getStartFormView(solId,bpmSolution.getActDefId());
			}else if(StringUtil.isNotEmpty(taskId)){
				BpmTask bpmTask = bpmTaskManager.get(taskId);
				BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
				bpmFormViews = bpmFormViewManager.getTaskFormViews(bpmInst.getSolId(), bpmInst.getActDefId(),bpmTask.getTaskDefKey(),bpmInst.getInstId());
				mv.addObject("bpmInst",bpmInst);
			}else if(StringUtil.isNotEmpty(instId)){
				BpmInst bpmInst = bpmInstManager.get(instId);
				bpmFormViews = bpmFormViewManager.getDetailFormView(bpmInst.getSolId(), bpmInst.getActDefId(),instId);
				mv.addObject("bpmInst",bpmInst);
			}
			else if(StringUtil.isNotEmpty(formAlias)) {
				bpmFormViews=new ArrayList<BpmFormView>();
				BpmFormView formView= bpmFormViewManager.getLatestByKey(formAlias, tenantId);
				bpmFormViews.add(formView);
			}
			boolean supportPdf=false;
			if(BeanUtil.isNotEmpty(bpmFormViews)){
				supportPdf=bpmFormViewManager.supportFdf(bpmFormViews);
			}
			if(supportPdf){
				mv.setViewName("bpm/form/bpmFormViewPrintPdf.jsp");
			}
	    	
	    	return mv;
	   }
	    
	    @RequestMapping("design")
		public ModelAndView design(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	String viewId=RequestUtil.getString(request, "viewId");
	    	String boDefId=RequestUtil.getString(request, "boDefId");
	    	String color=RequestUtil.getString(request, "color","transparent");
	    	String templates=RequestUtil.getString(request, "templates");
	    	ModelAndView mv = getPathView(request);
	    	
	    	mv.addObject("viewId", viewId);
	    	//表单定义ID
	    	if(StringUtil.isNotEmpty(viewId)){
	    		BpmFormView formView=bpmFormViewManager.get(viewId);
	    		mv.addObject("boDefId", formView.getBoDefId());
	    	}
	    	else{
	    		mv.addObject("boDefId", boDefId);
	    	}
	    	SysBoDef sysBoDef = sysBoDefManager.get(boDefId);
	    	if(sysBoDef !=null){
				mv.addObject("boDefName", sysBoDef.getName());
				mv.addObject("alais", sysBoDef.getAlais());
				mv.addObject("choiceSysTreeId", sysBoDef.getTreeId());
			}

	    	mv.addObject("templates", templates);
	    	mv.addObject("color", color);
	    	return mv;
	    }
	    
	    @RequestMapping("generateHtml")
	    @ResponseBody
		public JsonResult<String> generateHtml(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	String boDefId=RequestUtil.getString(request, "boDefId");
	    	String color=RequestUtil.getString(request, "color");
	    	String templates=RequestUtil.getString(request, "templates");
	    	boolean genTab=RequestUtil.getBoolean(request, "genTab", false);
	    	
	    	JSONObject jsonObj=JSONObject.parseObject(templates);
	        
	        SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
	        
	        String mainAlias=jsonObj.getJSONObject("main").getString(boEnt.getName());
	        
	        StringBuffer sb=new StringBuffer();
	        
	        BpmFormTemplate formTemplate= bpmFormTemplateManager.getTemplateByAlias(mainAlias, FormConstants.FORM_PC);
	        BpmFormTemplate fieldTemplate= bpmFormTemplateManager.getFieldTemplateByType(FormConstants.FORM_PC);
	        
	        List<String> titleList=new ArrayList<>();
	        List<String> contentList=new ArrayList<>();
	        
	        Map<String,Object> model=new HashMap<String,Object>();
	        
	        model.put("ctxPath", request.getContextPath());
	        //删除引用字段。
	        sysBoEntManager.removeEntRefFields(boEnt);
	        
	        model.put("ent", boEnt);
	        model.put("color", color);
	        
	        
	        
	        TemplateHashModel util=FreemakerUtil.getTemplateModel(StringUtil.class);
	        model.put("util", util);
	        
	        titleList.add(boEnt.getComment());
	        String mainHtml=freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + formTemplate.getTemplate());
	        contentList.add(mainHtml);
	        
	        JSONArray ary= jsonObj.getJSONArray("sub");
	        if(BeanUtil.isEmpty(ary)){
	        	JsonResult<String> result= new JsonResult<String>(true);
	        	result.setMessage("");
	        	result.setData(mainHtml);
	        	return result;
	        }
	        
	        List<SysBoEnt> entList=boEnt.getBoEntList();
	    	for(int i=0;i<ary.size();i++){
	    		JSONObject json=ary.getJSONObject(i);
	    		for(SysBoEnt ent:entList){
	    			String key=ent.getName();
	    			if(!json.containsKey(key)) continue;
	    			
					String template=json.getString(key);
					BpmFormTemplate subTemplate= bpmFormTemplateManager.getTemplateByAlias(template, FormConstants.FORM_PC);
	        		model.put("ent", ent);
	        		
	        		String html=freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + subTemplate.getTemplate());
	                
	                sb.append(html);
	                
	                titleList.add(ent.getComment());
	    	        contentList.add(html);
	    		}
	    	}
	    	String tag=genTab?BpmFormView.PAGE_TAG:"";
	    	String title=genTab? StringUtil.join(titleList, tag):"";
	    	String content=StringUtil.join(contentList, tag);
	    	JsonResult<String> result= new JsonResult<String>(true);
	    	result.setMessage(title);
	    	result.setData(content);
	    	return result;
	    }
	    
	    
	    
	    
	    @RequestMapping("generateByBoEnt")
	    @ResponseBody
		public String generateByBoEnt(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	String entId=RequestUtil.getString(request, "entId");
	    	String template=RequestUtil.getString(request, "template");
	    	
	        SysBoEnt boEnt=sysBoEntManager.getByEntId(entId);
	        
	        	        
	        StringBuffer sb=new StringBuffer();
	        
	        BpmFormTemplate formTemplate= bpmFormTemplateManager.getTemplateByAlias(template, FormConstants.FORM_PC);
	        BpmFormTemplate fieldTemplate= bpmFormTemplateManager.getFieldTemplateByType(FormConstants.FORM_PC);
	        
	        Map<String,Object> model=new HashMap<String,Object>();
	        
	        model.put("ctxPath", request.getContextPath());
	        model.put("ent", boEnt);
	        
	        TemplateHashModel util=FreemakerUtil.getTemplateModel(StringUtil.class);
	        model.put("util", util);
	        
	        sb.append(freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + formTemplate.getTemplate()));
	       
	    	return sb.toString();
	    }
	    
	    @RequestMapping("generateByAttr")
	    @ResponseBody
		public String generateByAttr(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    	String attrId=RequestUtil.getString(request, "attrId");
	    	String relType=RequestUtil.getString(request, "relType");
	    	
	        SysBoAttr boAttr= sysBoAttrDao.get(attrId);
	        boolean inTable="onetomany".equals(relType);
	        
	        	        
	        StringBuffer sb=new StringBuffer();
	        
	        String template="<@fieldCtrl field=field inTable=inTable />";
	        BpmFormTemplate fieldTemplate= bpmFormTemplateManager.getFieldTemplateByType(FormConstants.FORM_PC);
	        
	        Map<String,Object> model=new HashMap<String,Object>();
	        
	        model.put("ctxPath", request.getContextPath());
	        model.put("inTable", inTable);
	        model.put("field", boAttr);
	        
	        TemplateHashModel util=FreemakerUtil.getTemplateModel(StringUtil.class);
	        model.put("util", util);
	        
	        sb.append(freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + template));
	       
	    	return sb.toString();
	    }
		
	    /**
	     * 保存设计表单。
	     * @param formView
	     * @return
	     */
	    @RequestMapping("saveDesignForm")
	    @ResponseBody
	    public JsonResult saveDesignForm(@RequestBody BpmFormView formView,String isCreate){
	    	boolean rtn=bpmFormViewManager.isAliasExist(formView);
	        if(rtn) return new JsonResult(false, "表单key重复!");
	    	JsonResult result=new JsonResult(true,"保存设计表单成功!");
	    	try {
	    		bpmFormViewManager.saveFormView(formView);
	    		sysCustomFormSettingManager.saveDefault(formView);
			} catch (Exception e) {
				result=new JsonResult(false,e.getMessage());
			}
	    	return result;
	    }
	    
	    @RequestMapping("export")
	    public void export(HttpServletRequest req, HttpServletResponse res) throws Exception {
	    	String ids = req.getParameter("ids");
	    	String[] idArr = ids.split(",");
	    	
	    	JSONArray jArray = new JSONArray();
	    	
	    	for(String id : idArr) {
	    		//init
	    		JSONObject json = new JSONObject();
	        	JSONArray sysBoDefArr = new JSONArray(); //sysBoDef的json结果集
	        	JSONArray sysBoRelationArr = new JSONArray(); //sysBoRelation的json结果集
	        	JSONArray sysBoEntArr = new JSONArray(); //sysBoEnt的json结果集
	        	JSONArray sysBoAttrArr = new JSONArray(); //sysBoAttr的json结果集
	        	JSONArray bpmFormViewArr = new JSONArray(); //业务表单视图bpmFormView的json结果集
	        	
	    		//首先根据每一个id获取到其相关的数据 (权限，表单方案，表单，BO, 创建数据库表 ...etc) 
	        	BpmFormView bpmFormView = bpmFormViewManager.get(id);
	        	bpmFormViewArr.add(JSONObject.toJSON(bpmFormView));
	        	
	    		
	    		//获取业务模型(业务对象)
	    		String definitionId = bpmFormView.getBoDefId(); //业务模型id
	    		SysBoDef sysBoDef = sysBoDefManager.get(definitionId);
	    		sysBoDefArr.add(JSONObject.toJSON(sysBoDef));
	    		if(sysBoDef != null) {
	        		//获取业务模型关联的表单对象(主表和子表)
	        		List<SysBoRelation> sysBoRelationList = sysBoRelationManager.getByDefId(sysBoDef.getId());
	        		for(SysBoRelation boRel : sysBoRelationList) {
	        			sysBoRelationArr.add(JSONObject.toJSON(boRel));
	        			
	        			SysBoEnt sysBoEnt = sysBoEntManager.get(boRel.getBoEntid());
	        			sysBoEntArr.add(JSONObject.toJSON(sysBoEnt));
	        			
	        			List<SysBoAttr> sysBoAttrList = sysBoAttrManager.getAttrsByEntId(sysBoEnt.getId());
	        			for(SysBoAttr sysBoAttr : sysBoAttrList) {
	        				sysBoAttrArr.add(JSONObject.toJSON(sysBoAttr));
	        			}
	        		}
	        		
	        		//获取业务表单视图
	        		List<BpmFormView> bpmFormViewList = bpmFormViewManager.getByBoId(sysBoDef.getId());
	        		bpmFormViewArr.addAll(bpmFormViewList);
	    		}
	    		
	        	json.put("SYS_BO_DEFINITION", sysBoDefArr);
	        	json.put("SYS_BO_RELATION", sysBoRelationArr);
	        	json.put("SYS_BO_ENTITY", sysBoEntArr);
	        	json.put("SYS_BO_ATTR", sysBoAttrArr);
	        	json.put("BPM_FORM_VIEW", bpmFormViewArr);
	    		
	        	jArray.add(json);
	    	}
	    	
	    	res.setContentType("application/zip");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String downFileName = "Form-View-" + sdf.format(new Date());
			res.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
			
			ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
					.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
							res.getOutputStream());
			String jsonStr = jArray.toString();
			zipOutputStream.putArchiveEntry(new ZipArchiveEntry("Form-View.json"));
			InputStream is = new ByteArrayInputStream(jsonStr.getBytes("UTF-8"));
			IOUtils.copy(is, zipOutputStream);
			zipOutputStream.closeArchiveEntry();
			zipOutputStream.close(); //关闭流
	    }
	    
	    @RequestMapping("importFormsJsonZip")
	    public ModelAndView importFormsJsonZip(MultipartHttpServletRequest request, HttpServletRequest req, HttpServletResponse res) throws Exception{
	    	MultipartFile file = request.getFile("zipFile");
	    	
	    	InputStream is = file.getInputStream();
	    	ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
	    	String jsonStr = null;
	    	while ((zipIs.getNextZipEntry()) != null) {// 读取Zip中的每个文件
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				IOUtils.copy(zipIs, baos);
				jsonStr = baos.toString("UTF-8");
			}
			zipIs.close();
			
			ProcessHandleHelper.initProcessMessage();
			String exitMsg = ",导入完成!";
			Set<String> rtnMsg = new HashSet<String>();
			LinkedHashSet<String> differMsg = new LinkedHashSet<String>();
			
			if(StringUtil.isNotEmpty(jsonStr)) {
				JSONArray jArray = new JSONArray();
				jArray = JSONArray.parseArray(jsonStr);
				if(jArray.size() > 0) {
					for(int i = 0; i < jArray.size(); i++) {
						JSONObject json = jArray.getJSONObject(i);
						String jsonArrStr = json.toString();
						
						BpmFormView cfSetting = json.getJSONArray("BPM_FORM_VIEW").getObject(0, BpmFormView.class);
						rtnMsg.add(cfSetting.getName() + exitMsg);
						
						//转换
						json = JSON.parseObject(jsonArrStr);
						json.put("tenantId", ContextUtil.getCurrentTenantId());
						importHandlerManager.doImportForm(json);
						
					}
				}
				differMsg = ProcessHandleHelper.getProcessMessage().getDifferMsgs();
			}
			return getPathView(request).addObject("rtnMsg", rtnMsg).addObject("differMsg", differMsg);
	    }
	    
}
