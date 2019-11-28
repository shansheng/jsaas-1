package com.redxun.bpm.view.control;

import java.util.Date;
import java.util.Map;

import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;


/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public abstract class MiniDateViewHandler implements MiniViewHanlder {
	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name=el.attr("name");
		
		String val="";
		String format=el.attr("format");
		Object obj=jsonObj.get(name);
		if (obj instanceof Date) {
			if(StringUtil.isEmpty(format)){
				format="yyyy-MM-dd";
			}
			val=DateUtil.formatDate((Date) obj, format);
		}
		else{
			val=FastjsonUtil.getString(jsonObj, name);
			if(val.indexOf("T")>-1){
				val=getValue(format, val);
			}
		}
		
		
		el.attr("value",val);
	}
	
	protected String getValue(String formatStr,String val){
		val= val.replace("T", " ");
		Date date= DateUtil.parseDate(val,"yyyy-MM-dd HH:mm:ss");
		String str= DateUtil.formatDate(date, formatStr);
		return str;
	}
	
	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params, JSONObject jsonObj) {
		FormViewUtil.addHidden(el, el.val());
		el.replaceWith(new Element(Tag.valueOf("span"), "").text(el.val()));
		
	}
	
	
}
