
package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.wxrepair.core.entity.PatrolFullbillRecord;
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

/**
 * 巡检单填写记录控制器
 * @author zpf
 */
@Controller
@RequestMapping("/wxrepair/core/patrolFullbillRecord/")
public class PatrolFullbillRecordController extends MybatisListController{
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
    @LogEnt(action = "del", module = "wxrepair", submodule = "巡检单填写记录")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                patrolFullbillRecordManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除!");
    }
    
    /**
     * 查看明细
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("get")
    public ModelAndView get(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=RequestUtil.getString(request, "pkId");
        PatrolFullbillRecord patrolFullbillRecord=null;
        if(StringUtils.isNotEmpty(pkId)){
           patrolFullbillRecord=patrolFullbillRecordManager.get(pkId);
        }else{
        	patrolFullbillRecord=new PatrolFullbillRecord();
        }
        return getPathView(request).addObject("patrolFullbillRecord",patrolFullbillRecord);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	PatrolFullbillRecord patrolFullbillRecord=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		patrolFullbillRecord=patrolFullbillRecordManager.get(pkId);
    	}else{
    		patrolFullbillRecord=new PatrolFullbillRecord();
    	}
    	return getPathView(request).addObject("patrolFullbillRecord",patrolFullbillRecord);
    }
    
    /**
     * 有子表的情况下编辑明细的json
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("getJson")
    @ResponseBody
    public PatrolFullbillRecord getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        PatrolFullbillRecord patrolFullbillRecord = patrolFullbillRecordManager.getPatrolFullbillRecord(uId);
        return patrolFullbillRecord;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "wxrepair", submodule = "巡检单填写记录")
    public JsonResult save(HttpServletRequest request, @RequestBody PatrolFullbillRecord patrolFullbillRecord, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(patrolFullbillRecord.getId())) {
            patrolFullbillRecordManager.create(patrolFullbillRecord);
            msg = getMessage("patrolFullbillRecord.created", new Object[]{patrolFullbillRecord.getIdentifyLabel()}, "[巡检单填写记录]成功创建!");
        } else {
        	String id=patrolFullbillRecord.getId();
        	PatrolFullbillRecord oldEnt=patrolFullbillRecordManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, patrolFullbillRecord);
            patrolFullbillRecordManager.update(oldEnt);
       
            msg = getMessage("patrolFullbillRecord.updated", new Object[]{patrolFullbillRecord.getIdentifyLabel()}, "[巡检单填写记录]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return patrolFullbillRecordManager;
	}

    /**
     * 获取当前用户填单记录
     * @param params
     * @return
     */
    @RequestMapping("getRecordByStaff")
    @ResponseBody
    public ResResult getRecordByStaff(@RequestBody JSONObject params) {
        ResResult result = new ResResult();
        ResultMap res = new ResultMap();
        String staffId = params.getString("staffId");
        List<PatrolFullbillRecord> list = patrolFullbillRecordManager.getRecordByStaff(staffId);
        res.setResMsg("获取巡检单填写记录");
        res.setResCode(0);
        res.setData(list);
        result.setResMsg("请求成功");
        result.setResult(res);
        return result;
    }

    @RequestMapping("listData")
    public void listData(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
            queryFilter.addFieldParam("F_STATUS","2");
            List<?> list = getPage(queryFilter);
            JsonPageResult<?> result = new JsonPageResult(list, queryFilter.getPage().getTotalItems());
            String json = JSON.toJSONStringWithDateFormat(result, "yyyy-MM-dd HH:mm:ss");
            PrintWriter pw = response.getWriter();
            pw.println(json);
            pw.close();
        }
    }
}
