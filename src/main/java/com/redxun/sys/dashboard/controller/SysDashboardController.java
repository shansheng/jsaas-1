package com.redxun.sys.dashboard.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.dashboard.entity.SysDashboardCustom;
import com.redxun.sys.dashboard.manager.SysDashboardCustomManager;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.redxun.sys.echarts.manager.SysEchartsCustomManager;

@Controller
@RequestMapping("/sys/dashboard/")
public class SysDashboardController extends MybatisListController{
	
	@Resource
	private SysDashboardCustomManager dashboardManager;
	
	@Resource
	private SysEchartsCustomManager chartsManager;
	
	@Resource
	private FreemarkEngine freemarkEngine;
	
	//private String DASHBOARD_CAT_KEY = "CAT_DASHBOARD";
	
	@RequestMapping("dashboard/list")
	public ModelAndView queryDashboardList(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return getPathView(req);
	}
	
	@RequestMapping("dashboard/demo")
	public ModelAndView queryDashboardDemo(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String key = RequestUtil.getString(req, "key");
		String name = RequestUtil.getString(req, "name");
		String treeId = RequestUtil.getString(req, "treeId");
		SysDashboardCustom dashboard = dashboardManager.getByKey(key);
		if(dashboard == null) {
			dashboard = new SysDashboardCustom();
			dashboard.setName(name);
			dashboard.setKey(key);
			dashboard.setTreeId(treeId);
		}
		JSONObject json = (JSONObject) JSONObject.toJSON(dashboard);
		return getPathView(req).addObject("dashboardJson", json);
	}
	
	@RequestMapping("dashboard/readDemo")
	public ModelAndView previewDashboardDemo(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String key = RequestUtil.getString(req, "key");
		return getPathView(req).addObject("key", key);
	}
	
	@RequestMapping("dashboard/filter")
	public ModelAndView queryFilterSetting(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String queryFilterJsonStr = RequestUtil.getString(req, "queryFilter");
		JSONObject json = new JSONObject();
		json.put("queryFilterJson", queryFilterJsonStr);
		return getPathView(req).addObject("queryFilterJson", json);
	}
	
	@SuppressWarnings({ "rawtypes", "finally" })
	@RequestMapping(value = "saveHtml", method = RequestMethod.POST)
	@ResponseBody
    public JsonResult saveHtml(HttpServletRequest req, HttpServletResponse res){
		String msg = null;
		String jsonStr = RequestUtil.getString(req, "json");
		SysDashboardCustom dashboard = (SysDashboardCustom) JSONObject.parseObject(jsonStr, SysDashboardCustom.class);
		try {
			if(StringUtil.isEmpty(dashboard.getId())) {
				//可能在readDemo的时候做了save，所以要确保是不是key值有重复
				SysDashboardCustom oldDashboard = dashboardManager.getByKey(dashboard.getKey());
				if(BeanUtil.isEmpty(oldDashboard)){
					dashboard.setId(IdUtil.getId());
					dashboardManager.create(dashboard);
				} else {
					dashboard.setId(oldDashboard.getId());
					dashboard.setTreeId(ContextUtil.getCurrentTenantId());
					dashboardManager.update(dashboard);
				}
				msg = getMessage("Created", new Object[]{dashboard.getIdentifyLabel()}, "[自定义大屏展示]成功创建!");
			} else {
				dashboardManager.update(dashboard);
				msg = getMessage("Updated", new Object[] {dashboard.getIdentifyLabel()}, "[自定义大屏展示]成功修改!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, e.getMessage());
		} finally {
			return new JsonResult(true, msg);
		}
    }
	
	@RequestMapping("dashboard/delete")
	public void delete(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String key = RequestUtil.getString(req, "key");
		dashboardManager.deleteObject(dashboardManager.getByKey(key));
	}
	
	@RequestMapping("singleDashboard/{alias}")
	@ResponseBody
	public JSONObject queryDashboardByKey(HttpServletRequest req, @PathVariable(value="alias")String alias) throws Exception {
		SysDashboardCustom dashboard = dashboardManager.getByKey(alias);
		String rtnHtml = "";
		if(dashboard != null) {
			String html = dashboard.getLayoutHtml();
			if(StringUtil.isNotEmpty(html)) {
				Document doc = Jsoup.parse(html);
				Elements els = doc.getElementsByAttributeValueStarting("class", "colId");
				Iterator<Element> elIt = els.iterator();
				while(elIt.hasNext()) {
					Element el = elIt.next();
					String name = el.className();
					String colId = name.split("_")[1];
					Map<String, Object> params = new HashMap<>();
					params.put("ctxPath", req.getContextPath());
					//判断是属于报表还是查询条件
					if(colId.equals("queryFilter")) {
						String queryFilterStr = dashboard.getQueryFilterJsonStr();
						params.put("queryJson", JSON.parseArray(queryFilterStr));
						params.put("colId", dashboard.getTreeId());
						String colHtml = freemarkEngine.mergeTemplateIntoString("echarts/frontQueryFilterTemplate.ftl", params);
						el.html(colHtml);
					} else {
						SysEchartsCustom chart = chartsManager.get(colId);
						String chartType = chart.getEchartsType();
						String _alias = el.id();
						params.put("alias", _alias);
						params.put("key", chart.getKey());
						params.put("chartType", "echarts");
						params.put("dashboard", "dashboard");
						params.put("colId", colId);
						if(chartType.equals("Table")) {
							params.put("chartType", "table");
						}
						String colHtml = freemarkEngine.mergeTemplateIntoString("echarts/frontTemplate.ftl", params);
						el.html(colHtml);
					}
				}
				rtnHtml = doc.body().html();
			}
		}
		JSONObject htmlJson = new JSONObject();
		htmlJson.put("html", rtnHtml);		
		return htmlJson;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return dashboardManager;
	}
}
