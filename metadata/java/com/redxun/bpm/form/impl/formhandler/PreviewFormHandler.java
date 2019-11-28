package com.redxun.bpm.form.impl.formhandler;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.api.IPreviewFormHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormViewRight;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.form.manager.FormViewRightManager;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.context.HttpServletContext;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.core.util.JsaasUtil;

@Service
public class PreviewFormHandler implements IPreviewFormHandler {

	@Resource
	SysBoEntManager sysBoEntManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	FormViewRightManager formViewRightManager;
	
	@Override
	public String previewForm(String viewId,String title,String formHtml) throws Exception{
		BpmFormView formView=new BpmFormView();
		formView.setViewId(viewId);
		formView.setTitle(title);
		formView.setTemplateView(formHtml);
		String template=JsaasUtil.convertToFreemakTemplate(formHtml);
		
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
		JSONObject jsonData= getInitDataByForm(formView.getTemplate());
		
		HttpServletRequest request=HttpServletContext.getRequest();
		
		Map<String, Object> params = FormViewUtil.contructParams(request);
		
		String key=formView.getKey();
		
		Map<String, FormViewRight> rightMap = new HashMap<String, FormViewRight>() ;
		if (StringUtils.isNotEmpty(key)) {
			rightMap = formViewRightManager.getMapByFormKeyNodeId(key, FormViewRight.NODE_FORM);
		}
		
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		Map<String,String> rightsMap=FormUtil.calcRights(rightMap, profileMap, false);
		
		params.putAll(rightsMap);
		
		//setParams(jsonData,params);
		//处理tab
		FormUtil.handTab(formView, params, null,false);
		
		FormUtil.parseHtml(formView, params, jsonData, rightsMap, false);
		
		return formView.getTemplate();
	}

	@Override
	public JSONObject getInitDataByForm(String formHtml) {
		SysBoEnt boEnt= sysBoEntManager.parseHtml(formHtml);
		JSONObject jsonData=sysBoEntManager.getInitData(boEnt);
		return jsonData;
	}

}
