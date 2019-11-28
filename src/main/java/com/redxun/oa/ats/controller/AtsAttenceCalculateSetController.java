
package com.redxun.oa.ats.controller;

import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateFormatUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.oa.ats.entity.AtsAttenceCalculateSet;
import com.redxun.oa.ats.entity.AtsAttenceGroupDetail;
import com.redxun.oa.ats.entity.AtsAttencePolicy;
import com.redxun.oa.ats.entity.AtsCardRule;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsScheduleShift;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.oa.ats.entity.AtsShiftRuleDetail;
import com.redxun.oa.ats.manager.AtsAttenceCalculateSetManager;
import com.redxun.oa.ats.manager.AtsAttenceGroupDetailManager;
import com.redxun.oa.ats.manager.AtsAttencePolicyManager;
import com.redxun.oa.ats.manager.AtsCardRuleManager;
import com.redxun.oa.ats.manager.AtsLegalHolidayDetailManager;
import com.redxun.oa.ats.manager.AtsScheduleShiftManager;
import com.redxun.oa.ats.manager.AtsShiftInfoManager;
import com.redxun.oa.ats.manager.AtsShiftRuleDetailManager;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 考勤计算设置控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceCalculateSet/")
public class AtsAttenceCalculateSetController extends MybatisListController{
    @Resource
    AtsAttenceCalculateSetManager atsAttenceCalculateSetManager;
    @Resource
    AtsAttenceGroupDetailManager atsAttenceGroupDetailManager;
    @Resource
    AtsScheduleShiftManager atsScheduleShiftManager;
    @Resource
    AtsShiftInfoManager atsShiftInfoManager;
    @Resource
    AtsCardRuleManager atsCardRuleManager;
    @Resource
    AtsAttencePolicyManager atsAttencePolicyManager;
	@Resource
	private AtsShiftRuleDetailManager atsShiftRuleDetailManager;
	@Resource
	private AtsLegalHolidayDetailManager atsLegalHolidayDetailManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "考勤计算设置")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsAttenceCalculateSetManager.delete(id);
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
        AtsAttenceCalculateSet atsAttenceCalculateSet=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsAttenceCalculateSet=atsAttenceCalculateSetManager.get(pkId);
        }else{
        	atsAttenceCalculateSet=new AtsAttenceCalculateSet();
        }
        return getPathView(request).addObject("atsAttenceCalculateSet",atsAttenceCalculateSet);
    }
    
    
    /**
	 * 编辑考勤计算设置
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request) throws Exception {
		Short type = RequestUtil.getShort(request, "type");
		AtsAttenceCalculateSet atsAttenceCalculateSet = atsAttenceCalculateSetManager
				.get("1");
		if (BeanUtil.isNotEmpty(atsAttenceCalculateSet)) {
			if (type == 1) {
				String summary = atsAttenceCalculateSet.getSummary();
				atsAttenceCalculateSet.setSummary(summary);
			} else {
				String detail = atsAttenceCalculateSet.getDetail();
				atsAttenceCalculateSet.setDetail(detail);
			}
		}
		return getPathView(request).addObject("atsAttenceCalculateSet",
				atsAttenceCalculateSet).addObject("type", type);
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
        AtsAttenceCalculateSet atsAttenceCalculateSet = atsAttenceCalculateSetManager.getAtsAttenceCalculateSet(uId);
        String json = JSON.toJSONString(atsAttenceCalculateSet);
        return json;
    }
    
    
    @RequestMapping("userList")
    public ModelAndView userList(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	AtsAttencePolicy atsAttencePolicy = atsAttencePolicyManager.getDefaultAttencePolicy();
    	return getPathView(request).addObject("atsAttencePolicy",atsAttencePolicy);
    }
    /**
     * 选择人员
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("userListData")
    public void userListData(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
	    response.setContentType("application/json");
	    QueryFilter queryFilter=getQueryFilter(request);
	    
	    List<AtsAttenceGroupDetail> list = atsAttenceGroupDetailManager.getAtsAttenceGroupDetailListSet(queryFilter);
	    
	    JsonPageResult result=new JsonPageResult(list,queryFilter.getPage().getTotalItems());
	    String jsonResult=iJson.toJson(result);
	    PrintWriter pw=response.getWriter();
	    pw.println(jsonResult);
	    pw.close();
	}
    
    /**
	 * 获取排班列表列
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("scheduleList")
	@ResponseBody
	public JSONObject scheduleList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date startTime = RequestUtil.getDate(request, "startTime");
		Date endTime = RequestUtil.getDate(request, "endTime");
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		JSONObject json = new JSONObject();
		JSONArray colNamesAry = new JSONArray();
		JSONArray colModelAry = new JSONArray();

		setJsonAry(colNamesAry, colModelAry, "工号", "account", "account", 80);
		setJsonAry(colNamesAry, colModelAry, "姓名", "userName", "userName", 80);

		for (int i = 0; i <= betweenDays; i++) {
			Date date = DateUtil.addDay(startTime, i);
			String week = DateUtil.getWeekOfDate(date);
			String time = DateFormatUtil.formatDate(date);
			setJsonAry(colNamesAry, colModelAry, time + "</br>" + week, time,
					time, 90);
		}
		json.accumulate("colNames", colNamesAry.toString()).accumulate(
				"colModel", colModelAry.toString());

		return json;

	}
	
	/**
	 * 列表排班处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listShiftHandler")
	@ResponseBody
	public String listShiftHandler(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date startTime = RequestUtil.getDate(request, "startTime");
		Date endTime = RequestUtil.getDate(request, "endTime");
		String users = RequestUtil.getString(request, "users");
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		JSONArray userAry = JSONArray.fromObject(users);
		JSONArray jsonAry = new JSONArray();
		int index = 0;
		for (Object user : (JSONArray)userAry) {
			JSONObject json = new JSONObject();
			JSONObject userJson = (JSONObject) user;
			Object fileId = userJson.get("id");
			String userId = fileId.toString();
			json.accumulate("fileId", userId);
			json.accumulate("account", BeanUtil.isEmpty(userJson
					.get("userNo")) ? "" : userJson.get("userNo"));
			json.accumulate("userName", userJson.get("fullName"));
			for (int i = 0; i <= betweenDays; i++) {
				Date date = DateUtil.addDay(startTime, i);
				String attenceTime = DateFormatUtil.formatDate(date);
				AtsScheduleShift ass = atsScheduleShiftManager
						.getByFileIdAttenceTime(userId, date);
				JSONObject shiftJson = new JSONObject();
				String title = "";
				String dateType = "";
				String shiftId = "";
				String holidayName = "";
				if (BeanUtil.isNotEmpty(ass)) {
					if(BeanUtil.isNotEmpty(ass.getShiftId())){
						AtsShiftInfo atsShiftInfo =atsShiftInfoManager
								.get(ass.getShiftId());
						title = atsShiftInfo.getName();
						shiftId = ass.getShiftId().toString();
					}
					dateType = ass.getDateType().toString();
				}
				shiftJson.accumulate("title", title)
						.accumulate("start", attenceTime)
						.accumulate("dateType", dateType)
						.accumulate("shiftId", shiftId)
						.accumulate("holidayName", holidayName);
				
				json.accumulate(attenceTime, shiftJson);
			}
			json.accumulate("index", index++);
			jsonAry.add(json);
		}

		JSONObject json = new JSONObject();
		json.accumulate("results", jsonAry.toString());
		return json.toString();
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
		JSONObject json = new JSONObject();
		json.accumulate("header", lable).accumulate("width", width).accumulate("field", name).accumulate("index", index);
		colNamesAry.add(lable);
		colModelAry.add(json);
	}
    
	/**
	 * 日历排班处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("calendarShiftHandler")
	@ResponseBody
	public JSONObject calendarShiftHandler(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Date startTime = RequestUtil.getDate(request, "startTime");
		Date endTime = RequestUtil.getDate(request, "endTime");
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		JSONArray jay = new JSONArray();
		for (int i = 0; i <= betweenDays; i++) {
			Date date = DateUtil.addDay(startTime, i);
			String time = DateFormatUtil.formatDate(date);
			JSONObject json = new JSONObject();
			json.accumulate("title", "").accumulate("start", time);
			jay.add(json);
		}
		JSONObject json = new JSONObject();
		json.element("success", true).element("results", jay.toString());

		return json;
	}
	
	/**
	 * 完成
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("finished")
	@ResponseBody
	public String finished(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String userAry = RequestUtil.getString(request, "userAry");
		String listRowDatas = RequestUtil.getString(request, "listRowDatas");
		
		Short shiftType = RequestUtil.getShort(request, "shiftType");
		JSONArray userJsonAry = JSONArray.fromObject(userAry);
		JSONArray listRowDatasJson = JSONArray.fromObject(listRowDatas);
		List<AtsScheduleShift> list = null;
		JSONObject json = new JSONObject();

		json.element("success", true);
		try {
			list = atsScheduleShiftManager.save(userJsonAry, listRowDatasJson,shiftType);
			String results = getScheduleShiftPageList(list);
			json.element("results", results);
		} catch (Exception e) {
			e.printStackTrace();
			json.element("success", false);
			json.element("results", "出错了" + e.getMessage());
		}

		return json.toString();
	}

	
	private String getScheduleShiftPageList(List<AtsScheduleShift> list) {
		JSONArray jary = new JSONArray();
		for (AtsScheduleShift atsScheduleShift : list) {
			JSONObject json = new JSONObject();
			String shiftName = "";
			String cardRuleName = "";
			String dateType = "工作日";
			if (BeanUtil.isNotEmpty(atsScheduleShift.getShiftId())) {
				AtsShiftInfo atsShiftInfo = atsShiftInfoManager
						.get(atsScheduleShift.getShiftId());
				shiftName = atsShiftInfo.getName();
				AtsCardRule atsCardRule = atsCardRuleManager
						.get(atsShiftInfo.getCardRule());
				cardRuleName = atsCardRule.getName();
			}
			if (atsScheduleShift.getDateType() == 3) {
				dateType = BeanUtil.isEmpty(atsScheduleShift.getTitle())?"法定假日":atsScheduleShift.getTitle();
			} else if (atsScheduleShift.getDateType() == 2) {
				dateType = "休息日";
			}
			json.accumulate("userName", atsScheduleShift.getFullName())
					.accumulate("orgName", atsScheduleShift.getOrgName())
					.accumulate(
							"attenceTime",
							DateFormatUtil.formatDate(atsScheduleShift
									.getAttenceTime()))
					.accumulate("dateType", dateType)
					.accumulate("shiftName", shiftName)
					.accumulate("cardNumber", atsScheduleShift.getCardNumber())
					.accumulate("policyName",
							atsScheduleShift.getAttencePolicyName())
					.accumulate("cardRuleName", cardRuleName);

			jary.add(json);
		}
		return jary.toString();
	}
	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsAttenceCalculateSetManager;
	}
	
	/**
	 * 选择排班规则计算出排班数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("calculate")
	@ResponseBody
	public String calculate(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String ruleId = RequestUtil.getString(request, "ruleId");
		Integer startNum = RequestUtil.getInt(request, "startNum");
		// 编排的区间开始时间
		Date startDate = RequestUtil.getDate(request, "startDate");
		// 实际选择的开始时间
		Date startTime = RequestUtil.getDate(request, "startTime");
		// 实际选择的结束时间
		Date endTime = RequestUtil.getDate(request, "endTime");
		Short holidayHandle = RequestUtil.getShort(request, "holidayHandle");

		String attencePolicy = atsAttencePolicyManager.getDefaultAttencePolicy().getId();
		
		Map<String, String> holidayMap = atsLegalHolidayDetailManager
				.getHolidayMap(attencePolicy);
		List<AtsShiftRuleDetail> shiftRuleDetailList = atsShiftRuleDetailManager
				.getAtsShiftRuleDetailList(ruleId);
		Map<Integer, AtsShiftRuleDetail> map = getShiftRuleDetailMap(shiftRuleDetailList);
		// 排班规则长度
		int shiftRuleSize = shiftRuleDetailList.size();
		// 2个时间的天数
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		int addHoliday = 0;
		JSONArray jay = new JSONArray();
		for (int i = 0; i <= betweenDays; i++) {
			Date date = DateUtil.addDay(startTime, i);
			String time = DateFormatUtil.formaDatetTime(date);
			String shiftName = "";
			String holidayName = "";
			String shiftId = null;
			short dateType = 0;

			JSONObject json = new JSONObject();
			/**
			 * <pre>
			 * 1:替换	     表示按照原有规则排班 只将法定节日那几天替换成法定节日;
			 * 2:不替换  表示按照原有规则排班,法定节假日按原有的排班规则;
			 * 3:顺延      表示 指法定节假日结束的第一天排班将从法定节假日开始的第一天班次的下个班次的开始。
			 * </pre>
			 */
			if (holidayHandle.shortValue() == AtsConstant.HOLIDAY_HANDLE_REPLACE
					|| holidayHandle == AtsConstant.HOLIDAY_HANDLE_NOREPLACE) {
				// 序号
				int sn = (i + startNum) % shiftRuleSize;
				if (sn == 0)
					sn = shiftRuleSize;
				AtsShiftRuleDetail atsShiftRuleDetail = map.get(sn);
				shiftName = atsShiftRuleDetail.getShiftName();
				shiftId = atsShiftRuleDetail.getShiftId();
				// 节假日处理
				dateType = atsShiftRuleDetail.getDateType();
				if (holidayHandle.shortValue() == AtsConstant.HOLIDAY_HANDLE_REPLACE) {
					holidayName = holidayMap.get(time);
					if (BeanUtil.isNotEmpty(holidayName)) {
						shiftId = null;
						shiftName = null;
						dateType = AtsConstant.DATE_TYPE_HOLIDAY;
						
					}
				}
			} else if (holidayHandle.shortValue() == AtsConstant.HOLIDAY_HANDLE_POSTPONE) {
				// 判断是否节假日
				holidayName = holidayMap.get(time);
				if (BeanUtil.isNotEmpty(holidayName)) {
					addHoliday = addHoliday + 1;
					dateType = AtsConstant.DATE_TYPE_HOLIDAY;
				} else {
					int sn = (i + startNum - addHoliday) % shiftRuleSize;
					if (sn == 0)
						sn = shiftRuleSize;
					AtsShiftRuleDetail atsShiftRuleDetail = map.get(sn);
					shiftName = atsShiftRuleDetail.getShiftName();
					shiftId = atsShiftRuleDetail.getShiftId();
					dateType = atsShiftRuleDetail.getDateType();
				}
			}
		
			time = DateFormatUtil.formatDate(date);
			json.accumulate("title", BeanUtil.isEmpty(shiftName)?"":shiftName)
					.accumulate("start", time)
					.accumulate("dateType", dateType)
					.accumulate("shiftId", shiftId)
					.accumulate("holidayName", BeanUtil.isEmpty(holidayName)?"":holidayName);
			jay.add(json);
		}

		JSONObject json = new JSONObject();
		json.accumulate("data", jay.toString()).accumulate("beginCol",
				DateUtil.daysBetween(startDate, startTime) + 1);
		return json.toString();
	}
	
	/**
	 * 获取规则的排序map
	 * 
	 * @param list
	 * @return
	 */
	private Map<Integer, AtsShiftRuleDetail> getShiftRuleDetailMap(
			List<AtsShiftRuleDetail> list) {
		Map<Integer, AtsShiftRuleDetail> map = new HashMap<Integer, AtsShiftRuleDetail>();
		for (AtsShiftRuleDetail atsShiftRuleDetail : list) {
			if (BeanUtil.isNotEmpty(atsShiftRuleDetail.getShiftId())) {
				AtsShiftInfo atsShiftInfo = atsShiftInfoManager
						.get(atsShiftRuleDetail.getShiftId());
				atsShiftRuleDetail.setShiftName(atsShiftInfo.getName());
			}
			map.put(atsShiftRuleDetail.getSn(), atsShiftRuleDetail);
		}
		return map;
	}

}
