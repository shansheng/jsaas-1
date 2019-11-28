
package com.redxun.bpm.form.controller;

import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.entity.FormValidRule;
import com.redxun.bpm.form.manager.FormValidRuleManager;
import com.redxun.bpm.form.service.IValidRule;
import com.redxun.bpm.form.service.ValidRuleFactory;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.customform.entity.SysCustomFormSetting;
import com.redxun.sys.customform.manager.SysCustomFormSettingManager;
import com.redxun.sys.log.LogEnt;

/**
 * FORM_VALID_RULE控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/form/formValidRule/")
public class FormValidRuleController extends MybatisListController{
    @Resource
    FormValidRuleManager formValidRuleManager;
    @Resource
    SysCustomFormSettingManager sysCustomFormSettingManager;
    @Resource
    SysBoEntManager sysBoEntManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "bpm", submodule = "FORM_VALID_RULE")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                formValidRuleManager.delete(id);
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
        FormValidRule formValidRule=null;
        if(StringUtils.isNotEmpty(pkId)){
           formValidRule=formValidRuleManager.get(pkId);
        }else{
        	formValidRule=new FormValidRule();
        }
        return getPathView(request).addObject("formValidRule",formValidRule);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	FormValidRule formValidRule=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		formValidRule=formValidRuleManager.get(pkId);
    	}else{
    		formValidRule=new FormValidRule();
    	}
    	return getPathView(request).addObject("formValidRule",formValidRule);
    }
    
    @RequestMapping("getValidRules")
    @ResponseBody
    public JSONArray getValidRules(HttpServletRequest  request,HttpServletResponse response){
    	ValidRuleFactory factory = AppBeanUtil.getBean(ValidRuleFactory.class);
    	final JSONArray array = new JSONArray();
    	Map<String,IValidRule> map = factory.getRuleMap();
    	map.forEach(new BiConsumer<String,IValidRule>() {
    		@Override
    		public void accept(String t, IValidRule u) {
    			JSONObject obj = new JSONObject();
    			obj.put("alias",t);
    			obj.put("ruleName",u.getName());
    			array.add(obj);
    		}
    	});
    	return array;
    }
    
    @RequestMapping("setting")
    public ModelAndView setting(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	ModelAndView mv = getPathView(request);
    	String setId=RequestUtil.getString(request, "setId");
    	SysCustomFormSetting sysCustomFormSetting=null;
    	if(StringUtils.isNotEmpty(setId)){
    		sysCustomFormSetting=sysCustomFormSettingManager.get(setId);
    		FormValidRule rule = formValidRuleManager.getBySetId(setId);
    		JSONObject obj = new JSONObject();
    		if(BeanUtil.isNotEmpty(rule)) {
    			obj = JSONObject.parseObject(rule.getJson());
    			mv.addObject("ruleId", rule.getId());
    		}
    		String pkId = sysCustomFormSetting.getBodefId();
    		if(StringUtil.isNotEmpty(pkId)) {
	    		SysBoEnt boEnt= sysBoEntManager.getByBoDefId(pkId, true);
	    		JSONArray jsonAry=new JSONArray();
	        	JSONObject mainTable=new JSONObject();
	        	mainTable.put("name", boEnt.getName());
	        	mainTable.put("comment", "主表-"+boEnt.getComment());
	        	mainTable.put("isMain", true);
	        	mainTable.put("boDefId", boEnt.getBoDefId());
	        	mainTable.put("valids", obj.get("main"));
	        	jsonAry.add(mainTable);
	        	List<SysBoEnt> boEnts=boEnt.getBoEntList();
	        	for(SysBoEnt ent:boEnts){
	        		JSONObject subTable=new JSONObject();
	        		subTable.put("name", ent.getName());
	        		subTable.put("comment", "从表-"+ent.getComment());
	        		subTable.put("isMain", false);
	        		subTable.put("boDefId", ent.getBoDefId());
	        		subTable.put("valids", obj.get(ent.getName()));
		        	jsonAry.add(subTable);
	        	}
	        	mv.addObject("tables", jsonAry);
	        	mv.addObject("boDefId", pkId);
    		}
    	}else{
    		sysCustomFormSetting=new SysCustomFormSetting();
    	}
    	return mv.addObject("sysCustomFormSetting",sysCustomFormSetting);
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
    public FormValidRule getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        FormValidRule formValidRule = formValidRuleManager.getFormValidRule(uId);
        return formValidRule;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "FORM_VALID_RULE")
    public JsonResult save(HttpServletRequest request, @RequestBody JSONObject json, BindingResult result) throws Exception  {
    	FormValidRule formValidRule = JSON.toJavaObject(json, FormValidRule.class);
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(formValidRule.getId())) {
            formValidRuleManager.create(formValidRule);
            msg = getMessage("formValidRule.created", new Object[]{formValidRule.getIdentifyLabel()}, "[FORM_VALID_RULE]成功创建!");
        } else {
        	String id=formValidRule.getId();
        	FormValidRule oldEnt=formValidRuleManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, formValidRule);
            formValidRuleManager.update(oldEnt);
       
            msg = getMessage("formValidRule.updated", new Object[]{formValidRule.getIdentifyLabel()}, "[FORM_VALID_RULE]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return formValidRuleManager;
	}
}
