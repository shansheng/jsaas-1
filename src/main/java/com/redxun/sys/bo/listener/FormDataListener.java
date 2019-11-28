package com.redxun.sys.bo.listener;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.ApplicationListener;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.form.entity.BpmTableFormula;
import com.redxun.bpm.form.entity.FormulaSetting;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.bpm.form.service.ITableFieldValueHandler;
import com.redxun.bpm.form.service.TableFieldValueHandlerConfig;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.bo.manager.DataHolderEvent;
import com.redxun.sys.bo.manager.SubDataHolder;
import com.redxun.sys.bo.manager.UpdJsonEnt;

import freemarker.template.TemplateException;

/**
 * [{
	"isMain": "yes",
	"name": "out_stock",
	"comment": "主表-出库单",
	"settings": {
		"opDescp": "wwww",
		"dsName": "",
		"setting": [{
			"condition": "name==''",
			"tableName": "demofield",
			"operator": "new",
			"filterSql": "NAME='{cur.F_name}'",
			"gridData": [{
				"comment": "主键",
				"fieldName": "ID",
				"mapType": "field",
				"mapTypeName": "从字段获取",
				"mapValue": "name"
			}]
		}, {
			"condition": "",
			"tableName": "demofield",
			"operator": "upd",
			"filterSql": "ID='{cur.F_name}'",
			"gridData": [{
				"comment": "主键",
				"fieldName": "ID",
				"mapType": "mainPkId",
				"mapTypeName": "主表主键字段"
			}]
		}]
	}
	}, {
		"name": "out_stock_item",
		"comment": "从表-出库单明细",
		"settings": {
			"opDescp": "demofield",
			"dsName": "",
			"setting": [{
				"condition": "",
				"tableName": "demofield",
				"operator": "new",
				"filterSql": "",
				"gridData": [{
					"comment": "主键",
					"fieldName": "ID",
					"mapType": "srcPkId",
					"mapTypeName": "原主键字段值"
				}]
			}]
		}
	}
	]
 * @author ray
 *
 */
public class FormDataListener implements ApplicationListener<DataHolderEvent> {

	@Resource
	private BpmTableFormulaManager bpmTableFormulaManager;
	@Resource
	private GroovyEngine  groovyEngine; 
	@Resource
	TableFieldValueHandlerConfig tableFieldValueHandlerConfig;
	@Resource
	CommonDao commonDao;
	@Resource
	FreemarkEngine freemarkEngine;
	
	protected static Logger logger=LogManager.getLogger(FormDataListener.class);
	
	
//	Logger

	/**
	 * {
		dsName:"",
		opDescp:"",
		setting:[{
		condition:"条件",
		filterSql:"过滤条件",
		operator:"new,upd,del",
		//字段映射
		gridData:[]
		}]	
	}
	 */
	@Override
	public void onApplicationEvent(DataHolderEvent event) {
		DataHolder holder=(DataHolder) event.getSource();
		FormulaSetting setting=ProcessHandleHelper.getFormulaSetting();
		if(setting==null) return;
		
		String mode=setting.getMode();
		try {
			List<BpmTableFormula> list=null;
			if(FormulaSetting.FORM.equals(mode)){
				list=bpmTableFormulaManager.getByFormSolId(setting.getFormSolId());
			}
			else{
				list=bpmTableFormulaManager.getBySolIdNode(setting.getSolId(), setting.getActDefId(), setting.getNodeId());
			}
			if(BeanUtil.isNotEmpty(list)){
				handFormula( holder, list,setting.getExtParams());
			}
		
		} catch (Exception e) {
			logger.error(ExceptionUtil.getExceptionMessage(e));
			throw new RuntimeException(e.getMessage());
		}
		
	}
	
	
	private void handFormula(DataHolder holder,List<BpmTableFormula> list,Map<String,Object> extParams) throws TemplateException, IOException, IllegalAccessException, NoSuchFieldException{
		String action=holder.getAction();
		for(BpmTableFormula formula:list){
			
			List<SqlModel> sqlModels=new ArrayList<>();
			
			if(!formula.getAction().equals(action)) continue;
			String setting=formula.getFillConf();
			
			boolean isTest=formula.getIsTest().equals("YES");
			
			JSONArray jsonAry=JSONArray.parseArray(setting);
			Map<String, List<JSONObject>> formulaMap=getSettingMap(jsonAry);
			
			//处理主表
			List<JSONObject> mains=formulaMap.get("main");			
			
			if(BeanUtil.isNotEmpty(mains)){
				for(JSONObject json:mains){
					JSONObject settings=json.getJSONObject("settings");
					JSONArray jsonArray=settings.getJSONArray("setting");
					String dsName=settings.getString("dsName");
					for(int i=0;i<jsonArray.size();i++){
						JSONObject tableSetting=jsonArray.getJSONObject(i);
						handMainSetting(tableSetting, holder, dsName,sqlModels,extParams);
					}
				}
			}
			
			
			//处理子表。
			List<JSONObject> subs=formulaMap.get("sub");
			if(BeanUtil.isNotEmpty(subs)){
				for(JSONObject json:subs){
					String entName=json.getString("name");
					JSONObject settings=json.getJSONObject("settings");
					String dsName=settings.getString("dsName");
					JSONArray jsonArray=settings.getJSONArray("setting");
					
					for(int i=0;i<jsonArray.size();i++){
						JSONObject tableSetting=jsonArray.getJSONObject(i);
						handSubSetting(tableSetting, holder,entName,  dsName,sqlModels,extParams);
					}
				}
			}
			
			/**
			 * 一次性执行。
			 */
			for(SqlModel model:sqlModels){
				if(isTest){
					logger.debug(model.getSql());
					logger.debug(JSONObject.toJSONString(model.getParams()));
				}
				commonDao.executeNamedSql(model);
			}
		}
	}
	
	
	/**
	 * {
			"condition": "name==''",
			"tableName": "demofield",
			"operator": "new",
			"filterSql": "NAME='{cur.F_name}'",
			"gridData": [{
				"comment": "主键",
				"fieldName": "ID",
				"mapType": "field",
				"mapTypeName": "从字段获取",
				"mapValue": "name"
			}]
		}
	 * @param tableSetting
	 * @param holder
	 * @param entName
	 * @param dsName
	 * @param isMain
	 * @throws IOException 
	 * @throws TemplateException 
	 */
	private void handMainSetting(JSONObject tableSetting,DataHolder holder,String dsName,List<SqlModel> sqlModels,Map<String,Object> extParams) throws TemplateException, IOException{
		String operator=tableSetting.getString("operator");
		String condition=tableSetting.getString("condition");
		//不是新增 必须填写filterSql 
		boolean needFilter=needFilterSql( tableSetting);
		if(needFilter) return; 
		
		
		
		//处理condition
		boolean rtn= handMainCondition(condition,holder.getAction(),holder,extParams);
		if(!rtn) return;
		String action = (String) extParams.get("action");
		if(!"ok".equals(action) && action!=null) {
			operator = DataHolder.ACTION_NEW;
		}
		
		switch(operator){
			case DataHolder.ACTION_NEW:
				String pk=handInsert(tableSetting,holder.getCurMain(),holder.getOriginMain(),holder, "",sqlModels,dsName,extParams);
				holder.setNewPk(pk);
				break;
			case DataHolder.ACTION_UPD:
				handUpd( tableSetting, holder.getCurMain(), holder.getOriginMain(), holder,sqlModels,dsName,extParams);
				break;
			case DataHolder.ACTION_DEL:
				handDel( tableSetting,holder.getCurMain(),holder.getOriginMain(),holder,sqlModels,dsName,extParams);
				break;
		}
		
	}
	
	private boolean needFilterSql(JSONObject tableSetting){
		String operator=tableSetting.getString("operator");
		String filterSql=tableSetting.getString("filterSql");
		
		if(!operator.equals("new") && StringUtil.isEmpty(filterSql)) return true;
		
		return false;
	}
	
	/**
	 * {
			"condition": "name==''",
			"tableName": "demofield",
			"operator": "new",
			"filterSql": "NAME='{cur.F_name}'",
			"gridData": [{
				"comment": "主键",
				"fieldName": "ID",
				"mapType": "field",
				"mapTypeName": "从字段获取",
				"mapValue": "name"
			}]
		}
	 * @param tableSetting
	 * @param jsonObj
	 * @param oldJsonObj
	 * @param dataHolder
	 * @return
	 * @throws IOException 
	 * @throws TemplateException 
	 */
	private void handUpd(JSONObject tableSetting,JSONObject jsonObj,JSONObject oldJsonObj,DataHolder dataHolder,List<SqlModel> sqlModels,String dsName,Map<String,Object> extParams) throws TemplateException, IOException{
		String tableName=tableSetting.getString("tableName");
		String filterSql=tableSetting.getString("filterSql");
		JSONArray data=tableSetting.getJSONArray("gridData");
		JSONArray mapper= getJsonAry(data);
		
		String sql="update " +tableName +" set ";
		
		String fields="";
		SqlModel sqlModel=new SqlModel();
		for(int i=0;i<mapper.size();i++){
			JSONObject json=mapper.getJSONObject(i);
			String mapType=json.getString("mapType");
			ITableFieldValueHandler valHandler=tableFieldValueHandlerConfig.getByMapType(mapType);
			if(valHandler==null){
				continue;
			}
			String fieldName=json.getString("fieldName");
			String columnType=json.getString("columnType");
			String mapValue=json.getString("mapValue");
			
			Object obj= valHandler.getFieldValue(columnType, dataHolder.getNewPk(), 
					dataHolder, jsonObj, oldJsonObj, mapValue,extParams);
			
			boolean isParam=valHandler.isParameterize();
			
			
			String pre=(i==0)? "" :","; 
			if(isParam){
				fields+=pre + fieldName +"=:"+fieldName;
				sqlModel.addParam(fieldName, obj);
			}
			else{
				if(columnType.equals("varchar")){
					fields+=pre + fieldName +"='" + obj.toString() + "'";
				}
				else{
					fields+=pre + fieldName +"=" + obj.toString() ;
				}
			}
		}
		sql+=fields +" where ";
		
		Map<String,Object> params=new HashMap<>();
		params.put("cur", jsonObj);
		params.put("old", oldJsonObj);
		
		String whereSql=freemarkEngine.parseByStringTemplate(params, filterSql);
		
		sql+=whereSql;
		
		
		
		sqlModel.setSql(sql);
		sqlModel.setDsName(dsName);
		sqlModels.add(sqlModel);
		
		
	}
	
	private JSONArray getJsonAry(JSONArray mapper){
		JSONArray ary=new JSONArray();
		for(int i=0;i<mapper.size();i++){
			JSONObject json=mapper.getJSONObject(i);
			String mapType=json.getString("mapType");
			if(StringUtil.isEmpty(mapType)) continue;
			ary.add(json);
		}
		return ary;
	}
	
	private void handDel(JSONObject tableSetting,JSONObject jsonObj,JSONObject oldJsonObj,DataHolder dataHolder,List<SqlModel> sqlModels,String dsName,Map<String,Object> extParams) throws TemplateException, IOException{
		String tableName=tableSetting.getString("tableName");
		String filterSql=tableSetting.getString("filterSql");
		
		String sql="delete from " +tableName +" where  ";
		
	 
		
		Map<String,Object> params=new HashMap<>();
		params.put("cur", jsonObj);
		
		String whereSql=freemarkEngine.parseByStringTemplate(params, filterSql);
		
		sql+=whereSql;
		
		
		SqlModel model=new SqlModel(sql);
		model.setDsName(dsName);
		sqlModels.add(model);
		
		
	}
	
	private String handInsert(JSONObject tableSetting,JSONObject jsonObj,JSONObject oldJsonObj,DataHolder dataHolder,String newPkId,List<SqlModel> sqlModels,String dsName,Map<String,Object> extParams){
	
		String tableName=tableSetting.getString("tableName");

		String sql="insert into " + tableName +"(";
		
		String fields="";
		
		String values="";
		
		SqlModel sqlModel=new SqlModel();
		
		JSONArray data=tableSetting.getJSONArray("gridData");
		
		JSONArray mapper= getJsonAry(data);
		
		String pkVal="";
		for(int i=0;i<mapper.size();i++){
			JSONObject json=mapper.getJSONObject(i);
			String mapType=json.getString("mapType");
			ITableFieldValueHandler valHandler=tableFieldValueHandlerConfig.getByMapType(mapType);
			if(valHandler==null){
				continue;
			}
			String fieldName=json.getString("fieldName");
			String columnType=json.getString("columnType");
			String mapValue=json.getString("mapValue");
			boolean isPk=json.getBooleanValue("isPk");
			
			Object obj= valHandler.getFieldValue(columnType, newPkId, dataHolder, jsonObj, oldJsonObj, mapValue,extParams);
			
			boolean isParam=valHandler.isParameterize();
			
			if(isPk){
				pkVal=obj.toString();
			}
			
			String pre=(i==0)? "" :",";
			
			fields+=pre+ fieldName ;
			
			if(isParam){
				sqlModel.addParam(fieldName, obj);
				values+=pre + ":"+ fieldName ;
			}
			else{
				if(columnType.equals("varchar")){
					values+=pre + "'" + obj.toString() +"'";
				}
				else{
					values+=pre + "'" + obj+"'";
				}
			}
			
		}
		sql+=fields +") values ("+values+")";
		
		
		
		sqlModel.setSql(sql);
		sqlModel.setDsName(dsName);
		sqlModels.add(sqlModel);
		return pkVal;
	}
	
	private void handSubSetting(JSONObject tableSetting,DataHolder holder,String entName,String dsName,List<SqlModel> sqlModels,Map<String,Object> extParams) throws TemplateException, IOException{
		
		SubDataHolder dataHolder= holder.getSubData(entName);
		
		//获取子表增加的数据。
		List<JSONObject> addList= dataHolder.getAddList();
		for(JSONObject jsonObj:addList){
			handSubAdd( tableSetting, jsonObj, holder, sqlModels,dsName,extParams);
		}
		
		//获取子表更新的数据
		List<UpdJsonEnt> updList= dataHolder.getUpdList();
		for(UpdJsonEnt jsonEnt:updList){
			handSubUpd(tableSetting, jsonEnt, holder,sqlModels,dsName,extParams);
		}
		
		//获取子表删除的数据。
		List<JSONObject> delList= dataHolder.getDelList();
		for(JSONObject jsonObj:delList){
			handSubDel( tableSetting, jsonObj, holder,sqlModels,dsName,extParams);
		}
	}
	
	
	private void handSubAdd(JSONObject tableSetting,JSONObject jsonObject,DataHolder holder,List<SqlModel> sqlModels,String dsName,Map<String,Object> extParams) throws TemplateException, IOException{
		String operator=tableSetting.getString("operator");
		String condition=tableSetting.getString("condition");
		//没有过滤条件直接不处理
		boolean needFilter=needFilterSql(tableSetting);
		if(needFilter) return ;
		
		boolean rtn=handNewSubCondition(condition, holder, jsonObject,extParams);
		
		if(!rtn) throw new RuntimeException("执行条件不满足："+condition);
		//根据操作类型判断做何种操作。
		handByOperator( operator, tableSetting,jsonObject,null, holder,  sqlModels,dsName,extParams);
		
		
	}
	
	/**
	 * 处理子表数据更新
	 * @param tableSetting
	 * @param jsonObject
	 * @param holder
	 * @param isTest
	 * @throws TemplateException
	 * @throws IOException
	 */
	private void handSubUpd(JSONObject tableSetting,UpdJsonEnt jsonObject,DataHolder holder,List<SqlModel> sqlModels,String dsName,Map<String,Object> extParams) throws TemplateException, IOException{
		String operator=tableSetting.getString("operator");
		String condition=tableSetting.getString("condition");
		//没有过滤条件直接不处理
		boolean needFilter=needFilterSql( tableSetting);
		if(needFilter) return ;
		
		boolean rtn=handUpdSubCondition(condition, holder, jsonObject,extParams);
		
		if(!rtn) return;
		
		handByOperator( operator, tableSetting,jsonObject.getCurJson(),jsonObject.getOriginJson(), holder, sqlModels,dsName,extParams);
		
	}
	
	/**
	 * 根据操作类型调用不同的操作。
	 * @param operator
	 * @param tableSetting
	 * @param jsonObj
	 * @param oldJsonObj
	 * @param holder
	 * @param isTest
	 * @throws TemplateException
	 * @throws IOException
	 */
	private void handByOperator(String operator,JSONObject tableSetting,JSONObject jsonObj,JSONObject oldJsonObj,DataHolder holder,List<SqlModel> sqlModels,String dsName,Map<String,Object> extParams) throws TemplateException, IOException{
		switch(operator){
			case DataHolder.ACTION_NEW:
				handInsert(tableSetting, jsonObj, null, holder, holder.getNewPk(),sqlModels,dsName,extParams);
				break;
			case DataHolder.ACTION_UPD:
				
				handUpd(tableSetting, jsonObj, oldJsonObj, holder,sqlModels,dsName,extParams);
				break;
			case DataHolder.ACTION_DEL:
				handDel(tableSetting, jsonObj, null, holder,sqlModels,dsName,extParams);
				break;
		}
	}
	
	/**
	 * 处理数据删除
	 * @param tableSetting
	 * @param jsonObject
	 * @param holder
	 * @throws IOException 
	 * @throws TemplateException 
	 */
	private void handSubDel(JSONObject tableSetting,JSONObject jsonObject,DataHolder holder,List<SqlModel> sqlModels,String dsName,Map<String,Object> extParams) throws TemplateException, IOException{
		String operator=tableSetting.getString("operator");
		String condition=tableSetting.getString("condition");
		//没有过滤条件直接不处理
		boolean needFilter=needFilterSql( tableSetting);
		if(needFilter) return ;
		
		boolean rtn=handDelSubCondition(condition, holder, jsonObject,extParams);
		
		if(!rtn) return;
		
		handByOperator( operator, tableSetting,jsonObject,null, holder,  sqlModels,dsName,extParams);
		
	}
	

	/**
	 * 处理条件是否满足。
	 * @param entName
	 * @param condition
	 * @param isMain
	 * @return 
	 */
	private boolean handMainCondition(String condition,String action,DataHolder holder,Map<String,Object> extParams){
		if(StringUtil.isEmpty(condition)) return true;
		Map<String,Object> params=new HashMap<>();
		
		if(action.equals(DataHolder.ACTION_UPD)){
			params.put("cur", holder.getCurMain());
			params.put("old", holder.getOriginMain());
		}
		else{
			params.put("cur", holder.getCurMain());
		}
		
		params.put("action",action);
		
		params.putAll(extParams);
		
		Boolean rtn= (Boolean) groovyEngine.executeScripts(condition, params);
		
		return rtn;
	}
	
	/**
	 * 子表记录行更新处理
	 * @param condition
	 * @param holder
	 * @param jsonEnt
	 * @return
	 */
	private boolean handUpdSubCondition(String condition,DataHolder holder,UpdJsonEnt jsonEnt ,Map<String,Object> extParams){
		if(StringUtil.isEmpty(condition)) return true;
		Map<String,Object> params=new HashMap<>();
		
		params.put("mainCur", holder.getCurMain());
		params.put("mainOld", holder.getOriginMain());
		
		params.put("cur", jsonEnt.getCurJson());
		params.put("old", jsonEnt.getOriginJson());
		
		params.put("action", DataHolder.ACTION_UPD);
		
		params.putAll(extParams);
		
		Boolean rtn= (Boolean) groovyEngine.executeScripts(condition, params);
		
		return rtn;
	}
	
	/**
	 * 处理子表数据新增的情况。
	 * 子表 数据新增 也分为两种情况。
	 *  1.新增时新增
	 *  2.更新时新增
	 * @param condition
	 * @param holder
	 * @param jsonObject
	 * @return
	 */
	private boolean handNewSubCondition(String condition,DataHolder holder,JSONObject jsonObject,Map<String,Object> extParams ){
		if(StringUtil.isEmpty(condition)) return true;
		
		String action=holder.getAction();
		
		Map<String,Object> params=new HashMap<>();
		
		if(action.equals(DataHolder.ACTION_UPD)){
			params.put("mainCur", holder.getCurMain());
			params.put("mainOld", holder.getOriginMain());
			
			params.put("cur", jsonObject);
			params.put("old", null);
		}
		else{
			params.put("main", holder.getCurMain());
			params.put("cur", jsonObject);
		}
		
		params.put("action", DataHolder.ACTION_NEW);
		
		params.putAll(extParams);
		
		Boolean rtn= (Boolean) groovyEngine.executeScripts(condition, params);
		
		return rtn;
	}
	
	/**
	 * 处理子表数据删除是的条件。
	 * @param condition
	 * @param holder
	 * @param jsonObject
	 * @return
	 */
	private boolean handDelSubCondition(String condition,DataHolder holder,JSONObject jsonObject ,Map<String,Object> extParams ){
		if(StringUtil.isEmpty(condition)) return true;
		
		Map<String,Object> params=new HashMap<>();
		
		params.put("main", holder.getCurMain());
		params.put("cur", jsonObject);
		params.put("action", DataHolder.ACTION_DEL);
		
		params.putAll(extParams);
		
		
		Boolean rtn= (Boolean) groovyEngine.executeScripts(condition, params);
		
		return rtn;
	}
	
	
	/**
	 * 将主从进行分开处理。
	 * @param jsonAry
	 * @return
	 */
	private Map<String, List<JSONObject>> getSettingMap(JSONArray jsonAry){
		Map<String, List<JSONObject>> map=new HashMap<String, List<JSONObject>>();
		for(int i=0;i<jsonAry.size();i++){
			JSONObject json=jsonAry.getJSONObject(i);
			String isMain=json.getString("isMain").equals("yes")?"main":"sub";
			if(map.containsKey(isMain)){
				List<JSONObject> list=map.get(isMain);
				list.add(json);
			}
			else{
				List<JSONObject> list=new ArrayList<>();
				list.add(json);
				map.put(isMain, list);
			}
		}
		return map;
		
	}

	
}
