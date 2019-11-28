package com.redxun.bpm.form.impl.formhandler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;

public class PrintFormHandler extends AbstractFormHandler {
	
	@Resource
	BpmSolutionManager bpmSolutionManager;
	@Resource
	BpmTaskManager bpmTaskManager;
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	

	@Override
	public String getType() {
		return IFormHandler.FORM_TYPE_PRINT;
	}
	
	
	/**
	 * //	{
		//	    "bos": [
		//	        {
		//	            "boDefId": "2400000001991001",
		//	            "formKey": "simple3",
		//	            "readOnly": false,
		//	            "data": {
		//	                "bo_Def_Id_": "2400000001991001",
		//	                "name": "44",
		//	                "address": "44"
		//	            }
		//	        }
		//	    ]
		//	}
	 */
	@Override
	public List<FormModel> getStartForm(String solId,String instId, String jsonStr) throws Exception {
		BpmSolution bpmSolution=bpmSolutionManager.get(solId);
		
		List<BpmFormView> bpmFormViews = bpmFormViewManager.getStartFormView(solId,bpmSolution.getActDefId());
		
		List<FormModel> formModels=new ArrayList<FormModel>();
		
		if(BeanUtil.isEmpty(bpmFormViews)){
			FormModel model=new FormModel();
			model.setResult(false);
			model.setMsg("表单设置为空");
			formModels.add(model);
			return formModels;
		}

		BpmInst bpmInst=null;
		if(StringUtil.isNotEmpty(instId)){
			bpmInst=bpmInstManager.get(instId);
		}
		if(StringUtil.isEmpty(jsonStr)){
			jsonStr="{}";
		}
		JSONObject jsonData=JSONObject.parseObject(jsonStr);
		Map<String,JSONObject> map= FormUtil. convertJsonToMap(jsonData);
		for(BpmFormView bpmFormView:bpmFormViews){
			FormModel model=new FormModel();
			FormUtil.setFormModelByFormView(model, bpmFormView,bpmInst);
			if(model.getType().equals(BpmFormView.FORM_TYPE_SEL_DEV)){
				formModels.add(model);
				continue;
			}
			JSONObject json=map.get(bpmFormView.getBoDefId());
			
			model= FormUtil.getByStart(bpmSolution,bpmFormView,json,true,true);
			formModels.add(model);
		}
		return formModels;
	}
	
	
	

	

	@Override
	public List<FormModel> getByTaskId(String taskId, String jsonStr) throws Exception {
		BpmTask bpmTask = bpmTaskManager.get(taskId);
		BpmInst bpmInst = bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		
		String solId=bpmInst.getSolId();
		String actDefId=bpmInst.getActDefId();
		String nodeId=bpmTask.getTaskDefKey();
		
		List<BpmFormView> bpmFormViews = bpmFormViewManager.getTaskFormViews(solId, actDefId,nodeId,bpmInst.getInstId());
		List<FormModel> models=new ArrayList<FormModel>();
		FormModel model=null;
		if(BeanUtil.isEmpty(bpmFormViews)){
			model=new FormModel();
			model.setResult(false);
			model.setMsg("表单设置为空");
			models.add(model);
			return models;
		}
		
		JSONObject jsonData=JSONObject.parseObject(jsonStr);
		Map<String,JSONObject> map= FormUtil. convertJsonToMap(jsonData);
		
		for(BpmFormView bpmFormView:bpmFormViews){
			model=new FormModel();
			FormUtil.setFormModelByFormView(model, bpmFormView,bpmInst);
			if(model.getType().equals(BpmFormView.FORM_TYPE_SEL_DEV)){
				continue;
			}
			String boDefId=bpmFormView.getBoDefId();
			JSONObject dataObj=FormUtil.getData(bpmInst,boDefId);
			JSONObject newDataObj=map.get(boDefId);
			if(newDataObj==null){
				newDataObj=new JSONObject();
			}
			FastjsonUtil.copyProperties(dataObj, newDataObj);
			
			model= FormUtil.getByTask(bpmInst,bpmTask, bpmFormView, dataObj, true,true);
			models.add(model);
		}
		return models;
	}

	@Override
	public List< FormModel> getByInstId(String instId) throws Exception {
		return this.getByInstId(instId, true);
	}
	
	@Override
	public FormModel getFormByFormAlias(String alias, String pk,boolean readOnly,Map<String,Object> params) throws Exception {
		FormModel model=FormUtil.getFormByFormAlias(alias, pk, true, true,params);
		return model;
	}
	
	@Override
	public FormModel getFormByFormAlias(String alias, JSONObject jsonData, boolean readOnly, Map<String, Object> params)
			throws Exception {
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(alias,tenantId);
		FormModel formModel= FormUtil.getByFormView(bpmFormView, jsonData, readOnly, true);
		return formModel;
	}

}
