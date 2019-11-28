package com.redxun.bpm.view.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.RequestUtil;

/**
 * 表单视图工具类
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class FormViewUtil {
	/**
	 * 构建参数
	 * @param request
	 * @return
	 */
	public static Map<String,Object> contructParams(HttpServletRequest request){
		Map<String,Object> reqparams=RequestUtil.getParameterValueMap(request, false);
		//构建参数
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("params",reqparams);
		params.put(FormViewConsts.PARAM_CTX_PATH, request.getContextPath());
		params.put(FormViewConsts.PARAM_CUR_USER,ContextUtil.getCurrentUser());
		params.put(FormViewConsts.PARAM_START_USER_ID, ContextUtil.getCurrentUserId());
		//加入参数处理
		String actInstId=request.getParameter("actInstId");
		if(StringUtils.isNotEmpty(actInstId)){
			params.put(FormViewConsts.PARAM_ACT_INST_ID, actInstId);
		}
		//当前节点Id
		String nodeId=request.getParameter("nodeId");
		if(StringUtils.isNotEmpty(nodeId)){
			params.put(FormViewConsts.PARAM_NODE_ID, nodeId);
		}
		Date curDate=new Date();
		
		SimpleDateFormat fullSdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		SimpleDateFormat ymdSdf=new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat ymSdf=new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat hmsSdf=new SimpleDateFormat("HH:mm:ss");
		
		params.put(FormViewConsts.PARAM_CUR_TIME_FULL,fullSdf.format(curDate));
		params.put(FormViewConsts.PARAM_CUR_TIME_YMD, ymdSdf.format(curDate));
		params.put(FormViewConsts.PARAM_CUR_TIME_YM, ymSdf.format(curDate));
		params.put(FormViewConsts.PARAM_CUR_TIM_HMS, hmsSdf.format(curDate));
		
		return params;
	}
	
	
	public static void addHidden(Element el,JSONObject  jsonObj,boolean isComplex,boolean replace){
		String name = el.attr("name");
		String textname = el.attr("textname");
		String val = FastjsonUtil.getString(jsonObj, name);
		
		Element elHidden= new Element(Tag.valueOf("input"), "");
		elHidden.addClass("mini-hidden");
		elHidden.attr("value", val);
		elHidden.attr("name", name);
		el.after(elHidden);
		if(isComplex){
			String text=FastjsonUtil.getString(jsonObj, textname);
			Element elHiddenText= new Element(Tag.valueOf("input"), "");
			elHiddenText.addClass("mini-hidden");
			elHiddenText.attr("value", text);
			elHiddenText.attr("name", textname);
			el.after(elHiddenText);
			if(replace){
				el.replaceWith(new Element(Tag.valueOf("span"), "").text(text));
			}
			
		}
		else{
			if(replace){
				el.replaceWith(new Element(Tag.valueOf("span"), "").text(val));
			}
			
		}
		
	}
	
	
	
	
	public static void addHidden(Element el,String val){
		String name = el.attr("name");
		 
		Element elHidden= new Element(Tag.valueOf("input"), "");
		elHidden.addClass("mini-hidden");
		elHidden.attr("value", val);
		elHidden.attr("name", name);
		el.after(elHidden);
	
	}
	
	public static void addHidden(Element el, String name,String val){
		 
		Element elHidden= new Element(Tag.valueOf("input"), "");
		elHidden.addClass("mini-hidden");
		elHidden.attr("value", val);
		elHidden.attr("name", name);
		el.after(elHidden);
	
	}
	 
	
}
