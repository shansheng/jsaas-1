
package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.util.JsonUtils;
import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.wxrepair.core.entity.PatrolQuestionInfo;
import com.airdrop.wxrepair.core.entity.PatrolQuestionOption;
import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireInfo;
import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireType;
import com.airdrop.wxrepair.core.manager.PatrolQuestionInfoManager;
import com.airdrop.wxrepair.core.manager.PatrolQuestionnaireInfoManager;
import com.airdrop.wxrepair.core.manager.PatrolQuestionnaireTypeManager;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 问题信息控制器
 *
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolQuestionInfo/")
public class PatrolQuestionInfoController extends MybatisListController {
    @Resource
    PatrolQuestionInfoManager patrolQuestionInfoManager;

    @Resource
    PatrolQuestionnaireInfoManager patrolQuestionnaireInfoManager;

    @Resource
    PatrolQuestionnaireTypeManager patrolQuestionnaireTypeManager;

    @Override
    protected QueryFilter getQueryFilter(HttpServletRequest request) {
        QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
        queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
        return queryFilter;
    }

    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "wxrepair", submodule = "问题信息")
    public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String uId = RequestUtil.getString(request, "ids");
        if ( StringUtils.isNotEmpty(uId) ) {
            String[] ids = uId.split(",");
            for (String id : ids) {
                patrolQuestionInfoManager.delete(id);
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
        PatrolQuestionInfo patrolQuestionInfo = null;
        if ( StringUtils.isNotEmpty(pkId) ) {
            patrolQuestionInfo = patrolQuestionInfoManager.get(pkId);
        } else {
            patrolQuestionInfo = new PatrolQuestionInfo();
        }
        return getPathView(request).addObject("patrolQuestionInfo", patrolQuestionInfo);
    }


    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String pkId = RequestUtil.getString(request, "pkId");
        PatrolQuestionInfo patrolQuestionInfo = null;
        if ( StringUtils.isNotEmpty(pkId) ) {
            patrolQuestionInfo = patrolQuestionInfoManager.get(pkId);
        } else {
            patrolQuestionInfo = new PatrolQuestionInfo();
        }
        return getPathView(request).addObject("patrolQuestionInfo", patrolQuestionInfo);
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
    public PatrolQuestionInfo getJson(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String uId = RequestUtil.getString(request, "ids");
        PatrolQuestionInfo patrolQuestionInfo = patrolQuestionInfoManager.getPatrolQuestionInfo(uId);
        return patrolQuestionInfo;
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "问题信息")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolQuestionInfo patrolQuestionInfo, BindingResult result) throws Exception {

        if ( result.hasFieldErrors() ) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if ( StringUtils.isEmpty(patrolQuestionInfo.getId()) ) {
            patrolQuestionInfoManager.create(patrolQuestionInfo);
            msg = getMessage("patrolQuestionInfo.created", new Object[]{patrolQuestionInfo.getIdentifyLabel()}, "[问题信息]成功创建!");
        } else {
            String id = patrolQuestionInfo.getId();
            PatrolQuestionInfo oldEnt = patrolQuestionInfoManager.get(id);
            BeanUtil.copyNotNullProperties(oldEnt, patrolQuestionInfo);
            patrolQuestionInfoManager.update(oldEnt);

            msg = getMessage("patrolQuestionInfo.updated", new Object[]{patrolQuestionInfo.getIdentifyLabel()}, "[问题信息]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public MybatisBaseManager getBaseManager() {
        return patrolQuestionInfoManager;
    }

    /**
     * 获取所选问卷全部问题
     *
     * @param params
     * @return
     * @throws Exception
     */
    @RequestMapping("getQuestions")
    @ResponseBody
    public ResResult getQuestions(@RequestBody JSONObject params) throws Exception {
        String nId = params.getString("nId");
        ResResult result = new ResResult();
        ResultMap resultMap = new ResultMap();
        List list = patrolQuestionInfoManager.getQuestionByNaire(nId);
        PatrolQuestionnaireInfo questionnaireInfo = patrolQuestionnaireInfoManager.get(nId);
        JSONObject obj = new JSONObject();
        obj.put("questionnaire", questionnaireInfo);
        obj.put("questionlist", list);
        resultMap.setResCode(0);
        resultMap.setResMsg("获取题目信息");
        resultMap.setData(obj);
        result.setResCode(0);
        result.setResMsg("请求成功");
        result.setResult(resultMap);
        return result;
    }

    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request, @RequestBody PatrolQuestionnaireInfo patrolQuestionnaireInfo, HttpServletResponse response) throws Exception {
        String questionnaireType = patrolQuestionnaireInfo.getQuestionnaireType();
        if ( StringUtils.isEmpty(questionnaireType) ){
            PatrolQuestionnaireType type = new PatrolQuestionnaireType();
            type.setTypeName(patrolQuestionnaireInfo.getQuestionnaireTypeName());
            patrolQuestionnaireTypeManager.create(type);
            patrolQuestionnaireInfo.setQuestionnaireType(type.getId());
        }
        if ( StringUtils.isEmpty(patrolQuestionnaireInfo.getId()) ) {
            patrolQuestionnaireInfoManager.create(patrolQuestionnaireInfo);
        }else{
            patrolQuestionnaireInfoManager.update(patrolQuestionnaireInfo);
        }
        ModelAndView modelAndView = getPathView(request);
        modelAndView.addObject("questionnaireInfo", patrolQuestionnaireInfo);
        return modelAndView;
    }

    @RequestMapping("listData")
    public void listData(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String refId = request.getParameter("refId");
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
            queryFilter.addFieldParam("REF_ID_", refId);
            List<?> list = getPage(queryFilter);
            List<Map> maps = new ArrayList();
            if ( list != null && list.size() > 0 ) {
                for (int i = 0; i <list.size() ; i++) {
                    /*Map info = (Map)list.get(i);
                    Object id = info.get("ID_");
                    List<Map> questionOption = patrolQuestionInfoManager.getQuestionOption(id);
                    info.put("options",questionOption);*/
                    HashMap<String, Object> map = new HashMap<>();
                    PatrolQuestionInfo questionInfo = (PatrolQuestionInfo)list.get(i);
                    map.put("id",questionInfo.getId());
                    map.put("questionType",questionInfo.getQuestionType());
                    map.put("questionTypeName",questionInfo.getQuestionTypeName());
                    map.put("questionContent",questionInfo.getQuestionContent());
                    map.put("sequence",questionInfo.getSequence());
                    map.put("refid",questionInfo.getRefId());
                    List<PatrolQuestionOption> questionOption = patrolQuestionInfoManager.getQuestionOption(questionInfo.getId());
                    map.put("showdata",questionOption);
                    maps.add(map);
                }
            }
            JsonPageResult<?> result = new JsonPageResult(maps, queryFilter.getPage().getTotalItems());
            String json = JSON.toJSONStringWithDateFormat(result, "yyyy-MM-dd HH:mm:ss");
            PrintWriter pw = response.getWriter();
            pw.println(json);
            pw.close();
        }
    }

    @RequestMapping("saveQuestion")
    @ResponseBody
    public ResResult saveQuestion(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String data = request.getParameter("data");
        String nid = request.getParameter("nid");
        List<JSONObject> jsonObjects = JsonUtils.json2List(data, JSONObject.class);
        boolean b = patrolQuestionInfoManager.saveQuestion(jsonObjects, nid);
        ResResult result = new ResResult();
        ResultMap resultMap = new ResultMap();
        if ( b ) {
            resultMap.setResCode(0);
            resultMap.setResMsg("保存成功");
        } else {
            resultMap.setResCode(-1);
            resultMap.setResMsg("保存失败");
        }
        result.setResCode(0);
        result.setResMsg("请求成功");
        result.setResult(resultMap);
        return result;
    }
}
