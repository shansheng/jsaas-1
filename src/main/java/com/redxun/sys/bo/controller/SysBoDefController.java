
package com.redxun.sys.bo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.BpmMobileForm;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.BpmMobileFormManager;
import com.redxun.core.database.api.ITableOperator;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.controller.BaseMybatisListController;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.dao.SysBoAttrDao;
import com.redxun.sys.bo.dao.SysBoRelationDao;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.bo.manager.SysBoRelationManager;
import com.redxun.sys.bo.manager.parse.BoAttrParseFactory;

/**
 * BO定义控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/bo/sysBoDef/")
public class SysBoDefController extends BaseMybatisListController{
    @Resource
    SysBoDefManager sysBoDefManager;
    @Resource
    BpmFormViewManager bpmFormViewManager;
    @Resource
    BpmMobileFormManager bpmMobileFormManager;
    @Resource
    SysBoEntManager sysBoEntManager;
    @Resource
    BoAttrParseFactory boAttrParseFactory;
    @Resource
    SysBoAttrDao sysBoAttrDao;
    @Resource
    SysBoRelationDao sysBoRelationDao;
    @Resource
    SysBoAttrManager sysBoAttrManager;
    @Resource
    SysBoRelationManager sysBoRelationManager;
    
    @Resource
	private ITableOperator  tableOperator;
    
    
    @RequestMapping("getBoEntities")
    @ResponseBody
    public List<SysBoEnt> getBoEntities(HttpServletRequest request,HttpServletResponse response) throws Exception{
 	   String boDefId=request.getParameter("boDefId");
 	   List<SysBoEnt> sysBoEnts=sysBoEntManager.getEntitiesByBoDefId(boDefId);
 	   for(SysBoEnt ent:sysBoEnts){
 		   List<SysBoAttr> attrs=sysBoAttrManager.getAttrsByEntId(ent.getId());
 		   ent.setSysBoAttrsJson(iJson.toJson(attrs));
 	   }
 	   return sysBoEnts;
    }
    
    @RequestMapping("step1")
    public ModelAndView step1(HttpServletRequest request,HttpServletResponse response) throws Exception{
 	   String boDefId=request.getParameter("boDefId");
 	   SysBoDef sysBoDef=sysBoDefManager.get(boDefId);
 	   return getPathView(request).addObject("sysBoDef",sysBoDef);
    }
    /**
     * 删除某个业务对象定义下的业务实体对象
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("delEntByIds")
    @ResponseBody
    public JsonResult delEntByIds(HttpServletRequest request,HttpServletResponse response) throws Exception{
 	   String entIds=request.getParameter("entIds");
 	   String boDefId=request.getParameter("boDefId");
 	   if(StringUtils.isNotEmpty(entIds)){
 		   String[]ids=entIds.split("[,]");
 		   for(int i=0;i<ids.length;i++){
 			   sysBoEntManager.delByBoEntIdBoDefId(boDefId,ids[i]);
 		   }
 	   }
 	   return new JsonResult(true,"成功删除数据！");
    }
    
    /**
     * 保存业务定义配置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("saveBoDef")
    @ResponseBody
    public JsonResult saveBoDef(HttpServletRequest request,HttpServletResponse response) throws Exception{
 	   String boDefJson=request.getParameter("boDefJson");
 	   String sysBoEnties=request.getParameter("sysBoEnties");
 	   
 	   SysBoDef sysBoDef=JSONObject.parseObject(boDefJson, SysBoDef.class);
 	   //1.处理业务定义
 	   if(StringUtils.isNotEmpty(sysBoDef.getId())){
 		   SysBoDef tmpBoDef=sysBoDefManager.get(sysBoDef.getId());
 		   BeanUtil.copyNotNullProperties(tmpBoDef, sysBoDef);
 		   sysBoDefManager.update(tmpBoDef);
 	   }else{
 		   sysBoDef.setId(idGenerator.getSID());
 		   sysBoDefManager.create(sysBoDef);
 	   }
 	   
 	   //2.处理业务实体对象
 	   JSONArray sysBoEntArr=JSONObject.parseArray(sysBoEnties);
 	   for(int i=0;i<sysBoEntArr.size();i++){
 		   JSONObject jsonObj=sysBoEntArr.getJSONObject(i);
 		   SysBoEnt sysBoEnt=jsonObj.toJavaObject(SysBoEnt.class);
 		   String pkId=jsonObj.getString("id");
 		   SysBoRelation sysBoRelation=null;
 		   if(StringUtils.isNotEmpty(pkId)){
 			   sysBoEnt.setId(pkId);
 			  sysBoEntManager.update(sysBoEnt);
 			 //2.1 处理实体的关系
 			 sysBoRelation=sysBoRelationManager.getByDefEntId(sysBoDef.getId(),pkId);
 			 if(sysBoRelation!=null){
 				 sysBoRelation.setRelationType(sysBoEnt.getRelationType());
 				 sysBoRelation.setMainField(sysBoEnt.getMainField());
 				 sysBoRelation.setSubField(sysBoEnt.getSubField());
 				 sysBoRelationManager.update(sysBoRelation);
 			 }
 		   }else{
 			   sysBoEnt.setId(idGenerator.getSID());
 			   sysBoEntManager.create(sysBoEnt);
 		   }
 		   
 		   //处理实体的关系
 		   if(sysBoRelation==null){
 		   		sysBoRelation=new SysBoRelation();
 			 sysBoRelation.setBoDefid(sysBoDef.getId());
 			 sysBoRelation.setBoEntid(sysBoEnt.getId());
 			 sysBoRelation.setRelationType(sysBoEnt.getRelationType());
 			 sysBoRelation.setMainField(sysBoEnt.getMainField());
 			 sysBoRelation.setSubField(sysBoEnt.getSubField());
 			 sysBoRelation.setIsRef(0);
 			 sysBoRelation.setId(idGenerator.getSID());
 			 sysBoRelationManager.create(sysBoRelation);
 		   }
 		   JSONArray sysBoAttrsArr=jsonObj.getJSONArray("sysBoAttrsJson");
 		   //处理实体的字段存储
 		   for(int c=0;c<sysBoAttrsArr.size();c++){
 			   JSONObject boAttObj=sysBoAttrsArr.getJSONObject(c);
 			   SysBoAttr fieldAttr=boAttObj.toJavaObject(SysBoAttr.class);
 			   String attId=boAttObj.getString("id");
 			   fieldAttr.setEntId(sysBoEnt.getId());
 			   fieldAttr.setId(attId);
 			   if(StringUtils.isNotEmpty(attId)){
 				   sysBoAttrManager.update(fieldAttr);
 			   }else{
 				   fieldAttr.setId(idGenerator.getSID());
 				   sysBoAttrManager.create(fieldAttr);
 			   }
 		   }
 	   }
 	   
 	   return new JsonResult(true,"成功更新业务对象定义！");
    }

   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysBoDefManager.delete(id);
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
        SysBoDef sysBoDef=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysBoDef=sysBoDefManager.get(pkId);
        }else{
        	sysBoDef=new SysBoDef();
        }
        return getPathView(request).addObject("sysBoDef",sysBoDef);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysBoDef sysBoDef=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysBoDef=sysBoDefManager.get(pkId);
    	}else{
    		String treeId=RequestUtil.getString(request, "treeId");
    		sysBoDef=new SysBoDef();
    		sysBoDef.setTreeId(treeId);
    	}
    	return getPathView(request).addObject("sysBoDef",sysBoDef);
    }
    
    
    @RequestMapping("getJson")
    @ResponseBody
    public  JSONObject  getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	IFormDataHandler handler=BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_JSON);
		if(handler!=null){
			return handler.getInitData(pkId);
		}
		return null;
    }
    
    @RequestMapping("getHelpJson")
    @ResponseBody
    public  JSONObject  getHelpJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysBoDef boDef=this.sysBoDefManager.get(pkId);
    	if(boDef==null){
    		JSONObject json=new JSONObject();
    		json.put("alias", "没找到BO定义");
    		json.put("params", "{}");
    		return json;
    	}
    	JSONObject json=new JSONObject();
    	json.put("alias", boDef.getAlais());
    	
    	IFormDataHandler handler=BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_JSON);
		
		JSONObject jsonObj= handler.getInitData(pkId);
		json.put("params", jsonObj);
    	
		return json;
    }
    
    
    @RequestMapping("getBoDefJson")
    @ResponseBody
    public  JSONObject  getBoDefJson(HttpServletRequest request) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysBoDef boDef=sysBoDefManager.get(pkId);
    	List<SysBoEnt> boEnts= sysBoEntManager.getListByBoDefId(pkId, false);
    	
    	JSONObject jsonObj=(JSONObject) JSONObject.toJSON(boDef);
    	
    	JSONArray subJsonAry=new JSONArray();
    	
    	for(SysBoEnt boEnt:boEnts){
    		if(SysBoRelation.RELATION_MAIN.equals( boEnt.getRelationType())){
    			jsonObj.put("mainEntId", boEnt.getId());
    			jsonObj.put("mainEntName", boEnt.getComment());
    		}
    		else{
    			JSONObject subJson=new JSONObject();
    			subJson.put("entId", boEnt.getId());
    			subJson.put("entName", boEnt.getComment());
    			subJson.put("relateType", boEnt.getRelationType());
    			
    			subJsonAry.add(subJson);
    		}
    	}
    	
    	if(subJsonAry.size()>0){
    		jsonObj.put("subEnts",subJsonAry);
    	}
    	
    	return jsonObj;
    }
    

 
    
    @RequestMapping("getRelForm")
    @ResponseBody
    public  JSONObject  getRelForm(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	//pc表单
    	QueryFilter filter=  new QueryFilter();
		filter.addFieldParam("BO_DEFID_",pkId);
		List<BpmFormView> formViews = bpmFormViewManager.getQuery(filter);
		//手机表单
		List<BpmMobileForm> mobileforms = bpmMobileFormManager.getByBoDefId(pkId);
		//pc表单
		JSONArray formAry=new JSONArray();
		for(BpmFormView view:formViews){
			JSONObject obj=new JSONObject();
			obj.put("id", view.getViewId());
			obj.put("name", view.getName());
			obj.put("alias", view.getKey());
			formAry.add(obj);
		}
		//手机表单	
		JSONArray mobileAry=new JSONArray();
		for(BpmMobileForm view:mobileforms){
			JSONObject obj=new JSONObject();
			obj.put("id", view.getId());
			obj.put("name", view.getName());
			obj.put("alias", view.getAlias());
			mobileAry.add(obj);
		}
		
		JSONObject rtnObj=new JSONObject();
		
		rtnObj.put("pc",formAry);
		rtnObj.put("mobile",mobileAry);
    	
		return rtnObj;
    	
    	
    }
    
    @RequestMapping("getBoJson")
    @ResponseBody
    public  JSONObject  getBoJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String boDefId=RequestUtil.getString(request, "boDefId");
    	List<SysBoEnt> list=sysBoEntManager.getListByBoDefId(boDefId,true);
    	SysBoDef boDef=sysBoDefManager.get(boDefId);
    	
    	JSONObject json=new JSONObject();
    	
    	json.put("list", list);
    	json.put("hasGen", boDef.getSupportDb());
    	json.put("boDefId", boDefId);
    	
		return json;
    	
    	
    }
    
    @RequestMapping("manage")
    @ResponseBody
    public  ModelAndView  manage(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String boDefId=RequestUtil.getString(request, "boDefId");
    	com.alibaba.fastjson.JSONObject json= boAttrParseFactory.getPluginDesc();
		ModelAndView mv = getPathView(request);
		mv.addObject("json", json);
		mv.addObject("boDefId", boDefId);
		return mv;
    }
    
    @RequestMapping("removeAttr")
    @ResponseBody
    public  JsonResult<Void>  removeAttr(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String attrId=RequestUtil.getString(request, "attrId");
    	JsonResult<Void> rtn=new JsonResult<Void>(true, "删除列成功!");
    	try{
    		sysBoEntManager.removeAttr(attrId);
    	}
    	catch (Exception e) {
    		rtn=new JsonResult<Void>(false, "删除列失败!");
		}
		
		return rtn;
    }
    
    @RequestMapping("removeEnt")
    @ResponseBody
    public JsonResult<Void> removeEnt(HttpServletRequest request,HttpServletResponse response) {
    	String boDefId=RequestUtil.getString(request, "boDefId");
    	String entId=RequestUtil.getString(request, "entId");
    	JsonResult<Void> json=new JsonResult<Void>(true,"删除BO实体成功!");
    	SysBoDef boDef=sysBoDefManager.get(boDefId);
    	SysBoEnt boEnt=sysBoEntManager.get(entId);
    	boolean genTable=SysBoDef.BO_YES.equals(boDef.getSupportDb());
    	SysBoRelation boRelation=sysBoRelationDao.getByDefEntId(boDefId, entId);
    	try{
    		//删除表
        	if(genTable && boRelation.getIsRef()!=1){
        		//删除物理表
        		tableOperator.dropTable(boEnt.getTableName());
        	}
        	
        	//删除关系和实体定义。
        	if(boRelation.getIsRef()!=1){
        		sysBoEntManager.delete(entId);
        		sysBoAttrDao.delByMainId(entId);
        	}
        	sysBoRelationDao.delete(boRelation.getId());
    	}
    	catch (Exception e) {
			json=new JsonResult<Void>(false, ExceptionUtil.getExceptionMessage(e));
		}
    	return json;
    	
    }

	@SuppressWarnings("rawtypes")
	@Override
	public ExtBaseManager getBaseManager() {
		return sysBoDefManager;
	}
	
	@RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult save(HttpServletRequest request,@RequestBody JSONObject jsonObj , BindingResult result) {
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        JsonResult rtn=null;
		try {
			rtn = sysBoDefManager.save(jsonObj);
		} catch (Exception e) {
			rtn=new JsonResult(false,ExceptionUtil.getExceptionMessage(e));
		}
      
        return rtn;
    }
	
	@RequestMapping(value = "removeByDefId")
    @ResponseBody
    public JsonResult removeByDefId(@RequestParam(value="defIds") String defIds ) {
        JsonResult rtn=sysBoDefManager.removeByDefId(defIds);
        return rtn;
    }
	
	private JSONObject getByAttr(SysBoAttr attr,SysBoEnt boEnt){
		JSONObject obj=new JSONObject();
		
		JSONObject jsonType=new JSONObject();
		jsonType.put("varchar", "icon-varchar");
		jsonType.put("clob", "icon-clob");
		jsonType.put("date", "icon-date");
		jsonType.put("number", "icon-number");
		
		obj.put("name", attr.getName());
		obj.put("comment", attr.getComment());
		obj.put("dateType", attr.getDataType());
		obj.put("isField", true);
		obj.put("entName", boEnt.getName());
		obj.put("type", boEnt.getRelationType());
		obj.put("boEntId", boEnt.getId());
		obj.put("attrId", attr.getId());
		obj.put("iconCls", jsonType.getString(attr.getDataType()));

		return obj;
	}
	
	/**
	 * 取得主体Bo及其子Bo属性
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("getBosByDefId")
	@ResponseBody
	public JSONArray getBosByDefId(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String pkId=RequestUtil.getString(request, "boDefId");
    	SysBoEnt boEnt= sysBoEntManager.getByBoDefId(pkId, true);
    	JSONArray jsonAry=new JSONArray();
    	JSONObject mainTable=new JSONObject();
    	mainTable.put("name", boEnt.getName());
    	mainTable.put("comment", "主表-"+boEnt.getComment());
    	mainTable.put("isMain", true);
    	jsonAry.add(mainTable);
    	List<SysBoEnt> boEnts=boEnt.getBoEntList();
    	for(SysBoEnt ent:boEnts){
    		JSONObject subTable=new JSONObject();
    		subTable.put("name", ent.getName());
    		subTable.put("comment", "从表-"+ent.getComment());
    		subTable.put("isMain", false);
    		jsonAry.add(subTable);
    	}
    	return jsonAry;
	}
	
	@RequestMapping("getBoAttrsByBoDefIdAttName")
	@ResponseBody
	public JSONArray getBoAttrsByBoDefIdAttName(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String boDefId=RequestUtil.getString(request, "boDefId");
		String boName=RequestUtil.getString(request, "boName");
		SysBoEnt boEnt=sysBoEntManager.getSubEntByMainBoDefId(boDefId, boName);
		JSONArray attrsArr=new JSONArray();
		if(boEnt==null){
			return attrsArr;
		}
		
		for(SysBoAttr attr:boEnt.getSysBoAttrs()){
    		JSONObject obj=getByAttr(attr, boEnt);
    		attrsArr.add(obj);
    	}
		
		return attrsArr;
	}
	
	/**
	 * 构建JSON 结构。
	 * [
	 * 	{"name":"","comment":"","dateType":"","isField":true,type:"main"},
	 *  {"name":"","comment":"","dateType":"","isField":true,type:"main"},
	 *  {"name":"","comment":"","dateType":"","isField":false,type:"sub",
	 *  	children:[
	 *  		{"name":"","comment":"","dateType":"","isField":true,type:"sub"},
	 *  		{"name":"","comment":"","dateType":"","isField":true,type:"sub"}
	 *  	]
	 *  }
	 * ]
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getBoDefConstruct")
    @ResponseBody
    public  JSONArray  getBoDefConstruct(HttpServletRequest request) throws Exception{
    	String pkId=RequestUtil.getString(request, "boDefId");
    	Boolean isMain=RequestUtil.getBoolean(request, "isMain",false);
    	String entName=RequestUtil.getString(request, "entName");
    	JSONArray jsonAry=getBoDefConstruct(pkId, isMain, entName);
    	return jsonAry;
    }
	
	
	private JSONArray getBoDefConstruct(String boDefId,boolean isMain,String entName){
		SysBoEnt  boEnt= sysBoEntManager.getByBoDefId(boDefId, true);
		
		sysBoEntManager.removeEntRefFields(boEnt);
		
    	List<SysBoAttr> attrs=boEnt.getSysBoAttrs();
    	
    	JSONArray jsonAry=new JSONArray();
    	
    	for(SysBoAttr attr:attrs){
    		JSONObject obj=getByAttr(attr, boEnt);
    		jsonAry.add(obj);
    	}
    	//只要主表
    	if(isMain) return jsonAry;
    	
    	List<SysBoEnt> boEnts=boEnt.getBoEntList();
    	for(SysBoEnt ent:boEnts){
    		if(StringUtil.isEmpty(entName)){
    			JSONObject entJson= getByEnt(ent);
        		jsonAry.add(entJson);
    		}
    		//非空。
    		else{
    			if(entName.equals(ent.getName())){
    				JSONObject entJson= getByEnt(ent);
            		jsonAry.add(entJson);
    			}
    		}
    	}
    	return jsonAry;
	}
	
	private JSONObject getByEnt(SysBoEnt ent){
		JSONObject entJson=new JSONObject();
		
		entJson.put("name", ent.getName());
		entJson.put("comment", ent.getComment());
		entJson.put("dateType", "");
		entJson.put("isField", false);
		entJson.put("type", ent.getRelationType());
		entJson.put("boEntId", ent.getId());
		entJson.put("iconCls", "icon-table");
		
		List<SysBoAttr> boAttrs=ent.getSysBoAttrs();
		
		JSONArray subAry=new JSONArray();
		
		for(SysBoAttr attr:boAttrs){
    		JSONObject obj=getByAttr(attr, ent);
    		subAry.add(obj);
    		entJson.put("children", subAry);
    	}
		return entJson;
	}
	
	
	

}
