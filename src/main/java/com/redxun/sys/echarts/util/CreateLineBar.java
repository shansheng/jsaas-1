package com.redxun.sys.echarts.util;

import java.util.HashSet;
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
 * 制作 折线或者柱状图 JSON数据
 * @author Louis
 */
public class CreateLineBar {

	//生成折线或者柱状图
	public static JSONObject createEchartsCommonType(HttpServletRequest req, SysEchartsCustom customQuery, 
			FreemarkEngine freemarkEngine, CommonDao commonDao) throws Exception {
		//JSONObject json = new JSONObject();
		//TODO 处理传递的参数 -start
		/*Map<String, String[]> reqMap = req.getParameterMap();
		json.putAll(reqMap);
		json.remove("id");
		Map<String, Object> params = new HashMap<String, Object>();
		for(String str : json.keySet()) {
			String[] arr = (String[])json.get(str);
			params.put(str, arr[0]);//只取数组第一个值
		}
		if ("freeMakerSql".equals(customQuery.getSqlBuildType())) {
			sql = SysUtil.replaceConstant(sql);
			sql = freemarkEngine.parseByStringTemplate(params, sql);
			//System.err.println("params: "+params);
		}*/
		//TODO -end
		String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
		
		String resultField = customQuery.getDataField(); //返回栏位信息
		String xAxisDataField = customQuery.getxAxisDataField();
		
		JSONArray jArrayField = new JSONArray(); //栏位Json数据
		jArrayField = JSON.parseArray(resultField);
		
		List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, sql, commonDao); //按SQL查询返回的数据
		if(resultList.size() == 0) {
			return null;
		}
		JSONArray jArrayData = new JSONArray();
		jArrayData.addAll(resultList); //结果数据保存为json数据	
		
		JSONArray jArrayDataXaxis = JSON.parseArray(xAxisDataField); //x轴栏位，因为只有一个
		
		JSONObject optionMap = new JSONObject();
		//添加标题
		optionMap.put("title", EchartsCommonUtil.titleHandler(customQuery));
		//添加标记legend
		optionMap.put("legend", EchartsCommonUtil.legendHandler(jArrayField, jArrayData, customQuery));
		//添加X轴
		String xAxisField = customQuery.getxAxisField();
		optionMap.put("xAxis", setXAxisData(resultList, jArrayDataXaxis, xAxisField));
		//添加Y轴
		optionMap.put("yAxis", isOpenDoubleYAxis(jArrayField));
		//添加series数据
		optionMap.put("series", handleCommonTypeContentData(resultList, jArrayField/*, jArrayData, xStr*/));
		//添加提示框
		optionMap.put("tooltip", setTooltip());
		//添加缩放区域
		if(StringUtil.isNotEmpty(customQuery.getDataZoom()) && !customQuery.getDataZoom().equals("0")) {
			optionMap.put("dataZoom", setDataZoom(jArrayField, customQuery.getXyConvert()));
		}
		
		//如果需要xy轴相互转换
		if(customQuery.getXyConvert() != null && customQuery.getXyConvert() == 1) {
			setXYConvert(optionMap);
		}
		
		optionMap.put("grid", JSON.parseObject(customQuery.getGridField()));
		//System.err.println(optionMap);
		
		return optionMap;
	}
	
	/**
	 * xy轴互换
	 * @param optionMap
	 */
	private static void setXYConvert(JSONObject optionMap) {
		JSONObject objXAxis = optionMap.getJSONObject("xAxis");
		JSONArray objYAxis = optionMap.getJSONArray("yAxis");
		
		optionMap.remove("xAxis");
		optionMap.remove("yAxis");
		
		//xy转换
		optionMap.put("xAxis", objYAxis);
		optionMap.put("yAxis", objXAxis);
		
		//变换属性名字
		JSONArray objChangeXAxis = optionMap.getJSONArray("xAxis");
		for(int i = 0; i < objChangeXAxis.size(); i++) {
			JSONObject _single = objChangeXAxis.getJSONObject(i);
			if(_single.get("yAxisIndex") != null) {
				Object sin = _single.get("yAxisIndex");
				_single.remove("yAxisIndex");
				_single.put("xAxisIndex", sin);
			}
		}
		
		//变换series中的属性名字
		JSONArray objSeries = optionMap.getJSONArray("series");
		for(int i = 0; i < objSeries.size(); i++) {
			JSONObject _single = objSeries.getJSONObject(i);
			Object sin = _single.get("yAxisIndex");
			_single.remove("yAxisIndex");
			_single.put("xAxisIndex", sin);
		}
	}
	
	/**
	 * 设置缩放区域
	 * @return
	 */
	private static JSONArray setDataZoom(JSONArray jArrayField, Integer xyConvert) {
		JSONArray dataZoom = new JSONArray();
		
		JSONObject singleDataZoom = new JSONObject();
		singleDataZoom.put("type", "slider");
		singleDataZoom.put("show", true);
		singleDataZoom.put("realTime", true);
		singleDataZoom.put("start", 0);
		singleDataZoom.put("end", 20);
		singleDataZoom.put(xyConvert == 0 ? "xAxisIndex" : "yAxisIndex", 0);
		dataZoom.add(singleDataZoom);
		
		int yIndexCount = 0;
		for(int i = 0; i < jArrayField.size(); i++) {
			JSONObject json = jArrayField.getJSONObject(i);
			String yIndex = json.getString("yAxisIndex");
			if(yIndex != null && Integer.parseInt(yIndex) == 1) {
				yIndexCount++;
				break;
			}
		}
		for(int i = 0; i <= yIndexCount; i++) {
			singleDataZoom = new JSONObject();
			singleDataZoom.put("type", "slider");
			singleDataZoom.put("show", true);
			singleDataZoom.put("realTime", true);
			singleDataZoom.put("start", 0);
			singleDataZoom.put("end", 100);
			singleDataZoom.put(xyConvert == 0 ? "yAxisIndex" : "xAxisIndex", i);
			if(i % 2 == 0) {
				singleDataZoom.put(xyConvert == 0 ? "left" : "bottom", 10);
			} else {
				singleDataZoom.put(xyConvert == 0 ? "right" : "top", 10);
			}
			dataZoom.add(singleDataZoom);
		}
		
		return dataZoom;
	}
	
	/**
	 * 设置提示框 - 后面的版本进行配置化
	 * @return
	 */
	private static JSONObject setTooltip() {
		JSONObject tooltip = new JSONObject();
		tooltip.put("show", true); //TODO 不能写死
		tooltip.put("trigger", "axis"); //TODO 不能写死
		return tooltip;
	}
	
	/**
	 * 开启双Y轴显示
	 * @param jArrayField : dataField字段json数据
	 * @return
	 */
	private static JSONArray isOpenDoubleYAxis(JSONArray jArrayField) {
		JSONArray yAxisField = new JSONArray();
		Set<JSONObject> set = new HashSet<JSONObject>();
		for(int i = 0; i < jArrayField.size(); i++) {
			JSONObject json = jArrayField.getJSONObject(i);
			JSONObject singleY = new JSONObject();
			singleY.put("type", "value");
			Object yIndex = json.get("yAxisIndex");
			if(yIndex != null && Integer.parseInt(String.valueOf(yIndex)) == 1) {
				singleY.put("yAxisIndex", 1);
			}
			set.add(singleY);
		}
		yAxisField.addAll(set);
		return yAxisField;
	}
	
	/**
	 * 设置xAxis
	 * @param jArrayField
	 * @return
	 */
	private static JSONObject setXAxisData(List<Map<String, Object>> resultList, JSONArray jArrayDataXaxis, String xAxisField) {
		JSONArray xAxisData = new JSONArray();
		for(Map<String, Object> map : resultList) {
			Set<String> keySet = map.keySet();
			if(jArrayDataXaxis != null) {
				String[] pre_name = new String[jArrayDataXaxis.size()];
				for(int i = 0; i < jArrayDataXaxis.size(); i++) {
					JSONObject field = jArrayDataXaxis.getJSONObject(i);
					String fieldName = field.getString("fieldName");
					if(keySet.contains(fieldName)) {
						pre_name[i] = String.valueOf(map.get(fieldName));
					}
				}
				xAxisData.add(EchartsCommonUtil.handleArrays(pre_name));
			}
		}
		JSONObject json = JSON.parseObject(xAxisField);
		json.put("data", xAxisData);
		JSONObject axisLabel = new JSONObject();
		axisLabel.put("rotate", 0); //x轴文字角度 //可以做为配置
		json.put("axisLabel", axisLabel);
		return json;
	}
	
	/**
	 * 处理成显示数据series
	 * @param jArrayField 栏位数据
	 * @param jArrayData  信息数据
	 * @param xStr
	 */
	private static JSONArray handleCommonTypeContentData(List<Map<String, Object>> resultList, JSONArray jArrayField/*, JSONArray jArrayData, String xStr*/) {
		//行数据
		JSONArray series = new JSONArray();
		for(int i = 0; i < jArrayField.size(); i++) {
			JSONObject field = jArrayField.getJSONObject(i);
			String fieldName = field.getString("fieldName");
			String comment = field.getString("comment");
			String shapeType = field.getString("shapeType");
			String yAxisIndex = field.getString("yAxisIndex"); //是否处于第二Y轴
			String stack = field.getString("stack"); //是否堆叠
			
			JSONArray singleData = new JSONArray();
			for(Map<String, Object> map : resultList) {
				Set<String> keySet = map.keySet();
				
				if(keySet.contains(fieldName)) {
					singleData.add(map.get(fieldName));
				}
			}
			JSONObject singleSeries = new JSONObject();
			singleSeries.put("data", singleData);
			singleSeries.put("name", comment);
			singleSeries.put("alias", fieldName);
			singleSeries.put("type", shapeType);
			
			if(yAxisIndex != null && yAxisIndex.equals("1")) { //是否处于第二Y轴
				singleSeries.put("yAxisIndex", yAxisIndex);
			}
			if(stack != null && stack.equals("1")) { //是否堆叠
				singleSeries.put("stack", stack);
			}
			if(shapeType.equals("line")) { //是否平滑
				if(field.getString("smooth") != null && field.getString("smooth").equals("1")) {
					singleSeries.put("smooth", true);
				}
			}
			series.add(singleSeries);
		}
		
		return series;
	}
}
