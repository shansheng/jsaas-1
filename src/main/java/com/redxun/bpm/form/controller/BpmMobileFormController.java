package com.redxun.bpm.form.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.dao.BpmFormViewDao;
import com.redxun.bpm.form.entity.BpmFormTemplate;
import com.redxun.bpm.form.entity.BpmMobileForm;
import com.redxun.bpm.form.manager.BpmFormTemplateManager;
import com.redxun.bpm.form.manager.BpmMobileFormManager;
import com.redxun.bpm.form.manager.FormConstants;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;

import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;

/**
 * [BpmMobileForm]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/form/bpmMobileForm/")
public class BpmMobileFormController extends BaseListController{
    @Resource
    BpmMobileFormManager bpmMobileFormManager;
    @Resource
    BpmFormViewDao bpmFormViewDao ;
    @Resource
    BpmFormTemplateManager bpmFormTemplateManager ; 
    @Resource
    FreemarkEngine freemarkEngine;
    @Resource
    SysBoEntManager sysBoEntManager;
    @Resource
    SysTreeManager sysTreeManager;
   
    
    @Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter filter= QueryFilterBuilder.createQueryFilter(request);
		String tenantId=ContextUtil.getCurrentTenantId();
		filter.addFieldParam("a.TENANT_ID_", tenantId);
		return filter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "手机业务表单视图")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmMobileFormManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
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
        String pkId=request.getParameter("pkId");
        BpmMobileForm bpmMobileForm=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmMobileForm=bpmMobileFormManager.get(pkId);
        }else{
        	bpmMobileForm=new BpmMobileForm();
        }
        return getPathView(request).addObject("bpmMobileForm",bpmMobileForm);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmMobileForm bpmMobileForm=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmMobileForm=bpmMobileFormManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmMobileForm.setId(null);
    		}
    	}else{
    		bpmMobileForm=new BpmMobileForm();
    	}
    	ModelAndView mv= getPathView(request).addObject("bpmMobileForm",bpmMobileForm);
    	if(StringUtils.isNotEmpty(bpmMobileForm.getTreeId())){
    		SysTree sysTree=sysTreeManager.get(bpmMobileForm.getTreeId());
    		if(sysTree!=null){
    			mv.addObject("treeName",sysTree.getName());
    		}
    	}

    	return mv;
    }
    
	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmMobileFormManager;
	}
	
	
	@RequestMapping("generate")
    public ModelAndView generate(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String boDefId=RequestUtil.getString(request, "boDefId") ;
        String templates=RequestUtil.getString(request, "templates") ;
        ModelAndView mv= getPathView(request);
        mv.addObject("boDefId", boDefId);
        mv.addObject("templates", templates);
        return mv;
    }
	
	@RequestMapping("generateHtml")
	@ResponseBody
	public String generateHtml(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String boDefId=RequestUtil.getString(request, "boDefId") ;
        String templates=RequestUtil.getString(request, "templates") ;
        String html= genTemplate(boDefId,templates);
        return html;
    }
	
	@RequestMapping("generateAllHtml")
	@ResponseBody
	public JsonResult generateAllHtml(HttpServletRequest request,HttpServletResponse response) throws Exception{
		List<BpmMobileForm> bpmMobileForms=bpmMobileFormManager.getAll();
		for(BpmMobileForm bpmMobileForm:bpmMobileForms){
			String boDefId=bpmMobileForm.getBoDefId();
	        String type="mobile"; 
	        
	        SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
	        
	        List<BpmFormTemplate> mainForms=bpmFormTemplateManager.getTemplateByType(SysBoRelation.RELATION_MAIN, type);
	        
	        List<BpmFormTemplate> subOneToOneForms=bpmFormTemplateManager.getTemplateByType(SysBoRelation.RELATION_ONETOONE, type);
	        
	        List<BpmFormTemplate> subOneToManyForms=bpmFormTemplateManager.getTemplateByType(SysBoRelation.RELATION_ONETOMANY, type);
	        
	        JSONObject mainAry= getFirstJsonByTemplates(mainForms);
	        JSONObject subOneAry= getFirstJsonByTemplates(subOneToOneForms);
	        JSONObject subManyAry= getFirstJsonByTemplates(subOneToManyForms);
	        
	        JSONObject rtnJson=new JSONObject();
	        
	        JSONObject mainJson=new JSONObject();
	        mainJson.put(boEnt.getName(), mainAry.getString("alias"));
	        
	        rtnJson.put("main",mainJson);
	        
	        JSONArray subs= new JSONArray();

	        if(BeanUtil.isNotEmpty( boEnt.getBoEntList())){
	        	for(SysBoEnt subEnt: boEnt.getBoEntList()){
	        		JSONObject subJson=new JSONObject();
	            	if(SysBoRelation.RELATION_ONETOONE.equals(subEnt.getRelationType())){
	            		subJson.put(subEnt.getName(), subOneAry.getString("alias"));
	            	}
	            	else{
	            		subJson.put(subEnt.getName(), subManyAry.getString("alias"));
	            	}
	            	subs.add(subJson);
	            }
	        }
	        rtnJson.put("sub",subs);
	        String templates=rtnJson.toString();
			String template=genTemplate(boDefId,templates);
	        bpmMobileForm.setFormHtml(template);
            bpmMobileFormManager.update(bpmMobileForm);
		}
        return new JsonResult(true,"成功生成！");
    }
	
    /**
     * 获取第一个模板
     * @param forms
     * @return
     */
    private JSONObject getFirstJsonByTemplates(List<BpmFormTemplate> forms){
    	JSONObject ary=new JSONObject();
    	if(forms==null||forms.size()==0) return ary;
    	BpmFormTemplate template=forms.get(0);
		JSONObject obj=new JSONObject();
		obj.put("alias", template.getAlias());
		obj.put("name", template.getName());
    	return obj;
    }
	
	/**
	 * {
	 * 	main:{boname:""},
	 *  sub:[
	 *  	table1:"template1",
	 *  	table2:"template1"
	 *  
	 *  ]
	 * }
	 * @param boDefId
	 * @param templates
	 * @return
	 * @throws TemplateException
	 * @throws IOException
	 */
	private String genTemplate(String boDefId,String templates) throws TemplateException, IOException{
		
		SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
        
        JSONObject jsonObj=JSONObject.parseObject(templates);
        
        //获取主模版
        String mainAlias=jsonObj.getJSONObject("main").getString(boEnt.getName());
        
        StringBuffer sb=new StringBuffer();
        
        BpmFormTemplate formTemplate= bpmFormTemplateManager.getTemplateByAlias(mainAlias, FormConstants.FORM_MOBILE);
        BpmFormTemplate fieldTemplate= bpmFormTemplateManager.getFieldTemplateByType(FormConstants.FORM_MOBILE);
        
        Map<String,Object> model=new HashMap<String,Object>();
        
        model.put("ent", boEnt);
        
        TemplateHashModel util=FreemakerUtil.getTemplateModel(this.getClass());
        model.put("Util", util);
        
        //计算公式。
        JSONObject formulaJson=getFormula(boEnt);
        model.put("formula", formulaJson.toJSONString());
        //计算日期。
        JSONObject dateCalcJson=getDateCalc(boEnt);
        model.put("datecalc", dateCalcJson.toJSONString());
        //配置扩展JSON
        JSONObject extJson=getExtJson(boEnt);
        model.put("extJson", extJson.toJSONString());
        //获取校验规则。
        String validRule=getValidRule(boEnt);
        model.put("validRule", validRule);
        //boDefId
        model.put("boDefId", boDefId);
        
        
        sb.append(freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + formTemplate.getTemplate()));
        
        //子表处理
        JSONArray ary= jsonObj.getJSONArray("sub");
        if(BeanUtil.isEmpty(ary)){
        	return sb.toString();
        }
        
        List<SysBoEnt> entList=boEnt.getBoEntList();
    	for(int i=0;i<ary.size();i++){
    		JSONObject json=ary.getJSONObject(i);
    		for(SysBoEnt ent:entList){
    			String key=ent.getName();
    			if(!json.containsKey(key)) continue;
    			
				String template=json.getString(key);
				BpmFormTemplate subTemplate= bpmFormTemplateManager.getTemplateByAlias(template, FormConstants.FORM_MOBILE);
        		model.put("ent", ent);
                
                sb.append(freemarkEngine.parseByStringTemplate(model, fieldTemplate.getTemplate() + subTemplate.getTemplate()));
    		}
    	}
        return sb.toString();
	}
	
	/**
	 * 取出字段配置。
	 * @param field
	 * @return
	 */
	private static String getFormula(SysBoAttr field){
		if(StringUtil.isEmpty(field.getExtJson())) return "";
		JSONObject obj=JSONObject.parseObject(field.getExtJson());
		if(!obj.containsKey("conf")) return "";
		
		JSONObject json=obj.getJSONObject("conf");
		if(json.containsKey("formula")) {
			String formula= json.getString("formula");
			return formula;
		};
			
		return "";
	}
	
	/**
	 * 日期计算格式
	 * {start:start,end:end,dateUnit:dateUnit}
	 * @param field
	 * @return
	 */
	private static String getDateCalc(SysBoAttr field){
		if(StringUtil.isEmpty(field.getExtJson())) return "";
		JSONObject obj=JSONObject.parseObject(field.getExtJson());
		if(!obj.containsKey("conf")) return "";
		
		JSONObject json=obj.getJSONObject("conf");
		if(json.containsKey("datecalc")) {
			String datecalc= json.getString("datecalc");
			return datecalc;
		};
		return "";
	}
	
	private static JSONObject getAttrValidRule(SysBoAttr field){
		if(StringUtil.isEmpty(field.getExtJson())) return null;
		JSONObject obj=JSONObject.parseObject(field.getExtJson());
		boolean flag=false;
		JSONObject tmpObj=new JSONObject();
		if(obj.containsKey("required")) {
			flag=true;
			if("true".equals(obj.getString("required"))){
				tmpObj.put("required", true);
			}else{
				tmpObj.put("required", false);
			}
		}
		if(obj.containsKey("vtype")) {
			flag=true;
			tmpObj.put("vtype", obj.getString("vtype"));
		}
		if(obj.containsKey("validrule")) {
			flag=true;
			tmpObj.put("vtype", obj.getString("validrule"));
		}
		if(!flag) return null;
		
		return tmpObj;
		
	}
	
	private static String getValidRule(SysBoEnt ent){
		JSONObject json=new JSONObject();
		for(SysBoAttr attr:ent.getSysBoAttrs()){
			JSONObject rule=getAttrValidRule(attr);
			if(rule!=null){
				JSONObject tmp=new JSONObject();
				if(json.containsKey("main")){
					tmp=  json.getJSONObject("main");
				}
				tmp.put(attr.getName(), rule);
				json.put("main", tmp);
			}
		}
		
		for(SysBoEnt subEnt:ent.getBoEntList()){
			for(SysBoAttr attr:subEnt.getSysBoAttrs()){
				JSONObject rule=getAttrValidRule(attr);
				if(rule!=null){
					JSONObject tmp=new JSONObject();
					if(json.containsKey(subEnt.getName())){
						tmp=  json.getJSONObject(subEnt.getName());
					}
					tmp.put(attr.getName(), rule);
					json.put(subEnt.getName(), tmp);
				}
			}
		}
		return json.toJSONString();
	}
	
	
	
	/**
	 * 返回公式。
	 * @param ent
	 * @return
	 */
	private static JSONObject getFormula(SysBoEnt ent){
		JSONObject json=new JSONObject();
		
		for(SysBoAttr attr:ent.getSysBoAttrs()){
			String formula=getFormula(attr);
			if(StringUtil.isNotEmpty(formula)){
				JSONObject tmp=new JSONObject();
				if(json.containsKey("main")){
					tmp=  json.getJSONObject("main");
				}
				tmp.put(attr.getName(), formula);
				json.put("main", tmp);
			}
		}
		
		for(SysBoEnt subEnt:ent.getBoEntList()){
			for(SysBoAttr attr:subEnt.getSysBoAttrs()){
				String formula=getFormula(attr);
				if(StringUtil.isNotEmpty(formula)){
					JSONObject tmp=new JSONObject();
					if(json.containsKey(subEnt.getName())){
						tmp=  json.getJSONObject(subEnt.getName());
					}
					tmp.put(attr.getName(), formula);
					json.put(subEnt.getName(), tmp);
				}
			}
		}
		
		
		return json;
	}
	
	/**
	 * 返回日期运算公式。
	 * {
	 * 	main:{
	 * 		field1:{start:start,end:end,dateUnit:dateUnit}
	 * 	}
	 * 	zibiao1:{
	 * 		field1:{start:start,end:end,dateUnit:dateUnit}
	 * 	}
	 * }
	 * @param ent
	 * @return
	 */
	private static JSONObject getDateCalc(SysBoEnt ent){
		JSONObject json=new JSONObject();
		
		for(SysBoAttr attr:ent.getSysBoAttrs()){
			String datecalc=getDateCalc(attr);
			if(StringUtil.isNotEmpty(datecalc)){
				JSONObject tmp=new JSONObject();
				if(json.containsKey("main")){
					tmp=  json.getJSONObject("main");
				}
				tmp.put(attr.getName(), datecalc);
				json.put("main", tmp);
			}
		}
		
		for(SysBoEnt subEnt:ent.getBoEntList()){
			for(SysBoAttr attr:subEnt.getSysBoAttrs()){
				String datecalc=getDateCalc(attr);
				if(StringUtil.isNotEmpty(datecalc)){
					JSONObject tmp=new JSONObject();
					if(json.containsKey(subEnt.getName())){
						tmp=  json.getJSONObject(subEnt.getName());
					}
					tmp.put(attr.getName(), datecalc);
					json.put(subEnt.getName(), tmp);
				}
			}
		}
		
		
		return json;
	}
	
	
	/**
	 * 获取实体的扩展JSON。
	 * @param ent
	 * @return
	 */
	private static JSONObject getExtJson(SysBoEnt ent){
		JSONObject json=new JSONObject();
		
		if(StringUtil.isNotEmpty(ent.getExtJson())){
			json.put("main", ent.getExtJson());
		}
		
		for(SysBoEnt subEnt:ent.getBoEntList()){
			if(StringUtil.isNotEmpty(subEnt.getExtJson())){
				json.put(subEnt.getName(), subEnt.getExtJson());
			}
		}
		
		
		return json;
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
	
	@RequestMapping("getById")
	@ResponseBody
    public BpmMobileForm getById(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("id");
        BpmMobileForm bpmMobileForm=bpmMobileFormManager.get(pkId);
        return bpmMobileForm;
    }

	
	
	@RequestMapping("getByBoDefId")
	@ResponseBody
	public List<BpmMobileForm> getByBoDefId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boDefId=RequestUtil.getString(request, "boDefIds");
		List<BpmMobileForm> forms = bpmMobileFormManager.getByBoDefId(boDefId);
		return forms;
	}
	
	
	

}
