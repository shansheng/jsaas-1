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
 * 制作 漏斗图 JSON数据
 * @author Louis
 */
public class CreateFunnel {
	
	//生成漏斗图
	public static JSONObject createEchartsFunnel(HttpServletRequest req, SysEchartsCustom customQuery, 
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
		JSONObject seriesJson = JSON.parseObject(customQuery.getSeriesField());
		
		if(customQuery.getDetailMethod() != null && customQuery.getDetailMethod() == 1) { //以列为数据
			int resultCount = jArrayField.size();
			int resultIndex = 0;
			int inlineCount = (resultCount + 1) / 2;
			int inlineIndex = 1;
			
			for(int i = 0; i < jArrayField.size(); i++) {
				JSONArray singleData = new JSONArray();
				for(Map<String, Object> map : resultList) {
					String[] pre_name = new String[xAxisArr.size()];
					Set<String> keySet = map.keySet();
					
					for(int k = 0; k < xAxisArr.size(); k++) {
						for(String str : keySet) {
							if(str.equals(xAxisArr.getJSONObject(k).getString("fieldName"))) {
								pre_name[k] = String.valueOf(map.get(str));
							}
						}
					}
					
					//JSONObject obj = (JSONObject) jArrayField.get(i);
					JSONObject obj = jArrayField.getJSONObject(i);
					//Set<String> keySet = map.keySet();
					JSONObject single = new JSONObject();
					for(String str : keySet) {
						if(obj.getString("fieldName").equals(str)) {
							single.put("value", map.get(str));
						}
						
						for(int j = 0; j < xAxisArr.size(); j++) {
							if(xAxisArr.getJSONObject(j).get("fieldName").equals(str)) {
								single.put("name", EchartsCommonUtil.handleArrays(pre_name));
							}
						}
					}
					singleData.add(single);
				}
				
				JSONObject seriesSingle = JSON.parseObject(customQuery.getGridField());
				positionSetting(seriesSingle, resultIndex, inlineIndex, inlineCount, jArrayField.size());
				seriesSingleDataSetting(seriesSingle, singleData, ((JSONObject) jArrayField.get(i)).getString("comment"), seriesJson);
				
				seriesDetail.add(seriesSingle);
				if(inlineIndex == inlineCount) {
					inlineIndex = 0;
				}
				resultIndex++;
				inlineIndex++;
			}
			
			JSONArray legendArr = new JSONArray();
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
			
			legend = EchartsCommonUtil.legendHandler(jArrayField, jArrayData, customQuery);
			legend.remove("data");
			legend.put("data", legendArr);
		} else { //以行为数据
			int resultCount = resultList.size();
			int resultIndex = 0;
			int inlineCount = (resultCount + 1) / 2;
			int inlineIndex = 1;
			
			for(Map<String, Object> map : resultList) {
				JSONArray dataArr = new JSONArray();
				for(int i = 0; i < jArrayField.size(); i++) {
					for(String str : map.keySet()) {
						JSONObject obj = jArrayField.getJSONObject(i);
						if(obj.get("fieldName").equals(str)) {
							String singleName = String.valueOf(obj.get("comment"));
							JSONObject dataSingleObj = new JSONObject();
							dataSingleObj.put("value", map.get(str));
							dataSingleObj.put("name", singleName);
							//dataSingleObj.put("id", str);
							dataArr.add(dataSingleObj);
						}
					}
				}
				
				JSONObject seriesSingle = JSON.parseObject(customQuery.getGridField());
				positionSetting(seriesSingle, resultIndex, inlineIndex, inlineCount, resultList.size());
				seriesSingleDataSetting(seriesSingle, dataArr, null, seriesJson);
				seriesDetail.add(seriesSingle);
				
				if(inlineIndex == inlineCount) {
					inlineIndex = 0;
				}
				resultIndex++;
				inlineIndex++;
			}
			legend = EchartsCommonUtil.legendHandler(jArrayField, jArrayData, customQuery);
		}
		
		JSONObject optionMap = new JSONObject();
		optionMap.put("title", EchartsCommonUtil.titleHandler(customQuery));
		optionMap.put("legend", legend);
		optionMap.put("tooltip", new JSONObject());
		optionMap.put("series", seriesDetail);
		//System.err.println(optionMap);
		return optionMap;
	}
	
	//series中的一些属性配置
	private static void seriesSingleDataSetting(JSONObject seriesSingle, JSONArray dataArr, String preName, JSONObject seriesJson) {
		seriesSingle.put("type", "funnel");
		seriesSingle.put("data", dataArr);
		
		String labelPosition = seriesJson.getString("labelPosition");
		
		JSONObject labelNormal = new JSONObject();
		labelNormal.put("position", StringUtil.isEmpty(labelPosition) ? "outside" : labelPosition);
		labelNormal.put("formatter", (StringUtil.isEmpty(preName)) ? "{b}" : preName + " {b}");
		JSONObject labelJson = new JSONObject();
		labelJson.put("normal", labelNormal);
		seriesSingle.put("label", labelJson);
	}
	
	//调整每个漏斗图的位置
	private static void positionSetting(JSONObject seriesSingle, 
				int resultIndex, int inlineIndex, int inlineCount, int size) {
		if(resultIndex < inlineCount) {
			seriesSingle.put("top", "10%");
			seriesSingle.put("bottom", "50%");
		} else {
			seriesSingle.put("bottom", "10%");
			seriesSingle.put("top", "50%");
		}
		seriesSingle.put("left", 90 / inlineCount * (inlineIndex - 1) + 5 + "%");
		seriesSingle.put("height", size == 1 ? "80%" : "35%");
		seriesSingle.put("width", (90 / inlineCount - 5) + "%");
	}
}
