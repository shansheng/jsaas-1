package com.redxun.bpm.form.controller;

import java.util.List;

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
import com.redxun.bpm.form.entity.BpmFormTemplate;
import com.redxun.bpm.form.manager.BpmFormTemplateManager;
import com.redxun.bpm.form.manager.FormConstants;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmFormTemplate]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/form/bpmFormTemplate/")
public class BpmFormTemplateController extends BaseListController{
    @Resource
    BpmFormTemplateManager bpmFormTemplateManager;
    @Resource
    SysBoEntManager sysBoEntManager;
    
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "表单模板")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmFormTemplateManager.delete(id);
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
        BpmFormTemplate bpmFormTemplate=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmFormTemplate=bpmFormTemplateManager.get(pkId);
        }else{
        	bpmFormTemplate=new BpmFormTemplate();
        }
        return getPathView(request).addObject("bpmFormTemplate",bpmFormTemplate);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmFormTemplate bpmFormTemplate=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmFormTemplate=bpmFormTemplateManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmFormTemplate.setId(null);
    		}
    	}else{
    		bpmFormTemplate=new BpmFormTemplate();
    	}
    	return getPathView(request).addObject("bpmFormTemplate",bpmFormTemplate);
    }
    
    @RequestMapping("init")
    @ResponseBody
    @LogEnt(action = "init", module = "流程", submodule = "表单模板")
    public JsonResult init(HttpServletRequest request,HttpServletResponse response) throws Exception{
        try{
        	bpmFormTemplateManager.init();
        	return new JsonResult(true,"初始化成功！");
        }
        catch(Exception ex){
        	return new JsonResult(false,"初始化失败！");
        }
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmFormTemplateManager;
	}
	
	 /**
     *[{type:"main",key:"",name:"表单名称",temlate:[{alias:"alias",name:"模版名称"}]},
     * {type:"sub",key:"",name:"表单名称",temlate:[{alias:"alias",name:"模版名称"}]}
     * {type:"sub",key:"",name:"表单名称",temlate:[{alias:"alias",name:"模版名称"}]}]
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getTemplatesByBoDef")
    @ResponseBody
    public JSONArray getTemplatesByBoDef(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String boDefId=RequestUtil.getString(request, "boDefId");
        String type=RequestUtil.getString(request, "type"); 
        
        SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
        
        List<BpmFormTemplate> mainForms=bpmFormTemplateManager.getTemplateByType(SysBoRelation.RELATION_MAIN, type);
        
        List<BpmFormTemplate> subOneToOneForms=bpmFormTemplateManager.getTemplateByType(SysBoRelation.RELATION_ONETOONE, type);
        
        List<BpmFormTemplate> subOneToManyForms=bpmFormTemplateManager.getTemplateByType(SysBoRelation.RELATION_ONETOMANY, type);
        
        JSONArray mainAry= getJsonByTemplates(mainForms);
        JSONArray subOneAry= getJsonByTemplates(subOneToOneForms);
        JSONArray subManyAry= getJsonByTemplates(subOneToManyForms);
        
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
        		subJson.put("type", subEnt.getRelationType());
            	subJson.put("key", subEnt.getName());
            	subJson.put("name", subEnt.getComment());
            	if(SysBoRelation.RELATION_ONETOONE.equals(subEnt.getRelationType())){
            		subJson.put("template", subOneAry);
            	}
            	else{
            		subJson.put("template", subManyAry);
            	}
            	rtnJson.add(subJson);
            }
        }
        return rtnJson;
        
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
     * 根据类别和类型获取模版列表。
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getByCategory")
    @ResponseBody
    public JSONArray getByCategory(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String category=RequestUtil.getString(request, "category");
    	String type=RequestUtil.getString(request, "type");
    	List<BpmFormTemplate> templates=bpmFormTemplateManager.getTemplateByType(category, type);
    	JSONArray jsonAry= getJsonByTemplates(templates);
    	return jsonAry;
    }

}
