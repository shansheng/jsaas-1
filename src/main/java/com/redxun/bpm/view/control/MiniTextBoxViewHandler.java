package com.redxun.bpm.view.control;

import java.text.DecimalFormat;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.form.impl.formhandler.FormUtil;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.database.api.model.Column;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.manager.SysSeqIdManager;
/**
 *
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniTextBoxViewHandler implements MiniViewHanlder {
	@Resource
	SysSeqIdManager sysSeqIdManager;

	@Resource
	GroovyEngine groovyEngine;

	@Override
	public String getPluginName() {
		return "mini-textbox";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String val = getVal( el, jsonObj,false);
		if(StringUtils.isEmpty(jsonObj.getString("ID_"))){
			if(StringUtils.isNotEmpty(val)){
				el.attr("value", val);
				return;
			}
		} else {
			el.attr("value", StringUtil.isEmpty(jsonObj.getString(el.attr("name"))) ? "" : val);
		}
	}

	private String getVal(Element el,JSONObject jsonObj,boolean display){
		String name=el.attr("name");
		String format=el.attr("format");
		String dataType=el.attr("datatype");
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
				return new DecimalFormat("#.##").format(orginVal);
			}
		}catch(Exception e){
			e.printStackTrace();
			return "";
		}
	}


	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
								  JSONObject jsonObj) {
		String val = getVal( el, jsonObj,false);
		FormViewUtil.addHidden(el, val);
		String display= getVal(el,jsonObj,true);
		FormUtil.convertFieldToReadOnly(el, params, jsonObj,display);
	}



}
