
package com.redxun.oa.ats.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateFormatUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.ats.entity.AtsAttenceCalculate;
import com.redxun.oa.ats.entity.AtsAttenceCalculateSet;
import com.redxun.oa.ats.entity.AtsAttencePolicy;
import com.redxun.oa.ats.entity.AtsAttendanceFile;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.manager.AtsAttenceCalculateManager;
import com.redxun.oa.ats.manager.AtsAttenceCalculateSetManager;
import com.redxun.oa.ats.manager.AtsAttenceCycleDetailManager;
import com.redxun.oa.ats.manager.AtsAttencePolicyManager;
import com.redxun.oa.ats.manager.AtsAttendanceFileManager;
import com.redxun.oa.ats.manager.AtsShiftInfoManager;
import com.redxun.oa.ats.manager.AtsUtils;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.ui.view.model.ExportFieldColumn;

/**
 * 考勤计算控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceCalculate/")
public class AtsAttenceCalculateController extends MybatisListController{
    @Resource
    AtsAttenceCalculateManager atsAttenceCalculateManager;
	@Resource
	private AtsAttencePolicyManager atsAttencePolicyManager;
	@Resource
	private AtsAttenceCycleDetailManager atsAttenceCycleDetailManager;
	@Resource
	private AtsAttenceCalculateSetManager atsAttenceCalculateSetManager;
	@Resource
	private AtsAttendanceFileManager atsAttendanceFileManager;
	@Resource
	private AtsShiftInfoManager atsShiftInfoManager;
	@Resource
	private OsRelInstManager osRelInstManager;
	@Resource
	private OsGroupManager osGroupManager;
	@Resource
	private OsUserManager osUserManager;
	
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "考勤计算")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsAttenceCalculateManager.delete(id);
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
        AtsAttenceCalculate atsAttenceCalculate=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsAttenceCalculate=atsAttenceCalculateManager.get(pkId);
        }else{
        	atsAttenceCalculate=new AtsAttenceCalculate();
        }
        return getPathView(request).addObject("atsAttenceCalculate",atsAttenceCalculate);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsAttenceCalculate atsAttenceCalculate=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsAttenceCalculate=atsAttenceCalculateManager.get(pkId);
    	}else{
    		atsAttenceCalculate=new AtsAttenceCalculate();
    	}
    	return getPathView(request).addObject("atsAttenceCalculate",atsAttenceCalculate);
    }
    
    /**
	 * 获取表格的行列数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getGridColModel")
	@ResponseBody
	public JSONObject getGridColModel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Date startTime = RequestUtil.getDate(request, "startTime");
		Date endTime = RequestUtil.getDate(request, "endTime");
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		net.sf.json.JSONObject json = new net.sf.json.JSONObject();
		JSONArray colNamesAry = new JSONArray();
		JSONArray colModelAry = new JSONArray();

/*		this.setJsonAry(colNamesAry, colModelAry, "ID", "fileId", "fileId", 80);
		this.setJsonAry(colNamesAry, colModelAry, "组织ID", "orgName", "orgName", 80);*/
		this.setJsonAry(colNamesAry, colModelAry, "工号", "account", "account", 80);
		this.setJsonAry(colNamesAry, colModelAry, "姓名", "userName", "userName", 80);
		// 汇总字段
		setJsonSummary(colNamesAry, colModelAry);

		for (int i = 0; i <= betweenDays; i++) {
			Date date = DateUtil.addDay(startTime, i);
			String week = DateUtil.getWeekOfDate(date);
			String time = DateFormatUtil.format(date, "dd");
			this.setJsonAry(colNamesAry, colModelAry, time + "(" + week + ")", String.valueOf(i+1<10?"0"+i:i+1), DateFormatUtil.formatDate(date), 85);
		}
		json.accumulate("colNames", colNamesAry.toString()).accumulate("colModel", colModelAry.toString());

		return JSON.parseObject(json.toString());

	}
	
	/**
	 * 设置汇总字段
	 * 
	 * @param colNamesAry
	 * @param colModelAry
	 */
	private void setJsonSummary(JSONArray colNamesAry, JSONArray colModelAry) {
		JSONArray jsonSet = this.getAtsAttenceCalculateSetSummary();
		for (Object obj : jsonSet) {
			JSONObject set = (JSONObject) obj;
			this.setJsonAry(colNamesAry, colModelAry, set.getString("lable"), set.getString("name"), set.getString("name"), 80);
		}
	}
	
	/**
	 * 设置展示字段
	 * 
	 * @param colNamesAry
	 * @param colModelAry
	 * @param lable
	 * @param name
	 * @param index
	 * @param width
	 * @param hidden
	 * @param summaryType
	 */
	private void setJsonAry(JSONArray colNamesAry, JSONArray colModelAry, String lable, String name, String index, int width) {
		net.sf.json.JSONObject json = new net.sf.json.JSONObject();
		json.accumulate("header", lable).accumulate("width", width).accumulate("field", name).accumulate("index", index);
		colNamesAry.add(lable);
		colModelAry.add(json);
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
    public String getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "ids");    	
        AtsAttenceCalculate atsAttenceCalculate = atsAttenceCalculateManager.getAtsAttenceCalculate(uId);
        String json = net.sf.json.JSONObject.fromObject(atsAttenceCalculate).toString();
        return json;
    }
    
    /**
	 * 取得考勤计算分页列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 考勤制度
		AtsAttencePolicy atsAttencePolicy = atsAttencePolicyManager.getDefaultAttencePolicy();
		// 考勤周期
		//		List<AtsAttenceCycleDetail> cycleList = null;
		//		if (BeanUtils.isNotEmpty(atsAttencePolicy))
		//			cycleList = atsAttenceCycleDetailService.getByCycleId(
		//					atsAttencePolicy.getAttenceCycle(), true);
		// 开始结束时间
		Calendar ca = Calendar.getInstance();

		ca.set(Calendar.DAY_OF_MONTH, 1);
		Date startTime = ca.getTime();
		ca.add(Calendar.MONTH, 1);
		ca.add(Calendar.DAY_OF_MONTH, -1);
		Date endTime = ca.getTime();
		return this.getPathView(request).addObject("atsAttencePolicy", atsAttencePolicy).addObject("startTime", DateFormatUtil.formatDate(startTime)).addObject("endTime", DateFormatUtil.formatDate(endTime));
	}
	
    /**
	 * 考勤结果明细
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getDetailList")
	@ResponseBody
	public void getDetailList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/json");
		QueryFilter filter = getQueryFilter(request);
		String[] type = RequestUtil.getStringAryByStr(request, "type");
		String orgPath = RequestUtil.getString(request, "orgPath");
		if (BeanUtil.isNotEmpty(orgPath)) {
			OsGroup org = osGroupManager.get(orgPath);
			if (BeanUtil.isNotEmpty(org))
				// 查找某一组织下包含其子类的所有组织
				filter.addFieldParam("path", org.getPath() + "%");
		}
		if (BeanUtil.isNotEmpty(type)) {
			List<String> attenceType = new ArrayList<String>();
			for (String t : type) {
				attenceType.add("%" + t + "%");
			}
			filter.addFieldParam("attenceType", attenceType);
		}

		List<AtsAttenceCalculate> list = atsAttenceCalculateManager.getListData(filter);

		JSONArray array = getPageDetailList(list);
		JsonPageResult<?> result=new JsonPageResult(array,filter.getPage().getTotalItems());
		String jsonResult=iJson.toJson(result);
		PrintWriter pw=response.getWriter();
		pw.println(jsonResult);
		pw.close();
	}
	
	/**
	 * 我的考勤结果明细
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getMyDetailList")
	@ResponseBody
	public void getMyDetailList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/json");
		QueryFilter filter = getQueryFilter(request);
		filter.addFieldParam("userId", osUserManager.get(ContextUtil.getCurrentUserId()).getUserNo());
		String[] type = RequestUtil.getStringAryByStr(request, "type");
		if (BeanUtil.isNotEmpty(type)) {
			List<String> attenceType = new ArrayList<String>();
			for (String t : type) {
				attenceType.add("%" + t + "%");
			}
			filter.addFieldParam("attenceType", attenceType);
		}

		List<AtsAttenceCalculate> list = atsAttenceCalculateManager.getListData(filter);

		JSONArray array = getPageDetailList(list);
		JsonPageResult<?> result=new JsonPageResult(array,filter.getPage().getTotalItems());
		String jsonResult=iJson.toJson(result);
		PrintWriter pw=response.getWriter();
		pw.println(jsonResult);
		pw.close();
	}
	
	/**
	 * 我的日历结果处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("myCalendarHandler")
	@ResponseBody
	public net.sf.json.JSONObject myCalendarHandler(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date startTime = RequestUtil.getDate(request, "startTime");
		Date endTime = RequestUtil.getDate(request, "endTime");
		
		QueryFilter filter = getQueryFilter(request);
		filter.addFieldParam("userId", osUserManager.get(ContextUtil.getCurrentUserId()).getUserNo());
		filter.addFieldParam("beginattenceTime", startTime);
		filter.addFieldParam("endattenceTime", endTime);
		
		JSONArray jay = new JSONArray();
		List<AtsAttenceCalculate> list = atsAttenceCalculateManager.getListData(filter);
		for (AtsAttenceCalculate atsAttenceCalculate : list) {
			net.sf.json.JSONObject json = new net.sf.json.JSONObject();
			String time = DateFormatUtil.formatDate(atsAttenceCalculate.getAttenceTime());
			json.accumulate("title", AtsUtils.getAttenceType(atsAttenceCalculate, "、", true))
				.accumulate("start",time)
				.accumulate("dateType", atsAttenceCalculate.getAbnormity())
				.accumulate("abnormity", atsAttenceCalculate.getAbnormity())
				.accumulate("content", getContent(atsAttenceCalculate.getAbsentRecord()));
			jay.add(json);
		}		
		net.sf.json.JSONObject json = new net.sf.json.JSONObject();
		json.element("success", true).element("results", jay.toString());

		return json;
	}
	
	private String getContent(String record) {
		StringBuffer content = new StringBuffer("没有打卡记录！");
		JSONArray array;
		if(StringUtil.isNotEmpty(record)) {
			content.setLength(0);
			array = JSONArray.parseArray(record);
			for (Object object : array) {
				JSONObject obj = (JSONObject) object;
				Integer segment = (Integer) obj.get("segment");
				String onTime = (String) obj.get("onCardTime");
				String offTime = (String) obj.get("offCardTime");
				if(StringUtil.isEmpty(onTime)) {
					onTime = "无";
				}
				if(StringUtil.isEmpty(offTime)) {
					offTime = "无";
				}
				if(segment==1) {
					content.append("第一段上班："+ onTime +" 第一段下班："+ offTime +"<br/>");
				}
				if(segment==2) {
					content.append("第二段上班："+ onTime +" 第二段下班："+ offTime +"<br/>");
				}
				if(segment==3) {
					content.append("第三段上班："+ onTime +" 第三段下班："+ offTime +"<br/>");
				}
			}
		}
		
		return content.toString();
	}
	
	/**
	 * 分页数据
	 * 
	 * @param list
	 * @param pageBean
	 * @param betweenDays
	 * @param startTime
	 * @return
	 */
	private JSONArray getPageDetailList(List<AtsAttenceCalculate> list) {
		JSONArray jary = new JSONArray();
		for (AtsAttenceCalculate calculate : list) {
			/*if(DateFormatUtil.formatDate(calculate.getAttenceTime()).equals("2015-07-21")){
				System.out.println();
			}*/
			net.sf.json.JSONObject json = new net.sf.json.JSONObject();
			String orgNames = atsAttenceCalculateManager.getOrgnamesByUserId(calculate.getUserId());
			String attenceType = AtsUtils.getAttenceType(calculate, "、", true);
			String holidayRecord = calculate.getHolidayRecord();
			if(StringUtil.isNotEmpty(holidayRecord)) {
				attenceType = holidayRecord;
			}
			getAbsentRecord(calculate);//设置一下没有效打卡却有打卡的明细显示时间，默认放在第一段上班和下班时间
			String abnormity =calculate.getAbnormity()==AtsAttenceCalculate.AbnormityType.normal?"否":"是";
			
			json.accumulate("id", calculate.getId()).accumulate("account", BeanUtil.isEmpty(calculate.getAccount()) ? "" : calculate.getAccount()).accumulate("userName", BeanUtil.isEmpty(calculate.getUserName()) ? "" : calculate.getUserName()).accumulate("orgName", BeanUtil.isEmpty(orgNames) ? "" : orgNames).accumulate("attenceTime", DateFormatUtil.formatDate(calculate.getAttenceTime())).accumulate("week", DateUtil.getWeekOfDate(calculate.getAttenceTime())).accumulate("shiftName", BeanUtil.isNotEmpty(calculate.getShiftName()) ? calculate.getShiftName() : "").accumulate("attenceType", attenceType).accumulate("shiftTime11", BeanUtil.isEmpty(calculate.getAbsentRecord11()) ? "" : calculate.getAbsentRecord11())
					.accumulate("shiftTime12", BeanUtil.isEmpty(calculate.getAbsentRecord12()) ? "" : calculate.getAbsentRecord12()).accumulate("shiftTime21", BeanUtil.isEmpty(calculate.getAbsentRecord21()) ? "" : calculate.getAbsentRecord21()).accumulate("shiftTime22", BeanUtil.isEmpty(calculate.getAbsentRecord22()) ? "" : calculate.getAbsentRecord22()).accumulate("shiftTime31", BeanUtil.isEmpty(calculate.getAbsentRecord31()) ? "" : calculate.getAbsentRecord31()).accumulate("shiftTime32", BeanUtil.isEmpty(calculate.getAbsentRecord32()) ? "" : calculate.getAbsentRecord32()).accumulate("abnormity", abnormity);//TODO
			jary.add(json);
		}
		return jary;
	}
	
	/**
	 * 考勤结果导出明细
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("exportReportMyDetail")
	public void exportReportMyDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QueryFilter filter = getQueryFilter(request);
		filter.addFieldParam("userId", osUserManager.get(ContextUtil.getCurrentUserId()).getUserNo());
		exportExcel(2, filter, response);
	}
	/**
	 * 考勤结果导出明细
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("exportReportDetail")
	public void exportReportDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		QueryFilter filter = getQueryFilter(request);
		Integer action = RequestUtil.getInt(request, "action");
		String[] type = RequestUtil.getStringAryByStr(request, "type");
		String orgPath = RequestUtil.getString(request, "orgPath");
		if (BeanUtil.isNotEmpty(orgPath)) {
			OsGroup org = osGroupManager.get(orgPath);
			if (BeanUtil.isNotEmpty(org))
				// 查找某一组织下包含其子类的所有组织
				filter.addFieldParam("path", org.getPath() + "%");
		}
		if (BeanUtil.isNotEmpty(type)) {
			List<String> attenceType = new ArrayList<String>();
			for (String t : type) {
				attenceType.add("%" + t + "%");
			}
			filter.addFieldParam("attenceType", attenceType);
		}
		exportExcel(action, filter, response);
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void exportExcel(Integer action,QueryFilter filter,HttpServletResponse response) {
		List<AtsAttenceCalculate> list= atsAttenceCalculateManager.getListDataAll(filter);
		
		JSONArray rowData = new JSONArray();
		List<ExportFieldColumn> headMap = new ArrayList<ExportFieldColumn>();
		String fileName = "考勤结果明细";

		if (action == 0 || action == 1) {
			String[] titleAry = new String[] { "姓名", "员工编号", "组织", "考勤日期", "应出勤时数", "实际出勤时数", "迟到次数", "迟到分钟", "早退次数", "早退分钟", "旷工次数", "旷工小时数" };
			String[] filedAry = new String[] { "userName", "account", "orgName", "attenceTime", "shouldAttenceHours", "actualAttenceHours", "lateNumber", "lateTime", "leaveNumber", "leaveTime", "absentNumber", "absentTime"};
			for (int i = 0; i < titleAry.length; i++) {
				ExportFieldColumn column = new ExportFieldColumn();
				column.setField(filedAry[i]);
				column.setWidth(3000);
				column.setColspan(1);
				column.setHeader(titleAry[i]);
				column.setChildColumn(new ArrayList<ExportFieldColumn>());
				headMap.add(column);
			}
			for (int i = 0; i < list.size(); i++) {
				AtsAttenceCalculate cal = list.get(i);
				rowData.add(cal);
			}
		} else {// 考勤结果
			String[] titleAry = new String[] { "姓名", "工号", "组织", "考勤日期", "星期", "班次名称", "异常类型", "第一段上班", "第一段下班", "第二段上班", "第二段下班", "第三段上班", "第三段下班" };
			String[] filedAry = new String[] { "userName", "account", "orgName", "attenceTime", "attenceTime", "shiftName", "attenceType", "absentRecord11", "absentRecord12", "absentRecord21", "absentRecord22", "absentRecord31", "absentRecord32"};
			for (int i = 0; i < titleAry.length; i++) {
				ExportFieldColumn column = new ExportFieldColumn();
				column.setField(filedAry[i]);
				column.setWidth(3000);
				column.setColspan(1);
				column.setHeader(titleAry[i]);
				column.setChildColumn(new ArrayList<ExportFieldColumn>());
				headMap.add(column);
			}
			for (int i = 0; i < list.size(); i++) {
				AtsAttenceCalculate calculate = list.get(i);
				String orgNames = atsAttenceCalculateManager.getOrgnamesByUserId(calculate.getUserId());
				String attenceType = AtsUtils.getAttenceType(calculate, "、", true);
				calculate.setAttenceType(attenceType);
				calculate.setOrgName(orgNames);
				getAbsentRecord(calculate);
				rowData.add(calculate);
			}
		}

		// 取得表的数据
		ExcelUtil.downloadExcelFile(fileName, headMap, rowData, response);
	}
	
	private void getAbsentRecord(AtsAttenceCalculate calculate) {
		//不包含旷工才设置
		if (BeanUtil.isEmpty(calculate.getAbsentRecord())&&!calculate.getAttenceType().contains("00"+AtsConstant.TIME_TYPE_ABSENT)){
			if(StringUtil.isNotEmpty(calculate.getCardRecord())){
				String[] strs = calculate.getCardRecord().split("\\|");
				calculate.setAbsentRecord11(strs[0]);
				calculate.setAbsentRecord12(strs[strs.length-1]);
				//System.out.println(strs);
			}
			return;
		}
		
		JSONArray jary = JSON.parseArray(calculate.getAbsentRecord());
		if(jary == null){  
			return;
		}
		for (int i = 0; i < jary.size(); i++) {
			if(jary.get(i) == null || "null".equals(jary.get(i).toString()))  
				continue;
			JSONObject json = (JSONObject) jary.get(i);
			Integer segment = (Integer) json.get("segment");
			Object onCardTime = null;
			Object offCardTime = null;
			if (BeanUtil.isNotEmpty(segment)) {
				onCardTime = json.get("onCardTime");
				offCardTime = json.get("offCardTime");
			} else {
				segment = i + 1;
			}
			String onTime = "";
			String offTime = "";
			if (BeanUtil.isNotEmpty(onCardTime))
				onTime = onCardTime.toString();
			if (BeanUtil.isNotEmpty(offCardTime))
				offTime = offCardTime.toString();

			if (segment.intValue() == AtsConstant.SEGMENT_1) {
				calculate.setAbsentRecord11(onTime);
				calculate.setAbsentRecord12(offTime);
			} else if (segment.intValue() == AtsConstant.SEGMENT_2) {
				calculate.setAbsentRecord21(onTime);
				calculate.setAbsentRecord22(offTime);
			} else if (segment.intValue() == AtsConstant.SEGMENT_3) {
				calculate.setAbsentRecord31(onTime);
				calculate.setAbsentRecord32(offTime);
			}
		}

	}
	
	/**
	 * 全部计算
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("calculate")
	@ResponseBody
	public JsonResult calculate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Date startTime = RequestUtil.getDate(request, "startTime");
		Date endTime = RequestUtil.getDate(request, "endTime");
		String[] fileIds = RequestUtil.getStringAryByStr(request, "fileIds");
		
		int count;
		
		try {
			if (BeanUtil.isEmpty(fileIds) || "".equals(fileIds[0]))
				count = atsAttenceCalculateManager.allCalculate(startTime, endTime,ContextUtil.getCurrentTenantId());
			else
				// 选中记录
				count = atsAttenceCalculateManager.calculate(startTime, endTime, fileIds);
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false,"出错了" + e.getMessage());
		}
		if(count==0) {
			return new JsonResult(false,"没有可计算人员");
		}
		return new JsonResult(true,"计算完毕,总计算人数:"+count);
	}
	
	
	/**
	 * 取得未计算人员列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getNoneCalList")
	@ResponseBody
	public void getNoneCalList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/json");
		try {
			QueryFilter filter = getQueryFilter(request);
			String orgPath = RequestUtil.getString(request, "orgPath");
			if (BeanUtil.isNotEmpty(orgPath)) {
				OsGroup org = osGroupManager.get(orgPath);
				if (BeanUtil.isNotEmpty(org))
					// 查找某一组织下包含其子类的所有组织
					filter.addFieldParam("path", org.getPath() + "%");
			}
			List<AtsAttendanceFile> list = atsAttendanceFileManager.getNoneCalList(filter);
			JSONArray jary = new JSONArray();
			for (AtsAttendanceFile atsAttendanceFile : list) {
				net.sf.json.JSONObject j = new net.sf.json.JSONObject();
				String orgNames = "";
				if (BeanUtil.isNotEmpty(atsAttendanceFile.getUserId()))
					orgNames = atsAttenceCalculateManager.getOrgnamesByUserId(atsAttendanceFile.getUserId());
				j.accumulate("fileId", atsAttendanceFile.getId()).accumulate("cardNumber", atsAttendanceFile.getCardNumber()).accumulate("userName", BeanUtil.isEmpty(atsAttendanceFile.getUserName()) ? "" : atsAttendanceFile.getUserName()).accumulate("account", BeanUtil.isEmpty(atsAttendanceFile.getUserNo()) ? "" : atsAttendanceFile.getUserNo()).accumulate("orgName", orgNames);
				jary.add(j);
			}
			JsonPageResult<?> result=new JsonPageResult(jary,filter.getPage().getTotalItems());
			String jsonResult=iJson.toJson(result);
			PrintWriter pw=response.getWriter();
			pw.println(jsonResult);
			pw.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 取得考勤计算分页列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getCalList")
	public void getCalList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/json");
		Date startTime = RequestUtil.getDate(request, "Q_beginattenceTime_D_LE");
		Date endTime = RequestUtil.getDate(request, "Q_endattenceTime_D_GE");
		
		QueryFilter filter = getQueryFilter(request);
		String orgPath = RequestUtil.getString(request, "orgPath");
		if (BeanUtil.isNotEmpty(orgPath)) {
			OsGroup org = osGroupManager.get(orgPath);
			if (BeanUtil.isNotEmpty(org))
				// 查找某一组织下包含其子类的所有组织
				filter.addFieldParam("path", org.getPath() + "%");
		}
		List<AtsAttenceCalculate> list = atsAttenceCalculateManager.getList(filter);
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		
		JSONArray json = getPageList(list, (Page)filter.getPage(), betweenDays, startTime);
		JsonPageResult<?> result=new JsonPageResult(json,filter.getPage().getTotalItems());
		String jsonResult=iJson.toJson(json);
		PrintWriter pw=response.getWriter();
		pw.println(jsonResult);
		pw.close();
	}
	
	/**
	 * 分页数据
	 * 
	 * @param list
	 * @param pageBean
	 * @param betweenDays
	 * @param startTime
	 * @return
	 */
	private JSONArray getPageList(List<AtsAttenceCalculate> list, Page pageBean, int betweenDays, Date startTime) {
		JSONArray jary = new JSONArray();
		AtsAttenceCalculateSet atsAttenceCalculateSet = atsAttenceCalculateSetManager.getDefault();
		for (AtsAttenceCalculate calculate : list) {
			String fileId = calculate.getFileId();
			net.sf.json.JSONObject json = new net.sf.json.JSONObject();
			json.accumulate("fileId", fileId).accumulate("account", BeanUtil.isEmpty(calculate.getAccount()) ? "" : calculate.getAccount()).accumulate("userName", BeanUtil.isEmpty(calculate.getUserName()) ? "" : calculate.getUserName()).accumulate("orgName", BeanUtil.isEmpty(calculate.getOrgName()) ? "" : calculate.getOrgName());
			Double shouldAttenceHours = 0d;
			Double actualAttenceHours = 0d;
			Double absentNumber = 0d;
			Double lateNumber = 0d;
			Double leaveNumber = 0d;
			Double absentTime = 0d;
			Double lateTime = 0d;
			Double leaveTime = 0d;
			for (int i = 0; i <= betweenDays; i++) {

				Date date = DateUtil.addDay(startTime, i);
				//String time = DateFormatUtil.format(date, "dd");
				AtsAttenceCalculate cal = atsAttenceCalculateManager.getByFileIdAttenceTime(fileId, date);
				if (BeanUtil.isEmpty(cal)) {
					json.accumulate(String.valueOf(i+1<10?"0"+i:i+1), "无排班记录");
					continue;
				}
				String tilte = this.getSetDetail(cal, atsAttenceCalculateSet);
				json.accumulate(String.valueOf(i+1<10?"0"+i:i+1), tilte);

				if (BeanUtil.isNotEmpty(cal.getShouldAttenceHours()))
					shouldAttenceHours += cal.getShouldAttenceHours();
				if (BeanUtil.isNotEmpty(cal.getActualAttenceHours()))
					actualAttenceHours += cal.getActualAttenceHours();
				// 计算旷工、迟到、早退数
				if (BeanUtil.isNotEmpty(cal.getAbsentNumber()))
					absentNumber += cal.getAbsentNumber();
				if (BeanUtil.isNotEmpty(cal.getLateNumber()))
					lateNumber += cal.getLateNumber();
				if (BeanUtil.isNotEmpty(cal.getLeaveNumber()))
					leaveNumber += cal.getLeaveNumber();
				if (BeanUtil.isNotEmpty(cal.getAbsentTime()))
					absentTime += cal.getAbsentTime();
				if (BeanUtil.isNotEmpty(cal.getLateTime()))
					lateTime += cal.getLateTime();
				if (BeanUtil.isNotEmpty(cal.getLeaveTime()))
					leaveTime += cal.getLeaveTime();
			}
			JSONArray jsonSet = this.getAtsAttenceCalculateSetSummary();
			for (Object obj : jsonSet) {
				JSONObject set = (JSONObject) obj;
				String key1 = set.getString("name");
				double val = 0d;
				if (key1.contains("S11"))
					val = shouldAttenceHours;
				else if (key1.contains("S12"))
					val = actualAttenceHours;
				else if (key1.contains("S21"))
					val = absentNumber;
				else if (key1.contains("S22"))
					val = absentTime;
				else if (key1.contains("S31"))
					val = lateNumber;
				else if (key1.contains("S32"))
					val = lateTime;
				else if (key1.contains("S41"))
					val = leaveNumber;
				else if (key1.contains("S42"))
					val = leaveTime;

				json.accumulate(key1, val);
			}
			jary.add(json);

		}
		
		return jary;
	}
	
	/**
	 * 获取汇总明细
	 * 
	 * @return
	 */
	private JSONArray getAtsAttenceCalculateSetSummary() {
		AtsAttenceCalculateSet atsAttenceCalculateSet = atsAttenceCalculateSetManager.getDefault();
		JSONArray jary = new JSONArray();
		if (BeanUtil.isNotEmpty(atsAttenceCalculateSet) && BeanUtil.isNotEmpty(atsAttenceCalculateSet.getSummary()))
			jary = JSON.parseArray(atsAttenceCalculateSet.getSummary());
		if (jary!=null && jary.size()>0) {
			jary = new JSONArray();
			net.sf.json.JSONObject json2 = new net.sf.json.JSONObject();
			json2.accumulate("lable", "旷工次数").accumulate("name", "S21");
			jary.add(json2);
			net.sf.json.JSONObject json3 = new net.sf.json.JSONObject();
			json3.accumulate("lable", "迟到次数").accumulate("name", "S31");
			jary.add(json3);
			net.sf.json.JSONObject json4 = new net.sf.json.JSONObject();
			json4.accumulate("lable", "早退次数").accumulate("name", "S41");
			jary.add(json4);
		}
		return jary;
	}
	
	private String getSetDetail(AtsAttenceCalculate cal, AtsAttenceCalculateSet atsAttenceCalculateSet) {
		if (BeanUtil.isEmpty(cal))
			return "";
		String tilte = "";
		if (cal.getIsScheduleShift() == AtsConstant.NO)
			return AtsConstant.NO_SHIFT;
		Short dateType = cal.getDateType();

		//先处理考勤流程里面的数据
		if (cal.getOtNumber() != null && cal.getOtNumber() > 0) {
			return cal.getOtRecord();
		}
		if (cal.getHolidayNumber() != null && cal.getHolidayNumber() > 0) {
			return cal.getHolidayRecord();
		}
		if(cal.getTripNumber()!=null&&cal.getTripNumber()>0){
			return cal.getTripRecord();
		}
		
		if (dateType == AtsConstant.DATE_TYPE_DAYOFF) {
			tilte = AtsConstant.DATE_TYPE_DAYOFF_STRING;
		} else if (dateType == AtsConstant.DATE_TYPE_HOLIDAY) {
			tilte = BeanUtil.isEmpty(cal.getHolidayName()) ? AtsConstant.DATE_TYPE_HOLIDAY_STRING : cal.getHolidayName();
		} else {
			if (cal.getIsCardRecord() == AtsConstant.NO) {
				tilte = "无打卡记录";
			}
		}
		if (BeanUtil.isNotEmpty(tilte))
			return tilte;
		if (BeanUtil.isEmpty(atsAttenceCalculateSet) || BeanUtil.isEmpty(atsAttenceCalculateSet.getDetail())){
			Double hour = (BeanUtil.isEmpty(cal.getActualAttenceHours()) ? 0 : cal.getActualAttenceHours());
			int h  = hour.intValue();
			return "实出勤时数:" + h + ":" + (int)((hour-h)*60);
		}
		JSONArray jary = JSON.parseArray(atsAttenceCalculateSet.getDetail());
		for (Object o : jary) {
			JSONObject json = (JSONObject) o;
			String name = json.getString("name");
			String lable = json.getString("lable");
			Double val = null;
			if (name.contains("S11"))
				val = cal.getShouldAttenceHours();
			else if (name.contains("S12"))
				val = cal.getActualAttenceHours();
			else if (name.contains("S21"))
				val = cal.getAbsentNumber();
			else if (name.contains("S22"))
				val = cal.getAbsentTime();
			else if (name.contains("S31"))
				val = cal.getLateNumber();
			else if (name.contains("S32"))
				val = cal.getLateTime();
			else if (name.contains("S41"))
				val = cal.getLeaveNumber();
			else if (name.contains("S42"))
				val = cal.getLeaveTime();
			if (BeanUtil.isNotEmpty(val) && val > 0)
				return lable + ":" + val;
		}

		return "实出勤时数:" + (BeanUtil.isEmpty(cal.getActualAttenceHours()) ? 0 : cal.getActualAttenceHours());
	}

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsAttenceCalculateManager;
	}

}
