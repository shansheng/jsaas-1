package com.redxun.sys.echarts.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.redxun.sys.util.SysUtil;

/**
 * 生成sql的实体数据
 * @author Louis
 */
public class CreateSqlDetail {
	
	//把freemerker sql转换成sql
	public static String createSQL(HttpServletRequest req, SysEchartsCustom customQuery, FreemarkEngine freemarkEngine) throws Exception {
		JSONObject json = new JSONObject();
		Map<String, String[]> reqMap = req.getParameterMap();
		json.putAll(reqMap);
		json.remove("id");
		Map<String, Object> params = new HashMap<String, Object>();
		for(String str : json.keySet()) {
			String[] arr = (String[])json.get(str);
			params.put(str, arr[0]);//只取数组第一个值
		}
		
		String sql = customQuery.getSql();
		if ("freeMakerSql".equals(customQuery.getSqlBuildType())) {
			sql = SysUtil.replaceConstant(sql);
			sql = freemarkEngine.parseByStringTemplate(params, sql);
			//System.err.println("params: "+params);
		}
		//System.out.println(sql);
		return sql;
	}
	
	//在各自的数据源中加载数据
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> useDataSourceUtil(SysEchartsCustom customQuery, String sql, CommonDao commonDao) throws Exception {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		if(StringUtil.isNotEmpty(customQuery.getDsAlias())) {
			DbContextHolder.setDataSource(customQuery.getDsAlias());
			resultList = commonDao.query(sql);
			DbContextHolder.setDefaultDataSource();
		} else {
			resultList = commonDao.query(sql);
		}
		return resultList;
	}
}
