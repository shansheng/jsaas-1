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
 * 制作 饼图 JSON数据
 * @author Louis
 */
public class CreatePie {
	
	public static JSONObject createEchartsPie(HttpServletRequest req, SysEchartsCustom customQuery, 
			FreemarkEngine freemarkEngine, CommonDao commonDao) throws Exception {
		String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
		String resultField = customQuery.getDataField(); //返回栏位信息
		
		JSONArray jArrayField = JSON.parseArray(resultField); //栏位Json数据
		List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, sql, commonDao); //按SQL查询返回的数据
		if(resultList.size() == 0) {
			return null;
		}
		JSONArray jArrayData = new JSONArray();
		jArrayData.addAll(resultList);
		
		JSONObject legend = new JSONObject();
		JSONArray seriesDetail = new JSONArray();
		
		String xAxisField = customQuery.getxAxisDataField();
		JSONArray xAxisArr = JSON.parseArray(xAxisField);
		
		JSONObject seriesProp = JSON.parseObject(customQuery.getSeriesField());
		
		//一般来说饼图只有一行的数据，但是如果是返回了多行的数据，改如何处理
		if(customQuery.getDetailMethod() != null && customQuery.getDetailMethod() == 1) { //以列为数据
			JSONArray radiusArr = seriesProp.getJSONArray("radius");
			
			int resultIndex = 0;
			double minRadi = Double.parseDouble(radiusArr.getString(0));
			double maxRadi = Double.parseDouble(radiusArr.getString(1));
			int rsSize = jArrayField.size();
			double gap = (maxRadi - minRadi) / (rsSize * 2 - 1);
			
			for(int i = 0; i < jArrayField.size(); i++) {
				JSONObject fieldObj = jArrayField.getJSONObject(i);
				JSONArray dataArr = new JSONArray();
				for(Map<String, Object> map: resultList) {
					Set<String> keySet = map.keySet();
					String[] pre_name = new String[0];
					if(xAxisArr != null) {
						pre_name = new String[xAxisArr.size()];
						for(int k = 0; k < xAxisArr.size(); k++) {
							JSONObject obj = xAxisArr.getJSONObject(k);
							if(keySet.contains(obj.getString("fieldName"))) {
								pre_name[k] = String.valueOf(map.get(obj.getString("fieldName")));
							}
						}
					}
					
					JSONObject dataSingleObj = new JSONObject();
					if(keySet.contains(fieldObj.getString("fieldName"))) {
						dataSingleObj.put("value", map.get(fieldObj.getString("fieldName")));
					}
					dataSingleObj.put("name", EchartsCommonUtil.handleArrays(pre_name));
					dataArr.add(dataSingleObj);
				}
				JSONObject seriesSingle = new JSONObject();
				seriesSingleSetting(seriesSingle, seriesProp, dataArr, resultIndex, maxRadi, gap, "row", jArrayField.getJSONObject(i).getString("comment"));
				seriesDetail.add(seriesSingle);
				resultIndex++;
			}
			
			JSONArray legendArr = new JSONArray();
			if(xAxisArr != null) {
				for(Map<String, Object> map : resultList) {
					String[] val_name = new String[xAxisArr.size()];
					Set<String> keySet = map.keySet();
					for(int j = 0; j < xAxisArr.size(); j++) {
						String field = xAxisArr.getJSONObject(j).getString("fieldName");
						if(keySet.contains(field)) {
							val_name[j] = String.valueOf(map.get(field));
						}
					}
					legendArr.add(EchartsCommonUtil.handleArrays(val_name));
				}
			}
			
			//rewrite legend.data
			legend = EchartsCommonUtil.legendHandler(jArrayField, jArrayData, customQuery);
			legend.remove("data");
			legend.put("data", legendArr);
		} else { //以行为数据
			JSONArray radiusArr = seriesProp.getJSONArray("radius");
			
			int resultIndex = 0;
			double minRadi = Double.parseDouble(radiusArr.getString(0));
			double maxRadi = Double.parseDouble(radiusArr.getString(1));
			int rsSize = resultList.size();
			double gap = (maxRadi - minRadi) / (rsSize * 2 - 1);
			
			for(Map<String, Object> map : resultList) {
				JSONArray dataArr = new JSONArray();
				for(int i = 0; i < jArrayField.size(); i++) {
					for(String str : map.keySet()) {
						JSONObject obj = jArrayField.getJSONObject(i);
						if(obj.get("fieldName").equals(str)) {
							String singleName = obj.getString("comment");
							JSONObject dataSingleObj = new JSONObject();
							dataSingleObj.put("value", map.get(str));
							dataSingleObj.put("name", singleName);
							dataArr.add(dataSingleObj);
						}
					}
				}
				
				JSONObject seriesSingle = new JSONObject();
				seriesSingleSetting(seriesSingle, seriesProp, dataArr, resultIndex, maxRadi, gap, "row", null);
				
				seriesDetail.add(seriesSingle);
				
				resultIndex++;
			}
			legend = EchartsCommonUtil.legendHandler(jArrayField, jArrayData, customQuery);
		}
		JSONObject series = new JSONObject();
		series.put("data", seriesDetail);
		series.putAll(seriesProp);
		
		JSONObject optionMap = new JSONObject();
		optionMap.put("title", EchartsCommonUtil.titleHandler(customQuery));
		optionMap.put("legend", legend);
		optionMap.put("tooltip", new JSONObject());
		optionMap.put("series", seriesDetail);
		//System.err.println(optionMap);
		return optionMap;
	}
	
	//调整每个环位置
	private static void seriesSingleSetting(JSONObject seriesSingle, JSONObject seriesProp, JSONArray dataArr, 
				int resultIndex, double maxRadi, double gap, String type, String commentName) {
		seriesSingle.put("type", "pie");
		seriesSingle.put("data", dataArr);
		seriesSingle.putAll(seriesProp);
		
		String position = seriesProp.getString("labelPosition");
		JSONObject labelJson = new JSONObject();
		labelJson.put("position", position);
		labelJson.put("formatter", (StringUtil.isEmpty(commentName) ? "{b}" : commentName + " - {b}"));
		seriesSingle.put("label", labelJson);
		
		if(position.equals("inside")) {
			JSONObject emphasisJson = new JSONObject();
			JSONObject emphasisLabelJson = new JSONObject();
			emphasisLabelJson.put("fontSize", 18);
			emphasisJson.put("label", emphasisLabelJson);
			seriesSingle.put("emphasis", emphasisJson);
		}
		
		JSONArray rdArr = new JSONArray();
		rdArr.add((maxRadi - resultIndex * (type.equals("row") ? 2 : 1) * gap - gap) + "%");
		rdArr.add((maxRadi - resultIndex * (type.equals("row") ? 2 : 1) * gap) + "%");
		seriesSingle.put("radius", rdArr);
	}
}
