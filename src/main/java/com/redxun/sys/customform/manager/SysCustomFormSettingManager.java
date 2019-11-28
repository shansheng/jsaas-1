
package com.redxun.sys.customform.manager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.api.IFlowService;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormulaSetting;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.util.DbUtil;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.bo.entity.BoResult;
import com.redxun.sys.bo.entity.BoResult.ACTION_TYPE;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.bo.manager.DataHolderEvent;
import com.redxun.sys.bo.manager.SubDataHolder;
import com.redxun.sys.bo.manager.SysBoDataHandler;
import com.redxun.sys.bo.manager.SysBoDefManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.customform.dao.SysCustomFormSettingDao;
import com.redxun.sys.customform.entity.SysCustomFormSetting;
import com.sun.star.uno.RuntimeException;

/**
 * 
 * <pre> 
 * 描述：自定义表单配置设定 处理接口
 * 作者:mansan
 * 日期:2017-05-16 10:25:38
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysCustomFormSettingManager extends MybatisBaseManager<SysCustomFormSetting>{
	@Resource
	private SysCustomFormSettingDao sysCustomFormSettingDao;
	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	SysBoDataHandler sysBoDataHandler;
	@Resource
	CommonDao commonDao;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
    IFlowService flowService;
	@Resource
	BpmInstDataManager bpmInstDataManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	SysBoDefManager sysBoDefManager;
	@Resource
	BpmTableFormulaManager bpmTableFormulaManager;
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysCustomFormSettingDao;
	}
	
	
	
	public boolean isAliasExist(SysCustomFormSetting formSetting){
		return sysCustomFormSettingDao.isAliasExist(formSetting);
	} 
	
	/**
	 * 根据别名获取
	 * @param alias
	 * @return
	 */
	public SysCustomFormSetting getByAlias(String alias){
		String tenantId=ContextUtil.getCurrentTenantId();
		SysCustomFormSetting cus=sysCustomFormSettingDao.getByAlias(alias, tenantId);
		if(cus==null){
			cus=sysCustomFormSettingDao.getByAlias(alias, ITenant.ADMIN_TENANT_ID);
		}
		return cus;
	} 
	
	/**
	 * 根据别名获取树形数据。
	 * @param alias
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public List<JSONObject> getTreeData(String alias,String parentId) throws Exception{
		SysCustomFormSetting setting=getByAlias(alias);
		String field= setting.getDisplayFields();
		String boDefId=setting.getBodefId();
		SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId) ;
		
		//如果加载模式为懒加载且没有输入父ID设置父ID为0
		if(setting.getLoadMode().intValue()==1 && StringUtil.isEmpty(parentId)  ){
			parentId="0";
		}
		
		List<JSONObject> list=sysBoDataHandler.getData(ent, parentId);
		String fkField=ent.getParentField();
		String pkField=ent.getPkField();
		for(JSONObject json:list){
			String val=json.getString(field);
			json.put("text_", val);
			if(ent.isDbMode()){
				String pid=json.getString(fkField);
				String id=json.getString(pkField);
				json.put(fkField, pid);
				json.put(pkField, id);
				json.remove(fkField);
				json.remove(pkField);
			}
		}
		//添加根节点。
		if("".equals(parentId) ||  parentId.equals("0")){
			JSONObject root=new JSONObject();
			root.put(pkField, "0");
			root.put(fkField, "-1");
			root.put("text_", setting.getName());
			list.add(0, root);
		}
		
		
		return list;
    }
	
	/**
	 * 根据别名和id删除主键。
	 * @param alias
	 * @param id
	 */
	public BoResult removeTreeById(String alias,String id){
		BoResult result = new BoResult();
		result.setAction(ACTION_TYPE.DELETE);
		SysCustomFormSetting setting=getByAlias(alias);
		if(StringUtil.isNotEmpty(setting.getDataHandler())){
			ICustomFormDataHandler handler=(ICustomFormDataHandler) AppBeanUtil.getBean(setting.getDataHandler());
			handler.delById(id);
		}else{
			String boDefId=setting.getBodefId();
			SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId) ;
			ent.setSetId(setting.getId());
			
			IFormDataHandler handler= BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_DB);
			JSONObject jsonObj= handler.getData(boDefId, id);
			//删除时发布事件。
			FormulaSetting formulaSetting=new FormulaSetting(setting.getId());
			formulaSetting.setMode(FormulaSetting.FORM);
			ProcessHandleHelper.setFormulaSetting(formulaSetting);
			
			DataHolder dataHolder=convertToDataHolder(jsonObj);
			WebAppUtil.publishEvent(new DataHolderEvent(dataHolder));
			
			List<String> list= getData(ent,id);
			for(String pk:list){
				result.setPk(pk);
				sysBoDataHandler.parseBoResult(result, ent, jsonObj);
				if(result.getIsSuccess()) {
					delByPkId(ent,pk);
				}
			}
		}
		return result;
	}
	
	/**
	 * 根据数据构建 DataHolder
	 * @param jsonObj
	 * @return
	 */
	private DataHolder convertToDataHolder(JSONObject jsonObj){
		DataHolder dataHolder=new DataHolder();
		dataHolder.setAction(DataHolder.ACTION_DEL);
		dataHolder.setCurMain(jsonObj);
		Set<String> keySet= jsonObj.keySet();
		for(String key:keySet){
			if(!key.startsWith(SysBoEnt.SUB_PRE)) continue;
			String entName=key.substring(4);
			Object obj= jsonObj.get(key);
			SubDataHolder subHolder=new SubDataHolder();
			if(obj instanceof JSONObject){
				subHolder.addDelList((JSONObject)obj);
			}
			else{
				JSONArray ary=(JSONArray)obj;
				subHolder.addDelJsonAry(ary);
			}
			dataHolder.addSubData(entName, subHolder);
		}
		return dataHolder;
	}
	
	public static void main(String[] args) {
		String str="SUB_stock";
		int idx=str.indexOf("SUB_");
		System.err.println(idx);
		System.out.println( str.substring(4));
	}
	
	private void delByPkId(SysBoEnt ent,String pkId){
		//刪除子表
		delSubById( ent, pkId);
		//根据主键删除
		delById( ent, pkId);
	}
	
	/**
	 * 删除子表记录。
	 * @param ent
	 * @param id
	 */
	private void delSubById(SysBoEnt ent,String id){
		if(BeanUtil.isEmpty( ent.getBoEntList())) return;
		
		for(SysBoEnt subEnt:ent.getBoEntList()){
			String fkField=subEnt.getParentField();
			if(StringUtil.isEmpty(fkField)) continue;
			String sql=" delete from " + subEnt.getTableName() + " where " + fkField + "=#{" +fkField +"}";
			SqlModel model=new SqlModel(sql);
			model.addParam(fkField , id);
			commonDao.execute(model);
		}
	}
	
	private void delById(SysBoEnt ent,String id){
		String pkField=ent.getPkField();
		String sql=" delete from " + ent.getTableName() + " where " + pkField + "=#{" +pkField +"}";
		SqlModel model=new SqlModel(sql);
		model.addParam(pkField , id);
		commonDao.execute(model);
	}
	
	private List<String> getData(SysBoEnt boEnt,String id){
		List<String> rtnList=new ArrayList<String>();
		rtnList.add(id);
		//递归访问
		getData(boEnt,id,rtnList);
		
		return rtnList;
	}
	
	private void getData(SysBoEnt boEnt,String id,List<String> rtnList){
		List<String> list= getListByPid( boEnt,id);
		if(BeanUtil.isEmpty(list)) return;
		rtnList.addAll(list);
		
		for(String pId:list){
			getData(boEnt,pId,rtnList);
		}
	}
	
	
	
	private List<String> getListByPid(SysBoEnt boEnt,String pid){
		List<String> rtnList=new ArrayList<String>();
		String fkField=boEnt.getParentField();
		if(StringUtil.isEmpty(fkField)) return rtnList;
		
		String pkField=boEnt.getPkField();
		
		String sql="select "+pkField +" from " + boEnt.getTableName() + " where "+fkField+"=#{"+pkField+"}";
		SqlModel model=new SqlModel(sql);
		model.addParam(pkField, pid);
		List<Map<String,Object>> list= (List<Map<String,Object>>) commonDao.query(model);
		
		for(Map<String,Object> row: list){
			String tmp=String.valueOf(row.get(pkField));
			rtnList.add(tmp);
		}
		return rtnList;
	} 
	
	
	
	/**
	 * 保存JSON数据。
	 * @param alias
	 * @param jsonData
	 * @return
	 */
	public BoResult saveData(SysCustomFormSetting formSetting,JSONObject jsonData){
		JSONObject formData=jsonData.getJSONObject("formData");
		
		//1.执行前置脚本
		String preScript=formSetting.getPreJavaScript();
		Map<String,Object> params=new HashMap<String, Object>();
		params.put("data", formData);
		if(StringUtil.isNotEmpty(preScript)){
			groovyEngine.executeScripts(preScript, params);
		}
		
		String boDefId=formSetting.getBodefId();
		
		//表间公式
		FormulaSetting formulaSetting=new FormulaSetting(formSetting.getId());
		formulaSetting.addExtParams("action", jsonData.getString("action"));
		if(StringUtil.isNotEmpty(formSetting.getSolId())){
			JSONObject setting=jsonData.getJSONObject("setting");
			//启动流程
			String action=setting.getString("action");
			boolean start=action.equals("startFlow");
			String op=start?"start":"draft";
			formulaSetting.addExtParams("op",op );
		}
		else{
			formulaSetting.addExtParams("op","save");
		}
		ProcessHandleHelper.setFormulaSetting(formulaSetting);
		
		//2.执行数据保存。
		BoResult result=null;
		String formDataHandler=formSetting.getDataHandler();
		if(StringUtil.isNotEmpty(formDataHandler)){
			ICustomFormDataHandler dataHandler=(ICustomFormDataHandler) AppBeanUtil.getBean(formDataHandler);
			result=dataHandler.save(boDefId,formData);
		}
		else{
			SysBoEnt ent=sysBoEntManager.getByBoDefId(boDefId) ;
			ent.setSetId(formSetting.getId());
			result= sysBoDataHandler.handleData(ent, formData);
		}
		
		if(!result.getIsSuccess())return result;
		
		if(StringUtil.isNotEmpty(formSetting.getSolId())){
			//3.启动流程。
			startFlow(formSetting, jsonData, result);
		}
		//4.执行后置脚本
		String afterScript=formSetting.getAfterJavaScript();
		if(StringUtil.isNotEmpty(afterScript)){
			params.put("result_", result);
			groovyEngine.executeScripts(afterScript, params);
		}
		
	
		
		return result;
	}
	
	/**
	 * 启动流程。
	 * @param formSetting
	 * @param jsonData
	 * @param result
	 */
	private void startFlow(SysCustomFormSetting formSetting,JSONObject jsonData,BoResult result){
		
		String solId=formSetting.getSolId();
		if(StringUtil.isEmpty(solId)) return;
		
		String formDataHandler=formSetting.getDataHandler();
		JSONObject setting=jsonData.getJSONObject("setting");
		//启动流程
		String action=setting.getString("action");
		boolean start=action.equals("startFlow");
		//取得流程实例，如果为不启动流程并且实例存在则返回。
		BpmInst bpmInst=bpmInstManager.getByBusKey(result.getPk());
		if(!start && bpmInst!=null){
			return;
		}
		
		if(start && bpmInst!=null && !BpmInst.STATUS_DRAFTED.equals( bpmInst.getStatus())){
			throw new RuntimeException("流程已处理!");
		}
		
		String boDefId=formSetting.getBodefId();
		JSONObject cmdJsonData=new JSONObject();
		
		JSONObject boJson=new JSONObject();
		boJson.put("boDefId",formSetting.getBodefId());
		boJson.put("formKey", formSetting.getFormAlias());
		boJson.put("readonly", "false");
		boJson.put("data", jsonData.getJSONObject("formData"));
		JSONArray bos=new JSONArray();
		bos.add(boJson);
		cmdJsonData.put("bos", bos);
		
		String userId=ContextUtil.getCurrentUserId();
		JsonResult<BpmInst> jsonResult= flowService.startProcess(userId,solId,result.getPk(),cmdJsonData.toJSONString(),"",start,"customForm");
		if(StringUtil.isEmpty(formDataHandler)){
			bpmInst=jsonResult.getData();
			//更新表单数据。
			updFormData( bpmInst, result);
			if(result.getAction().equals(BoResult.ACTION_TYPE.ADD)) {
				//增加
				bpmInstDataManager.addBpmInstData(boDefId, result.getPk(), bpmInst.getInstId());
			}
		}
			
	}
	
	/**
	 * 更新表单数据。
	 * @param bpmInst
	 * @param result
	 */
	private void updFormData(BpmInst bpmInst,BoResult result){
		SysBoEnt boEnt=result.getBoEnt();
		String pk=result.getPk();
		String pkField=result.getBoEnt().getPkField();
		
		String sql="update " + boEnt.getTableName() +" set " 
				+SysBoEnt.FIELD_INST +"=#{" + SysBoEnt.FIELD_INST +"},"
				+SysBoEnt.FIELD_INST_STATUS_ +"=#{" + SysBoEnt.FIELD_INST_STATUS_ +"}"
				+" where " + pkField + "=#{" + pkField +"}";
		//draft(草稿),runing(运行),complete(完成)
		String status=BpmInst.STATUS_DRAFTED;
		if(StringUtil.isNotEmpty(bpmInst.getActInstId())){
			status=BpmInst.STATUS_RUNNING;
		}
				
		SqlModel model=new SqlModel(sql);
		model.addParam(pkField, pk);
		model.addParam(SysBoEnt.FIELD_INST, bpmInst.getInstId());
		model.addParam(SysBoEnt.FIELD_INST_STATUS_, status);
		
		commonDao.execute(model);
		
	}
	
	/**
	 * 判断字段唯一性。
	 * @param tableName
	 * @param fieldName
	 * @param value
	 * @param pk
	 * @return
	 */
	public boolean isFieldUnique(String tableName,String fieldName,String value,String pk){
		String sql="select count(*) from "+ DbUtil.getTablePre()  +tableName+" where "+ DbUtil.getColumnPre() +fieldName  +"=#{"+ fieldName  +"}" ;
		if(StringUtil.isNotEmpty(pk)){
			sql+=" and " + SysBoEnt.SQL_PK +"!=#{"+ SysBoEnt.SQL_PK +"}";
		}
		SqlModel model=new SqlModel(sql);
		model.addParam(fieldName, value);
		if(StringUtil.isNotEmpty(pk)){
			model.addParam(SysBoEnt.SQL_PK, pk);
		}
		String comrtn=commonDao.queryOne(model).toString();
		Integer rtn=Integer.parseInt(comrtn);
		return rtn>0;
		
	}
	
	public String getTableRightJson(SysCustomFormSetting setting){
		String rightJson=setting.getTableRightJson();
    	String boDefId = setting.getBodefId();
    	SysBoEnt boEnt= sysBoEntManager.getByBoDefId(boDefId, false);
    
    	JSONObject rtnJson=new JSONObject();
    	if(boEnt==null){
    		return rtnJson.toJSONString();
    	}
    	List<SysBoEnt> subList=boEnt.getBoEntList();
    	if(BeanUtil.isEmpty(subList)) return "{}";    	
    	
    	if(StringUtil.isEmpty(rightJson)){
    		for(SysBoEnt ent:subList){
        		String name=ent.getName();        	
        		JSONObject typeJson=new JSONObject();
        		typeJson.put("type", "all");
        		typeJson.put("comment", ent.getComment());
        		rtnJson.put(name, typeJson);
    		}
    		return rtnJson.toJSONString();
    	}
    	JSONObject orginJson=JSONObject.parseObject(rightJson);
    	 
    	for(SysBoEnt ent:subList){
    		String name=ent.getName();
    		if(!orginJson.containsKey(name)){
    			JSONObject typeJson=new JSONObject();
    			typeJson.put("type", "all");
    			typeJson.put("comment", ent.getComment());
    			rtnJson.put(name, typeJson);
    		}
    		else{
    			JSONObject json=orginJson.getJSONObject(name);
    			json.put("comment", ent.getComment());		
    			rtnJson.put(name, json);
    		}
    	}
		return rtnJson.toJSONString();
	}
	
	public String getTableRightJsonByBoDefId(String boDefId){
		JSONObject rtnJson=new JSONObject();
		SysBoEnt boEnt= sysBoEntManager.getByBoDefId(boDefId, false);
		List<SysBoEnt> subList=boEnt.getBoEntList();
    	if(BeanUtil.isEmpty(subList)) return "{}";   
    	for(SysBoEnt ent:subList){
    		String name=ent.getName();        	
    		JSONObject typeJson=new JSONObject();
    		typeJson.put("type", "all");
    		typeJson.put("comment", ent.getComment());
    		rtnJson.put(name, typeJson);
		}
		return rtnJson.toJSONString();
	}

	public boolean saveDefault(BpmFormView bpmFormView) {
		String isCreate = bpmFormView.getIsCreate();
		if(!"on".equals(isCreate) && !"true".equals(isCreate)) return false;
		
		String key = bpmFormView.getKey();
		String name = bpmFormView.getName();
		String boDefId = bpmFormView.getBoDefId();
		
		SysCustomFormSetting sysCustomFormSetting = new SysCustomFormSetting();
		sysCustomFormSetting.setAlias(key);
		boolean rtn= isAliasExist(sysCustomFormSetting);
    	if(rtn){
    		sysCustomFormSetting = getByAlias(key);
    		sysCustomFormSetting.setBodefId(boDefId);
    		SysBoDef def = sysBoDefManager.get(boDefId);
        	if(BeanUtil.isNotEmpty(def)) {
        		sysCustomFormSetting.setBodefName(def.getName());
        	}
        	update(sysCustomFormSetting);
    		return false;
    	}
    	
    	sysCustomFormSetting.setId(IdUtil.getId());
   
    	sysCustomFormSetting.setTreeId(bpmFormView.getTreeId());
    	
    	sysCustomFormSetting.setName(name);
    	sysCustomFormSetting.setFormName(name);
    	sysCustomFormSetting.setFormAlias(key);
    	sysCustomFormSetting.setBodefId(boDefId);
    	SysBoDef def = sysBoDefManager.get(boDefId);
    	if(BeanUtil.isNotEmpty(def)) {
    		sysCustomFormSetting.setBodefName(def.getName());
    	}
    	sysCustomFormSetting.setIsTree(0);
    	sysCustomFormSetting.setTenantId(ContextUtil.getCurrentTenantId());
    	sysCustomFormSetting.setExpandLevel(1);
    	sysCustomFormSetting.setLoadMode(0);
    	sysCustomFormSetting.setTableRightJson("{}");
    	create(sysCustomFormSetting);
    	
    	
    	return true;
	}

	public List<SysCustomFormSetting> getJsonAll(QueryFilter queryFilter) {
		return sysCustomFormSettingDao.getJsonAll(queryFilter);
	}
	
}
