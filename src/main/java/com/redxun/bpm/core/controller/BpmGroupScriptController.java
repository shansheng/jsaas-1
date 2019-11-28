
package com.redxun.bpm.core.controller;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.core.entity.BpmGroupScript;
import com.redxun.bpm.core.manager.BpmGroupScriptManager;
import com.redxun.core.annotion.cls.MethodDefine;
import com.redxun.core.annotion.cls.ParamDefine;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyScript;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 人员脚本控制器
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmGroupScript/")
public class BpmGroupScriptController extends BaseListController{
    @Resource
    BpmGroupScriptManager bpmGroupScriptManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "人员脚本")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmGroupScriptManager.delete(id);
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
        BpmGroupScript bpmGroupScript=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmGroupScript=bpmGroupScriptManager.get(pkId);
        }else{
        	bpmGroupScript=new BpmGroupScript();
        }
        return getPathView(request).addObject("bpmGroupScript",bpmGroupScript);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmGroupScript bpmGroupScript=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmGroupScript=bpmGroupScriptManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmGroupScript.setScriptId(null);
    		}
    	}else{
    		bpmGroupScript=new BpmGroupScript();
    	}
    	return getPathView(request).addObject("bpmGroupScript",bpmGroupScript);
    }

	
	
	@RequestMapping("getAllClass")
	@ResponseBody
	public List<KeyValEnt> getAllClass(HttpServletResponse response,HttpServletRequest request){
		Collection<GroovyScript> list= AppBeanUtil.getBeanList(GroovyScript.class);
		List<KeyValEnt> lists=new ArrayList<KeyValEnt>();
		for (GroovyScript groovyScript : list) {
			String className=groovyScript.getClass().getName().split("\\$\\$")[0];
			KeyValEnt keyValEnt=new KeyValEnt(className, className.split("\\.")[className.split("\\.").length-1]);
			lists.add(keyValEnt);
		}
		return lists;
	}
	
	@RequestMapping("getAllMethodByClassName")
	@ResponseBody
	public JSONArray getAllMethodByClassName(HttpServletRequest request,HttpServletResponse response) throws ClassNotFoundException{
		JSONArray jarray = new JSONArray();
		String className=RequestUtil.getString(request, "className");
		Class clazz = Class.forName(className);
		Method[] methods = clazz.getDeclaredMethods();
		for (Method method : methods) {
			String returnType = method.getReturnType().getCanonicalName();
			Integer modifirer = method.getModifiers();
			// 只要public方法
			if (modifirer != 1||!"java.util.Collection".equals(returnType)) continue;
			
			JSONObject jobMethod = new JSONObject();
			JSONArray jaryPara = new JSONArray();
			Class<?>[] paraArr = method.getParameterTypes();
			String desc = "";
			MethodDefine methodDefine = method.getAnnotation(MethodDefine.class);
			ParamDefine[] paramDefines = null;
			if(BeanUtil.isNotEmpty(methodDefine)) {
				desc = methodDefine.title();
				paramDefines = methodDefine.params();
			}
			for (int i = 0; i < paraArr.length; i++) {
				Class<?> para = paraArr[i];
				String paraName = "arg" + i;
				String paraDesc = "";
				if(BeanUtil.isNotEmpty(paramDefines)) {
					ParamDefine paramDefine = paramDefines[i];
					paraDesc = paramDefine.title();
					paraName = paramDefine.varName();
				}
				String paraType = para.getCanonicalName();
				JSONObject jsonObject = new JSONObject().accumulate("paraName", paraName).accumulate("paraType", paraType).accumulate("paraDesc", paraDesc);
				jaryPara.add(jsonObject);
			}
			jobMethod.accumulate("returnType", returnType).accumulate("methodName", method.getName()).accumulate("para", jaryPara).accumulate("methodDesc", desc);
			jarray.add(jobMethod);
		}
		return jarray;
	}
	
	
	@RequestMapping("saveGroupScript")
	@LogEnt(action = "saveGroupScript", module = "流程", submodule = "人员脚本")
	public JSONObject saveGroupScript(HttpServletRequest request,HttpServletResponse response){
		JSONObject jsonObject=new JSONObject();
		String scriptId=RequestUtil.getString(request, "scriptId");
		String className=RequestUtil.getString(request, "className");
		String methodName=RequestUtil.getString(request, "methodName");
		String methodDesc=RequestUtil.getString(request, "methodDesc");
		String argument=RequestUtil.getString(request, "argument");
		if(StringUtils.isNotBlank(scriptId)){
			BpmGroupScript bpmGroupScript=bpmGroupScriptManager.get(scriptId);
			bpmGroupScript.setClassName(className);
			bpmGroupScript.setMethodName(methodName);
			bpmGroupScript.setMethodDesc(methodDesc);
			bpmGroupScript.setArgument(argument);
			bpmGroupScriptManager.update(bpmGroupScript);
		}else{
			BpmGroupScript bpmGroupScript=new BpmGroupScript();
			bpmGroupScript.setScriptId(idGenerator.getSID());
			bpmGroupScript.setClassName(className);
			bpmGroupScript.setMethodName(methodName);
			bpmGroupScript.setMethodDesc(methodDesc);
			bpmGroupScript.setArgument(argument);
			bpmGroupScriptManager.create(bpmGroupScript);
		}
		jsonObject.put("success", true);
		return jsonObject;
	}
	
	@RequestMapping("selectBuild")
	public  ModelAndView selectBuild(HttpServletRequest request,HttpServletResponse response){
		String solId=RequestUtil.getString(request, "solId");
		String actDefId=RequestUtil.getString(request, "actDefId");
		return this.getPathView(request).addObject("solId", solId).addObject("actDefId", actDefId);
	}
	
	@RequestMapping("getScriptParams")
	@ResponseBody
	public JSONArray getScriptParams(HttpServletRequest request,HttpServletResponse response){
		String scriptId=RequestUtil.getString(request, "scriptId");
		BpmGroupScript bpmGroupScript=bpmGroupScriptManager.get(scriptId);
		String arguement=bpmGroupScript.getArgument();
		JSONArray jsonArray=JSONArray.fromObject(arguement);
		return jsonArray;
	}

	@Override
	public BaseManager getBaseManager() {
		return bpmGroupScriptManager;
	}

}
