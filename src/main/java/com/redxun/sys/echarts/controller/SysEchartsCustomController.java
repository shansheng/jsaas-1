package com.redxun.sys.echarts.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.thoughtworks.xstream.XStream;
import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.script.SqlScript;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.IJson;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.IPage;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.QueryParam;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.redxun.sys.echarts.manager.SysEchartsCustomManager;
import com.redxun.sys.echarts.manager.SysEchartsPremissionManager;
import com.redxun.sys.echarts.util.CreateFunnel;
import com.redxun.sys.echarts.util.CreateGauge;
import com.redxun.sys.echarts.util.CreateHeatmap;
import com.redxun.sys.echarts.util.CreateLineBar;
import com.redxun.sys.echarts.util.CreatePie;
import com.redxun.sys.echarts.util.CreateRadar;
import com.redxun.sys.echarts.util.CreateSqlDetail;
import com.redxun.sys.echarts.util.CreateTable;
import com.redxun.sys.echarts.util.CreateWordCloud;
import com.redxun.sys.util.SysUtil;
import com.redxun.ui.view.model.ExportFieldColumn;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysBoListManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.db.manager.SysSqlCustomQueryManager;

@Controller
@RequestMapping("/sys/echarts/echartsCustom/")
public class SysEchartsCustomController extends MybatisListController {

    @Resource
    private CommonDao commonDao;

    @Resource
    private SysSqlCustomQueryManager customQueryManager;

    @Resource
    private SysEchartsCustomManager echartsCustomManager;

    @Resource
    private FreemarkEngine freemarkEngine;

    @Resource
    SysBoListManager sysBoListManager;

    @Resource
    private SysEchartsPremissionManager premissionManager;

    @Resource
    private SysTreeManager treeManager;

    @Resource
    protected IJson iJson;

    private String CUSTOM_ECHARTS_VERSION = "1.5.422";
    private String ECHART_CAT_KEY = "CAT_GRAPHIC_REPORT";

    //生成echarts的json数据
    @RequestMapping("json/{alias}")
    @ResponseBody
    public JSONObject echartsJson(HttpServletRequest req, @PathVariable(value = "alias") String alias) throws Exception {
        SysEchartsCustom customQuery = echartsCustomManager.getByKey(alias);
        JSONObject json = new JSONObject();
        JSONObject resultObj = new JSONObject();
        if (customQuery == null) {
            resultObj.put("json", "noData");
            return resultObj;
        }

        JSONArray conditionArray = null;
        String echartType = customQuery.getEchartsType();
        if (echartType.equals("common")) {
            json = CreateLineBar.createEchartsCommonType(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Pie")) {
            json = CreatePie.createEchartsPie(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Gauge")) {
            json = CreateGauge.createEchartsGauge(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Funnel")) {
            json = CreateFunnel.createEchartsFunnel(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Radar")) {
            json = CreateRadar.createEchartsRadar(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Heatmap")) {
            json = CreateHeatmap.createEchartsHeatmap(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("WordCloud")) {
            json = CreateWordCloud.createEchartsWordCloud(req, customQuery, freemarkEngine, commonDao);
        }
        conditionArray = createConditionMenu(req, customQuery);


        resultObj.put("json", json == null ? "noData" : json);
        resultObj.put("condition", conditionArray);
        resultObj.put("drillDown", createDrillDownFieldName(customQuery));
        resultObj.put("ctxPath", req.getContextPath());
        resultObj.put("theme", createTheme(customQuery));
        return resultObj;
    }

    /**
     * @param alias - key :  now using
     */
    @RequestMapping("preview/{alias}")
    public void previewByAlias(HttpServletRequest req, HttpServletResponse res, @PathVariable(value = "alias") String alias) throws Exception {
        SysEchartsCustom customQuery = echartsCustomManager.getByKey(alias);
        JSONObject json = new JSONObject();
        JSONArray conditionArray = null;
        String html = "";
        Map<String, Object> mv = new HashMap<String, Object>();
        String echartType = customQuery.getEchartsType();

        String defaultTemplate = "echarts/previewTemplate.ftl";
        if (echartType.equals("common")) {
            json = CreateLineBar.createEchartsCommonType(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Pie")) {
            json = CreatePie.createEchartsPie(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Gauge")) {
            json = CreateGauge.createEchartsGauge(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Funnel")) {
            json = CreateFunnel.createEchartsFunnel(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Radar")) {
            json = CreateRadar.createEchartsRadar(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Heatmap")) {
            json = CreateHeatmap.createEchartsHeatmap(req, customQuery, freemarkEngine, commonDao);
        } else if (echartType.equals("Table")) {
            mv = previewTableTemplate(req, alias);
            html = freemarkEngine.mergeTemplateIntoString("echarts/previewTableTemplate.ftl", mv);
            res.setContentType("text/html;charset=utf-8");
            PrintWriter pw = res.getWriter();
            pw.print(html);
            pw.flush();
            return;
        } else if (echartType.equals("WordCloud")) {
            json = CreateWordCloud.createEchartsWordCloud(req, customQuery, freemarkEngine, commonDao);
        }
        conditionArray = createConditionMenu(req, customQuery);

        mv.put("alias", alias);
        mv.put("json", json == null ? "'noData'" : json.toString());
        mv.put("condition", conditionArray == null ? "" : conditionArray.toString());
        mv.put("ctxPath", req.getContextPath());
        mv.put("drillDown", customQuery.getDrillDownField() == null ? "" : customQuery.getDrillDownField());
        mv.put("theme", createTheme(customQuery));
        mv.put("version", SysPropertiesUtil.getGlobalProperty("static_res_ver", CUSTOM_ECHARTS_VERSION));
        //System.err.println(JSONObject.toJSON(mv));

        html = freemarkEngine.mergeTemplateIntoString(defaultTemplate, mv);
        res.setContentType("text/html;charset=utf-8");
        PrintWriter pw = res.getWriter();
        pw.print(html);
        pw.flush();
    }

    @RequestMapping("jsonTable/{alias}")
    @ResponseBody
    public Map<String, Object> previewTableTemplate(HttpServletRequest req, @PathVariable(value = "alias") String alias) throws Exception {
        SysEchartsCustom customQuery = echartsCustomManager.getByKey(alias);
        String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
        List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, sql, commonDao); //按SQL查询返回的数据

        String qColumn = customQuery.getxAxisDataField();
        JSONArray qArray = JSON.parseArray(qColumn);
        //qArray = JSON.parseArray(qColumn);
        String vColumn = customQuery.getDataField();
        JSONArray vArray = JSON.parseArray(vColumn);
        //vArray = JSON.parseArray(vColumn);

        //设置参数
        boolean drillDownNext = false;
        String paramStr = "?";
        Map<String, String[]> reqMap = req.getParameterMap();
        for (String str : reqMap.keySet()) {
            String[] arr = reqMap.get(str);
            if (str.equals("drillDownNext")) {
                drillDownNext = true;
            }
            paramStr += (str + "=" + arr[0].toString() + "&");
        }

        Map<String, Object> mv = new HashMap<String, Object>();
        mv.put("data", resultList);
        mv.put("param", paramStr);
        mv.put("qArray", qArray);
        mv.put("vArray", vArray);
        mv.put("alias", alias);
        mv.put("ctxPath", req.getContextPath());
        mv.put("drillDownNext", drillDownNext);
        mv.put("version", SysPropertiesUtil.getGlobalProperty("static_res_ver", CUSTOM_ECHARTS_VERSION));
        return mv;
    }

    @RequestMapping("previewTable/{alias}")
    public ModelAndView previewTable(HttpServletRequest req, @PathVariable(value = "alias") String alias) throws Exception {
        SysEchartsCustom customQuery = echartsCustomManager.getByKey(alias);
        String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);
        List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, sql, commonDao); //按SQL查询返回的数据

        String qColumn = customQuery.getxAxisDataField();
        JSONArray qArray = JSON.parseArray(qColumn);
        //qArray = qArray.parseArray(qColumn);
        String vColumn = customQuery.getDataField();
        JSONArray vArray = JSON.parseArray(vColumn);
        //vArray = vArray.parseArray(vColumn);

        ModelAndView mv = getPathView(req);
        mv.setViewName("sys/echarts/tablePreview.jsp");
        mv.addObject("data", resultList);
        mv.addObject("qArray", qArray);
        mv.addObject("vArray", vArray);
        mv.addObject("alias", alias);
        return mv;
    }

    @RequestMapping("previewTableJson/{alias}")
    public void previewTableJson(HttpServletRequest req, HttpServletResponse res, @PathVariable(value = "alias") String alias) throws Exception {
        CreateTable.previewTableJson(req, res, alias, echartsCustomManager, freemarkEngine, commonDao, iJson);
    }

    //获取主题
    private String createTheme(SysEchartsCustom customQuery) throws Exception {
        String theme = customQuery.getTheme();
        return theme == null ? "" : theme;
    }

    //生成条件查询菜单json
    private JSONArray createConditionMenu(HttpServletRequest req, SysEchartsCustom customQuery) throws Exception {
        String whereField = customQuery.getWhereField();
        JSONArray array = null;
        if (!StringUtil.isEmpty(whereField)) {
            array = JSON.parseArray(whereField);
            for (int i = 0; i < array.size(); i++) {
                JSONObject singleObj = (JSONObject) array.get(i);
                String curSql = (String) singleObj.get("valueSource");
                if (StringUtil.isEmpty(curSql)) {
                    continue;
                }
                List<Map<String, Object>> resultList = CreateSqlDetail.useDataSourceUtil(customQuery, curSql, commonDao); //useDataSourceUtil(customQuery, curSql); //按条件sql查询出的结果集
                //增加一个空条件
                Map<String, Object> m = new HashMap<String, Object>();
                m.put(resultList.get(0).keySet().iterator().next().toString(), "");
                resultList.add(m);
                for (int k = 0; k < resultList.size(); k++) {
                    resultList.get(k).put("id", k + 1);
                }
                //System.err.println(resultList);
                JSONArray values = new JSONArray();
                values.addAll(resultList);
                singleObj.put("valueSource", values);
            }
        }
        //System.err.println(array);
        return array;
    }

    //下钻所选择的栏位名称
    private JSONObject createDrillDownFieldName(SysEchartsCustom customQuery) {
        JSONObject rtnObj = new JSONObject();
        rtnObj = JSONObject.parseObject(customQuery.getDrillDownField());
        return rtnObj;
    }

    /**
     * 以上是处理sql返回数据转变为echarts的json数据 , 暂时性测试数据
     **************************************/

    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pkId = RequestUtil.getString(request, "pkId");
        // 复制添加
        String forCopy = request.getParameter("forCopy");
        SysEchartsCustom echartsCustom = null;
        if (StringUtils.isNotEmpty(pkId)) {
            echartsCustom = echartsCustomManager.get(pkId);
            if ("true".equals(forCopy)) {
                echartsCustom.setId(null);
            }
        } else {
            echartsCustom = new SysEchartsCustom();
        }

        ModelAndView mv = getPathView(request);

        if (!echartsCustom.getEchartsType().equals("common")) {
            String path = mv.getViewName();
            path = path.substring(0, path.lastIndexOf(".")) + echartsCustom.getEchartsType() + path.substring(path.lastIndexOf("."), path.length());
            mv.setViewName(path);
        }

        return mv.addObject("echartsCustom", echartsCustom).addObject("version", CUSTOM_ECHARTS_VERSION);
    }

    @RequestMapping("select")
    public ModelAndView select(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String multiSelect = RequestUtil.getString(req, "multiSelect");
        return getPathView(req).addObject("multiSelect", multiSelect);
    }

    /**
     * 保存实体数据
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = null;
        try {
            String jsonStr = request.getParameter("json");
            SysEchartsCustom echartsCustom = (SysEchartsCustom) JSONObject.parseObject(jsonStr, SysEchartsCustom.class);

            if (StringUtils.isEmpty(echartsCustom.getId())) {
                echartsCustom.setId(IdUtil.getId());
                echartsCustomManager.create(echartsCustom);
                msg = getMessage("sysSqlCustomQuery.created", new Object[]{echartsCustom.getIdentifyLabel()}, "[自定义图形报表]成功创建!");
            } else {
                echartsCustomManager.update(echartsCustom);
                msg = getMessage("sysSqlCustomQuery.updated", new Object[]{echartsCustom.getIdentifyLabel()}, "[自定义图形报表]成功更新!");
            }
            return new JsonResult(true, msg);
        } catch (Exception e) {
            e.printStackTrace();
            return new JsonResult(false, e.getMessage());
        }
    }

    @RequestMapping("getById")
    @ResponseBody
    public SysEchartsCustom getById(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pkId = RequestUtil.getString(request, "id");
        SysEchartsCustom echartsCustom = echartsCustomManager.get(pkId);
        return echartsCustom;
    }

    @RequestMapping("list")
    public ModelAndView echartsList(HttpServletRequest req, HttpServletResponse res) throws Exception {
        IUser user = ContextUtil.getCurrentUser();
        return getPathView(req).addObject("superAdmin", user.isSuperAdmin());
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String uId = RequestUtil.getString(request, "ids");
        if (StringUtils.isNotEmpty(uId)) {
            String[] ids = uId.split(",");
            for (String id : ids) {
                echartsCustomManager.delete(id);
            }
        }
        return new JsonResult(true, "成功删除!");
    }

    @RequestMapping("checkKeyExist")
    @ResponseBody
    public JSONObject checkKeyExist(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String id = req.getParameter("id");
        String key = req.getParameter("key");
        SysEchartsCustom echarts = echartsCustomManager.getKeyNotCurrent(id, key);
        JSONObject json = new JSONObject();
        json.put("message", echarts == null ? "success" : "fail");
        return json;
    }

    @RequestMapping("frontSetting")
    @ResponseBody
    public String frontPageEchartsContentSettting(HttpServletRequest req, HttpServletResponse res) throws Exception {
        //String id = req.getParameter("id");
        String alias = req.getParameter("alias");
        String key = req.getParameter("key");
        Map<String, String> params = new HashMap<String, String>();
        params.put("alias", alias);
        params.put("key", key);
        //String html = freemarkEngine.mergeTemplateIntoString("echarts/frontPageTemplate.ftl", params);
        //using this
        SysEchartsCustom customQuery = echartsCustomManager.getByKey(alias);
        //JSONObject json = new JSONObject();
        //JSONArray conditionArray = null;

        params.put("chartType", "echarts");
        /*if(customQuery.getEchartsType().equals("common")) {
			json = createEchartsCommonType(req, customQuery);
			conditionArray = createConditionMenu(req, customQuery);
		} else if(customQuery.getEchartsType().equals("Pie")) {
			json = createEchartsPie(req, customQuery);
		} else if(customQuery.getEchartsType().equals("Gauge")) {
			json = createEchartsGauge(req, customQuery);
		}*/
        if (customQuery.getEchartsType().equals("Table")) {
            params.put("chartType", "table");
        }
        //params.put("json", json.toString());
        //params.put("condition", conditionArray == null ? "" : conditionArray.toString());
        //params.put("ctxPath", req.getContextPath());
        //params.put("theme", createTheme(customQuery));
        //params.put("version", SysPropertiesUtil.getGlobalProperty("static_res_ver","1"));
        String otherHtml = freemarkEngine.mergeTemplateIntoString("echarts/frontTemplate.ftl", params);
        return otherHtml;
    }

    @SuppressWarnings({"unchecked", "rawtypes", "static-access"})
    @RequestMapping("exportExcel/{alias}")
    public void tableExportExcel(HttpServletRequest req, HttpServletResponse res) throws Exception {
        //*数据处理
        String alias = req.getParameter("alias");
        String jsonStr = req.getParameter("data");

        SysEchartsCustom customQuery = echartsCustomManager.getByKey(alias);
        if (StringUtil.isNotEmpty(customQuery.getDsAlias())) {
            DbContextHolder.setDataSource(customQuery.getDsAlias());
        }

        JSONObject json = JSON.parseObject(jsonStr);
        JSONArray jArrParam = JSON.parseArray(String.valueOf(json.get("filter")));

        Map<String, Object> jsonMap = new HashMap<String, Object>();
        QueryFilter filter = new QueryFilter();
        for (Object object : jArrParam) {
            json = JSON.parseObject(String.valueOf(object));
            if (StringUtil.isEmpty(String.valueOf(json.get("value")))) {
                continue;
            }
            String name = json.getString("name");
            filter.addFieldParam(name.substring(2, name.lastIndexOf("_S_LK")), QueryParam.OP_LIKE, "%" + json.get("value") + "%");
        }
        jsonMap = commonDao.parseGridFilter(filter);

        String sql = CreateSqlDetail.createSQL(req, customQuery, freemarkEngine);

        if (jsonMap != null && jsonMap.size() != 0) {
            sql = "SELECT _A_.* FROM (" + sql + ") _A_ WHERE " + String.valueOf(jsonMap.get("whereSql"));
        }

        List list = commonDao.query(sql, jsonMap);

        List<ExportFieldColumn> gridcolumns = new ArrayList<ExportFieldColumn>();
        JSONArray jArr = new JSONArray();
        List<JSONObject> arrList = new ArrayList<JSONObject>();
        jArr = JSON.parseArray(customQuery.getxAxisDataField());
        for (int i = 0; i < jArr.size(); i++) {
            JSONObject oo = new JSONObject();
            oo = (JSONObject) JSON.toJSON(jArr.get(i));
            oo.put("width", "100");
            arrList.add(oo);
        }
        jArr = JSON.parseArray(customQuery.getDataField());
        for (int i = 0; i < jArr.size(); i++) {
            JSONObject oo = new JSONObject();
            oo = (JSONObject) JSON.toJSON(jArr.get(i));
            oo.put("width", "100");
            arrList.add(oo);
        }
        String columns = arrList.toString().replaceAll("fieldName", "field").replaceAll("comment", "header");
        gridcolumns = poiTableBuilder.constructSingleExportFieldColumns(columns, gridcolumns);

        jArr = new JSONArray();
        jArr.addAll(list);

        if (StringUtil.isNotEmpty(customQuery.getDsAlias())) {
            DbContextHolder.setDefaultDataSource();
        }
        System.err.println("aosidoasjdaiosdjoaisoasjdoasjdioasdhoiasdioasod");

        echartsCustomManager.downloadExcelFile(customQuery.getName(), gridcolumns, jArr, customQuery.getxAxisDataField(), res);
    }

    @Override
    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping("listData")
    public void listData(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String export = req.getParameter("_export");
        // 是否导出
        if (StringUtils.isNotEmpty(export)) {
            String exportAll = req.getParameter("_all");
            if (StringUtils.isNotEmpty(exportAll)) {
                exportAllPages(req, res);
            } else {
                exportCurPage(req, res);
            }
        } else {
            res.setContentType("application/json");
            QueryFilter queryFilter = getQueryFilter(req);
            IPage page = queryFilter.getPage();

            IUser user = ContextUtil.getCurrentUser();
            Map<String, Set<String>> profiles = ProfileUtil.getCurrentProfile();
            Set<String> userIds = profiles.get("user");
            Set<String> groupIds = profiles.get("group");
            Set<String> subGroupIds = profiles.get("subGroup");
            List premTreeList = premissionManager.getUserTreeGrant(userIds, groupIds, subGroupIds);//当前登录用户所拥有的的树ID
            List<SysEchartsCustom> list = new ArrayList<SysEchartsCustom>();
            JsonPageResult<?> result = null;

            String treeId = req.getParameter("treeId");
            if (StringUtil.isEmpty(treeId)) {
                if (user.isSuperAdmin()) {
                    list = echartsCustomManager.getAllByTenantId(ContextUtil.getCurrentTenantId(), queryFilter);
                } else {
                    //查询所有拥有权限树的图形
                    for (int i = 0; i < premTreeList.size(); i++) {
                        Map<String, Object> obj = (Map<String, Object>) premTreeList.get(i);
                        queryFilter.addFieldParam("TREE_ID_", obj.get("TREE_ID_").toString());
                        List<SysEchartsCustom> curTreeList = echartsCustomManager.getAll(queryFilter);
                        list.addAll(curTreeList);
                    }
                }
                Integer size = list.size();
                list = list.subList(page.getStartIndex(),
                        (page.getStartIndex() + page.getPageSize() > size) ? size : page.getStartIndex() + page.getPageSize());
                result = new JsonPageResult(list, size);
            } else {
                //查询当前树的图形
                for (int i = 0; i < premTreeList.size(); i++) {
                    Map<String, Object> obj = (Map<String, Object>) premTreeList.get(i);
                    String _id = obj.get("TREE_ID_").toString();
                    if (_id.equals(treeId)) { //如果迭代的TREE_ID_和传入的treeId相同，列出当前树下的所有图形
                        list = getBaseManager().getAll(queryFilter);
                    }
                }
                result = new JsonPageResult(list, queryFilter.getPage().getTotalItems());
            }

            String jsonResult = iJson.toJson(result);
            PrintWriter pw = res.getWriter();
            pw.println(jsonResult);
            pw.close();
        }
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping("getUserGrantTreeList")
    @ResponseBody
    public List<SysTree> getUserGrantTreeList(HttpServletRequest req, HttpServletResponse res) throws Exception {
        IUser user = ContextUtil.getCurrentUser();
        Map<String, Set<String>> profiles = ProfileUtil.getCurrentProfile();
        Set<String> userIds = profiles.get("user");
        Set<String> groupIds = profiles.get("group");
        Set<String> subGroupIds = profiles.get("subGroup");

        //拿到树的权限
        List<SysTree> grantTreeList = new ArrayList<SysTree>();
        if (user.isSuperAdmin()) {
            grantTreeList = treeManager.getByCatKeyTenantId(ECHART_CAT_KEY, ContextUtil.getCurrentTenantId());
        } else {
            List<SysTree> treeList = treeManager.getByCatKeyTenantId(ECHART_CAT_KEY, ContextUtil.getCurrentTenantId()); //图形报表的所有树
            List premTreeList = premissionManager.getUserTreeGrant(userIds, groupIds, subGroupIds); //当前登录用户所拥有的的树ID, 在后面的操作中要把上级的树id一并获取,getByPath
            List<SysTree> curAllTreeList = new ArrayList<SysTree>(); //根据path查询到的所有树，包含重复的树
            for (SysTree tree : treeList) {
                for (int i = 0; i < premTreeList.size(); i++) {
                    Map<String, Object> obj = (Map<String, Object>) premTreeList.get(i);
                    if (tree.getTreeId().equals(obj.get("TREE_ID_").toString())) {
                        String[] paths = tree.getPath().split("\\."); //分解path
                        for (String path : paths) {
                            SysTree t1 = treeManager.get(path);
                            if (t1 != null) {
                                curAllTreeList.add(t1);
                            }
                        }
                    }
                }
            }
            Set<SysTree> set = new HashSet<SysTree>();//去除重复数据
            for (SysTree t : curAllTreeList) {
                set.add(t);
            }
            grantTreeList.addAll(set);
        }
        return grantTreeList;
    }

    /**
     * 导出报表
     */
    @RequestMapping("doExport")
    public void doExport(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String keys = req.getParameter("keys");
        String[] key = keys.split(",");
        List<SysEchartsCustom> chartList = echartsCustomManager.getSysEchartsTemplateByIds(key);

        res.setContentType("application/zip");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String downFileName = "SysEchartsCustom-" + sdf.format(new Date());
        res.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");

        ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
                .createArchiveOutputStream(ArchiveStreamFactory.ZIP,
                        res.getOutputStream());

        for (SysEchartsCustom chart : chartList) {
            XStream xstream = new XStream();
            xstream.autodetectAnnotations(true);
            // 生成XML
            String xml = xstream.toXML(chart);

            zipOutputStream.putArchiveEntry(new ZipArchiveEntry(chart.getName() + ".xml"));
            InputStream is = new ByteArrayInputStream(xml.getBytes("UTF-8"));
            IOUtils.copy(is, zipOutputStream);
            zipOutputStream.closeArchiveEntry();

        }
        zipOutputStream.close();
    }

    /**
     * 导入报表
     */
    @RequestMapping("importDirect")
    public ModelAndView importDirect(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception {
        MultipartFile file = req.getFile("zipFile");
        echartsCustomManager.doImport(file);
        return getPathView(req);
    }

    /*********************************************************************************/
    /**                                                                             **/
    /**   以上为 Version 1 , 以下为Version 2的代码                                  **/
    /**                                                                             **/
    /*********************************************************************************/

    /***
     * Version 2
     *******************************************************************/
    //根据freeMarker SQL查询数据
    @RequestMapping("queryListByFmSQL_V2")
    @ResponseBody
    public List<Map<String, Object>> queryListByFmSQL_V2(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String ds = req.getParameter("ds");
        String sql = createSQL_V2(req);

        Page page = new Page(0, 20);
        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        resultList = useDataSourceUtil_V2(ds, sql, page);

        return resultList;
    }

    //格式化传入的freemarker sql
    private String createSQL_V2(HttpServletRequest req) throws Exception {
        String ds = req.getParameter("ds");
        String sql = req.getParameter("query"); //SQL暂时没有做freemarker处理,只是单纯的SQL
        String queryType = req.getParameter("queryType");

        Map<String, Object> params = new HashMap<String, Object>();
        if ("freeMakerSql".equals(queryType)) {
            sql = SysUtil.replaceConstant(sql);
            sql = freemarkEngine.parseByStringTemplate(params, sql);
        }
        return sql;
    }

    //根据数据源查询结果
    private List<Map<String, Object>> useDataSourceUtil_V2(String ds, String sql, Page page) throws Exception {
        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        if (StringUtil.isNotEmpty(ds)) {
            DbContextHolder.setDataSource(ds);
            resultList = commonDao.query(sql, new HashMap());
            DbContextHolder.setDefaultDataSource();
        } else {
            resultList = commonDao.query(sql, new HashMap());
        }
        return resultList;
    }

    @Resource
    SqlScript script;

    //快速预览 - for detailTable & groupTable
    @RequestMapping("quickPreview_V2")
    public void quickPreview_V2(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String ds = req.getParameter("ds");
        String sql = createSQL_V2(req);

        //current for table preview
        List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
        resultList = useDataSourceUtil_V2(ds, sql, null);

        JsonPageResult result = new JsonPageResult(true);
        result.setData(resultList);
        queryPageResult_V2(result, ds, sql, null);
        String jsonResult = iJson.toJson(result);

        PrintWriter pw = res.getWriter();
        pw.println(jsonResult);
        pw.close();
    }

    private void queryPageResult_V2(JsonPageResult result, String ds, String sql, Map<String, Object> jsonMap) throws Exception {
        if (StringUtil.isNotEmpty(ds)) {
            DbContextHolder.setDataSource(ds);
            result.setTotal(commonDao.query(sql, jsonMap).size());
            DbContextHolder.setDefaultDataSource();
        } else {
            result.setTotal(commonDao.query(sql, jsonMap).size());
        }
    }

    //快速预览 - for crossTable
    @RequestMapping("quickPreview_Cross_V2")
    public void quickPreview_Cross_V2(HttpServletRequest req, HttpServletResponse res, @RequestBody String data) throws Exception {
        //System.out.println(data);
        String ds = req.getParameter("ds");
        String sql = req.getParameter("query");
        String queryType = req.getParameter("queryType");
        String[] rowD = req.getParameterValues("rowD[]");
        String[] colD = req.getParameterValues("colD[]");
        String[] qD = req.getParameterValues("qD[]");

        String rowArr = Arrays.toString(rowD).substring(1, Arrays.toString(rowD).length() - 1);
        //String rowSql = "SELECT " + rowArr + " FROM (" + sql + ") A GROUP BY " + rowArr + " ORDER BY " + rowArr;
        //System.out.println(rowSql);

        //表头数据
        JSONObject json = new JSONObject();
        Map crossHead = new HashMap();
        if (colD != null) {
            crossHead = createCrossTableColDetail(sql, colD);
            json.put("cross_head", crossHead);
        }

        //实体数据
        JSONObject headObj = new JSONObject();
        headObj.putAll(crossHead);
        List list = new ArrayList();
        list = createCrossTableDetail(sql, colD, rowD, qD, headObj);
        json.put("cross_detail", list);

        PrintWriter pw = res.getWriter();
        pw.print(json);
        pw.close();
    }

    //crossTable 表头数据集合
    private Map createCrossTableColDetail(String sql, String[] colD) {
        Map<String, List<Map<String, String>>> map = new HashMap<String, List<Map<String, String>>>();
        for (String col : colD) {
            String _sql = "SELECT " + col + " FROM (" + sql + ") A GROUP BY " + col + " ORDER BY " + col;
            List<Map<String, String>> colList = commonDao.query(_sql);
            map.put(col, colList);
        }
        return map;
    }

    /**
     * 生成交叉报表的实体数据
     *
     * @param sql  传入的sql
     * @param colD 列维度
     * @param rowD 行维度
     * @param qD   指标
     */
    private List createCrossTableDetail(String sql, String[] colD, String[] rowD, String[] qD, JSONObject headObj) {

        //维度和指标栏位
        String rowArr = Arrays.toString(rowD).substring(1, Arrays.toString(rowD).length() - 1);
        String qArr = Arrays.toString(qD).substring(1, Arrays.toString(qD).length() - 1);
        String colArr = Arrays.toString(colD).substring(1, Arrays.toString(colD).length() - 1);

        String _colSql = "SELECT " + ((rowD != null ? (qD != null ? rowArr + ", " + qArr : rowArr) : (qD != null ? qArr : "*"))) + " FROM (" + sql + ") A WHERE 1=1 ";
        //System.err.println(_colSql);
        String wholeSql = "SELECT * FROM ";

        if (colD != null) {
            List<String> whereSql = new ArrayList<String>(); //列维度查询条件结果集
			/*for(int i = 0; i < colD.length; i++) {
				JSONArray arr = headObj.getJSONArray(colD[i]);
				if(i == 0) {
					for(int k = 0; k < arr.size(); k++) {
						String where = "AND " + colD[i] + " = '" + arr.getJSONObject(k).getString(colD[i]) + "' ";
						whereSql.add(where);
					}
				} else {
					List<String> whereSqlBak = whereSql;
					whereSql = new ArrayList<String>();
					for(int k = 0; k < arr.size(); k++) {
						for(String whereRes : whereSqlBak) {
							String where = whereRes + " AND " + colD[i] + " = '" + arr.getJSONObject(k).getString(colD[i]) + "' ";
							whereSql.add(where);
						}
					}
				}
			}*/
            for (int i = colD.length - 1; i >= 0; i--) {
                JSONArray arr = headObj.getJSONArray(colD[i]);
                if (i == colD.length - 1) {
                    for (int k = 0; k < arr.size(); k++) {
                        String where = "AND " + colD[i] + " = '" + arr.getJSONObject(k).getString(colD[i]) + "' ";
                        whereSql.add(where);
                    }
                } else {
                    List<String> whereSqlBak = whereSql;
                    whereSql = new ArrayList<String>();
                    for (int k = 0; k < arr.size(); k++) {
                        for (String whereRes : whereSqlBak) {
                            String where = whereRes + " AND " + colD[i] + " = '" + arr.getJSONObject(k).getString(colD[i]) + "' ";
                            whereSql.add(where);
                        }
                    }
                }
            }
            //System.err.println(whereSql);
            //生成所有的列维度 //没有行列维度就报错
            String __sql = "SELECT ";
            __sql += (rowD != null ? rowArr : "");
            __sql += (colD != null ? (rowD != null ? ", " : "") + colArr : "");
            for (int i = 0; i < whereSql.size(); i++) {
                String colSql = __sql;
                if (qD != null) {
                    for (String qdstr : qD) {
                        qdstr = qdstr + " AS " + qdstr + (i + 1);
                        colSql += ", " + qdstr;
                    }
                }
                colSql += " FROM (" + sql + ") A WHERE 1=1 ";
                if (rowD != null) {
                    String _qStr = "";
                    for (int k = 0; k < qD.length; k++) {
                        if (k == 0) {
                            _qStr += "B." + qD[k] + " ";
                        } else {
                            _qStr += ", B." + qD[k] + " ";
                        }
                    }
                    for (String qdstr : qD) {
                        _qStr = _qStr.replace(qdstr, qdstr + (i + 1)); //命名别名
                    }
//					String _sql_ = "SELECT A.*, " + _qStr + " FROM (SELECT " + rowArr + (colD != null ? ", " + colArr : "") + 
//							" FROM (" + sql + ") A " + (rowD != null ? "GROUP BY " + rowArr : "") + ") A LEFT JOIN (" + colSql + ") B ON ";
                    String _sql_ = "SELECT A.*, " + _qStr + " FROM (" + __sql +
                            " FROM (" + sql + ") A " + (rowD != null ? "GROUP BY " + rowArr : "") + ") A LEFT JOIN (" + colSql + ") B ON ";
                    for (int k = 0; k < rowD.length; k++) {
                        if (k == 0) {
                            _sql_ += "A." + rowD[k] + " = B." + rowD[k] + " ";
                        } else {
                            _sql_ += "AND A." + rowD[k] + " = B." + rowD[k] + " ";
                        }
                    }
                    _sql_ += whereSql.get(i).replace("AND ", "AND B.") + " ORDER BY " + (rowD != null ? (rowArr + ", ") : "") + colArr;
                    colSql = _sql_;
                } else {
                    colSql += whereSql.get(i);
                }
                whereSql.set(i, colSql);
            }
            //System.err.println(whereSql);
            for (int i = 0; i < whereSql.size(); i++) {
                if (i == 0) {
                    wholeSql += "(" + whereSql.get(i) + ") A" + i;
                } else {
                    wholeSql += " LEFT JOIN (" + whereSql.get(i) + ") A" + i;
                    if (rowD != null) {
                        wholeSql += " ON ";
                        for (int k = 0; k < rowD.length; k++) {
                            if (k == 0) {
                                wholeSql += "A" + (i - 1) + "." + rowD[k] + " = A" + i + "." + rowD[k] + " ";
                            } else {
                                wholeSql += "AND A" + (i - 1) + "." + rowD[k] + " = A" + i + "." + rowD[k] + " ";
                            }
                        }
                    } else {
                        wholeSql += " ON 1=1 ";
                    }
                }
            }
        } else {
            wholeSql += "(" + _colSql + ") AS A ";
        }
        //System.err.println(wholeSql);
        List<Map<String, String>> list = commonDao.query(wholeSql);
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public MybatisBaseManager getBaseManager() {
        return echartsCustomManager;
    }
}
