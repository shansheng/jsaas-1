package com.redxun.bpm.core.manager.impl;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSON;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.IDataSettingHandler;
import com.redxun.core.script.GroovyEngine;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.bo.entity.SysBoAttr;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.SysBoEntManager;

@Service
public class DataSettingHandler implements IDataSettingHandler {

	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	ContextHandlerFactory contextHandlerFactory;
	@Resource
	GroovyEngine groovyEngine;

	private static final Pattern PATTERN=Pattern.compile("\\[(.*?)\\]", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
	private static final String INITDATA ="initData";

	@Override
	public void handSetting(JSONObject jsonData, String boDefId, JSONObject setting,boolean isSave,Map<String,Object> vars) {
		if(setting==null){return;}
		if(vars==null) {
			vars=new HashMap<>();
		}
		vars.put("jsonData", jsonData);
		vars.put("boDefId", boDefId);
		//执行初始化脚本
		if(isSave){
			String saveScript=setting.getString("saveScript");
			if(StringUtils.isNotEmpty(saveScript)){

				groovyEngine.executeScripts(saveScript, vars);
			}
		}else{
			String initScript=setting.getString("initScript");
			if(StringUtils.isNotEmpty(initScript)){
				groovyEngine.executeScripts(initScript, vars);
			}
		}
		JSONArray boAttSettings=setting.getJSONArray("boAttSettings");
		if(boAttSettings==null || boAttSettings.isEmpty()){
			return ;
		}
		//找到BO对应的属性设置
		JSONObject boAttsObj=null;
		for(int i=0;i<boAttSettings.size();i++){
			JSONObject tmpObj=boAttSettings.getJSONObject(i);
			String tmpBoDefId=tmpObj.getString("boDefId");
			if(boDefId.equals(tmpBoDefId)){
				boAttsObj=tmpObj;
				break;
			}
		}
		if(boAttsObj==null) {return;}
		//保存与初始化时其设置的值
		if(isSave){
			boAttsObj=boAttsObj.getJSONObject("save");
		}else {
			boAttsObj=boAttsObj.getJSONObject("init");
		}
		if(boAttsObj==null){return;}

		List<SysBoEnt> sysBoEnts=sysBoEntManager.getListByBoDefId(boDefId, true);
		for(SysBoEnt ent:sysBoEnts){
			JSONObject boJson=boAttsObj.getJSONObject(ent.getName());
			if(boJson==null) {continue;}
			Set<String> boFieldSet=  boJson.keySet();

			boolean isMain=SysBoRelation.RELATION_MAIN.equals(ent.getRelationType());

			JSONObject jsonSubRow=new JSONObject();
			JSONObject jsonSub=null;

			if(!isMain){
				if(!jsonData.containsKey(INITDATA)){
					jsonSub=new JSONObject();
					jsonData.put(INITDATA, jsonSub);
				}
				else{
					jsonSub=jsonData.getJSONObject(INITDATA);
				}
			}

			Map<String,SysBoAttr> attrs= getAttrMap(ent);
			for(Iterator<String> it=boFieldSet.iterator();it.hasNext();){
				String key=it.next();
				if(!attrs.containsKey(key)) {continue;}
				SysBoAttr attr=attrs.get(key);
				JSONObject jsonSetting= boJson.getJSONObject(key);
				if(isMain){
					handJson(jsonData,jsonSetting, attr,vars);
				}
				else{
					handJson(jsonSubRow,jsonSetting, attr,vars);
					if(jsonSub!=null){
						jsonSub.put(ent.getName(), jsonSubRow);
					}

				}
			}

		}
	}


	/**
	 * 处理一个初始数据。
	 * @param rowData
	 * @param jsonSetting
	 * jsonSetting格式如下：
	 * 	{"valType":"manual","val":"ray","val_name":"ray"}
	 * 	valType :
	 * 	manual : 固定值
	 * 	constant :常量
	 * 		这个常量在spring-bean.xml 中进行定义，用户可以扩展这个常量列表。
	 * 		script : 脚本
	 * 		在脚本中可以引用其他字段的值。
	 * 		[userid] 中括号表示表字段。
	 * @param attr
	 */
	private void handJson(JSONObject rowData,JSONObject jsonSetting,SysBoAttr attr,Map<String,Object> vars){
		String valType=jsonSetting.getString("valType");
		//固定值
		if("manual".equals(valType)){
			handManual(rowData, jsonSetting, attr);
		}
		else if("constant".equals(valType)){
			handConstant(rowData, jsonSetting, attr,vars);
		}
		else if("script".equals(valType)){
			handScript(rowData, jsonSetting, attr,vars);
		}
		else if("opinion".equals(valType)){
			handOpinion(rowData, attr);
		}

	}

	private void handOpinion(JSONObject rowData,SysBoAttr attr){
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		if(cmd==null) {return;}
		ProcessConfig config= (ProcessConfig) cmd.getTransientVars().get("processConfig");
		String opinionType="";
		String type=cmd.getJumpType();
		if(config!=null){
			Map<String,String> opinionMap= config.getOpinionTextMap();
			if(opinionMap.containsKey(type)){
				opinionType=opinionMap.get(type);
			}
		}else{
			opinionType=null;
		}

		String name=attr.getName();

		IUser iUser =ContextUtil.getCurrentUser();
		String userFullName =iUser.getFullname();

		JSONObject jsonData = JSON.parseObject(cmd.getJsonData());
		JSONArray bos = (JSONArray)jsonData.get("bos");
		JSONObject data =null;
		String opinionValue = "";
		for(int i=0;bos!=null&&i<bos.size();i++){
			JSONObject bosList =(JSONObject) bos.get(i);
			if(bosList!=null){
				data =(JSONObject)bosList.get("data");
				if(data!=null){
					opinionValue = data.getString(name);
					break;
				}
			}
		}

		String opinion = StringUtil.isNotEmpty(cmd.getOpinion())?cmd.getOpinion():"无";
		String time = DateUtil.formatDate(new Date(),DateUtil.DATE_FORMAT_FULL);
		String opinionVal ="";
		if(StringUtil.isNotEmpty(opinionType)){
			opinionVal ="【"+opinionType+"】 "+opinion+"\n"+"          "+userFullName +" "+time;
		}else{
			opinionVal =opinion+"\n"+"          "+userFullName +" "+time;
		}


		if(StringUtil.isEmpty(opinionValue)){
			opinionValue =opinionVal;
		}else{
			opinionValue =opinionValue+"\n"+opinionVal;
		}
		rowData.put(name, opinionValue);
	}

	/**
	 * 固定值。
	 * @param rowData
	 * @param jsonSetting
	 * @param attr
	 */
	void handManual(JSONObject rowData,JSONObject jsonSetting,SysBoAttr attr){
		String name=attr.getName();
		String valName="val" + SysBoEnt.COMPLEX_NAME.toLowerCase();

		rowData.put(name, jsonSetting.getString("val"));
		if(!attr.single()){
			rowData.put(name + SysBoEnt.COMPLEX_NAME.toLowerCase(), jsonSetting.getString(valName));
		}
	}

	/**
	 * 常量计算。
	 * @param rowData
	 * @param jsonSetting
	 * @param attr
	 */
	void handScript(JSONObject rowData,JSONObject jsonSetting,SysBoAttr attr,Map<String,Object> vars){
		String name=attr.getName();
		String valName="val" + SysBoEnt.COMPLEX_NAME.toLowerCase();
		String script=jsonSetting.getString("val");

		Object rtn= executeScript(rowData,script,vars);
		rowData.put(name, rtn);

		if(!attr.single()){
			String nameScript=jsonSetting.getString(valName);
			Object rtnName= executeScript(rowData,nameScript,vars);
			rowData.put(name + SysBoEnt.COMPLEX_NAME.toLowerCase(), rtnName);
		}
	}

	private Object executeScript(JSONObject rowData,String script,Map<String,Object> vars){
		Matcher m=PATTERN.matcher(script);
		while(m.find()){
			String key=m.group(1);
			String val=rowData.getString(key);
			script=script.replace(m.group(0), val);
		}
		return groovyEngine.executeScripts(script, vars);
	}

	void handConstant(JSONObject rowData,JSONObject jsonSetting,SysBoAttr attr,Map<String,Object> vars){
		String name=attr.getName();
		String valName="val" + SysBoEnt.COMPLEX_NAME.toLowerCase();

		String constantKey=jsonSetting.getString("val");
		Object val=contextHandlerFactory.getValByKey(constantKey,vars);
		rowData.put(name, val);

		if(!attr.single()){
			String constantNameKey=jsonSetting.getString(valName);
			Object nameVal=contextHandlerFactory.getValByKey(constantNameKey,vars);
			rowData.put(name + SysBoEnt.COMPLEX_NAME.toLowerCase(), nameVal);
		}
	}



	private Map<String,SysBoAttr> getAttrMap(SysBoEnt ent){
		Map<String,SysBoAttr> attrMap=new HashMap<>();
		List<SysBoAttr> attrs= ent.getSysBoAttrs();
		for(SysBoAttr attr:attrs){
			attrMap.put(attr.getName(), attr);
		}
		return attrMap;
	}



	public static void main(String[] args) {
		String str="aaa[userid],[name],[name]dddd";
		Matcher m= PATTERN.matcher(str);
		while(m.find()){
			str=str.replace(m.group(0), "");
		}
	}
}
