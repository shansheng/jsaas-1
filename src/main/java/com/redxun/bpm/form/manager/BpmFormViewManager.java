package com.redxun.bpm.form.manager;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import com.redxun.core.manager.MybatisBaseManager;
import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.dao.BpmInstDao;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.form.dao.BpmFormViewDao;
import com.redxun.bpm.form.entity.BpmFormTemplate;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.OpinionDef;
import com.redxun.bpm.form.entity.RightModel;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.view.control.MiniControlParseConfig;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.customform.manager.SysCustomFormSettingManager;

import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;

/**
 * <pre> 
 * 描述：BpmFormView业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmFormViewManager extends MybatisBaseManager<BpmFormView> {
	
	static Pattern  regex = Pattern.compile("&lt;#if(.*?)&gt;", Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE | Pattern.DOTALL);


	@Resource
	private BpmFormViewDao bpmFormViewDao;
	
	@Resource
	private FreemarkEngine freemarkEngine;
	
	@Resource
	MiniControlParseConfig miniControlParseConfig;
	
	@Resource
	private SysBoDefManager sysBoDefManager;
	@Resource
	private SysBoEntManager  sysBoEntManager;
	@Resource
	private GroupService groupService;
	
	@Resource
	private BpmSolFvManager bpmSolFvManager;
	
	@Resource
	private BpmNodeJumpManager bpmNodeJumpManager;
	
	@Resource
	private BpmInstDao bpmInstDao;
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	BpmFormRightManager bpmFormRightManager;
	@Resource
	BpmFormTemplateManager bpmFormTemplateManager;
	@Resource
	SysCustomFormSettingManager sysCustomFormSettingManager;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmFormViewDao;
	}
	
	
	
	 /**
     * 获得表单视图中的所有版本
     * @param page
     * @return
     */
    public List<BpmFormView> getAllVersionsByKey(String key,String tenantId ,Page page){
    	return bpmFormViewDao.getAllVersionsByKey(key, tenantId, page);
    }
    
    /**
     * 通过表单Key获得业务表单
     * @param key
     * @param tenantId
     * @return
     */
    public BpmFormView getLatestByKey(String key,String tenantId){
    	BpmFormView formView=bpmFormViewDao.getByAlias(key,tenantId);
    	if(formView==null){
    		formView=bpmFormViewDao.getByAlias(key,ITenant.ADMIN_TENANT_ID);
    	}
    	return formView;
    }
    
    public List<BpmFormView> getByFilter(QueryFilter queryFilter){
    	
    	String tenantId=ContextUtil.getCurrentTenantId();
    	queryFilter.addFieldParam("STATUS_",BpmFormView.STATUS_DEPLOYED);
    	queryFilter.addFieldParam("tenantId", tenantId);
    	queryFilter.addFieldParam("IS_MAIN_", MBoolean.YES.toString());
    	
    	return  bpmFormViewDao.getByFilter(queryFilter);
    }

	public List<BpmFormView> getQuery(QueryFilter queryFilter){

		String tenantId=ContextUtil.getCurrentTenantId();
		queryFilter.addFieldParam("STATUS_",BpmFormView.STATUS_DEPLOYED);
		queryFilter.addFieldParam("TENANT_ID_", tenantId);
		queryFilter.addFieldParam("IS_MAIN_", MBoolean.YES.toString());

		return  bpmFormViewDao.query(queryFilter);
	}
    
    /**
     * 查询在线表单
     * @param queryFilter
     * @return
     */
    public List<BpmFormView> getOnlineForms(QueryFilter queryFilter){
    	String tenantId=ContextUtil.getCurrentTenantId();
    	queryFilter.addFieldParam("STATUS_",BpmFormView.STATUS_DEPLOYED);
    	queryFilter.addFieldParam("TENANT_ID_", tenantId);
    	queryFilter.addFieldParam("IS_MAIN_", MBoolean.YES.toString());
    	queryFilter.addFieldParam("TYPE_","ONLINE-DESIGN");
    	return bpmFormViewDao.getAll(queryFilter);
    }
    
    
    /**
     * 设置当前的视图为主视图
     * @param viewId
     */
    public void doSetMain(String viewId){
    	bpmFormViewDao.updateIsMain(viewId);;
    }
	
	/**
	 * 发布新版本
	 * @param bpmFormView
	 * @return
	 */
	public BpmFormView doDeployNewVersion(BpmFormView bpmFormView){
		BpmFormView newView=new BpmFormView();
		//从缓存中移除该实体
		detach(bpmFormView);
		
		String key= bpmFormView.getKey();
		String tenantId=bpmFormView.getTenantId();
		
		int maxVersion=bpmFormViewDao.getMaxVersion(key, tenantId);
		//将key对应的表单修改成非主版本
		bpmFormViewDao.updateIsNotMain(bpmFormView.getKey(), bpmFormView.getTenantId());
		
		BeanUtil.copyProperties(newView, bpmFormView);
		newView.setViewId(IdUtil.getId());
		newView.setIsMain(MBoolean.YES.toString());
		newView.setVersion(maxVersion+1);
		newView.setStatus(BpmFormView.STATUS_DEPLOYED);
		create(newView);
		return newView;
	}
	
	
	
	
	
	
	
	private boolean isNotEmpty(String str){
		return StringUtils.isNotEmpty(str) && (!"null".equals(str));
	}
	
	private boolean hasRight(String rightJson,Map<String,Set<String>> profileMap){
		RightModel model=(RightModel)JSONObject.parseObject(rightJson, RightModel.class);
		return PermissionUtil.hasRight(model, profileMap);
	}
	
	
	public boolean isAliasExist(BpmFormView formView){
		String tenantId=ContextUtil.getCurrentTenantId();
		//表示存在
		if(StringUtil.isNotEmpty(formView.getViewId())){
			BpmFormView oldForm= bpmFormViewDao.get(formView.getViewId());
			if(oldForm==null || oldForm.getKey().equals(formView.getKey())){
				return false;
			}
		}
		Integer rtn= bpmFormViewDao.getCountByAlias(tenantId, formView.getKey());
		return rtn>0;
	}
	
	/**
	 * 导入是判断别名是否存在。
	 * @param alias
	 * @return
	 */
	public boolean isAliasExist(String alias){
		String tenantId=ContextUtil.getCurrentTenantId();
		Integer rtn= bpmFormViewDao.getCountByAlias(tenantId, alias);
		return rtn>0;
	}
	
	
    /**
     * 根据key删除表单。
     * @param tenantId
     * @return
     */
    public void deletByKey(String key,String tenantId){
    	bpmFormViewDao.deletByKey(key,tenantId);
    }
    
    /**
     * 保存表单。
     * 
     * @param formView	表单对象
     * @param genTable	生成物理表
     * @throws Exception 
     */
    public JsonResult saveFormAndBo(BpmFormView formView,String genTable) throws Exception{
    	
    	String viewId=formView.getViewId();
    	ITenant  tenant=ContextUtil.getTenant();
    	String tenantId=tenant.getInstId();
    	String genTreeId = formView.getTreeId();
    	
    	//1.解析表单和bo。
		String boDefId="";
		String content=formView.getTemplateView();
		SysBoEnt curEnt=sysBoEntManager.parseHtml(content);
		String formKey=formView.getKey();
		String formComment=formView.getName();
		curEnt.setName(formKey.replace(" ",""));
		curEnt.setTableName(SysBoEntManager.getTableName(formKey).replace(" ",""));
		curEnt.setComment(formComment);
		
		List<OpinionDef> opinionDefs=parseOpinion(content);
		//解析按钮。
		JSONArray buttonDefs=parseButtonDef(content);
		formView.setButtonDef(buttonDefs.toJSONString());
		List<SysBoAttr> sysBoAttrs=new ArrayList<SysBoAttr>();//对原有bo实体临时传递
		String isCreate = formView.getIsCreate();
		//2.如果表单之前存，则将bo实体数据进行合并。
		if(StringUtil.isNotEmpty(viewId)){
			String title=formView.getTitle();
			String status=formView.getStatus();
			String buttonDef=formView.getButtonDef();
			formView= this.get(viewId);
			formView.setTreeId(genTreeId);
			formView.setIsCreate(isCreate);
			if(StringUtils.isNotBlank(status)){
				formView.setStatus(status);
			}
			formView.setTitle(title);
			formView.setTemplateView(content);
			formView.setKey(formKey);
			formView.setName(formComment);
			formView.setButtonDef(buttonDef);
			boDefId=formView.getBoDefId();
			
			if(StringUtil.isNotEmpty(boDefId)){
				SysBoEnt baseEnt= sysBoEntManager.getByBoDefId(boDefId);
				List<SysBoAttr> attr=baseEnt.getSysBoAttrs();
				for (SysBoAttr sysBoAttr : attr) {
					sysBoAttrs.add((SysBoAttr) sysBoAttr.clone());
				}
				sysBoEntManager.merageBoEnt(baseEnt, curEnt);
				curEnt=baseEnt;
			}
		}
		//curEnt.setTreeId(formView.getTreeId()); //modify by Louis
		curEnt.setCategoryId(formView.getTreeId());
		curEnt.setGenTable(genTable);
		
		
		JsonResult  checkResult= checkBoValid(curEnt);
		if(!checkResult.isSuccess()) return checkResult;
		
		//3.在表单保存之前做检查。
		JsonResult result= sysBoDefManager.canExeSave(boDefId, curEnt, tenantId);
		if(!result.isSuccess()) return result;
		
		//4.保存bo数据。
		String rtnBoDefId= sysBoDefManager.saveBoEnt( boDefId,curEnt,sysBoAttrs,tenantId,opinionDefs) ;
		//5.保存表单数据。
    	if(StringUtil.isNotEmpty(rtnBoDefId)){
    		formView.setBoDefId(rtnBoDefId);
    	}
    	sysCustomFormSettingManager.saveDefault(formView);
    	saveFormView(formView);
    	return new JsonResult(true,"保存表单元数据成功!");
    	
	}
    
    /**
	 * 表单意见解析。
	 * @param html
	 * @return
	 */
	public List<OpinionDef> parseOpinion(String html){
		List<OpinionDef> list=new ArrayList<OpinionDef>();
		Document doc=(Document) Jsoup.parseBodyFragment(html);
		Elements  elements= doc.select("[plugins=\"mini-nodeopinion\"]");
		if(BeanUtil.isEmpty(elements)) return list;
		Iterator<Element> elIt=elements.iterator();
		while(elIt.hasNext()){
			Element el=elIt.next();
			String name=el.attr("name").replace(IExecutionCmd.FORM_OPINION, "");
			String label=el.attr("label");
			OpinionDef def=new OpinionDef(name, label);
			list.add(def);
		}
		return list;
	}
	
	/**
	 * 解析表单中的按钮。
	 * @param html
	 * @return
	 */
	public JSONArray parseButtonDef(String html){
		JSONArray list=new JSONArray();
		Document doc=(Document) Jsoup.parseBodyFragment(html);
		Elements  elements= doc.select("[plugins=\"mini-button\"]");
		if(BeanUtil.isEmpty(elements)) return list;
		Iterator<Element> elIt=elements.iterator();
		while(elIt.hasNext()){
			Element el=elIt.next();
			String name=el.attr("name");
			String label=el.attr("text");
			JSONObject def=new JSONObject();
			def.put("name", name);
			def.put("label", label);
			list.add(def);
		}
		return list;
	}
    
    private JsonResult checkBoValid(SysBoEnt ent){
    	if(!SysBoDef.BO_YES.equals(ent.getGenTable())) return new  JsonResult(true);
    	JsonResult result= new  JsonResult(true);
    	List<SysBoAttr> attrList=ent.getSysBoAttrs();
    	String msg="字段类型为空,字段名:";
    	for(SysBoAttr attr:attrList){
    		if(StringUtil.isEmpty( attr.getDataType())){
    			result.setSuccess(false);
    			msg+=attr.getName() +","; 
    		}
    	}
    	List<SysBoEnt> entList=ent.getBoEntList();
    	for(SysBoEnt subEnt:entList){
    		List<SysBoAttr> subAttrList=subEnt.getSysBoAttrs();
    		for(SysBoAttr attr:subAttrList){
        		if(StringUtil.isEmpty( attr.getDataType())){
        			result.setSuccess(false);
        			msg+=attr.getName() +","; 
        		}
        	}
    	}
    	if(!result.isSuccess()){
    		result.setMessage(msg);
    	}
    	return result;
    	
    	
    }
    
    
    /**
     * 保存表单。
     * @param formView
     * @throws Exception
     */
    public void saveFormView(BpmFormView formView) throws Exception{
    	if(!BpmFormView.FORM_TYPE_SEL_DEV.equals( formView.getType()) ){
    		String templateView=formView.getTemplateView();
        	templateView=templateView.replace("&nbsp;", "");
    		formView.setTemplateView(templateView);
    		String template=convertToFreemakTemplate(templateView);
        	formView.setTemplate(template);
    	}

    	String viewId=formView.getViewId();
    	if(StringUtil.isEmpty(viewId)){
    		formView.setViewId(IdUtil.getId());
    		formView.setVersion(1);
    		formView.setIsMain(MBoolean.YES.toString());
    		if(StringUtil.isEmpty(formView.getStatus())){
    			formView.setStatus( BpmFormView.STATUS_INIT);
    		}
    		bpmFormViewDao.create(formView);
    	}
    	else{
    		BpmFormView orignView= bpmFormViewDao.get(viewId);
    		BeanUtil.copyNotNullProperties(orignView, formView);
    		bpmFormViewDao.update(orignView);
    	}
    }
    
    
    /**
     * 拷贝并创建新的表单。
     * @param formView
     */
    public BpmFormView copyNew(BpmFormView formView){
    	BpmFormView newView=new BpmFormView();
        BpmFormView view=bpmFormViewDao.get(formView.getViewId());
        BeanUtil.copyProperties(newView, view);
        
        newView.setViewId(IdUtil.getId());
        newView.setVersion(1);
        newView.setName(formView.getName());
        newView.setKey(formView.getKey());
        newView.setIsMain(MBoolean.YES.name());
        newView.setStatus(BpmFormView.STATUS_DEPLOYED);
        
        bpmFormViewDao.create(newView);
        
        return newView;
    }

	

	
    /**
     * 根据类型获取表单配置。
     * @param fv
     * @param type
     * @return
     */
    private String getFormConf(BpmSolFv fv,String type){
    	if(BeanUtil.isEmpty(fv))return null;
    	if(BpmFormView.TYPE_MOBILE.equals(type)){
    		return fv.getMobileForms();
    	}
    	return fv.getCondForms();
    }
    
    /**
     * 获取表单配置公共方法
     * @param solId		方案ID
     * @param actDefId	流程定义ID
     * @param nodeId	节点ID
     * @param type		表单类型(pc表单,打印表单)
     * @param instId	流程实例
     * @return
     */
    private List<BpmFormView> getFormView(String solId,String actDefId,String nodeId, String type,String instId){
    	FormConfig config= getFormAlias(solId,actDefId,nodeId,type,instId);
    	List<BpmFormView> formViews=new ArrayList<BpmFormView>();
    	
    	List<String> formList=config.getFormKeys();
    	if(BeanUtil.isEmpty(formList)) return formViews;

    	for(String alias:formList){
    		BpmFormView formView=getLatestByKey(alias, ContextUtil.getCurrentTenantId());
    		if(formView==null){
    			continue;
    		}
    		formView.setBpmSolFv(config.getBpmSolFv());
    		formViews.add(formView);
    	}
    	
    	return formViews;

    }
    
    /**
     * 获取表单配置。
     * <pre>
     * 1.根据节点获取表单配置。
     * 2.没有获取到则获取全局的配置。
     * </pre>
     * @param solId
     * @param actDefId
     * @param nodeId
     * @param type
     * @param instId
     * @return
     */
    public FormConfig getFormAlias(String solId,String actDefId,String nodeId, String type,String instId){
    	BpmSolFv bpmSolFv=bpmSolFvManager.getBySolIdActDefIdNodeId(solId,actDefId,nodeId);
    	
    	BpmSolFv solFv=bpmSolFv;
    
    	
    	List<String> formList=null;
    	
    	String condForms="";
    	
    	if(bpmSolFv!=null ){
    		condForms=getFormConf(bpmSolFv,type);
    		formList=getFormList(condForms,instId);
    	}
    	if(BeanUtil.isEmpty(formList)){
    		bpmSolFv=bpmSolFvManager.getBySolIdActDefIdNodeId(solId, actDefId,BpmFormView.SCOPE_PROCESS);
    		condForms=getFormConf(bpmSolFv,type);
    	}
    	if(StringUtil.isNotEmpty(condForms)){
    		formList=getFormList(condForms,instId);
    	}
    	FormConfig config=new FormConfig(solFv, formList);
    	
    	return config;
    }
    
    /**
     * 根据JSON和实例ID获取表单列表。
     * @param formJson	
     * jsonObj :格式
     * {"attendUsers": "true",
		"formName": "报价单",
		"userIds":"1,2",
		"groupIds":"3,4",
		"isAll": "false",
		"startUser": "true",
		"formAlias": "quotation"}	
     * @param instId	流程实例ID
     * @return
     */
    public List<String> getFormList(String formJson,String instId){
    	List<String> list=new ArrayList<String>();
    	if(StringUtil.isEmpty(formJson)) return list;
    	
    	JSONArray jsonAry=JSONArray.parseArray(formJson);
    	if(jsonAry.size()==0) return list;
    	
    	IUser curUser= ContextUtil.getCurrentUser();
    	
    	String startUserId="";
    	Set<String> handleUsers=null;
    	
    	if(StringUtils.isNotEmpty(instId)){
			BpmInst bpmInst=bpmInstDao.get(instId);
        	//启动的情况还没有实例
        	if(BeanUtil.isEmpty(bpmInst)){
        		handleUsers=new HashSet<String>();
    			startUserId=curUser.getUserId();
        	}
        	else{
        		startUserId=bpmInst.getCreateBy();
        		handleUsers=bpmNodeJumpManager.getNodeHandleUserIds(bpmInst.getActInstId());
        	}
		}else{
			handleUsers=new HashSet<String>();
			startUserId=curUser.getUserId();
		}
    	//取得表单
    	for(Object o :jsonAry){
    		JSONObject jsonObj=(JSONObject)o;
    		String formAlias=jsonObj.getString("formAlias");
			if(StringUtils.isEmpty(formAlias)) continue;
			boolean isContain=isContain(jsonObj,handleUsers,startUserId,curUser);
			
			if(!isContain) continue;
			//若为合法授权则添加至表单的权限中
			list.add(formAlias);
    	}
    	
    	return list;
    }
    
    
    /**
     * 判断是否有权限访问表单。
     * jsonObj :格式
     * {"attendUsers": "true",
		"formName": "报价单",
		"userIds":"1,2",
		"groupIds":"3,4",
		"isAll": "false",
		"startUser": "true",
		"formAlias": "quotation"}			 
     * @param jsonObj
     * @param handleUsers
     * @param startUserId
     * @param curUser
     * @return
     */
    private boolean isContain(JSONObject jsonObj,Set<String> handleUsers,	String startUserId,IUser curUser){
    	String isAll=jsonObj.getString("isAll");
		String startUser=jsonObj.getString("startUser");
		String userIds=jsonObj.getString("userIds");
		String groupIds=jsonObj.getString("groupIds");
		String attendUsers=jsonObj.getString("attendUsers");
		String curUserId=curUser.getUserId();
		if("true".equals(isAll)){
			return true;
		}
		if("true".equals(startUser) && curUserId.equals(startUserId)){
			return true;
		}
		if(userIds!=null){
			String[]uIds=userIds.split("[,]");
			for(String uId:uIds){
				if(curUserId.equals(uId)){
					return true;
				}
			}
		}
		if(groupIds!=null){
			String[] gIds=groupIds.split("[,]");
			for(String gId:gIds){
				if(curUser.getGroupIds().contains(gId)){
					return true;
				}
			}
		}
		if("true".equals(attendUsers)){
			if(handleUsers.contains(curUserId)){
				return true;
			}
		}
		return false;
    }
    
    public List<BpmFormView> getByTreeFilter(QueryFilter filter){
		return bpmFormViewDao.getByTreeFilter(filter);
	}
    
	public List<BpmFormView> getByBoId(String boDefId){
		return bpmFormViewDao.getByBoId(boDefId);
	}
    

    
    /**
     * 获得流程解决方案中的开始表单
     * @param solId
     * @return
     */
    public List<BpmFormView> getStartFormView(String solId,String actDefId){
    	return getFormView(solId, actDefId, BpmFormView.SCOPE_START,BpmFormView.TYPE_FORM,"");

    }
     
    /**
     * 取得当前任务的多个表单
     * @param solId
     * @param actDefId
     * @param nodeId
     * @param instId
     * @return
     */
    public List<BpmFormView> getTaskFormViews(String solId,String actDefId,String nodeId,String instId){
    	return getFormView(solId, actDefId, nodeId, BpmFormView.TYPE_FORM, instId);
    }
    
  
    
    /**
     * 获得流程解决方案中的明细表单
     * @param solId
     * @return
     */
    public List<BpmFormView> getDetailFormView(String solId,String actDefId,String instId){
    	return getFormView(solId, actDefId, BpmFormView.SCOPE_DETAIL,BpmFormView.TYPE_FORM , instId);
    }
    
   

    
   
    public class FormConfig{
    	private BpmSolFv bpmSolFv;
    	
    	private List<String> formKeys=new ArrayList<String>();
    	
    	private List<BpmFormView> formViews=new ArrayList<BpmFormView>();
    	
    	public FormConfig(){}

    	public FormConfig(BpmSolFv bpmSolFv, List<String> formKeys) {
    		this.bpmSolFv = bpmSolFv;
    		this.formKeys = formKeys;
    	}

    	public BpmSolFv getBpmSolFv() {
    		return bpmSolFv;
    	}

    	public void setBpmSolFv(BpmSolFv bpmSolFv) {
    		this.bpmSolFv = bpmSolFv;
    	}

    	public List<String> getFormKeys() {
    		return formKeys;
    	}

    	public void setFormKeys(List<String> formKeys) {
    		this.formKeys = formKeys;
    	}

    	public List<BpmFormView> getFormViews() {
    		return formViews;
    	}

    	public void setFormViews(List<BpmFormView> formViews) {
    		this.formViews = formViews;
    	}
    }
    
    /**
     * 清理表单bo定义。
     * @param boDefId
     * @throws SQLException
     */
    public void cleanBoDef(String boDefId) throws SQLException{
    	//清除表单引用的
    	bpmFormViewDao.removeBoDef(boDefId);
    	
    	//删除bo定义
    	sysBoDefManager.removeBoDef(boDefId);
    }
    
    
    /**
     * @return
     * @throws Exception
     */
    public String getPdfHtmlByTask(String taskId,JSONObject jsonObject,boolean snippet) throws Exception {
    	BpmTask bpmTask=bpmTaskManager.get(taskId);
		BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		List<BpmFormView> bpmFormViews = getTaskFormViews(bpmTask.getSolId(),bpmTask.getProcDefId(),
				bpmTask.getTaskDefKey(),bpmInst.getInstId());
		
		StringBuffer sb = new StringBuffer();
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		Map<String,JSONObject> jsonMap=FormUtil.convertJsonToMap(jsonObject);
		for(BpmFormView bpmFormView:bpmFormViews){
			String actDefId=bpmTask.getProcDefId();
			JSONObject rightMap=FormUtil.getByNodeId(bpmFormView.getKey(), bpmTask.getTaskDefKey(), actDefId, bpmTask.getSolId());
			JSONObject rightsMap= bpmFormRightManager.calcRights( rightMap,profileMap,false);
			JSONObject jsonData=FormUtil.getData(bpmInst,bpmFormView.getBoDefId());
			JSONObject formJson=jsonMap.get(bpmFormView.getBoDefId());
			//设置意见。
			JSONObject opinionData=FormUtil.getOpinionByInst(bpmInst);
			
			setOpinionFromJson(opinionData, jsonData);
			FastjsonUtil.copyProperties(jsonData, formJson);
			
			
			String template=getRenderTemplate() + bpmFormView.getPdfTemp();
			
			
			String tempHtml=getPDFHtml(rightsMap, template,jsonData,opinionData,bpmInst.getBillNo());
			sb.append(tempHtml);
		}
		if(snippet){
			return sb.toString();
		}
		String html=  getHtml(sb.toString());
		return html;
	}
    
    private String getRenderTemplate(){
    	List<BpmFormTemplate> forms=bpmFormTemplateManager
        		.getTemplateByType("other", FormConstants.FORM_PRINT);
    	return forms.get(0).getTemplate();
    }
    
   
    
    /**
     * 获取pdf模板
     * @param instId
     * @return
     * @throws Exception
     */
    public String getPdfHtmlByInstId(String instId,boolean snippet) throws Exception {
    	BpmInst bpmInst = bpmInstManager.get(instId);
    	String solId=bpmInst.getSolId();
		String actDefId=bpmInst.getActDefId();
		List<BpmFormView> bpmFormViews = getDetailFormView(solId, actDefId, instId);
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		StringBuffer sb = new StringBuffer();
		
		for(BpmFormView bpmFormView:bpmFormViews){
			JSONObject rightMap=FormUtil.getByStart(bpmFormView.getKey(), actDefId, solId);
			JSONObject rightsMap= bpmFormRightManager.calcRights( rightMap,profileMap,false);
			JSONObject jsonData=FormUtil.getData(bpmInst,bpmFormView.getBoDefId());
			JSONObject opinionData= FormUtil.getOpinionByInst(bpmInst);
			
			String template=getRenderTemplate() + bpmFormView.getPdfTemp();
			
			String tempHtml=getPDFHtml(rightsMap, template,jsonData,opinionData,bpmInst.getBillNo());
			sb.append(tempHtml);
		}
		String html=  getHtml(sb.toString());
		return html;
	}
    
    public String getPdfHtmlByAlias(String alias,String json,boolean snippet) throws Exception {
    	String tenantId=ContextUtil.getCurrentTenantId();
		
		BpmFormView bpmformview=this.getLatestByKey(alias, tenantId);
		
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		JSONObject jsonData=JSONObject.parseObject(json);
		JSONArray jsonAry=jsonData.getJSONArray("bos");
		JSONObject jsonObj=jsonAry.getJSONObject(0).getJSONObject("data");
		
		JSONObject rightMap=FormUtil.getRightByForm(alias);
		JSONObject rightsMap=bpmFormRightManager.calcRights( rightMap,profileMap,false);
		
		JSONObject opinionData=new JSONObject();
		
		String template=getRenderTemplate() + bpmformview.getPdfTemp();
		
		String tempHtml=getPDFHtml(rightsMap, template,jsonObj,opinionData,"");
			
		
		String html=  getHtml(tempHtml);
		return html;
	}
    
    /**
     * 启动打印的HTML
     * @param solId
     * @param jsonObject
     * @param snippet
     * @return
     * @throws Exception
     */
    public String getPdfHtmlBySolId(String solId,JSONObject jsonObject,boolean snippet) throws Exception {
		BpmSolution bpmSolution=bpmSolutionManager.get(solId);
		
		String actDefId=bpmSolution.getActDefId();
		List<BpmFormView> bpmFormViews = getStartFormView(solId,actDefId);
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		StringBuffer sb = new StringBuffer();
		Map<String,JSONObject> jsonMap=FormUtil.convertJsonToMap(jsonObject);
		
		for(BpmFormView bpmFormView:bpmFormViews){
			JSONObject rightSetting=FormUtil.getByStart(bpmFormView.getKey(), actDefId, solId);
			JSONObject rightsMap=bpmFormRightManager.calcRights(rightSetting, profileMap, false);
			JSONObject jsonData=jsonMap.get(bpmFormView.getBoDefId());
			//TODO 
			JSONObject opinionData=new JSONObject();
			setOpinionFromJson(opinionData, jsonData);
			
			String template=getRenderTemplate() + bpmFormView.getPdfTemp();
			
			String tempHtml=getPDFHtml(rightsMap, template,jsonData,opinionData,"");
			sb.append(tempHtml);
		}
		if(snippet){
			return sb.toString();
		}
		String html=  getHtml(sb.toString());
		return html;
	}
    
    /**
     * "FORM_OPINION_": {
				"name": "bmjl",
				"val": "c"
			}
     * @param opinionData
     * @param jsonData
     */
    private void setOpinionFromJson(JSONObject opinionData,JSONObject jsonData){
    	JSONObject opinionJson=jsonData.getJSONObject("FORM_OPINION_");
    	if(BeanUtil.isEmpty(opinionJson)) return;
    	String name=opinionJson.getString("name");
    	String val=opinionJson.getString("val");
    	
    	JSONArray ary=new JSONArray();
    	JSONObject obj=new JSONObject();
    	IUser curUser=ContextUtil.getCurrentUser();
    	obj.put("opinion", val);
    	obj.put("userId", curUser.getUserId());
    	obj.put("userName", curUser.getFullname());
    	obj.put("createTime", DateUtil.formatDate(new Date()));
    	ary.add(obj);
    	
    	opinionData.put(name, val);
    	
    }
    
    
   
    
    public String getHtml(String html) throws IOException, TemplateException{
    	Map<String,Object> params = new HashMap<String, Object>();
    	String path=FileUtil.getWebRootPath();
    	params.put("filePath", path);
		params.put("data", html);
		String str=freemarkEngine.mergeTemplateIntoString("list/printPdf.ftl", params);
		return str;
    }

    
    /**
     * 构造pdf导出HTML
     * @param rightsMap 权限代码
     * @param pdfTemp PDF模板
     * @param jsonData 数据
     * @return
     * @throws Exception
     */
    public String getPDFHtml(JSONObject rightsMap,String pdfTemp,JSONObject jsonData,JSONObject opinionData,String no) throws Exception{
		String tempHtml = constructPDFTemp(pdfTemp);
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("rightsMap", rightsMap);
		params.put("data", jsonData);
		params.put("opinion", opinionData);
		params.put("no", no);
		
		TemplateHashModel sysBoListModel=FreemakerUtil.getTemplateModel(PdfPrintUtil.class);
		params.put("util", sysBoListModel);
		
		String pdfHtml=freemarkEngine.parseByStringTemplate(params, tempHtml);

    	return pdfHtml;
    }
    
    /**
     * 替换rx-if，rx-list 标签。
     * @param pdfTemp
     * @return
     */
    private String constructPDFTemp(String pdfTemp){
    	Document doc = Jsoup.parse(pdfTemp);
    	Elements ifELs = doc.getElementsByAttribute("rx-if");
    	Elements listELs = doc.getElementsByAttribute("rx-list");
		Iterator<Element> ifIt=ifELs.iterator();
		Iterator<Element> listIt=listELs.iterator();
		while(ifIt.hasNext()){
			Element el = ifIt.next();
			String value = el.attr("rx-if");
			el.removeAttr("rx-if");
			el.before("<#if rightsMap."+value+" != 'none'>");
			el.after("</#if>");
		}
		while(listIt.hasNext()){
			Element el = listIt.next();
			String value = el.attr("rx-list");
			el.removeAttr("rx-list");
			el.before("<#list data."+value+" as item>");
			el.after("</#list>");
		}
		
		String html = doc.body().html();
		html = html.replaceAll("&lt;", "<");
		html = html.replaceAll("&gt;", ">");
		html = html.replaceAll("<!--#if-->","</#if>");
		html = html.replaceAll("<!--#list-->","</#list>");
		html = html.replaceAll("<!--#assign-->","</#assign>");
		html = html.replaceAll("<!--#function-->","</#function>");
		html = html.replaceAll("&amp;&amp;","&&");
		
		return html;
    }
    
    /**
     * 表单是否支持pdf打印。
     * @param formViews
     * @return
     */
    public boolean supportFdf(List<BpmFormView> formViews){
    	for(BpmFormView view:formViews){
    		if(StringUtil.isEmpty(view.getPdfTemp())){
    			return false;
    		}
    	}
    	return true;
    }
    
    public List<String> getAliasByBoId(String boDefId){
    	return bpmFormViewDao.getAliasByBoId(boDefId);
    }
    
    public List<String> getAliasByBoIdMainVersion(String boDefId){
    	return bpmFormViewDao.getAliasByBoIdMainVersion(boDefId);
    }
    
    
    /**
     * 将表单内容进行一次转换,将子表替换成原生的方式，不在浏览器端转换。
     * @param content
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    public static String convertToFreemakTemplate(String content) throws IOException, TemplateException{
    	
    	Document  doc= Jsoup.parseBodyFragment(content);
    	FreemarkEngine freemarkEngine=AppBeanUtil.getBean(FreemarkEngine.class);
    	
    	//处理表单权限。
    	List<String> permissions= handPermission(doc);
    	
		Elements  elements= doc.select("[plugins=\"rx-grid\"]");
		
		Map<String,String> htmlMap=new HashMap<String, String>();
		
		for(Element el:elements){
			if(el.parent()!=null){
				el.parent().addClass("td-grid");
			}
			JSONObject jsonGrid= getMetaData( el);
			
			String gridId=jsonGrid.getString("gridId");
			el.attr("id", "gct_" + gridId);
			el.prepend("<div id=\"div_"+ gridId +"\"></div>");
			Map<String,Object> params=new HashMap<String, Object>();
			params.put("grid", jsonGrid);
			String html=freemarkEngine.mergeTemplateIntoString("form/render/grid.ftl", params);
			htmlMap.put(gridId, html);

			Elements tables= el.select(".rx-grid>table");

			if(tables.size()>0){
				tables.get(0).remove();
			}

			Elements divInit= el.select(".rx-grid > ._initdata");
			if(divInit.size()>0){
				divInit.remove();
			}
		}

		doc.body().getElementsByClass("button-container").remove();
		String html= doc.body().html();
		for (Entry<String, String> ent : htmlMap.entrySet()) {
			String replace="<div id=\"div_" +ent.getKey() +"\"></div>";
			html=html.replace(replace, ent.getValue());
		}
		html= doc.head().html() + html;
		
		
		Matcher matcher = regex.matcher(html);
		while (matcher.find()) {
			html=html.replace(matcher.group(0),"<#if " +matcher.group(1) +">");
		}
		html=html.replace("<!--#if-->","</#if>");
		return html;
    }
    
    private static List<String> handPermission(Document doc){
    	List<String> list=new ArrayList<String>();
    	Elements  elements= doc.select("[permission]");
    	for(Element el: elements){
    		String permission=el.attr("permission");
    		 
    		el.before("<#if !"+permission+"?exists || "+permission+"!=\"none\"> " );
    		el.after("</#if>" );
    		list.add(permission);
    	}
    	return list;
    }
    
    /**
     * 获取子表中的原数据。
     * @param el
     * @return
     */
    private static JSONObject getMetaData(Element el){
		//name="grid" edittype="inline"
		JSONObject json=new JSONObject();
		json.put("gridId", el.attr("name"));
		//openwindow,inline,
		String edittype=el.attr("edittype");
		json.put("edittype", el.attr("edittype"));
		
		json.put("formkey", el.attr("formkey"));
		//treegrid="true" treecolumn="name"
		json.put("treegrid", el.attr("treegrid"));
		json.put("treecolumn", el.attr("treecolumn"));
		
		String dataOptions=el.attr("data-options");
		if(StringUtil.isNotEmpty(dataOptions)){
			json.put("dataoptions", dataOptions.substring(1, dataOptions.length()-1));
		}
		else{
			json.put("dataoptions","");
		}
		
	
		json.put("oncellendedit", el.attr("oncellendedit"));
		
		//按钮的html
		String buttonHtml="";
		Elements buttonContainer=el.select(".button-container");
		if(buttonContainer.size()>0){
			Element button=buttonContainer.get(0);
			if(button.children().size()>0){
				buttonHtml=buttonContainer.html();
			}
		}
		json.put("buttonHtml", buttonHtml);
		
		
		Elements headEls= el.select("div.rx-grid > table >thead > tr > th.header");
		Elements bodyEls= el.select("div.rx-grid > table >tbody > tr > td");
		
		JSONArray ary=new JSONArray();
		for(int i=0;i<headEls.size();i++){
			JSONObject subJson=new JSONObject();
			Element headEl=headEls.get(i);
			Element bodyEl=bodyEls.get(i);
			
			subJson.put("name", headEl.attr("header"));
			subJson.put("comment", headEl.html());
			subJson.put("width", headEl.attr("width"));
			subJson.put("format", headEl.attr("format"));
			subJson.put("datatype", headEl.attr("datatype"));
			String visible=headEl.attr("visible");
			if(StringUtil.isEmpty(visible)) visible="true";
			subJson.put("visible",visible);
			
			
			subJson.put("displayfield", headEl.attr("displayfield"));
			String required="true".equals(headEl.attr("requires"))?"required":"";
			String vtype=headEl.attr("vtype");
			vtype=StringUtil.isEmpty(required)?vtype :"required;" + vtype;
			subJson.put("vtype", vtype);
			
			if(!bodyEl.children().isEmpty()){
				Element editorEl=bodyEl.child(0);
				subJson.put("control", editorEl.attr("plugins"));
				//property="editor"
				editorEl.attr("property", "editor");
				//editorEl.attr("required", headEl.attr("requires"));
				subJson.put("editor", editorEl.outerHtml());
				
				String options=editorEl.attr("data-options");
				if(StringUtil.isNotEmpty(options)){
					subJson.put("dataoptions", options.replace("\"","'"));
				}
			}
			ary.add(subJson);
		}
		json.put("fields", ary);
		
		return json;
	}
}

