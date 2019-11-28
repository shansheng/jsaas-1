package com.redxun.bpm.form.impl.formhandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmInstData;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.util.BeanUtil;

public abstract class AbstractFormHandler implements IFormHandler {
	
	@Resource
	BpmInstManager bpmInstManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	BpmInstDataManager bpmInstDataManager;

	 
	public List<FormModel> getByInstId(String instId,boolean isPrint) throws Exception {
		BpmInst bpmInst = bpmInstManager.get(instId);
		
		List<BpmFormView> bpmFormViews = bpmFormViewManager.getDetailFormView(bpmInst.getSolId(), bpmInst.getActDefId(),instId);
		if(BeanUtil.isEmpty(bpmFormViews)) return null;
		
		List<FormModel> list=new ArrayList<FormModel>();
		
		BpmFormView view=bpmFormViews.get(0);
		BpmSolFv bpmSolFv=view.getBpmSolFv();
		if(bpmSolFv.getFormType().equals(BpmFormView.FORM_TYPE_SEL_DEV)){
			FormModel model=new FormModel();
			FormUtil.setFormModelByFormView(model, view,bpmInst);
			list.add(model);
			return list;
		}
		
		List<BpmInstData> bpmInstDatas= bpmInstDataManager.getByInstId(instId);
		
		Map<String,BpmFormView> viewMap=convertToViewMap(bpmFormViews);
		
		List<FormModel> rtnModels=new ArrayList<FormModel>();
		
		for(BpmInstData instData:bpmInstDatas){
			String boDefId=instData.getBoDefId();
			BpmFormView formView=viewMap.get(boDefId);
			if(formView==null){
				continue;
			}
			JSONObject jsonData= FormUtil.getData(bpmInst,boDefId);
			//设置意见数据。
			FormUtil.setOpinionData(bpmInst, jsonData);
			FormModel model=FormUtil.getByInst(formView, bpmInst, jsonData,true,isPrint);
			model.setBoDefId(boDefId);
			model.setFormKey(formView.getKey());
			rtnModels.add(model);
		}
		return rtnModels;
	}
	

	protected Map<String,BpmFormView> convertToViewMap(List<BpmFormView> formViews){
		Map<String,BpmFormView> map=new HashMap<String, BpmFormView>();
		for(BpmFormView form:formViews){
			map.put(form.getBoDefId(), form);
		}
		return map;
	}
	
}
