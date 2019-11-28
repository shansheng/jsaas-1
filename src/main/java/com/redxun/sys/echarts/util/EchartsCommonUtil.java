package com.redxun.sys.echarts.util;

import java.text.NumberFormat;
import java.util.Arrays;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.sys.echarts.entity.SysEchartsCustom;

/**
 * Echarts通用方法
 * @author Louis
 */
public class EchartsCommonUtil {
	
	//生成标题title的json数据
	public static JSONObject titleHandler(SysEchartsCustom customQuery) {
		String titleField = customQuery.getTitleField();
		JSONObject title = JSON.parseObject(titleField);
		return title;
	}
	
	//生成图例legend的json数据
	@SuppressWarnings("unchecked")
	public static JSONObject legendHandler(JSONArray jArrayField, JSONArray jArrayData, SysEchartsCustom customQuery) {
		JSONArray jArrayLegend = new JSONArray();
		//图例标记legend
		Map<String, Object> singleData = (Map<String, Object>)jArrayData.get(0);
		
		for(int i = 0; i < jArrayField.size(); i++) {
			JSONObject obj = JSON.parseObject(String.valueOf(jArrayField.get(i)));
			if(singleData.containsKey(obj.get("fieldName"))) {
				jArrayLegend.add(obj.get("comment"));
			}
		}
		JSONObject legend = new JSONObject();
		legend.put("data", jArrayLegend);
		
		String legendField = customQuery.getLegendField();
		JSONObject legObj = new JSONObject();
		legObj = JSON.parseObject(legendField);
		legend.putAll(legObj);
		
		return legend;
	}
	
	//对数组进行处理
	public static String handleArrays(String[] arr) {
		String arrStr = Arrays.toString(arr);
		if(arr.length <= 1) {
			arrStr = arrStr.substring(1, arrStr.length() - 1);
		}
		return arrStr;
	}
	
	//百分数转换成double
	public static double parsePrecentToNum(String strNum) throws Exception {
		NumberFormat format = NumberFormat.getNumberInstance();
		Number num = format.parse(strNum);
		return num.doubleValue();
	}
}
