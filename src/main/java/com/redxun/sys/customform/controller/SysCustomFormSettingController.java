
package com.redxun.sys.customform.controller;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.manager.OsGroupManager;
import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.api.IFlowService;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.SolutionExpImpManager;
import com.redxun.bpm.form.api.FormHandlerFactory;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.BpmTableFormula;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.api.ITableOperator;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.PdfUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoDataHandler;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.bo.manager.SysBoRelationManager;
import com.redxun.sys.core.entity.SysBoList;
import com.redxun.sys.core.entity.SysFormulaMapping;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysBoListManager;
import com.redxun.sys.core.manager.SysFormulaMappingManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.customform.entity.SysCustomFormSetting;
import com.redxun.sys.customform.manager.ICustomFormDataHandler;
import com.redxun.sys.customform.manager.SysCustomFormSettingImportHandlerManager;
import com.redxun.sys.customform.manager.SysCustomFormSettingManager;

/**
 * 自定义表单配置设定控制器
 * @author mansan
 */
@Controller
@RequestMapping("/sys/customform/sysCustomFormSetting/")
public class SysCustomFormSettingController extends MybatisListController{
    @Resource
    SysCustomFormSettingManager sysCustomFormSettingManager;
    @Resource
    SysBoEntManager sysBoEntManager;
    @Resource
    SysBoListManager sysBoListManager;
    @Resource
    BpmFormViewManager bpmFormViewManager;
    @Resource
    SysBoDefManager sysBoDefManager;
    @Resource
    ContextHandlerFactory contextHandlerFactory;
    @Resource
    SysTreeManager sysTreeManager;
    @Resource
    BpmFormRightManager bpmFormRightManager;
    @Resource
    BpmTableFormulaManager bpmTableFormulaManager;
	@Resource
	OsGroupManager osGroupManager;
   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysCustomFormSettingManager.delete(id);
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
        SysCustomFormSetting sysCustomFormSetting=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysCustomFormSetting=sysCustomFormSettingManager.get(pkId);
        }else{
        	sysCustomFormSetting=new SysCustomFormSetting();
        }
        return getPathView(request).addObject("sysCustomFormSetting",sysCustomFormSetting);
    }
  
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	ModelAndView mv = getPathView(request);
    	SysCustomFormSetting sysCustomFormSetting=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysCustomFormSetting=sysCustomFormSettingManager.get(pkId);
    		String treeId=sysCustomFormSetting.getTreeId();
    		if(StringUtils.isNotBlank(treeId)){
    			SysTree sysTree=sysTreeManager.get(treeId);
    			mv.addObject("sysTree", sysTree);
    		}
    		String tableRightJson=sysCustomFormSettingManager.getTableRightJson(sysCustomFormSetting);
			//设置子表权限。
			mv.addObject("tableRightJson", tableRightJson);
			//设置公式。
			setFormula(sysCustomFormSetting);
			
    	}else{
    		sysCustomFormSetting=new SysCustomFormSetting();
    	}
    	JSONArray contextVarAry=getContextVars();
		mv.addObject("contextVars", contextVarAry.toJSONString());
    	return mv.addObject("sysCustomFormSetting",sysCustomFormSetting);
    }
    
    /**
     * 设置表单公式。
     * @param sysCustomFormSetting
     */
    private void setFormula(SysCustomFormSetting sysCustomFormSetting){
    	KeyValEnt<String> kv= bpmTableFormulaManager.getKvByFormSolId(sysCustomFormSetting.getId());
    	if(StringUtil.isNotEmpty(kv.getKey())){
    		sysCustomFormSetting.setFormulaId(kv.getKey());
    		sysCustomFormSetting.setFormulaName(kv.getVal());
    	}
    }
    
    /**
     * 多行保存
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("{alias}/rowsSave")
    @ResponseBody
    public JsonResult rowsSave(HttpServletRequest request,@PathVariable(value="alias")String alias){
    	String rows=request.getParameter("rows");
    	
    	SysCustomFormSetting setting=sysCustomFormSettingManager.getByAlias(alias);

    	if(setting==null){
    		return new JsonResult(false,"表单方案映射没有配置！请联系管理员。");
    	}
    	
    	sysBoEntManager.batchRows(setting.getBodefId(),rows);
    	
    	return new JsonResult(true,"成功保存行数据！");
    }

    @RequestMapping("getContextVarsAndTableJson")
    @ResponseBody
    public JSONObject getContextVarsAndTableJson(HttpServletRequest request,HttpServletResponse response){
    	String boDefId=RequestUtil.getString(request, "boDefId");
    	
    	JSONObject rtnObj=new JSONObject();
    	
    	String tableRightJson=sysCustomFormSettingManager.getTableRightJsonByBoDefId(boDefId);//getTableRightJson(sysCustomFormSettingManager.get(pkId));
		//设置子表权限。
		rtnObj.put("tableRightJson", tableRightJson);
    	JSONArray contextVarAry=getContextVars();
    	rtnObj.put("contextVars", contextVarAry.toJSONString());
    	
    	return rtnObj;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysCustomFormSettingManager;
	}
	
	@RequestMapping(value={"treeMgr/{alias}"})
    public ModelAndView treeMgr(HttpServletRequest request,@PathVariable(value="alias")String alias) throws Exception{
		ModelAndView mv=new ModelAndView();
		mv.addObject("alias", alias);
		mv.setViewName("sys/customform/sysCustomFormSettingTreeMgr.jsp");
		return mv;
    }
	
	@RequestMapping(value={"tree/{alias}"})
	@ResponseBody
	public List<JSONObject> treeData(HttpServletRequest request,@PathVariable(value="alias")String alias) throws Exception{
		String parentId=RequestUtil.getString(request, SysBoEnt.SQL_PK, "");
		List<JSONObject> list= sysCustomFormSettingManager.getTreeData(alias, parentId);
		return list;
    }
	
	/**
	 * 新版本的导入excel
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("{boKey}/importExcel")
    @ResponseBody
	public Long importExcel(@PathVariable("boKey")String boKey,MultipartHttpServletRequest request, HttpServletResponse response) throws Exception {

		SysBoList sysBoList=sysBoListManager.getByKey(boKey, ContextUtil.getCurrentTenantId());
		if(sysBoList ==null) return null;
		//获取该表所有字段
		String sysFormAlias = sysBoList.getFormAlias();
		SysCustomFormSetting scfs = sysCustomFormSettingManager.getByAlias(sysFormAlias);
		BpmFormView fv = bpmFormViewManager.getLatestByKey(scfs.getFormAlias(), ContextUtil.getCurrentTenantId());
		String boDefId = fv.getBoDefId();
		SysBoDef bodef = sysBoDefManager.get(boDefId);
		SysBoEnt boent = sysBoEntManager.getByBoDefId(bodef.getId());
		List<SysBoAttr> attrs = sysBoEntManager.getAttrsByEntId(boent.getId());
		
		Map<String, MultipartFile> files = request.getFileMap();
		Iterator<MultipartFile> it = files.values().iterator();
		long l = 0;
		
		while(it.hasNext()){
			MultipartFile f = it.next();
			InputStream is = f.getInputStream();
			WorkbookFactory.create(is);
			List<Map<String,Object>> dataList = ExcelUtil.importExcel(attrs, f);
			l += sysBoListManager.insertData(dataList,boent);			
		}
		return l;
	}
	
	/**
	 * 替换form方法实现新的表单的展示
	 * @param request
	 * @param alias
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"{alias}/add"})
	public ModelAndView add(HttpServletRequest request,@PathVariable(value="alias")String alias) throws Exception{
		return getAddForm(request,alias);
	}
	
	@RequestMapping(value={"form/{alias}"})
    public ModelAndView form(HttpServletRequest request,@PathVariable(value="alias")String alias) throws Exception{
		return getAddForm(request,alias);
    }
	
	private ModelAndView getAddForm(HttpServletRequest request,String alias) throws Exception{
		ModelAndView mv=new ModelAndView();
		String pid=RequestUtil.getString(request, "pid");
		String tenantId=ContextUtil.getCurrentTenantId();
		SysCustomFormSetting setting=sysCustomFormSettingManager.getByAlias(alias);
		
		Map<String,Object> params=RequestUtil.getParameterValueMap(request, false);
		
		String dataHandler=setting.getDataHandler();
		FormModel formModel=null;
		//增加数据处理器。
		if(StringUtil.isEmpty(dataHandler)){
			formModel=FormUtil.getFormByFormAlias(setting.getId(),setting.getFormAlias(), "",false,false, params);
		}else{
			BpmFormView bpmFormView=bpmFormViewManager.getLatestByKey(setting.getFormAlias(), tenantId);
			ICustomFormDataHandler handler=(ICustomFormDataHandler) AppBeanUtil.getBean(dataHandler);
			JSONObject jsonData= handler.getInitData(bpmFormView.getBoDefId());
			FormUtil.setContextData(jsonData, params);
			formModel=FormUtil.getByFormView(setting.getId(),bpmFormView, jsonData, false, false);
		}
		
		String parentHtml="";
		if(StringUtil.isNotEmpty(pid) && setting.getIsTree()==1){
			parentHtml="<input class='mini-hidden' name='"+SysBoEnt.SQL_FK+"' value='"+pid+"'>";
			formModel.setContent( formModel.getContent() +parentHtml);
		}
		boolean canStartFlow=StringUtil.isNotEmpty(setting.getSolId());
		boolean hasAfterJs=StringUtil.isNotEmpty(setting.getAfterJsScript());

		List<OsGroup> osGroupList =osGroupManager.getCanGroups(ContextUtil.getCurrentUserId(),ContextUtil.getCurrentTenantId());
		String osGroupArray =getOsGroupArray(osGroupList);

		String viewId=formModel.getViewId();
		mv.addObject("viewId", viewId);
		mv.addObject("formModel", formModel);
		mv.addObject("setting", setting);
		mv.addObject("canStartFlow", canStartFlow);
		mv.addObject("hasAfterJs", hasAfterJs);
		mv.addObject("osGroupArray",osGroupArray);
		
		mv.setViewName("sys/customform/sysCustomFormSettingForm.jsp");
		return mv;
	}

	/**
	 * 组装角色列表
	 */
	private String getOsGroupArray(List<OsGroup> osGroupList){
		String osGroupArray ="";
		for (OsGroup osGroup:osGroupList ) {
			if(StringUtil.isEmpty(osGroupArray)){
				osGroupArray=osGroup.getKey();
			}else{
				osGroupArray+=","+osGroup.getKey();
			}
		}
		return osGroupArray;
	}
	
	/**
	 * 跳至PDF表单打印页
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("exportPDF")
	@ResponseBody
	public void exportPDF(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String alias=RequestUtil.getString(request, "alias");
		String id=RequestUtil.getString(request, "id");
		String tenantId=ContextUtil.getCurrentTenantId();
		
		SysCustomFormSetting setting=sysCustomFormSettingManager.getByAlias(alias);
		BpmFormView bpmFormView=bpmFormViewManager.getLatestByKey(setting.getFormAlias(), tenantId);
		
		JSONObject rightSetting=FormUtil.getRightByForm(bpmFormView.getKey());
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		JSONObject rightJson=bpmFormRightManager.calcRights(rightSetting, profileMap, true) ;
		JSONObject jsonData= FormUtil.getData(bpmFormView.getBoDefId(),id);
		
		JSONObject opinionData=new JSONObject();
		
		String tempHtml = bpmFormViewManager.getPDFHtml(rightJson, bpmFormView.getPdfTemp(), jsonData,opinionData,"");
		
		String html= bpmFormViewManager. getHtml(tempHtml);
		String downloadFileName = URLEncoder.encode(setting.getName(),"UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=" +downloadFileName);
		PdfUtil.convertHtmlToPdf(html, response.getOutputStream());
	}
	
	/**
	 * 表单编辑数据。
	 * @param alias
	 * @param id
	 * @return
	 * @throws Exception
	 * @{@link Deprecated} 使用formEdit
	 */
	@RequestMapping(value={"form/{alias}/{id}"})
    public ModelAndView formEdit(HttpServletRequest request, @PathVariable(value="alias")String alias,@PathVariable(value="id")String id) throws Exception{
		ModelAndView mv=getFormEdit(request,alias,id);
		return mv;
    }
	/**
	 * 表单编辑数据。
	 * @param alias
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"{alias}/edit"})
    public ModelAndView formEdit(HttpServletRequest request, @PathVariable(value="alias")String alias) throws Exception{
		String id=request.getParameter("pk");
		ModelAndView mv=getFormEdit(request,alias,id);
		return mv;
    }
	
	private ModelAndView getFormEdit(HttpServletRequest request,String alias,String id) throws Exception{
		ModelAndView mv=new ModelAndView();
		String tenantId=ContextUtil.getCurrentTenantId();
		SysCustomFormSetting setting=sysCustomFormSettingManager.getByAlias(alias);
		String dataHandler=setting.getDataHandler();
		
		Map<String,Object> params=RequestUtil.getParameterValueMap(request, false);
		
		//设置子表权限。
		ProcessHandleHelper.clearObjectLocal();
		ProcessHandleHelper.setObjectLocal(setting.getTableRightJson());

		FormModel formModel=null;
		
		if(StringUtil.isEmpty(dataHandler)){
			String paramDef=setting.getParamDef();
			if(StringUtil.isEmpty(id) && StringUtil.isNotEmpty(paramDef)){
				formModel =FormUtil.getFormByFormAliasParam(setting.getId(),setting.getFormAlias(), paramDef,false,false, params);
			}
			else{
				formModel =FormUtil.getFormByFormAlias(setting.getId(),setting.getFormAlias(), id,false,false, params);
			}

		}else{
			BpmFormView bpmFormView=bpmFormViewManager.getLatestByKey(setting.getFormAlias(), tenantId);
			ICustomFormDataHandler handler=(ICustomFormDataHandler) AppBeanUtil.getBean(dataHandler);
			JSONObject jsonData= handler.getByPk(id,bpmFormView.getBoDefId());
			FormUtil.setContextData(jsonData, params);
			formModel=FormUtil.getByFormView(setting.getId(), bpmFormView, jsonData, false, false);
		}

		mv.addObject("formModel", formModel);
		
		boolean canStartFlow= canStartFlow(formModel,setting.getSolId());
		boolean hasAfterJs=StringUtil.isNotEmpty(setting.getAfterJsScript());
		
		mv.addObject("setting", setting);
		mv.addObject("hasAfterJs", hasAfterJs);
		
		mv.addObject("canStartFlow", canStartFlow);
		mv.setViewName("sys/customform/sysCustomFormSettingForm.jsp");
		return mv;
	}
	
	/**
	 * 判断否启动流程。
	 * <pre>
	 * 	1.是否存在解决方案。
	 * 	2.是否存在流程实例。
	 * </pre>
	 * @param formModel
	 * @param solId
	 * @return
	 */
	private boolean canStartFlow(FormModel formModel,String solId){
		if(StringUtil.isEmpty(solId)) return false;
		JSONObject data=formModel.getJsonData();
	
		String status=data.getString(SysBoEnt.FIELD_INST_STATUS_);
		if(BpmInst.STATUS_DRAFTED.equals(status)) return true;
		
		return false;
	}
	
	/**
	 * 查看明细
	 * @param alias
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/detail/{alias}/{id}"})
    public ModelAndView detail(@PathVariable(value="alias")String alias,@PathVariable(value="id")String id) throws Exception{
		return getDetailForm(alias,id);
    }
	
	/**
	 * 查看明细
	 * @param alias
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/{alias}/detail"})
    public ModelAndView detail(HttpServletRequest request,@PathVariable(value="alias")String alias) throws Exception{
		String id=request.getParameter("pk");
		return getDetailForm(alias,id);
    }

	private ModelAndView getDetailForm(String alias,String id) throws Exception{
		ModelAndView mv=new ModelAndView();
		String tenantId=ContextUtil.getCurrentTenantId();
		
		SysCustomFormSetting setting=sysCustomFormSettingManager.getByAlias(alias);
		
		//设置子表权限。
		ProcessHandleHelper.clearObjectLocal();
		ProcessHandleHelper.setObjectLocal(setting.getTableRightJson());
		
		String dataHandler=setting.getDataHandler();
		FormModel formModel=null;
		if(StringUtil.isEmpty(dataHandler)){
			String paramDef=setting.getParamDef();
			if(StringUtil.isEmpty(id) && StringUtil.isNotEmpty(paramDef)){
				formModel= FormUtil.getFormByFormAliasParam(setting.getId(),setting.getFormAlias(), paramDef,true,false, new HashMap<String, Object>());
			}
			else{
				formModel= FormUtil.getFormByFormAlias(setting.getId(),setting.getFormAlias(), id,true,false, new HashMap<String, Object>());
			}
			
		}else{
			BpmFormView bpmFormView=bpmFormViewManager.getLatestByKey(setting.getFormAlias(), tenantId);
			ICustomFormDataHandler handler=(ICustomFormDataHandler) AppBeanUtil.getBean(dataHandler);
			JSONObject jsonData= handler.getByPk(id,bpmFormView.getBoDefId());
			formModel=FormUtil.getByFormView(setting.getId(), bpmFormView, jsonData, true, false);
		}
		
		mv.addObject("formModel", formModel);
		
		JSONObject jsonObj=formModel.getJsonData();
		
		boolean hasInst=jsonObj.containsKey(SysBoEnt.FIELD_INST);
		if(hasInst){
			String instId=jsonObj.getString(SysBoEnt.FIELD_INST);
			mv.addObject("instId", instId);
		}
		mv.addObject("hasInst", hasInst);
		
		mv.addObject("setting", setting);
		mv.setViewName("sys/customform/sysCustomFormSettingDetail.jsp");
		return mv;
	}
	
	
	
	@RequestMapping(value={"saveData"},method=RequestMethod.POST)
	@ResponseBody
	public JsonResult save(HttpServletRequest request,@RequestBody String json ) throws Exception{
		JsonResult rtn=null;
		try{
			JSONObject jsonObj=JSONObject.parseObject(json);
			JSONObject setting=jsonObj.getJSONObject("setting");
			
			String alias=setting.getString("alias");
			
			SysCustomFormSetting formSetting= sysCustomFormSettingManager.getByAlias(alias);
			//设置公式来源
			BoResult result= sysCustomFormSettingManager.saveData(formSetting, jsonObj);
			
			return handTreeResult(result,formSetting,jsonObj);
 		}
		catch(Exception ex){
			rtn=  new JsonResult<JSONObject>(false, "保存表单数据失败!");
			rtn.setData(ex.getMessage());
		}
		return rtn;
    }
	
	/**
	 * 获得表单方案的对话框
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listForDialog")
	@ResponseBody
	public JsonPageResult<SysCustomFormSetting> listForDialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		
		String tenantId=ContextUtil.getCurrentTenantId();
		queryFilter.addFieldParam("TENANT_ID_", tenantId);
		queryFilter.addSortParam("CREATE_TIME_", "desc");
		List<SysCustomFormSetting> list=sysCustomFormSettingManager.getAll(queryFilter);
		return new JsonPageResult<SysCustomFormSetting>(list, queryFilter.getPage().getTotalItems());
	}
	
	private JsonResult<JSONObject> handTreeResult(BoResult result,SysCustomFormSetting setting,JSONObject jsonObj){
		if(!result.getIsSuccess()) {
			return new JsonResult(false, "验证不通过" ,result.getMessage());
		}
		JSONObject settingJson=jsonObj.getJSONObject("setting");
		JSONObject formData=jsonObj.getJSONObject("formData");
		JsonResult<JSONObject> rtn=new JsonResult<JSONObject>(true);
		String msg="";
		if(BoResult.ACTION_TYPE.ADD.equals(result.getAction())){
			msg="添加数据成功!";
		}else{
			msg="编辑数据成功!";
		}
		String action=settingJson.getString("action");
		if("startFlow".equals(action)){
			msg="启动流程成功!";
		}
		
		rtn.setMessage(msg);
		//1.不是属性返回。
		JSONObject json=new JSONObject();
		json.put("pk", result.getPk());
		json.put("action", result.getAction());
		//是否为树形。
		json.put("isTree", setting.getIsTree());
		
		rtn.setData(json);
		
		if(0== setting.getIsTree().intValue()) return rtn;
		//2.删除子表。
		Set<String> removeKeys=new HashSet<String>();
		Set<String> set= formData.keySet();
		for(String key :set){
			if(key.startsWith(SysBoEnt.SUB_PRE)){
				removeKeys.add(key);
			}
		}
		for(String key :removeKeys){
			formData.remove(key);
		}
		//3.设置主键
		formData.put(result.getBoEnt().getPkField(), result.getPk());
		//4.设置显示字段。
		String field=setting.getDisplayFields();
		
		if(StringUtil.isNotEmpty(field)){
			String val=formData.getString(field);
			formData.put("text_", val);
		}
		json.put("row", formData);
		rtn.setData(json);
		return rtn;
	}
	
	
	@RequestMapping(value={"{alias}/removeById"},method=RequestMethod.POST)
	@ResponseBody
	public JsonResult<Void> removeById(HttpServletRequest request,@PathVariable(value="alias")String alias ) throws Exception{
		String id=RequestUtil.getString(request, "id");
		String[] deleteIds = id.split(",");
		try{
			BoResult result = new BoResult();
			for (int i = 0; i < deleteIds.length; i++) {
				result = sysCustomFormSettingManager.removeTreeById(alias, deleteIds[i]);
			}
			if(!result.getIsSuccess()) {
				return new JsonResult<Void>(false,result.getMessage());
			}
			return new JsonResult<Void>(true, "删除数据成功!");
		}
		catch(Exception ex){
			return new JsonResult<Void>(false, "删除数据失败!");
		}
    }
	
	
	@RequestMapping("validateFieldUnique")
	@ResponseBody
	public JSONObject validateFieldUnique(HttpServletRequest request,HttpServletResponse response){
		JSONObject jsonObject=new JSONObject();
		String boDefId=RequestUtil.getString(request, "boDefId");
		String fieldName=RequestUtil.getString(request, "fieldName");
		String value=RequestUtil.getString(request, "value");
		String pkId=RequestUtil.getString(request, "pkId");
		
		SysBoEnt sysBoEnt=sysBoEntManager.getMainByBoDefId(boDefId);
		String tableName=sysBoEnt.getName();
		boolean isExist=sysCustomFormSettingManager.isFieldUnique(tableName, fieldName, value, pkId);
		if(isExist){
			jsonObject.put("success", false);
		}
		else{
			jsonObject.put("success", true);
		}
		return jsonObject;
	}
	
	@RequestMapping("getTreeByCat")
	@ResponseBody
	public List<SysTree> getTreeByCat (HttpServletRequest request,HttpServletResponse response){
		String catKey=RequestUtil.getString(request, "catKey");
		String tenantId=ContextUtil.getCurrentTenantId();
		List<SysTree> treeList=sysTreeManager.getByCatKeyTenantId(catKey, tenantId);
		return treeList;
	}
	
	
	@RequestMapping("getCustomFormSetting")
	@ResponseBody
	public  JsonPageResult<SysCustomFormSetting> getCustomFormSetting(HttpServletRequest request,HttpServletResponse response){
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		String treeId=RequestUtil.getString(request, "treeId");
		queryFilter.addFieldParam("TREE_ID_", treeId);
		List<SysCustomFormSetting> sysCustomFormSettings=sysCustomFormSettingManager.getAll(queryFilter);
		JsonPageResult<SysCustomFormSetting> jsonPageResult=new JsonPageResult<SysCustomFormSetting>(sysCustomFormSettings, queryFilter.getPage().getTotalItems());
		return jsonPageResult;
	}
	
	@RequestMapping("jsonAll")
	@ResponseBody
	public List<SysCustomFormSetting> jsonAll(HttpServletRequest request,HttpServletResponse response){
		QueryFilter queryFilter = getQueryFilter(request);
		List<SysCustomFormSetting> setList=sysCustomFormSettingManager.getJsonAll(queryFilter);
		return setList;
	}
	
    /**
     * 获取常量。
     * @return
     */
    private JSONArray getContextVars(){
    	JSONArray contextVarAry= contextHandlerFactory.getJsonHandlers();
		//添加常量
		addVars(contextVarAry);
		//常量
		return contextVarAry;
    }
    
    private void addVars(JSONArray ary){
    	JSONObject ref=new JSONObject();
    	ref.put("key",SysBoEnt.SQL_FK);
    	ref.put("val","外键字段");
    			
    	
    	JSONObject refState=new JSONObject();
    	
    	refState.put("key",SysBoEnt.SQL_FK_STATEMENT);
    	refState.put("val","外键占位符");
    	
    	ary.add(ref);
    	ary.add(refState);
    	
    }
    
    
    /**
     *  The methods : export & import were writed by Louis
     *  2018-11-30
     */
    
    @Resource
    SysBoAttrManager sysBoAttrManager;
    @Resource
    SysBoRelationManager sysBoRelationManager;
    @Resource
    CommonDao commonDao;
    @Resource
	private ITableOperator  tableOperator;
    @Resource
    SysFormulaMappingManager sysFormulaMappingManager;

    @RequestMapping("export")
    public void export(HttpServletRequest req, HttpServletResponse res) throws Exception {
    	String ids = req.getParameter("ids");
    	String[] idArr = ids.split(",");
    	
    	JSONArray jArray = new JSONArray();
    	
    	for(String id : idArr) {
    		//init
    		JSONObject json = new JSONObject();
        	JSONArray sysCustomFormSettingArr = new JSONArray(); //sysCustomFormSetting的json结果集
        	JSONArray sysBoDefArr = new JSONArray(); //sysBoDef的json结果集
        	//JSONArray sysTreeArr = new JSONArray(); //sysTree的json结果集
        	JSONArray sysBoRelationArr = new JSONArray(); //sysBoRelation的json结果集
        	JSONArray sysBoEntArr = new JSONArray(); //sysBoEnt的json结果集
        	JSONArray sysBoAttrArr = new JSONArray(); //sysBoAttr的json结果集
        	//JSONArray sysBoListArr = new JSONArray(); //sysBoList的json结果集
        	//JSONObject entObj = new JSONObject(); //实体表的结构和数据
        	JSONArray bpmFormRightArr = new JSONArray(); //表单视图字段管理权限bpmFormRight的json结果集
        	JSONArray bpmFormViewArr = new JSONArray(); //业务表单视图bpmFormView的json结果集
        	JSONArray sysFormulaMappingArr = new JSONArray(); //表单方案公式映射sysFormulaMapping的json结果集
        	JSONArray bpmTableFormulaArr = new JSONArray(); //表间公式bpmTableFormula的json结果集
        	
    		//首先根据每一个id获取到其相关的数据 (权限，表单方案，表单，BO, 创建数据库表 ...etc) 
    		SysCustomFormSetting sysCustomFormSetting = sysCustomFormSettingManager.get(id);
    		sysCustomFormSettingArr.add(JSONObject.toJSON(sysCustomFormSetting));
    		
    		//获取分类数据
    		/*String treeId = sysCustomFormSetting.getTreeId(); //分类id 
    		SysTree sysTree = sysTreeManager.get(treeId);
    		if(sysTree != null) {
    			String[] treeParentIds = sysTree != null ? sysTree.getPath().split("\\.") : new String[0];
        		for(String tpId : treeParentIds) { //分类的所有父类路径实体
        			SysTree sysTree1 = sysTreeManager.get(tpId);
        			if(sysTree1 != null){
        				sysTreeArr.add(JSONObject.toJSON(sysTree1));
        			}
        		}
    		}*/
    		
    		//获取表单视图字段管理的权限
    		BpmFormRight bpmFormRight = bpmFormRightManager.getBySolId(sysCustomFormSetting.getId()); //主表和子表的权限都集合在json中
    		bpmFormRightArr.add(JSONObject.toJSON(bpmFormRight));
    		
    		//获取表单方案公式映射
    		List<SysFormulaMapping> sysFormulaMappingList = sysFormulaMappingManager.getByFormSolId(sysCustomFormSetting.getId());
    		for(SysFormulaMapping sfm : sysFormulaMappingList) {
    			sysFormulaMappingArr.add(JSONObject.toJSON(sfm));
    			
    			//获取表间公式
        		BpmTableFormula bpmTableFormula = bpmTableFormulaManager.get(sfm.getFormulaId());
        		bpmTableFormulaArr.add(JSONObject.toJSON(bpmTableFormula));
        		
        		/*SysTree bpmTableFormulaTree = sysTreeManager.get(bpmTableFormula.getTreeId());
    			if(bpmTableFormulaTree != null) {
    				String[] bpmTableFormulaTreeParentIds = bpmTableFormulaTree != null ? bpmTableFormulaTree.getPath().split("\\.") : new String[0];
            		for(String btftpId : bpmTableFormulaTreeParentIds) { //表间公式的分类所有父类路径实体
            			SysTree sysTree1 = sysTreeManager.get(btftpId);
            			if(sysTree1 != null) {
            				sysTreeArr.add(JSONObject.toJSON(sysTree1));
            			}
            		}
    			}*/
    		}
    		//SysFormulaMapping sysFormulaMapping = sysFormulaMappingManager.
    		//sysFormulaMappingArr.add(JSONObject.toJSON(sysFormulaMapping));System.err.println("sysFormulaMapping");System.err.println(JSONObject.toJSON(sysFormulaMapping));
    		
    		//获取业务模型(业务对象)
    		String definitionId = sysCustomFormSetting.getBodefId(); //业务模型id
    		SysBoDef sysBoDef = sysBoDefManager.get(definitionId);
    		sysBoDefArr.add(JSONObject.toJSON(sysBoDef));
    		if(sysBoDef != null) {
    			/*SysTree boDefTree = sysTreeManager.get(sysBoDef.getTreeId());
    			if(boDefTree != null) {
    				String[] boDefTreeParentIds = boDefTree != null ? boDefTree.getPath().split("\\.") : new String[0];
            		for(String bdtpId : boDefTreeParentIds) { //业务对象的分类所有父类路径实体
            			SysTree sysTree1 = sysTreeManager.get(bdtpId);
            			if(sysTree1 != null) {
            				sysTreeArr.add(JSONObject.toJSON(sysTree1));
            			}
            		}
    			}*/
        		
        		//获取业务模型关联的表单对象(主表和子表)
        		List<SysBoRelation> sysBoRelationList = sysBoRelationManager.getByDefId(sysBoDef.getId());
        		for(SysBoRelation boRel : sysBoRelationList) {
        			sysBoRelationArr.add(JSONObject.toJSON(boRel));
        			
        			SysBoEnt sysBoEnt = sysBoEntManager.get(boRel.getBoEntid());
        			sysBoEntArr.add(JSONObject.toJSON(sysBoEnt));
        			
        			List<SysBoAttr> sysBoAttrList = sysBoAttrManager.getAttrsByEntId(sysBoEnt.getId());
        			for(SysBoAttr sysBoAttr : sysBoAttrList) {
        				sysBoAttrArr.add(JSONObject.toJSON(sysBoAttr));
        				//获取extJson的数据：来源可能有多种可能  -- 暂时缺省
        				/*JSONObject extJson = JSONObject.parseObject(sysBoAttr.getExtJson());*/
        			}
        			/*String sysBoListName = sysBoEnt.getName();
    				if(StringUtil.isNotEmpty(sysBoListName)) {
    					SysBoList sysBoList = sysBoListManager.getByKey(sysBoListName);
        				sysBoListArr.add(JSONObject.toJSON(sysBoList));
    				}*/
        		}
        		
        		//获取业务表单视图
        		List<BpmFormView> bpmFormViewList = bpmFormViewManager.getByBoId(sysBoDef.getId());
        		bpmFormViewArr.addAll(bpmFormViewList);
    		}
    		
    		json.put("SYS_CUSTOMFORM_SETTING", sysCustomFormSettingArr);
        	json.put("SYS_BO_DEFINITION", sysBoDefArr);
        	//json.put("SYS_TREE", sysTreeArr);
        	json.put("SYS_BO_RELATION", sysBoRelationArr);
        	json.put("SYS_BO_ENTITY", sysBoEntArr);
        	json.put("SYS_BO_ATTR", sysBoAttrArr);
        	//json.put("SYS_BO_LIST", sysBoListArr);
        	json.put("BPM_FORM_RIGHT", bpmFormRightArr);
        	json.put("BPM_FORM_VIEW", bpmFormViewArr);
        	json.put("SYS_FORMULA_MAPPING", sysFormulaMappingArr);
        	json.put("BPM_TABLE_FORMULA", bpmTableFormulaArr);
    		
        	jArray.add(json);
    	}
    	//System.err.println(json);
    	
    	res.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "Form-Configuration-" + sdf.format(new Date());
		res.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						res.getOutputStream());
		String jsonStr = jArray.toString();
		zipOutputStream.putArchiveEntry(new ZipArchiveEntry("Form-Configuration.json"));
		InputStream is = new ByteArrayInputStream(jsonStr.getBytes("UTF-8"));
		IOUtils.copy(is, zipOutputStream);
		zipOutputStream.closeArchiveEntry();
		zipOutputStream.close(); //关闭流
    }
    
    @Resource
    private SysCustomFormSettingImportHandlerManager importHandlerManager;
    
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
					
					SysCustomFormSetting cfSetting = json.getJSONArray("SYS_CUSTOMFORM_SETTING").getObject(0, SysCustomFormSetting.class);
					rtnMsg.add(cfSetting.getName() + exitMsg);
					
					//转换
					json = JSON.parseObject(jsonArrStr);
					json.put("tenantId", ContextUtil.getCurrentTenantId());
					importHandlerManager.doImport(json);
					
				}
			}
			differMsg = ProcessHandleHelper.getProcessMessage().getDifferMsgs();
		}
		return getPathView(request).addObject("rtnMsg", rtnMsg).addObject("differMsg", differMsg);
    }
    
    //导出差异脚本文件
    @RequestMapping("exportDifferScript")
    private void exportDifferScript(HttpServletRequest req, HttpServletResponse res) throws Exception {
    	String scripts = RequestUtil.getString(req, "differMsgs");
    	
    	res.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new Date());
		String downFileName = "DifferScripts-" + date;
		res.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						res.getOutputStream());
		
		zipOutputStream.putArchiveEntry(new ZipArchiveEntry("Script-" + date + ".sql"));
		InputStream is = new ByteArrayInputStream(scripts.getBytes("UTF-8"));
		IOUtils.copy(is, zipOutputStream);
		zipOutputStream.closeArchiveEntry();
		zipOutputStream.close(); //关闭流
    }
}
