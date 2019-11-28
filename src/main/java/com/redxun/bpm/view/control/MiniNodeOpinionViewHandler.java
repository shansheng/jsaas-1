package com.redxun.bpm.view.control;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;


public class MiniNodeOpinionViewHandler implements MiniViewHanlder{
	
	@Resource
	FreemarkEngine freemarkEngine;
	
	@Override
	public String getPluginName() {
		return "mini-nodeopinion";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		name=name.replace(IExecutionCmd.FORM_OPINION, "");
		String html=getOpinion( name, jsonObj);
		if(StringUtil.isNotEmpty(html)){
			el.before(html);
		}
	}

	/**
	 * 表单意见数据
	 * form_opinion_:{
	 * 	zsld:[{userId:"",userName:"",opinion:"",createTime:"",type:""}]
	 * }
	 */
	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
			JSONObject jsonObj) {
		el.remove();
	}
	
	/**
	 * 取得表单意见。
	 * @param name
	 * @param jsonObj
	 * @return
	 */
	private String getOpinion(String name,JSONObject jsonObj) {
		JSONObject data= jsonObj.getJSONObject("form_opinion_");
		if(BeanUtil.isEmpty(data)) return "";
		
		JSONArray jsonAry=data.getJSONArray(name);
		if(BeanUtil.isEmpty(jsonAry)) return "" ;
		
		Map<String,Object> model=new HashMap<String, Object>();
		model.put("opinions", jsonAry);
		
		String str="";
		try {
			str = freemarkEngine.mergeTemplateIntoString("form/render/opinion.ftl", model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
		
	}


}
