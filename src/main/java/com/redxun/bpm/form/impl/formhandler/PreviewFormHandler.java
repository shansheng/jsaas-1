package com.redxun.bpm.form.impl.formhandler;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.bpm.form.api.IPreviewFormHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.OpinionDef;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.context.HttpServletContext;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;

@Service
public class PreviewFormHandler implements IPreviewFormHandler {

	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;

	
	@Override
	public String previewForm(String viewId,String title,String displayType,String formHtml) throws Exception{
		BpmFormView formView=new BpmFormView();
		formView.setViewId(viewId);
		formView.setTitle(title);
		formView.setTemplateView(formHtml);
		formView.setDisplayType(displayType);
		
		String template=bpmFormViewManager.convertToFreemakTemplate(formHtml);
    	
		formView.setTemplate(template);
		String html=getHtmlByFormView(formView);
		return html;
	}

	@Override
	public String previewFormById(String viewId) throws Exception{
		BpmFormView formView=bpmFormViewManager.get(viewId);
		String html=getHtmlByFormView(formView);
		return html;
	}
	
	private String getHtmlByFormView(BpmFormView formView) throws Exception{
		String template=formView.getTemplate();
		JSONObject jsonData= getInitDataByForm(template);
		
		SysBoEnt boEnt= getBoEnt( template);
		
		//
		JSONArray buttonAry= bpmFormViewManager.parseButtonDef(template);
		
		List<OpinionDef> opinionAry= bpmFormViewManager.parseOpinion(template);
		
		
		HttpServletRequest request=HttpServletContext.getRequest();
		
		Map<String, Object> params = FormViewUtil.contructParams(request);
		
		
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		
		BpmFormRightManager bpmFormRightManager =AppBeanUtil.getBean(BpmFormRightManager.class); 
		
		JSONObject rightSetting=bpmFormRightManager.getInitByBo(boEnt, buttonAry,  opinionAry);
		
		
		JSONObject rightsJson= bpmFormRightManager.calcRights(rightSetting, profileMap, false);
		
		params.put(BpmFormRight.PERMISSION, rightsJson);
		params.put(BpmFormRight.READONLY, false);
		
		FormUtil.handTab(formView, params, null,false);
		
		FormUtil.parseHtml(formView, params, jsonData, rightsJson, false);
		
		return formView.getTemplate();
	}

	@Override
	public JSONObject getInitDataByForm(String formHtml) {
		SysBoEnt boEnt= getBoEnt(formHtml);
		JSONObject jsonData=sysBoEntManager.getInitData(boEnt);
		return jsonData;
	}

	@Override
	public SysBoEnt getBoEnt(String formContent) {
		SysBoEnt boEnt= sysBoEntManager.parseHtml(formContent);
		return boEnt;
	}

}
