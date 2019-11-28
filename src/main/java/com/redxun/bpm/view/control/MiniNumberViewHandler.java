package com.redxun.bpm.view.control;

import java.text.DecimalFormat;
import java.util.Map;

import com.redxun.core.database.api.model.Column;
import com.redxun.core.util.BeanUtil;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.util.StringUtil;

public class MiniNumberViewHandler implements MiniViewHanlder {

	@Override
	public String getPluginName() {
		return "mini-spinner";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String val=getVal(jsonObj, el);
		if(StringUtil.isNotEmpty(val)){
		el.attr("value",val);
		return;
		}
	}
	
	private String getVal(JSONObject jsonObj,Element el){
		String name = el.attr("name");
		String property = el.attr("property");
		if(StringUtil.isNotEmpty(property) && "editor".equals(property)) {
			return "";
		}
		Double val=  jsonObj.getDouble(name);
		String tmp="";
		if(val!=null) {
			tmp=new DecimalFormat("#.###").format(val);
			
		}
		return tmp;
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name = el.attr("name");
		Double orginVal=jsonObj.getDouble(name);
		//String val=getVal(jsonObj, el);
		String val=getVal(el, jsonObj,true);
		if(StringUtil.isEmpty(val)){
			el.replaceWith(new Element(Tag.valueOf("span"), "").text(""));
			return ;
		}
		
		String format = el.attr("fpattern");
		
		FormViewUtil.addHidden(el, val);
		
		String display=val;
		if(StringUtil.isNotEmpty(format)){
			display=new DecimalFormat(format).format(orginVal);
		}
		el.replaceWith(new Element(Tag.valueOf("span"), "").text(display));

	}

	private String getVal(Element el,JSONObject jsonObj,boolean display){
		String name=el.attr("name");
		String format=el.attr("format");
		String dataType=el.attr("datatype");
		String property = el.attr("property");
		if(StringUtil.isNotEmpty(property) && "editor".equals(property)) {
			return "";
		}
		if(!Column.COLUMN_TYPE_NUMBER.equals(dataType)) {
			return BeanUtil.isEmpty(jsonObj.getString(name))?el.attr("value"):jsonObj.getString(name);
		}
		Object val=jsonObj.get(name);
		if(BeanUtil.isEmpty(val)) return el.attr("value");

		try{
			Double orginVal=new Double(val.toString());

			if(display && StringUtil.isNotEmpty(format)){
				String value=new DecimalFormat(format).format(orginVal);
				if(value.startsWith(".")){
					return "0" + value;
				}
				return value;
			}
			else{
				return new DecimalFormat("#.###").format(orginVal);
			}
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}

}
