package com.redxun.bpm.form.impl.formhandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmInstTmpManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.bo.manager.DataHolder;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.customform.manager.SysCustomFormSettingManager;

public class PcFormHandler extends AbstractFormHandler {
	
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	BpmNodeSetManager bpmNodeSetManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	SysCustomFormSettingManager sysCustomFormSettingManager;
	@Resource
	BpmInstDataManager bpmInstDataManager;
	@Resource
	RuntimeService runtimeService;
	@Resource
	BpmInstTmpManager bpmInstTmpManager;
	@Resource
	SysBoEntManager sysBoEntManager;


	@Override
	public String getType() {
		return IFormHandler.FORM_TYPE_PC;
	}

	@Override
	public List<FormModel> getStartForm(String solId,String instId, String jsonStr) throws Exception {
		BpmSolution bpmSolution=bpmSolutionManager.get(solId);
	
		List<BpmFormView>	bpmFormViews = bpmFormViewManager.getStartFormView(solId,bpmSolution.getActDefId());
		List<FormModel> modelList=new ArrayList<FormModel>();
		
		if(BeanUtil.isEmpty(bpmFormViews)){
			FormModel model=new FormModel();
			model.setResult(false);
			model.setMsg("表单设置为空!");
			modelList.add(model);
			return modelList;
		}
		//自定义URL表单
		BpmInst bpmInst=null;
		if(StringUtil.isNotEmpty(instId)){
			bpmInst=bpmInstManager.get(instId);
		}
		
		Map<String,Object> vars=new HashMap<String, Object>();

		for(BpmFormView bpmFormView:bpmFormViews){
			FormModel model=new FormModel();
			model.addParams("nodeId_", "PROCESS_");
			FormUtil.setFormModelByFormView(model, bpmFormView,bpmInst);
			if(model.getType().equals(BpmFormView.FORM_TYPE_SEL_DEV)){
				modelList.add(model);
				return modelList;
			}
			
			JSONObject jsonData=null;
			if(StringUtil.isNotEmpty(jsonStr)){
				IFormDataHandler handler=BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_DB);
				jsonData= handler.getData(bpmFormView.getBoDefId(), jsonStr);
				if(jsonData.size()==0) {
					jsonData= bpmInstTmpManager.getByBusKey(jsonStr);
				} 
			}
			else{
				if(StringUtil.isEmpty(instId)){
					jsonData=FormUtil.getData(bpmSolution, bpmFormView);
				}else{
					jsonData=FormUtil.getData(bpmInst, bpmFormView,vars);
					if(jsonData.size()==0) {
						jsonData=bpmInstTmpManager.getByInstId(instId);
					}
				}
			}
			
			jsonData = getJsonData(jsonData,bpmFormView.getBoDefId());
			
			
			model= FormUtil.getByStart(bpmSolution,bpmFormView,jsonData,false,false);
			model.setDescription(bpmFormView.getName());
			model.setBoDefId(bpmFormView.getBoDefId());
			model.setFormKey(bpmFormView.getKey());
			modelList.add(model);
		}
		
		return modelList;
	}
	
	private JSONObject getJsonData(JSONObject jsonData,String boDefId) {
		JSONObject json = jsonData;
		SysBoEnt boEnt=sysBoEntManager.getByBoDefId(boDefId);
		List<SysBoEnt> list= boEnt.getBoEntList();
		
		if(BeanUtil.isEmpty(list)) return json;
		
		JSONObject initJson=new JSONObject();
		
		for(SysBoEnt subEnt:list){
			
			JSONObject subJson=sysBoEntManager.getJsonByEnt(subEnt);
			if(subJson.size()>0) {
				initJson.put(subEnt.getName(), subJson);
			}
			if(SysBoRelation.RELATION_ONETOMANY.equals( subEnt.getRelationType())){
				//根据外键获取数据。
				JSONArray jsonAry= json.getJSONArray(subEnt.getName());
				if(jsonAry!=null && jsonAry.size()>0) {
					json.put(SysBoEnt.SUB_PRE +  subEnt.getName(), jsonAry);
					json.remove(subEnt.getName());
				}
			}
			else{
				JSONObject jsonSub= json.getJSONObject(subEnt.getName());
				if(jsonSub!=null && jsonSub.size()>0) {
					json.put(SysBoEnt.SUB_PRE +  subEnt.getName(), jsonSub);
					json.remove(subEnt.getName());
				}
			}
			
		}
		
		return json;
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
	

	@Override
	public List<FormModel> getByTaskId(String taskId,String jsonStr) throws Exception{
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		
		Map<String,Object> vars= runtimeService.getVariables(bpmTask.getProcInstId());
		
		String solId=bpmInst.getSolId();
		String actDefId=bpmInst.getActDefId();
		String nodeId=bpmTask.getTaskDefKey();
		List<FormModel> list=new ArrayList<FormModel>();
		//找到任务对应的配置表单
		List<BpmFormView> bpmFormViews=bpmFormViewManager.getTaskFormViews(solId,actDefId,nodeId,bpmInst.getInstId());
		if(BeanUtil.isEmpty(bpmFormViews)) return list;
		
		List<FormModel> rtnModels=new ArrayList<FormModel>();
		
		for(BpmFormView fv:bpmFormViews){
			
			//在线表单
			if(BpmFormView.FORM_TYPE_SEL_DEV.equals(fv.getType())){
				FormModel model=new FormModel();
				model.addParams("nodeId_", bpmTask.getTaskDefKey());
				FormUtil.setFormModelByFormView(model, fv,bpmInst);
				rtnModels.add(model);
				return rtnModels;
			}
			JSONObject jsonData= FormUtil.getData(bpmInst,fv,vars);
			//设置意见数据。
			FormUtil.setOpinionData(bpmInst, jsonData);
			FormModel model= FormUtil.getByTask(bpmInst,bpmTask,fv,jsonData, false,false);
			model.setBoDefId(fv.getBoDefId());
			model.setFormKey(fv.getKey());
			model.setType(fv.getType());
			rtnModels.add(model);
		}

		return rtnModels;
		
	
	}
	
	

	@Override
	public List<FormModel> getByInstId(String instId) throws Exception {
		return this.getByInstId(instId, false);
	}

	
	@Override
	public FormModel getFormByFormAlias(String alias, JSONObject jsonData, boolean readOnly, Map<String, Object> params)
			throws Exception {
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(alias,tenantId);
		FormModel formModel= FormUtil.getByFormView(bpmFormView, jsonData, readOnly, false);
		return formModel;
	}

	@Override
	public FormModel getFormByFormAlias(String alias, String pk,boolean readOnly,Map<String,Object> params) throws Exception {
		FormModel model=FormUtil.getFormByFormAlias(alias, pk, readOnly, false,params);
		return model;
	}
	

}
