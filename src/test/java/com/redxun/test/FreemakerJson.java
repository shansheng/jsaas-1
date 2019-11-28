package com.redxun.test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;

import freemarker.template.TemplateException;

public class FreemakerJson  extends BaseTestCase{
	
	@Resource
	FreemarkEngine freemarkEngine;
	

	@Test
	public void testTemplate() throws IOException, TemplateException{
		String content=FileUtil.readFile("D:\\temp\\template.txt");
		
		Document  doc= Jsoup.parseBodyFragment(content);
		
		Elements  elements= doc.select("[plugins=\"rx-grid\"]");
		
		Map<String,String> htmlMap=new HashMap<String, String>();
		
		for(Element el:elements){
			JSONObject jsonGrid= getMetaData( el);
			
			String gridId=jsonGrid.getString("gridId");
			
			el.prepend("<div id=\"div_"+ gridId +"\"></div>");
			
			Map<String,Object> params=new HashMap<String, Object>();
			params.put("grid", jsonGrid);
			
			String html=freemarkEngine.mergeTemplateIntoString("form/render/grid.ftl", params);
			
			htmlMap.put(gridId, html);
			
			Elements tables= el.select(".rx-grid>table");
			
			if(tables.size()>0){
				tables.get(0).remove();
			}
			
			Elements divInit= el.select(".rx-grid > ._initdata");
			if(divInit.size()>0){
				divInit.remove();
			}
		}
		
		String html= doc.body().html();
		for (Entry<String, String> ent : htmlMap.entrySet()) {
			String replace="<div id=\"div_" +ent.getKey() +"\"></div>";
			html=html.replace(replace, ent.getValue());
		}
		
		System.out.println(html);
	
	}
	
	private JSONObject getMetaData(Element el){
		//name="grid" edittype="inline"
		JSONObject json=new JSONObject();
		json.put("gridId", el.attr("name"));
		//openwindow,inline,
		String edittype=el.attr("edittype");
		json.put("edittype", el.attr("edittype"));
		
		json.put("formkey", el.attr("formkey"));
		json.put("formname", el.attr("formname"));
		
		json.put("formname", el.attr("formname"));
		json.put("oncellendedit", el.attr("oncellendedit"));
		
		Elements headEls= el.select("div.rx-grid > table >thead > tr > th.header");
		Elements bodyEls= el.select("div.rx-grid > table >tbody > tr > td");
		
		JSONArray ary=new JSONArray();
		for(int i=0;i<headEls.size();i++){
			JSONObject subJson=new JSONObject();
			Element headEl=headEls.get(i);
			Element bodyEl=bodyEls.get(i);
			
			subJson.put("name", headEl.attr("header"));
			subJson.put("comment", headEl.html());
			subJson.put("width", headEl.attr("width"));
			subJson.put("format", headEl.attr("format"));
			subJson.put("datatype", headEl.attr("datatype"));
			String options=headEl.attr("data-options");
			if(StringUtil.isNotEmpty(options)){
				subJson.put("dataoptions", options);
			}
			
			subJson.put("displayfield", headEl.attr("displayfield"));
			subJson.put("vtype", headEl.attr("vtype"));
			if("inline".equals( edittype)){
				if(!bodyEl.children().isEmpty()){
					subJson.put("editor", bodyEl.child(0).outerHtml());
				}
			}
			ary.add(subJson);
		}
		json.put("fields", ary);
		
		return json;
	}
	
}
