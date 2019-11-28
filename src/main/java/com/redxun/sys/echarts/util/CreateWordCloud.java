package com.redxun.sys.echarts.util;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.sys.echarts.entity.SysEchartsCustom;

/**
 * 制作 字符云 JSON数据
 * @author Louis
 */
public class CreateWordCloud {
	//字符云
	public static JSONObject createEchartsWordCloud(HttpServletRequest req, SysEchartsCustom customQuery, 
			FreemarkEngine freemarkEngine, CommonDao commonDao) throws Exception {
		String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
		List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, sql, commonDao); //按SQL查询返回的数据
		
		String resultField = customQuery.getDataField(); //返回栏位信息
		JSONArray jArrayField = JSON.parseArray(resultField); //数据栏位Json
		
		JSONArray xArrayField = JSON.parseArray(customQuery.getxAxisDataField());
	
		int detailMethod = customQuery.getDetailMethod();
		JSONObject seriesJson = JSON.parseObject(customQuery.getSeriesField());
		
		JSONArray seriesData = new JSONArray();
		//行数据
		if(detailMethod == 0) {//行数据
			JSONObject sumMap = new JSONObject();
			for(Map<String, Object> map : resultList) {
				Set<String> keySet = map.keySet();
				for(int i = 0; i < jArrayField.size(); i++) {
					JSONObject obj = jArrayField.getJSONObject(i);
					String fieldName = obj.getString("fieldName");
					String comment = obj.getString("comment");
					if(keySet.contains(fieldName)) {
						double val = 0d;
						try {
							val = Double.parseDouble(String.valueOf(map.get(fieldName)));
						} catch(Exception e) {//Nothing Todo
						}
						if(sumMap.keySet().contains(comment)) {
							val += Double.parseDouble(String.valueOf(sumMap.get(comment)));
						}
						sumMap.put(comment, val);
					}
				}
			}
			
			for(int j = 0; j < jArrayField.size(); j++) {
				JSONObject obj = jArrayField.getJSONObject(j);
				String comment = obj.getString("comment");
				JSONObject single = new JSONObject();
				single.put("name", comment);
				single.put("value", sumMap.getDouble(comment));
				seriesData.add(single);
			}
		} else { //列数据
			String[] charField = new String[resultList.size()];
			int rowIndex = 0;
			JSONObject sumMap = new JSONObject();
			for(Map<String, Object> map : resultList) {
				double val = 0d;
				Set<String> keySet = map.keySet();
				for(int j = 0; j < jArrayField.size(); j++) {
					JSONObject o = jArrayField.getJSONObject(j);
					if(keySet.contains(o.getString("fieldName"))) {
						try {
							val += Double.parseDouble(String.valueOf(map.get(o.getString("fieldName"))));
						} catch (Exception e) {//Nothing Todo
						}
					}
				}
				if(xArrayField != null) {
					String[] pre_name = new String[xArrayField.size()];
					for(int j = 0; j < xArrayField.size(); j++) {
						JSONObject o = xArrayField.getJSONObject(j);
						if(keySet.contains(o.getString("fieldName"))) {
							pre_name[j] = String.valueOf(map.get(o.getString("fieldName")));
						}
					}
					sumMap.put(EchartsCommonUtil.handleArrays(pre_name), val);
					charField[rowIndex++] = EchartsCommonUtil.handleArrays(pre_name);
				} else {
					sumMap.put("" + rowIndex, val);
					charField[rowIndex] = "" + rowIndex++;
				}
			}
			
			for(int j = 0; j < charField.length; j++) {
				JSONObject single = new JSONObject();
				single.put("name", charField[j]);
				single.put("value", sumMap.get(charField[j]));
				seriesData.add(single);
			}
		}
		
		JSONObject optionMap = new JSONObject();
		optionMap.put("series", setSeries(seriesData, seriesJson));
		//System.out.println(optionMap);
		
		return optionMap;
	}
	
	//设置series
	private static JSONObject setSeries(JSONArray seriesData, JSONObject seriesJson) {
		JSONObject series = new JSONObject();
		series.put("type", "wordCloud");
		series.put("width", seriesJson.getString("width") + "%");
		series.put("height", seriesJson.getString("height") + "%");
		series.put("sizeRange", seriesJson.getJSONArray("sizeRange"));
		series.put("rotationRange", seriesJson.getJSONArray("rotationRange"));
		series.put("rotationStep", seriesJson.getDouble("rotationStep"));
		series.put("gridSize", seriesJson.getDouble("gridSize"));
		series.put("drawOutOfBound", seriesJson.getString("drawOutOfBound").equals("0") ? false : true);
		series.put("data", seriesData);
		series.put("textStyle", setTextStyle());
		return series;
	}
	
	private static JSONObject setTextStyle() {
		JSONObject textStyle = new JSONObject();
		
		JSONObject normal = new JSONObject();
		normal.put("fontFamily", "sans-serif");
		normal.put("fontWeight", "bold");
		normal.put("color", "function(){return 'rgb('+[Math.round(Math.random()*160),Math.round(Math.random()*160),Math.round(Math.random()*160)].join(',')+')'}");
		textStyle.put("normal", normal);
		
		JSONObject emphasis = new JSONObject();
		emphasis.put("shadowBlur", 4);
		emphasis.put("shadowColor", "#888");
		textStyle.put("emphasis", emphasis);
		
		return textStyle;
	}
}
