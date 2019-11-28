package com.redxun.sys.echarts.util;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.sys.echarts.entity.SysEchartsCustom;

/**
 * 制作 仪表图 JSON数据
 * @author Louis
 */
public class CreateGauge {

	//生成仪表图
	public static JSONObject createEchartsGauge(HttpServletRequest req, SysEchartsCustom customQuery, 
			FreemarkEngine freemarkEngine, CommonDao commonDao) throws Exception {
		String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
		String resultField = customQuery.getDataField(); //返回栏位信息
		
		JSONArray jArrayField = new JSONArray(); //栏位Json数据
		jArrayField = JSON.parseArray(resultField);
		
		List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, sql, commonDao);//按SQL查询返回的数据
		if(resultList.size() == 0) {
			return null;
		}
		JSONArray jArrayData = new JSONArray();
		jArrayData.addAll(resultList);
		
		//当前测试，随机选取其中一行数据，正式环境中，应当获取最新的数据为准 //TODO
		Map<String, Object> currentDetail = resultList.get(new java.util.Random().nextInt(resultList.size()));
		
		JSONArray seriesData = new JSONArray();
		for(String str : currentDetail.keySet()) {
			for(int i = 0; i < jArrayField.size(); i++) {
				JSONObject obj = (JSONObject) jArrayField.get(i);
				if(obj.get("fieldName").equals(str)) {
					String singleName = String.valueOf(obj.get("comment"));
					obj = new JSONObject();
					obj.put("value", currentDetail.get(str));
					obj.put("name", singleName);
					seriesData.add(obj);
				}
			}
		}
		JSONObject series = new JSONObject();
		series.put("name", customQuery.getName());
		series.put("data", seriesData);
		series.putAll(JSON.parseObject(customQuery.getSeriesField()));
		
		JSONObject optionMap = new JSONObject();
		optionMap.put("title", EchartsCommonUtil.titleHandler(customQuery));
		optionMap.put("legend", EchartsCommonUtil.legendHandler(jArrayField, jArrayData, customQuery));
		optionMap.put("tooltip", new JSONObject());
		optionMap.put("series", series);
		//System.err.println(optionMap);
		return optionMap;
	}
}
