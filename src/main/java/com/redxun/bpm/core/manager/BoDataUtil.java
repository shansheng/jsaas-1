package com.redxun.bpm.core.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.form.api.FormHandlerFactory;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.manager.SysBoDefManager;

public class BoDataUtil {
	
	/**
	 * 根据保存模式获取数据。
	 * @param dataSaveMode
	 * @return
	 */
	public static IFormDataHandler getDataHandler(String dataSaveMode){
		if( ProcessConfig.DATA_SAVE_MODE_ALL.equals(dataSaveMode)){
			return (IFormDataHandler) WebAppUtil.getBean("allFormDataHandler");
		}
		else if( ProcessConfig.DATA_SAVE_MODE_DB.equals(dataSaveMode)){
			return (IFormDataHandler) WebAppUtil.getBean("dbFormDataHandler");
		}
		else{
			return (IFormDataHandler) WebAppUtil.getBean("jsonFormDataHandler");
		}
	}
	/**
	 * 
	 * @param taskId
	 * @param formJsonData 用户传入的表单Json
	 * @return
	 * @throws Exception 
	 */
	public static JSONObject getFormDataFromTaskId(String taskId,JSONObject formJsonData) throws Exception{
		
		JSONObject cmdData=new JSONObject();
		if(formJsonData==null || !formJsonData.containsKey("bos")) {return cmdData;}
		
		FormHandlerFactory formHandlerFactory=AppBeanUtil.getBean(FormHandlerFactory.class);
		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels= formHandler.getByTaskId(taskId, "");
		
		
		if( formModels!=null &&formModels.size()>0 ){
			JSONArray boArr=new JSONArray();
			for(FormModel fm:formModels){
				JSONObject bo=new JSONObject();
				bo.put("boDefId", fm.getBoDefId());
				bo.put("formKey", fm.getFormKey());
				bo.put("data", fm.getJsonData());
				boArr.add(bo);
			}
			cmdData.put("bos", boArr);
		}
		
		if(formJsonData!=null){//合并外部传入的formJsonData;
			cmdData.putAll(formJsonData);
		}
		return cmdData;
	}
	
	/**
	 *  流程实例id
	 * @param instId
	 * @param formJsonData 用户传入的表单Json
	 * @return
	 * @throws Exception 
	 */
	public static JSONObject getFormDataFromInstId(String instId,JSONObject formJsonData) throws Exception{
		FormHandlerFactory formHandlerFactory=AppBeanUtil.getBean(FormHandlerFactory.class);
		IFormHandler formHandler=  formHandlerFactory.getByType(IFormHandler.FORM_TYPE_PC);
		List<FormModel> formModels= formHandler.getByInstId(instId);
		
		JSONObject cmdData=new JSONObject();
		if( formModels!=null &&formModels.size()>0 ){
			JSONArray boArr=new JSONArray();
			for(FormModel fm:formModels){
				JSONObject bo=new JSONObject();
				bo.put("boDefId", fm.getBoDefId());
				bo.put("formKey", fm.getFormKey());
				bo.put("data", fm.getJsonData());
				boArr.add(bo);
			}
			cmdData.put("bos", boArr);
		}
		
		if(formJsonData!=null){//合并外部传入的formJsonData;
			cmdData.putAll(formJsonData);
		}
		return cmdData;
	}
	
	public static Map<String,Object> getModelFieldsFromBoJsons(com.alibaba.fastjson.JSONObject boJsons){
		SysBoDefManager boDefManager= (SysBoDefManager) WebAppUtil.getBean(SysBoDefManager.class);
		Map<String,Object> maps=new HashMap<String, Object>();
		
		if(boJsons==null){return maps;}
		com.alibaba.fastjson.JSONArray jsonArr=boJsons.getJSONArray("vars");
		if(jsonArr!=null){
			for(int i=0;i<jsonArr.size();i++){
				com.alibaba.fastjson.JSONObject varObj=jsonArr.getJSONObject(i);
				String key=varObj.getString("key");
				String val=varObj.getString("val");
				if(StringUtils.isEmpty(key)||StringUtils.isEmpty(val)){
					continue;
				}
				maps.put(key, val);
			}
		}
		
		com.alibaba.fastjson.JSONArray boArr=boJsons.getJSONArray("bos");
		if(BeanUtil.isEmpty(boArr)) return maps;
		for(int i=0;i<boArr.size();i++){
			com.alibaba.fastjson.JSONObject varObj=boArr.getJSONObject(i);
			String boDefId=varObj.getString("boDefId");
			String formKey=FastjsonUtil.getString(varObj,"formKey","");
			String pre="";
			if(StringUtils.isEmpty(formKey)){
				SysBoDef boDef=boDefManager.get(boDefId);
				if(boDef!=null){
					pre=boDef.getAlais()+".";
				}
				varObj.put("formKey",boDef.getAlais());
			}else{
				pre=formKey+".";
			}
			com.alibaba.fastjson.JSONObject boData=varObj.getJSONObject("data");
			Map<String,Object> boFields=FastjsonUtil.json2Map(pre, boData);
			maps.putAll(boFields);
		}
		return maps; 
	}

	/**
	 * 返回一个map对象。
	 * <pre>
	 * 1. 这个数据包括 vars 流程变量数据。
	 * 2. formkey.字段名称
	 * </pre>
	 * @param boJsons
	 * @param solId
	 * @return
	 */
	public static Map<String,Object> getModelFieldsFromBoJsonsBoIds(com.alibaba.fastjson.JSONObject boJsons,String boIds){
		SysBoDefManager boDefManager= (SysBoDefManager) WebAppUtil.getBean(SysBoDefManager.class);
		Map<String,Object> maps=new HashMap<String, Object>();
		
		if(boJsons==null){return maps;}
		if(!boJsons.containsKey("bos")) {return maps;}
		com.alibaba.fastjson.JSONArray jsonArr=boJsons.getJSONArray("vars");
		if(jsonArr!=null){
			for(int i=0;i<jsonArr.size();i++){
				com.alibaba.fastjson.JSONObject varObj=jsonArr.getJSONObject(i);
				String key=varObj.getString("key");
				String val=varObj.getString("val");
				if(StringUtils.isEmpty(key)||StringUtils.isEmpty(val)){
					continue;
				}
				maps.put(key, val);
			}
		}
		
		com.alibaba.fastjson.JSONArray boArr=boJsons.getJSONArray("bos");
		String[] boIdsArray=boIds.split("[,]");
		if(BeanUtil.isEmpty(boArr)) return maps;
		for(int i=0;i<boArr.size();i++){
			com.alibaba.fastjson.JSONObject varObj=boArr.getJSONObject(i);
			String boDefId=FastjsonUtil.getString(varObj, "boDefId","");
			if(StringUtils.isEmpty(boDefId)){
				boDefId=boIdsArray[i];
				//若在参数中没有传入该值，则回写至BoDefId
				varObj.put("boDefId", boDefId);
			}
			//查看是否传入表单字段
			String pre="";
			String formKey=FastjsonUtil.getString(varObj,"formKey","");
			if(StringUtils.isNotEmpty(formKey)){
				pre=formKey+".";
			}else{
				SysBoDef boDef=boDefManager.get(boDefId);
				if(boDef!=null){
					pre=boDef.getAlais()+".";
				}
				varObj.put("formKey", boDef.getAlais());
			}
			com.alibaba.fastjson.JSONObject boData=varObj.getJSONObject("data");
			Map<String,Object> boFields=FastjsonUtil.json2Map(pre, boData);
			maps.putAll(boFields);
		}
		return maps; 
	}
}
