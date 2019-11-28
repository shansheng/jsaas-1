package com.redxun.bpm.view.control;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.script.GroovyEngine;
/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MiniUserFormDefineHandler implements MiniViewHanlder {
	
	protected Logger logger=LogManager.getLogger(MiniUserFormDefineHandler.class);

	@Resource
	GroovyEngine groovyEngine;

	@Override
	public String getPluginName() {
		return "mini-textbox";
	}

	@Override
	public void parse(Element el, Map<String, Object> params, JSONObject jsonObj) {
		String name = el.attr("name");
		String val = FastjsonUtil.getString(jsonObj, name);
		
		if(StringUtils.isNotEmpty(val)){
			el.attr("value", val);
			return;
		}
	}

	@Override
	public void convertToReadOnly(Element el, Map<String, Object> params,
			JSONObject jsonObj) {
		String name = el.attr("name");
		String val = FastjsonUtil.getString(jsonObj, name);
		String datatype=el.attr("datatype");
		String title=el.attr("title");
		String format=el.attr("format");
		try{
			if(StringUtils.isNotEmpty(format)){
				if("Number".equals(datatype)){
					DecimalFormat df=new DecimalFormat(format);
					val=df.format(new Double(val));
				}else if("Date".equals(datatype)){
					SimpleDateFormat sdf=new SimpleDateFormat(format);
					val=sdf.format(val);
				}
			}
		}catch(Exception ex){
			logger.error(ex.getMessage());
		}
		// 不作任何处理，通过miniui的样式asLabel，由客户端进行处理
		
		el.replaceWith(new Element(Tag.valueOf("span"), "").text(val).attr("title", title));
	}

	

}
