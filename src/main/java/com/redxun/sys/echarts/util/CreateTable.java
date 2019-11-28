package com.redxun.sys.echarts.util;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.IJson;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.QueryParam;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.redxun.sys.echarts.manager.SysEchartsCustomManager;

/**
 * 制作 表格
 * @author Louis
 */
public class CreateTable {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("previewTableJson/{alias}")
	public static void previewTableJson(HttpServletRequest req, HttpServletResponse res, String alias, 
			SysEchartsCustomManager echartsCustomManager, FreemarkEngine freemarkEngine, 
			CommonDao commonDao, IJson iJson) throws Exception{
		SysEchartsCustom customQuery = echartsCustomManager.getByKey(alias);
		if(StringUtil.isNotEmpty(customQuery.getDsAlias())) {
			DbContextHolder.setDataSource(customQuery.getDsAlias());
		}
		String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
		
		JSONObject json = new JSONObject();
		json.putAll(req.getParameterMap());
		Map<String,Object> jsonMap = new HashMap<String, Object>();
		QueryFilter filter = new QueryFilter();
		
		String formatSql = sql;
		JSONArray jArrParam = new JSONArray();
		if(json.get("filter") != null) {
			jArrParam = JSON.parseArray(json.getJSONArray("filter").getString(0));
			for(Object object : jArrParam) {
				json = JSON.parseObject(String.valueOf(object));
				if(StringUtil.isEmpty(String.valueOf(json.get("value")))) {
					continue;
				}
				String name = json.getString("name");
				filter.addFieldParam(name.substring(2, name.lastIndexOf("_S_LK")), QueryParam.OP_LIKE, "%"+json.get("value")+"%");
			}
			jsonMap = commonDao.parseGridFilter(filter);
			if(jsonMap != null && jsonMap.size() != 0) {
				formatSql = "SELECT _A_.* FROM (" + formatSql + ") _A_ WHERE " + String.valueOf(jsonMap.get("whereSql"));
			}
		} 
		String totalSql = formatSql;
		
		int pageIndex = RequestUtil.getInt(req, "pageIndex", 0);
        int pageSize = RequestUtil.getInt(req, "pageSize", Page.DEFAULT_PAGE_SIZE);
        formatSql += " LIMIT " + (pageIndex * pageSize) + ", " + pageSize;
		
		List list = commonDao.query(formatSql, jsonMap);
		JsonPageResult result = new JsonPageResult(true);
		result.setData(list);
		result.setTotal(commonDao.query(totalSql, jsonMap).size());
		String jsonResult = iJson.toJson(result);
		
		if(StringUtil.isNotEmpty(customQuery.getDsAlias())) {
			DbContextHolder.setDefaultDataSource();
		}
		PrintWriter pw = res.getWriter();
		pw.println(jsonResult);
		pw.close();
	}
}
