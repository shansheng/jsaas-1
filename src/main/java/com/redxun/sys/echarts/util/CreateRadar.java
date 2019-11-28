package com.redxun.sys.echarts.util;

import java.util.ArrayList;
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
 * 制作 雷达图 JSON数据
 * @author Louis
 */
public class CreateRadar {
	
	//生成雷达图
	public static JSONObject createEchartsRadar(HttpServletRequest req, SysEchartsCustom customQuery, 
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
		
		JSONObject seriesJson = JSON.parseObject(customQuery.getSeriesField());
		
		String xAxisField = customQuery.getxAxisDataField(); //图例字段
		JSONArray xAxisArr = JSON.parseArray(xAxisField);
		
		JSONObject series = new JSONObject();
		JSONArray seriesData = new JSONArray();
		
		JSONArray legendArr = new JSONArray();
		double[] maxVals = {};
		
		JSONObject radar = new JSONObject();
		
		if(customQuery.getDetailMethod() != null && customQuery.getDetailMethod() == 0) { //以列为数据
			maxVals = new double[resultList.size()];//最大值数据
			
			for(int i = 0; i < jArrayField.size(); i++) {//数据栏位信息
				JSONObject obj = jArrayField.getJSONObject(i);//单个数据栏位信息

				String[] dataVal = new String[resultList.size()]; //列数据集合
				int index = 0;
				for(Map<String, Object> map : resultList) {//sql结果集
					Set<String> keySet = map.keySet();//行数据栏位
					for(String field : keySet) {
						if(obj.getString("fieldName").equals(field)) {//如果数据栏位名称和行数据单个栏位名称相同
							String val = String.valueOf(map.get(field));
							dataVal[index] = val;
							double _val = 0d;
							try {
								_val = Double.parseDouble(StringUtil.isEmpty(val) ? "0" : val);
							} catch(Exception e) {
								//转换异常不处理
							}
							//最大值设置
							if(maxVals[index] < _val) {
								maxVals[index] = _val;
							}
							index++;
						}
					}
				}
				
				JSONObject singleData = new JSONObject();
				legendArr.add(obj.getString("comment"));
				singleData.put("name", obj.getString("comment"));
				singleData.put("value", dataVal);
				seriesData.add(singleData);
			}
			
			//重新建立新的图例字段
			JSONArray newArrayField = new JSONArray();
			if(xAxisArr != null) {
				for(Map<String, Object> map : resultList) {
					Set<String> keySet = map.keySet();
					
					List<String> singlelist = new ArrayList<String>();
					for(int i = 0; i < xAxisArr.size(); i++) {
						JSONObject obj = xAxisArr.getJSONObject(i);
						if(keySet.contains(obj.getString("fieldName"))) {
							singlelist.add(String.valueOf(map.get(obj.getString("fieldName"))));
						}
					}
					JSONObject singleJson = new JSONObject();
					singleJson.put("comment", singlelist.toString());
					newArrayField.add(singleJson);
				}
			}
			
			setMaxValue(maxVals);
			radar = setRadarProp(newArrayField, maxVals, seriesJson);
			
		} else {//以行为数据
			maxVals = new double[jArrayField.size()];//最大值数据
			//series-data数据
			for(Map<String, Object> map : resultList) {//sql结果集
				Set<String> keySet = map.keySet();//行数据
				
				String[] pre_name= {};
				if(xAxisArr!=null) {
					pre_name = new String[xAxisArr.size()];//行数据的图例字段合并名称
					for(int i = 0; i < xAxisArr.size(); i++) {//图例字段栏位
						JSONObject obj = xAxisArr.getJSONObject(i);//单个图例字段信息
						 if(keySet.contains(obj.getString("fieldName"))) {//如果行数据中包含图例字段
							 pre_name[i] = String.valueOf(map.get(obj.get("fieldName")));//[2018Q1, zhangsan, beijing]
						 }
					}
				}
				
				String[] dataVal = new String[jArrayField.size()];//data中每一个图例的数据集
				for(int i = 0; i < jArrayField.size(); i++) {//数据栏位的数量
					JSONObject obj = jArrayField.getJSONObject(i);//单个数据栏位信息
					if(keySet.contains(obj.getString("fieldName"))) {//如果行数据包含数据栏位
						String val = String.valueOf(map.get(obj.get("fieldName")));//行数据当前栏位的数值
						dataVal[i] = val;
						double _val = 0d;
						try {
							_val = Double.parseDouble(StringUtil.isEmpty(val) ? "0" : val);
						} catch(Exception e) {
							//转换异常不做处理
						}
						//最大值设置
						if(maxVals[i] < _val) {
							maxVals[i] = _val;
						}
					}
				}
				
				JSONObject singleData = new JSONObject();
				legendArr.add(EchartsCommonUtil.handleArrays(pre_name));
				singleData.put("name", EchartsCommonUtil.handleArrays(pre_name));
				singleData.put("value", dataVal);
				seriesData.add(singleData);
			}
			
			setMaxValue(maxVals);
			radar = setRadarProp(jArrayField, maxVals, seriesJson);
		}
		
		series.put("data", seriesData);
		series.put("type", "radar");
		series.put("emphasis", setSeriesEmphasis(seriesJson));
		
		JSONObject legend = EchartsCommonUtil.legendHandler(jArrayField, jArrayData, customQuery);
		legend.remove("data");
		legend.put("data", legendArr);
		
		JSONObject optionMap = new JSONObject();
		optionMap.put("title", EchartsCommonUtil.titleHandler(customQuery));
		optionMap.put("legend", legend);
		optionMap.put("tooltip", new JSONObject());
		optionMap.put("series", series);
		optionMap.put("radar", radar);
		//System.err.println(optionMap);
		
		return optionMap;
	}
	
	//设置series-emphasis
	private static JSONObject setSeriesEmphasis(JSONObject seriesJson) {
		int emphasisType = seriesJson.getInteger("selectedMode");
		JSONObject emphasisJson = new JSONObject();
		if(emphasisType != 1) {
			emphasisJson.put("areaStyle", new JSONObject());//阴影区域 
		}
		JSONObject labelJson = new JSONObject();
		labelJson.put("show", "true");
		labelJson.put("formatter", "function(params){return params.value;}"); //设置显示数值
		emphasisJson.put("label", labelJson);
		return emphasisJson;
	}
	
	//设置radar属性
	public static JSONObject setRadarProp(JSONArray jArrayField, double[] maxVals, JSONObject seriesJson) {
		JSONObject radar = new JSONObject();
		radar.put("indicator", setIndicator(jArrayField, maxVals));
		
		JSONArray raidus = seriesJson.getJSONArray("radius");
		seriesJson.remove("radius");
		seriesJson.put("radius", raidus.getDouble(1) + "%");
		radar.putAll(seriesJson);
		radar.remove("selectedMode");
		
		return radar;
	}
	
	//雷达图坐标系
	public static JSONArray setIndicator(JSONArray jArrayField, double[] maxVals) {
		JSONArray indiArr = new JSONArray();
		for(int i = 0; i < jArrayField.size(); i++) {
			JSONObject fieldObj = jArrayField.getJSONObject(i);
			
			JSONObject single = new JSONObject();
			single.put("name", fieldObj.getString("comment"));
			single.put("max", maxVals[i]);
			indiArr.add(single);
		}
		return indiArr;
	}
	
	//设置最大数值
	private static double[] setMaxValue(double[] maxVals) {
		for(int i = 0; i < maxVals.length; i++) {
			int num = (int)Math.ceil(maxVals[i]);
			String _num = num + "";
			int len = _num.length();
			int val = (int)(((Integer.parseInt(String.valueOf(_num.charAt(0)))) + 1) * Math.pow(10, len - 1));
			maxVals[i] = val;
		}
		return maxVals;
	}
}
