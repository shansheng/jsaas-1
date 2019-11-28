package com.redxun.bpm.form.manager;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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

import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.BaseFont;
import com.redxun.bpm.core.dao.BpmInstDao;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.form.dao.BpmFormViewDao;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormViewRight;
import com.redxun.bpm.form.entity.OpinionDef;
import com.redxun.bpm.form.entity.RightModel;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.bpm.view.control.MiniControlParseConfig;
import com.redxun.bpm.view.control.MiniViewHanlder;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
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
import com.redxun.sys.core.util.JsaasUtil;

import freemarker.template.TemplateException;
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
public class BpmFormViewManager extends ExtBaseManager<BpmFormView>{

	Pattern regex = Pattern.compile("&lt;#if(.*?)&gt;", Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE | Pattern.DOTALL);

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
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmFormViewDao;
	}
	
	@Override
	public BaseMybatisDao getMyBatisDao() {
		return bpmFormViewDao;
	}
	
	 /**
     * 获得表单视图中的所有版本
     * @param mainViewId
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
    	BpmFormView formView=bpmFormViewDao.getMainByKey(key,tenantId);
    	if(formView==null){
    		formView=bpmFormViewDao.getMainByKey(key,ITenant.ADMIN_TENANT_ID);
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
	
	
	public String parseHtml(String html,Map<String,Object> params,String modelJson){
		return parseHtml(html,params,modelJson,null);
	}
	
	/**
	 * 解析模板HTML
	 * @param html
	 * @param params
	 * @param modelJson
	 * @return
	 */
	public String parseHtml(String html,Map<String,Object> params,String modelJson,Map<String,FormViewRight> rightMap){
		String afterHtml=null;
		try{
			afterHtml=freemarkEngine.parseByStringTemplate(params, html);
		}catch(Exception e){
			logger.debug(e.getMessage());
			afterHtml=html;
		}
		//String userId=ContextUtil.getCurrentUserId();

		//是否打印
		String printable=(String)params.get(FormViewConsts.PARAM_PRINTABLE);
		
		//是否需要解析权限，如果需要，则把用户对应的用户组解析出来
		Map<String, Set<String>> profileMap= ProfileUtil.getCurrentProfile();
		
		//获得modelJson
		com.alibaba.fastjson.JSONObject jsonObj=com.alibaba.fastjson.JSONObject.parseObject(modelJson);
		
		Document doc = Jsoup.parse(afterHtml);
		//查找有该样式的控件
		Elements ctls=doc.select(".rxc");

		Iterator<Element> it=ctls.iterator();
		
		while(it.hasNext()){
			Element el=it.next();
			
			//取得控件的名字
			String name=el.attr("name");
			String plugins=el.attr("plugins");
			if(StringUtils.isEmpty(name) || StringUtils.isEmpty(plugins)) continue;
			
			FormViewRight fvr=null;
			//处理权限
			//只读，编辑，隐藏
			if(BeanUtil.isNotEmpty(rightMap)){
				fvr=rightMap.get(name);
			}
			
			com.alibaba.fastjson.JSONObject resultJson=calcRights(fvr, profileMap);

			String right=resultJson.getString("right");
			
			//是否编辑权限设置了
			boolean isEditSet=resultJson.getBooleanValue("isEditSet");
				
			//隐藏
			if("hide".equals(right)){
				el.remove();
				continue;
			}
			//若设置了编辑权限，但没有符合条件，或设置了只读权限
			if(isEditSet && "".equals(right) || "read".equals(right) || "true".equals(printable)){
				el.attr("readonly","true");
				el.addClass("asLabel");
			}
			//通过视图来执行
			MiniViewHanlder handler=miniControlParseConfig.getElementViewHandler(plugins);
			params.put("right", right);
			handler.parse(el, params, jsonObj);
			//转为只读，有些是在服务端转，有些是需要在客户端转化
			if("read".equals(right) || "true".equals(printable)){
				handler.convertToReadOnly(el, params, jsonObj);
			}
		}
		//增加主键
		String pkHtml="";
		if(jsonObj.containsKey(SysBoEnt.SQL_PK)){
			pkHtml="<input type='hidden' name='"+SysBoEnt.SQL_PK+"' value='"+jsonObj.getString(SysBoEnt.SQL_PK)+"'>";
		}

		//head中会带有script及style的内容，需要返回给前台进行解析，Js可以有效获得变量的内容值
		return doc.head().html() +pkHtml+ doc.body().html();
	}
	
	/**
	 * 计算表单权限。
	 * @param fvr
	 * @param userId
	 * @param groupsMap
	 * @return
	 */
	private com.alibaba.fastjson.JSONObject calcRights(FormViewRight fvr,Map<String, Set<String>> profileMap){
		
		com.alibaba.fastjson.JSONObject result=new com.alibaba.fastjson.JSONObject();
		result.put("isEditSet", false);
		result.put("right", "");
		
		if(fvr==null) return result;
		
		String right="";
		
		String editDf=fvr.getEditDf();
		String readDf=fvr.getReadDf();
		String hideDf=fvr.getHideDf();
		if(isNotEmpty(editDf) ){
			result.put("isEditSet", true);
			boolean hasEdit=hasRight(editDf,profileMap);
			if(hasEdit){
				right="edit";
			}
		}
		
		if("".equals(right) && isNotEmpty(readDf) ){
			boolean hasRead=hasRight(readDf,profileMap);
			if(hasRead ){
				right="read";
			}
		}
		
		if("".equals(right) && isNotEmpty(hideDf)){
			boolean hasHidden=hasRight(hideDf,profileMap);
			if(hasHidden){
				right="hide";
			}
		}

		result.put("right", right);
		return result;
		
		
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
     * @param alias
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
     * @param onlySave	值做保存
     * @param genTable	生成物理表
     * @throws SQLException 
     * @throws TemplateException 
     * @throws IOException 
     * @throws CloneNotSupportedException 
     */
    public JsonResult saveFormAndBo(BpmFormView formView,String genTable) throws SQLException, IOException, TemplateException, CloneNotSupportedException{
    	
    	String viewId=formView.getViewId();
    	String tenantId=ContextUtil.getCurrentTenantId();
    	
    	//1.解析表单和bo。
		String boDefId="";
		String content=formView.getTemplateView();
		SysBoEnt curEnt=sysBoEntManager.parseHtml(content);
		String formKey=formView.getKey();
		String formComment=formView.getName();
		curEnt.setName(formKey);
		curEnt.setComment(formComment);
		
		List<OpinionDef> opinionDefs=parseOpinion(content);
		//解析按钮。
		JSONArray buttonDefs=parseButtonDef(content);
		formView.setButtonDef(buttonDefs.toJSONString());
		List<SysBoAttr> sysBoAttrs=new ArrayList<SysBoAttr>();//对原有bo实体临时传递
		//2.如果表单之前存，则将bo实体数据进行合并。
		if(StringUtil.isNotEmpty(viewId)){
			String title=formView.getTitle();
			String status=formView.getStatus();
			String buttonDef=formView.getButtonDef();
			formView= this.get(viewId);
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
		curEnt.setTreeId(formView.getTreeId());
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
    	//保存表单。
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
    
    
    public void saveFormView(BpmFormView formView) throws IOException, TemplateException{
    	
    	if(BpmFormView.FORM_TYPE_ONLINE_DESIGN.equals( formView.getType())){
    		String templateView=formView.getTemplateView();
        	String template= JsaasUtil.convertToFreemakTemplate(templateView);
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
    		if(StringUtil.isEmpty(formView.getStatus()) ){
    			formView.setStatus(BpmFormView.STATUS_DEPLOYED);
    		}
    		bpmFormViewDao.update(formView);
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
    	if(BpmFormView.TYPE_MOBILE.equals(type)){
    		return fv.getMobileForms();
    	}
    	else if(BpmFormView.TYPE_PRINT.equals(type)){
    		if(StringUtil.isNotEmpty(fv.getPrintForms())){
    			return fv.getPrintForms();
    		}
    		return fv.getCondForms();
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
     * 获取发起流程时的打印表单。
     * @param solId
     * @param actDefId
     * @return
     */
    public List<BpmFormView> getStartPrintFormView(String solId,String actDefId){  
    	return getFormView(solId, actDefId, BpmFormView.SCOPE_START, BpmFormView.TYPE_PRINT,"");
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
     * 获得任务打印表单的配置
     * @param solId
     * @param actDefId
     * @param nodeId
     * @paran instId
     * @return
     */
    public List<BpmFormView> getTaskPrintFormView(String solId,String actDefId,String nodeId,String instId){
    	return getFormView(solId, actDefId, nodeId, BpmFormView.TYPE_PRINT, instId);
    }
    
    
    /**
     * 获得流程解决方案中的明细表单
     * @param solId
     * @return
     */
    public List<BpmFormView> getDetailFormView(String solId,String actDefId,String instId){
    	return getFormView(solId, actDefId, BpmFormView.SCOPE_DETAIL,BpmFormView.TYPE_FORM , instId);
    }
    
    /**
     * 获得流程解决方案中的明细打印表单
     * @param solId
     * @return
     */
    public List<BpmFormView> getDetailPrintFormView(String solId,String actDefId,String instId){
    	return getFormView(solId, actDefId, BpmFormView.SCOPE_DETAIL,BpmFormView.TYPE_PRINT , instId);
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
     * 将表单内容进行一次转换,将子表替换成原生的方式，不在浏览器端转换。
     * @param content
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    public String convertToFreemakTemplate(String content) throws IOException, TemplateException{
    	Document  doc= Jsoup.parseBodyFragment(content);
    
    	
    	//处理表单权限。
    	List<String> permissions= handPermission(doc);
    	
		Elements  elements= doc.select("[plugins=\"rx-grid\"]");
		
		Map<String,String> htmlMap=new HashMap<String, String>();
		
		for(Element el:elements){
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
//		String perm="";
//		for(String permission :permissions){
//			
//			perm+="<#assign " + permission +"="+ permission+"!\"w\">${"+permission +"}\r\n" ;
//		}
//		html=perm +"\r\n" + html;
		
		
		html=html.replace("<!--#if-->","</#if>");
		
		return html;
    }
    
    private List<String> handPermission(Document doc){
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
    private JSONObject getMetaData(Element el){
		//name="grid" edittype="inline"
		JSONObject json=new JSONObject();
		json.put("gridId", el.attr("name"));
		//openwindow,inline,
		String edittype=el.attr("edittype");
		json.put("edittype", el.attr("edittype"));
		
		
		
		json.put("formkey", el.attr("formkey"));
		json.put("formname", el.attr("formname"));
		
		String dataOptions=el.attr("data-options");
		if(StringUtil.isNotEmpty(dataOptions)){
			json.put("dataoptions", dataOptions.substring(1, dataOptions.length()-1));
		}
		else{
			json.put("dataoptions","");
		}
		
	
		json.put("oncellendedit", el.attr("oncellendedit"));
		
		
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
    
    /**
     * 获取pdf模板
     * @param solId
     * @param instId
     * @param jsonStr
     * @return
     * @throws Exception
     */
    public String getSolPDFHtml(String solId,String instId) throws Exception {
		BpmSolution bpmSolution=bpmSolutionManager.get(solId);
		BpmInst bpmInst = bpmInstManager.get(instId);
		
		List<BpmFormView> bpmFormViews = getStartFormView(solId,bpmSolution.getActDefId());
		
		StringBuffer sb = new StringBuffer();
		
		for(BpmFormView bpmFormView:bpmFormViews){
			String actDefId=bpmSolution.getActDefId();
			Map<String,FormViewRight> rightMap=FormUtil.getByStart(bpmFormView.getKey(), actDefId, solId);
			Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
			Map<String,String> rightsMap= FormUtil.calcRights( rightMap,profileMap,false);
			JSONObject jsonData=FormUtil.getData(bpmInst,bpmFormView.getBoDefId());
			String tempHtml=getPDFHtml(rightsMap, bpmFormView.getPdfTemp(),jsonData);
			sb.append(tempHtml);
		}
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("data", sb.toString());
		String html=freemarkEngine.mergeTemplateIntoString("list/exportRowTemp2.ftl", params);
		return html;
	}
    
/*    private String addRightAndData(BpmFormView bpmFormView,BpmSolution bpmSolution) throws Exception{
		String solId=bpmSolution.getSolId();
		String actDefId=bpmSolution.getActDefId();
    	Map<String,FormViewRight> rightMap=FormUtil.getByStart(bpmFormView.getKey(), actDefId, solId);
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();

		Map<String,String> rightsMap= FormUtil.calcRights( rightMap,profileMap,false);
		String pdfTemp = bpmFormView.getPdfTemp();
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("rightsMap", rightsMap);
		String tempHtml=freemarkEngine.mergeTemplateIntoString(pdfTemp, params);

		return tempHtml;
    }*/
    
    /**
     * 构造pdf导出HTML
     * @param rightsMap 权限代码
     * @param pdfTemp PDF模板
     * @param jsonData 数据
     * @return
     * @throws Exception
     */
    public String getPDFHtml(Map<String,String> rightsMap,String pdfTemp,JSONObject jsonData) throws Exception{
		String tempHtml = constructPDFTemp(pdfTemp);
    	Map<String,Object> params = new HashMap<String, Object>();
		params.put("rightsMap", rightsMap);
		params.put("data", jsonData);
		String pdfHtml=freemarkEngine.parseByStringTemplate(params, tempHtml);

    	return pdfHtml;
    }
    
    private String constructPDFTemp(String pdfTemp){
    	Document doc = Jsoup.parse(pdfTemp);
    	Elements ifELs = doc.getElementsByAttribute("rx-if");
    	Elements listELs = doc.getElementsByAttribute("rx-list");
		Iterator<Element> ifIt=ifELs.iterator();
		Iterator<Element> listIt=listELs.iterator();
		while(ifIt.hasNext()){
			Element el = ifIt.next();
			String value = el.attr("rx-if");
			el.before("<#if rightsMap."+value+" != 'none'>");
			el.after("</#if>");
		}
		while(listIt.hasNext()){
			Element el = listIt.next();
			String value = el.attr("rx-list");
			el.before("<#list data."+value+" as obj>");
			el.after("</#list>");
		}
		
		String html = doc.html();
		html = html.replaceAll("&lt;", "<");
		html = html.replaceAll("&gt;", ">");
		html = html.replaceAll("<!--", "</");
		html = html.replaceAll("-->", ">");
		return html;
    }
    
    /**
	    * HTML代码转PDF文档整体html
	    * 
	    * @param content 待转换的HTML代码
	    * @param storagePath 保存为PDF文件的路径
	     * @throws IOException 
	    */
		public  void parsePdf(String content, String storagePath)  {
			FileOutputStream os = null;
			try {
				File file = new File(storagePath);
				if (!file.exists()) {
					file.createNewFile();
				}
				os = new FileOutputStream(file);

				ITextRenderer renderer = new ITextRenderer();
				// 解决中文支持问题
				ITextFontResolver resolver = renderer.getFontResolver();
				resolver.addFont(FileUtil.getWebRootPath()+"/font/simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				renderer.setDocumentFromString(content);
				// 解决图片的相对路径问题,图片路径必须以file开头
				renderer.getSharedContext().setBaseURL("file:/");
				renderer.layout();
				renderer.createPDF(os); 
				
				

			} catch (DocumentException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (null != os){ 
					try {
						os.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
    
}

