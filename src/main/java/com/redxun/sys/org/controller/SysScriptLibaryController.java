
package com.redxun.sys.org.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.redxun.bpm.script.config.ScriptMethod;
import com.redxun.bpm.script.config.ScriptParam;
import com.redxun.bpm.script.config.ScriptServiceClass;
import com.redxun.bpm.script.config.ScriptServiceConfig;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.script.GroovyScript;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.org.entity.SysScriptLibary;
import com.redxun.sys.org.manager.SysScriptLibaryManager;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;
import com.redxun.core.util.BeanUtil;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * sys_script_libary控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/org/sysScriptLibary/")
public class SysScriptLibaryController extends MybatisListController{
    @Resource
    SysScriptLibaryManager sysScriptLibaryManager;
    @Resource
    private SysTreeManager sysTreeManager;

    private static List<SysTree> treeIdList =new ArrayList<>();
    private static final String CAT_KEY="SCRIPT_SERVICE_CLASS";
    private static final String CATEGORY="CATEGORY_";

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}

    /**
     * 初始化
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("initScriptFu")
    @ResponseBody
	public  JsonResult initScriptFu(HttpServletRequest request,HttpServletResponse response) throws Exception{
        Collection<GroovyScript> list= AppBeanUtil.getBeanList(GroovyScript.class);
        List<KeyValEnt> lists=new ArrayList<KeyValEnt>();
        List<SysScriptLibary> libaryList =new ArrayList<>();
        List<SysScriptLibary> libaryBoList =sysScriptLibaryManager.getAllList();

        String tenantId=ContextUtil.getCurrentTenantId();
        treeIdList=sysTreeManager.getByCatKeyTenantId(CAT_KEY, tenantId);

        for (GroovyScript groovyScript : list) {
            String className=groovyScript.getClass().getName().split("\\$\\$")[0];
            String beanName = className.split("\\.")[className.split("\\.").length-1];
            if(!Character.isLowerCase(beanName.charAt(0))){
                beanName = (new StringBuilder()).append(Character.toLowerCase(beanName.charAt(0))).append(beanName.substring(1)).toString();
            }
            boolean isInherit =  GroovyScript.class.isAssignableFrom(groovyScript.getClass());
            if (isInherit) {
                ScriptServiceClass serviceClass = new ScriptServiceClass(groovyScript, beanName);
                setSysScriptLibaryList(serviceClass,libaryList,libaryBoList);
            }
        }
        sysScriptLibaryManager.addSysScriptLibary(libaryList);
        return new JsonResult(true,"成功初始化!");
    }

    private void setSysScriptLibaryList(ScriptServiceClass serviceClass,List<SysScriptLibary> libaryList,List<SysScriptLibary> libaryBoList){
        for(ScriptMethod method:serviceClass.getMethods()){
            SysScriptLibary libary =new SysScriptLibary();
            libary.setBeanName(serviceClass.getBeanName());
            libary.setFullClassName(method.getTitle());
            libary.setMethod(method.getMethodName());
            libary.setReturnType(method.getReturnType());

            JSONArray jsonArray =new JSONArray();
            for (ScriptParam sp:method.getInputParams()) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("paramType",sp.getParamType());
                jsonObject.put("paramName",sp.getParamName());
                jsonObject.put("title",sp.getTitle());
                jsonArray.add(jsonObject);
            }
            if(jsonArray.size()>0){
                libary.setParams(jsonArray.toJSONString());
            }else{
                libary.setParams("null");
            }
            if(!libaryBoList.isEmpty()){
                addLibary(libary,libaryList,libaryBoList,method);
            }else{
                setTreeId(libary,method);
                setDos(libary,method);
                setExample(libary,method);
                libaryList.add(libary);
            }
        }
    }

    private void setTreeId(SysScriptLibary libary,ScriptMethod method){
        String treeId =idGenerator.getSID();
        if(treeIdList!=null){
            boolean isSameName =false;
            for (SysTree sysTree:treeIdList ) {
                if(sysTree.getName().equals(method.getCategory())){
                    isSameName =true;
                    libary.setTreeId(sysTree.getTreeId());
                    break;
                }
            }
            if(!isSameName){
                creatTree(treeId,method.getCategory());
            }
        }else {
            treeIdList =new ArrayList<>();
            creatTree(treeId,method.getCategory());
        }
    }
    private void creatTree(String treeId,String category){
        if(StringUtils.isEmpty(category)){
            return;
        }
        SysTree sysTree =new SysTree();
        sysTree.setTreeId(treeId);
        sysTree.setName(category);
        sysTree.setKey(CATEGORY+treeId);
        sysTree.setCatKey(CAT_KEY);
        sysTree.setSn(1);
        sysTree.setDataShowType("FLAT");
        sysTree.setUsed(true);
        sysTree.setParentId("0");
        SysTree parentTree=sysTreeManager.get(sysTree.getParentId());
        if(parentTree!=null){
            sysTree.setPath(parentTree.getPath()+sysTree.getTreeId()+".");
            sysTree.setDepth(parentTree.getDepth()+1);
        }else{
            sysTree.setDepth(1);
            sysTree.setPath("0."+sysTree.getTreeId()+".");
        }
        treeIdList.add(sysTree);
        sysTreeManager.create(sysTree);
    }

    private void setDos(SysScriptLibary libary,ScriptMethod method){
        String methods =method.getMethodName();
        List<ScriptParam> params =method.getInputParams();
        String returnType =libary.getReturnType();
        String beanName =libary.getBeanName();

        String fullClassName ="功能："+method.getTitle()+"\n";

        String paramsVal ="  无入参";
        if(params!=null && params.size()>0){
            paramsVal ="";
            for (ScriptParam sp:params) {
                paramsVal+= "  参数名："+sp.getParamName()+"\n  参数类型："+sp.getParamType()+"\n  作用："+sp.getTitle()+"\n";
            }
        }
        paramsVal ="参数列表：\n"+paramsVal+"\n";
        String returnValue = "void";
        if(!"void".equals(returnType)){
            returnValue = "";
            returnValue =returnType+"\n";
        }
        returnValue = "返回值：\n  "+returnValue;
        String returnVal = fullClassName+"\n"+paramsVal+returnValue;
        libary.setDos(returnVal);
    }

    private void setExample(SysScriptLibary libary,ScriptMethod method){
        String methods =method.getMethodName();
        List<ScriptParam> params =method.getInputParams();
        String returnType =libary.getReturnType();
        String beanName =libary.getBeanName();

        String fullClassName ="//"+method.getTitle()+"\n";

        String paramsListVal ="\n";
        String paramsVal ="()";
        if(params!=null && params.size()>0){
            paramsListVal ="";
            paramsVal ="";
            for (ScriptParam sp:params) {
                String paramValue ="//" +sp.getParamType() +" "+ sp.getParamName()+" /*"+sp.getTitle()+"*/\n";
                paramsListVal+=paramValue;
                if(StringUtil.isEmpty(paramsVal)){
                    paramsVal = sp.getParamName();
                }else{
                    paramsVal = paramsVal+","+sp.getParamName();
                }
            }
            paramsVal ="("+paramsVal+");";
        }
        String returnValue = "";
        if(!"void".equals(returnType)){
            returnValue =returnType+" var = ";
        }
        String returnName = returnValue+beanName+"."+methods;

        String returnVal = fullClassName+paramsListVal+returnName+paramsVal;
        libary.setExample(returnVal);
    }
    private void addLibary( SysScriptLibary libary,List<SysScriptLibary> newList,List<SysScriptLibary> oldBoList,ScriptMethod method){
        boolean iscreat =false;
        for (SysScriptLibary old:oldBoList ) {
            if(old.getMethod().equals(libary.getMethod()) &&
                    old.getBeanName().equals(libary.getBeanName()) &&
                    old.getReturnType().equals(libary.getReturnType()) ){
                iscreat=isSameToParams(libary,old);
                if(iscreat){
                    break;
                }
            }
        }
        if(!iscreat){
            setTreeId(libary,method);
            setDos(libary,method);
            setExample(libary,method);
            newList.add(libary);
        }
    }

    /**
     * 是否为同一个方法
     * @param newLibary
     * @param oldLibary
     * @return
     */
    private boolean isSameToParams(SysScriptLibary newLibary,SysScriptLibary oldLibary){
         String newParams = newLibary.getParams();
        String oldParams = oldLibary.getParams();

        //两个都是null 则为同一个方法
        if("null".equals(oldParams) && oldLibary.getParams().equals(newParams) ){
            return true;
        }
        //其中一个是null 则不是同一个方法
        if(("null".equals(oldParams) &&  !"null".equals(newParams)) || ("null".equals(newParams) &&  !"null".equals(oldParams))){
            return false;
        }

        JSONArray newArry = JSON.parseArray(newParams);
        JSONArray oldArry = JSON.parseArray(oldParams);
        //参数数量不一致，则不是同一个方法
        if(newArry.size()!=oldArry.size()){
            return false;
        }

        //参数类型不一致，则不是同一个方法
        for(int i=0;i<newArry.size();i++){
            JSONObject newJson = newArry.getJSONObject(i);
            JSONObject oldJson = oldArry.getJSONObject(i);
            if(!newJson.getString("paramType").equals(oldJson.getString("paramType"))){
                return false;
            }
        }
        return true;
    }
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "sys_script_libary")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysScriptLibaryManager.delete(id);
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
        SysScriptLibary sysScriptLibary=null;
        ModelAndView mv=getPathView(request);
        if(StringUtils.isNotEmpty(pkId)){
           sysScriptLibary=sysScriptLibaryManager.get(pkId);
           if(StringUtils.isNotEmpty(sysScriptLibary.getTreeId())){
               SysTree sysTree=sysTreeManager.get(sysScriptLibary.getTreeId());
               mv.addObject("treeName",sysTree==null? "":sysTree.getName());
           }
        }else{
        	sysScriptLibary=new SysScriptLibary();
        }
        return mv.addObject("sysScriptLibary",sysScriptLibary);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
        SysScriptLibary sysScriptLibary=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysScriptLibary=sysScriptLibaryManager.get(pkId);
    	}else{
    		sysScriptLibary=new SysScriptLibary();
    	}
    	return getPathView(request).addObject("sysScriptLibary",sysScriptLibary);
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
    public SysScriptLibary getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");
        SysScriptLibary sysScriptLibary = sysScriptLibaryManager.getSysScriptLibary(uId);
        return sysScriptLibary;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "sys_script_libary")
    public JsonResult save(HttpServletRequest request, @RequestBody SysScriptLibary sysScriptLibary, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysScriptLibary.getLibId())) {
            String paras =sysScriptLibary.getParams();
            JSONArray array = JSONArray.parseArray(paras);
            sysScriptLibaryManager.create(sysScriptLibary);
            msg = getMessage("sysScriptLibary.created", new Object[]{sysScriptLibary.getIdentifyLabel()}, "[sys_script_libary]成功创建!");
        } else {
        	String id=sysScriptLibary.getLibId();
            SysScriptLibary oldEnt=sysScriptLibaryManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysScriptLibary);
            sysScriptLibaryManager.update(oldEnt);
       
            msg = getMessage("sysScriptLibary.updated", new Object[]{sysScriptLibary.getIdentifyLabel()}, "[sys_script_libary]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

    /**
     * 按用户组及关系类型查找用户
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping("getListBytreeId")
    @ResponseBody
    public JsonPageResult getListBytreeId(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String treeId = request.getParameter("treeId");

        String instId = getCurTenantId(request);
        QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
        queryFilter.addParam("treeId", treeId);
        queryFilter.addParam("tenantId", instId);

        Map<String,Object> params=queryFilter.getParams();
        String fullClassName=(String)params.get("FULL_CLASS_NAME_");
        if(StringUtils.isNotEmpty(fullClassName)){
            queryFilter.addParam("fullClassName", fullClassName);
        }
        String method=(String)params.get("METHOD_");
        if(StringUtils.isNotEmpty(method)){
            queryFilter.addParam("method", method);
        }
        String beanName=(String)params.get("BEAN_NAME_");
        if(StringUtils.isNotEmpty(beanName)){
            queryFilter.addParam("beanName", beanName);
        }

        List<SysScriptLibary> list = sysScriptLibaryManager.getListBytreeId(queryFilter);
        return new JsonPageResult(list, queryFilter.getPage().getTotalItems());
    }
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysScriptLibaryManager;
	}
}
