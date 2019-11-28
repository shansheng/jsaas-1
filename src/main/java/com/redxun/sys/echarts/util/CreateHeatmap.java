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
import com.redxun.core.util.StringUtil;
import com.redxun.sys.echarts.entity.SysEchartsCustom;

/**
 * 制作 热力图 JSON数据
 * @author Louis
 */
public class CreateHeatmap {
	//热力图
	public static JSONObject createEchartsHeatmap(HttpServletRequest req, SysEchartsCustom customQuery, 
			FreemarkEngine freemarkEngine, CommonDao commonDao) throws Exception {
		String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
		List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, sql, commonDao); //按SQL查询返回的数据
		if(resultList.size() == 0) {
			return null;
		}
		
		String resultField = customQuery.getDataField(); //返回栏位信息
		JSONArray jArrayField = JSON.parseArray(resultField); //数据栏位Json
		
		JSONArray xAxisDataField = JSON.parseArray(customQuery.getxAxisDataField());
		JSONObject seriesFieldJson = JSON.parseObject(customQuery.getSeriesField());
		
		int detailMethod = customQuery.getDetailMethod(); //是否行列转换
		
		//行数据
		double min = 0d;
		double max = 0d;
		JSONArray xAxisData = new JSONArray();//x轴数据集合
		JSONArray yAxisData = new JSONArray();//y轴数据集合
		JSONArray seriesData = new JSONArray();//series-data数据集合
		int index = 0;
		for(Map<String, Object> map : resultList) {
			Set<String> keySet = map.keySet();
			for(int j = 0; j < jArrayField.size(); j++) {
				JSONObject obj = jArrayField.getJSONObject(j);
				String fieldName = obj.getString("fieldName");
				if(keySet.contains(fieldName)) {
					JSONArray singleData = new JSONArray();
					if(detailMethod == 0) {
						singleData.add(j);
						singleData.add(index);
					} else {
						singleData.add(index);
						singleData.add(j);
					}
					
					String val = String.valueOf(map.get(fieldName));
					double _val = 0d;
					try {
						_val = Double.parseDouble(val);
					} catch (Exception e) {
						//不做处理
					}
					min = min <= _val ? min : _val;
					max = max >= _val ? max : _val;
					singleData.add(_val);
					seriesData.add(singleData);
				}
				if(index == resultList.size() - 1) {
					if(detailMethod == 0) {
						xAxisData.add(obj.getString("comment"));
					} else {
						yAxisData.add(obj.getString("comment"));
					}
				}
			}
			
			if(xAxisDataField != null) {
				String[] pre_name = new String[xAxisDataField.size()];
				for(int j = 0; j < xAxisDataField.size(); j++) {
					JSONObject obj = xAxisDataField.getJSONObject(j);
					String fieldName = obj.getString("fieldName");
					if(keySet.contains(fieldName)) {
						pre_name[j] = String.valueOf(map.get(fieldName));
					}
				}
				if(detailMethod == 0) {
					yAxisData.add(EchartsCommonUtil.handleArrays(pre_name));
				} else {
					xAxisData.add(EchartsCommonUtil.handleArrays(pre_name));
				}
			}
			
			index++;
		}
		
		JSONObject optionMap = new JSONObject();
		optionMap.put("title", EchartsCommonUtil.titleHandler(customQuery));
		optionMap.put("tooltip", new JSONObject());
		optionMap.put("grid", JSON.parse(customQuery.getGridField()));
		optionMap.put("xAxis", settingXAxisDetail(xAxisData));
		optionMap.put("yAxis", settingYAxisDetail(yAxisData));
		optionMap.put("visualMap", settingVisualMap(JSON.parseObject(customQuery.getLegendField()), seriesFieldJson, min, max));
		optionMap.put("series", settingSeriesDetail(seriesData, seriesFieldJson));
		//System.out.println(optionMap);
		
		return optionMap;
	}
	
	//设置series数据
	private static JSONObject settingSeriesDetail(JSONArray seriesData, JSONObject seriesFieldJson) {
		JSONObject show = new JSONObject();
		show.put("show", seriesFieldJson.getString("labelShow").equals("0") ? false : true);
		JSONObject series = new JSONObject();
		series.put("data", seriesData);
		series.put("type", "heatmap");
		JSONObject seriesLabel = new JSONObject();
		seriesLabel.put("normal", show);
		series.put("label", seriesLabel);
		JSONObject emphasis = new JSONObject();
		emphasis.put("shadowBlur", 10);
		emphasis.put("shadowColor", "rgba(0, 0, 0, 0.5)");
		JSONObject seriesItemStyle = new JSONObject();
		seriesItemStyle.put("emphasis", emphasis);
		series.put("itemStyle", seriesItemStyle);
		return series;
	}
	
	//设置xAxis数据
	private static JSONObject settingXAxisDetail(JSONArray xAxisData) {
		JSONObject show = new JSONObject();
		show.put("show", true);
		JSONObject xAxis = new JSONObject();
		xAxis.put("type", "category");
		xAxis.put("data", xAxisData);
		xAxis.put("splitArea", show);
		return xAxis;
	}
	
	//是指yAxis数据
	private static JSONObject settingYAxisDetail(JSONArray yAxisData) {
		JSONObject show = new JSONObject();
		show.put("show", true);
		JSONObject yAxis = new JSONObject();
		yAxis.put("type", "category");
		yAxis.put("data", yAxisData);
		yAxis.put("splitArea", show);
		return yAxis;
	}
	
	//设置映射
	private static JSONObject settingVisualMap(JSONObject legendJson, JSONObject seriesFieldJson, double min, double max) {
		JSONArray radiusArr = seriesFieldJson.getJSONArray("radius");
		JSONObject visualMap = new JSONObject();
		if(legendJson != null) {
			visualMap.put("min", StringUtil.isEmpty(radiusArr.getString(0)) ? min : Double.parseDouble(radiusArr.getString(0)));
			visualMap.put("max", StringUtil.isEmpty(radiusArr.getString(1)) ? max : Double.parseDouble(radiusArr.getString(1)));
			visualMap.put("show", legendJson.getBoolean("show"));
			visualMap.put("type", legendJson.getString("type"));
			visualMap.put("calculable", legendJson.getString("calculable").equals("0") ? true : false);
			visualMap.put("orient", legendJson.getString("orient"));
			visualMap.put("x", legendJson.getString("x"));
			visualMap.put("y", legendJson.getString("y"));
		}
		return visualMap;
	}
}
