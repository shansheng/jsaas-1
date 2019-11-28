
package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.wxrepair.core.entity.PatrolFullbillRecord;
import com.airdrop.wxrepair.core.entity.PatrolFullbillRecordDetail;
import com.airdrop.wxrepair.core.manager.PatrolFullbillRecordDetailManager;
import com.airdrop.wxrepair.core.manager.PatrolFullbillRecordManager;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * 巡检单填写详情控制器
 *
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolFullbillRecordDetail/")
public class PatrolFullbillRecordDetailController extends MybatisListController {
    @Resource
    PatrolFullbillRecordDetailManager patrolFullbillRecordDetailManager;
    @Resource
    PatrolFullbillRecordManager patrolFullbillRecordManager;

    @Override
    protected QueryFilter getQueryFilter(HttpServletRequest request) {
        QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
        //queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
        return queryFilter;
    }

    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "巡检单填写详情")
    public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String uId = RequestUtil.getString(request, "ids");
        if ( StringUtils.isNotEmpty(uId) ) {
            String[] ids = uId.split(",");
            for (String id : ids) {
                patrolFullbillRecordDetailManager.delete(id);
            }
        }
        return new JsonResult(true, "成功删除!");
    }

    /**
     * 查看明细
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("get")
    public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pkId = RequestUtil.getString(request, "pkId");
        PatrolFullbillRecordDetail patrolFullbillRecordDetail = null;
        if ( StringUtils.isNotEmpty(pkId) ) {
            patrolFullbillRecordDetail = patrolFullbillRecordDetailManager.get(pkId);
        } else {
            patrolFullbillRecordDetail = new PatrolFullbillRecordDetail();
        }
        return getPathView(request).addObject("patrolFullbillRecordDetail", patrolFullbillRecordDetail);
    }


    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pkId = RequestUtil.getString(request, "pkId");
        PatrolFullbillRecordDetail patrolFullbillRecordDetail = null;
        if ( StringUtils.isNotEmpty(pkId) ) {
            patrolFullbillRecordDetail = patrolFullbillRecordDetailManager.get(pkId);
        } else {
            patrolFullbillRecordDetail = new PatrolFullbillRecordDetail();
        }
        return getPathView(request).addObject("patrolFullbillRecordDetail", patrolFullbillRecordDetail);
    }

    /**
     * 有子表的情况下编辑明细的json
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping("getJson")
    @ResponseBody
    public PatrolFullbillRecordDetail getJson(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String uId = RequestUtil.getString(request, "ids");
        PatrolFullbillRecordDetail patrolFullbillRecordDetail = patrolFullbillRecordDetailManager.getPatrolFullbillRecordDetail(uId);
        return patrolFullbillRecordDetail;
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "巡检单填写详情")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolFullbillRecordDetail patrolFullbillRecordDetail, BindingResult result) throws Exception {

        if ( result.hasFieldErrors() ) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if ( StringUtils.isEmpty(patrolFullbillRecordDetail.getId()) ) {
            patrolFullbillRecordDetailManager.create(patrolFullbillRecordDetail);
            msg = getMessage("patrolFullbillRecordDetail.created", new Object[]{patrolFullbillRecordDetail.getIdentifyLabel()}, "[巡检单填写详情]成功创建!");
        } else {
            String id = patrolFullbillRecordDetail.getId();
            PatrolFullbillRecordDetail oldEnt = patrolFullbillRecordDetailManager.get(id);
            BeanUtil.copyNotNullProperties(oldEnt, patrolFullbillRecordDetail);
            patrolFullbillRecordDetailManager.update(oldEnt);

            msg = getMessage("patrolFullbillRecordDetail.updated", new Object[]{patrolFullbillRecordDetail.getIdentifyLabel()}, "[巡检单填写详情]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public MybatisBaseManager getBaseManager() {
        return patrolFullbillRecordDetailManager;
    }

    /**
     * 获取巡检单填写详情
     *
     * @param params
     * @return
     */
    @RequestMapping("getRecordDetail")
    @ResponseBody
    public ResResult getRecordDetail(@RequestBody JSONObject params) {
        ResResult result = new ResResult();
        ResultMap res = new ResultMap();
        String recordId = params.getString("recordId");
        List<Map> list = patrolFullbillRecordDetailManager.getRecordDetail(recordId);
        res.setData(list);
        res.setResCode(0);
        res.setResMsg("获取填单详情");
        result.setResult(res);
        result.setResCode(0);
        result.setResMsg("请求成功");
        return result;
    }

    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pkId = request.getParameter("pkId");
        ModelAndView modelAndView = getPathView(request);
        modelAndView.addObject("recordId",pkId);
        return modelAndView;
    }

    @RequestMapping("listData")
    public void listData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String recordId = request.getParameter("recordId");
        String export = request.getParameter("_export");
        //是否导出
        if ( StringUtils.isNotEmpty(export) ) {
            String exportAll = request.getParameter("_all");
            if ( StringUtils.isNotEmpty(exportAll) ) {
                exportAllPages(request, response);
            } else {
                exportCurPage(request, response);
            }
        } else {
            response.setContentType("application/json");
            QueryFilter queryFilter = getQueryFilter(request);
            queryFilter.addFieldParam("REF_ID_", recordId);
            List<?> list = getPage(queryFilter);
            JsonPageResult<?> result = new JsonPageResult(list, queryFilter.getPage().getTotalItems());
            String json = JSON.toJSONStringWithDateFormat(result, "yyyy-MM-dd HH:mm:ss");
            PrintWriter pw = response.getWriter();
            pw.println(json);
            pw.close();
        }
    }

    @RequestMapping("fullDetail")
    public ModelAndView fullDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pkId = request.getParameter("pkId");
        List<Map> list = patrolFullbillRecordDetailManager.getRecordDetail(pkId);
        PatrolFullbillRecord record = patrolFullbillRecordManager.get(pkId);
        ModelAndView modelAndView = new ModelAndView();
        JSONObject recordDetail = new JSONObject();
        recordDetail.put("data",list);
        recordDetail.put("record",record);
        modelAndView.setViewName("wxrepair/core/patrolFullbillRecordDetail.jsp");
        modelAndView.addObject("recordDetail",recordDetail);
        return modelAndView;
    }
}
