
package com.redxun.oa.ats.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateFormatUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.MsgUtil;
import com.redxun.oa.ats.entity.AtsScheduleShift;
import com.redxun.oa.ats.manager.AtsAttendanceFileManager;
import com.redxun.oa.ats.manager.AtsScheduleShiftManager;
import com.redxun.oa.ats.manager.AtsShiftInfoManager;
import com.redxun.oa.ats.manager.AtsShiftTypeManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 排班列表控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsScheduleShift/")
public class AtsScheduleShiftController extends MybatisListController{
    @Resource
    private AtsScheduleShiftManager atsScheduleShiftManager;
    @Resource
    private AtsAttendanceFileManager atsAttendanceFileManager;
    @Resource
    private AtsShiftInfoManager atsShiftInfoManager;
    @Resource
    private AtsShiftTypeManager atsShiftTypeManager;
    
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
	
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "排班列表")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsScheduleShiftManager.delete(id);
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
        AtsScheduleShift atsScheduleShift=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsScheduleShift=atsScheduleShiftManager.get(pkId);
        }else{
        	atsScheduleShift=new AtsScheduleShift();
        }
        return getPathView(request).addObject("atsScheduleShift",atsScheduleShift);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsScheduleShift atsScheduleShift=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsScheduleShift=atsScheduleShiftManager.get(pkId);
    	}else{
    		atsScheduleShift=new AtsScheduleShift();
    	}
    	return getPathView(request).addObject("atsScheduleShift",atsScheduleShift);
    }
    
    /**
	 * 导入数据保存
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("importData")
	@ResponseBody
	public JsonResult importData(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile file = request.getFile("file");
		String fileExt = file.getOriginalFilename().substring(
				file.getOriginalFilename().lastIndexOf("."));
		String template = file.getOriginalFilename().substring(
				file.getOriginalFilename().indexOf("-")+1,
				file.getOriginalFilename().indexOf("-")+2);
		
		int temp = 1;
		if(BeanUtil.isNotEmpty(template)){
			temp = Integer.parseInt(template);
		}
		
		try {
			atsScheduleShiftManager.importExcel(file.getInputStream(), fileExt, temp);
			String msg = MsgUtil.getMessage();
			if("".equals(msg)) {
				return new JsonResult(true,"没有排版记录");
			}
			return new JsonResult(true,msg);
		} catch (Exception e) {
			e.printStackTrace();
			String msg = ExceptionUtil.getExceptionMessage(e);
			return new JsonResult(false,msg);
		}
	}
    
    /**
	 * 导出排班记录
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportData")
	public void exportData(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Object[] accounts = atsAttendanceFileManager.getFileAll().toArray();
		Object[] shiftNames = atsShiftInfoManager.shiftInfoNames().toArray();
		
		int template = RequestUtil.getInt(request, "template");
		
//		//导出这一个月的排班模板
//		Calendar cal = Calendar.getInstance(); 
//		Date startTime = cal.getTime();//开始时间
//		//获取月份最大天数
//		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);  
//		//设置日历中月份的最大天数  
//		cal.set(Calendar.DAY_OF_MONTH, lastDay);  
//		Date endTime = cal.getTime();//结束时间

		Date startTime = RequestUtil.getDate(request, "startTime");
		if(BeanUtil.isEmpty(startTime)) {
			startTime = new Date();
		}
		Date endTime = RequestUtil.getDate(request, "endTime");
		if(BeanUtil.isEmpty(endTime)) {
			endTime = new Date();
		}
		
		try {
			// 取得表的数据
			String fileName = "员工排班列表";
			HSSFWorkbook excel = new HSSFWorkbook();
			HSSFSheet sheet = excel.createSheet(fileName);// 重命名当前处于工作状态的表的名称
			// 取得表的数据
			if(template == 1){
				fileName = "员工排班列表-1";
				getExcelTemplate1(excel,sheet, accounts, shiftNames, startTime, endTime);
			} else if(template == 2){
				fileName = "员工排班列表-2";
				getExcelTemplate2(excel,sheet, accounts,shiftNames, startTime, endTime);
			}
			ExcelUtil.downloadExcel(excel, fileName, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void getExcelTemplate1(HSSFWorkbook excel,HSSFSheet sheet, Object[] accounts,
			Object[] shiftNames,
			Date startTime, Date endTime) throws ParseException {
		// TODO Auto-generated method stub
		
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		String[] attenceTimeList = new String[betweenDays+1];
				
		for (int i = 0; i <= betweenDays; i++) {
			Date attenceTime = DateUtil.addDay(startTime, i);
			attenceTimeList[i] = DateFormatUtil.formatDate(attenceTime);
		}
		
		
		String[] titleAry = new String[] { "员工编号","员工姓名","班次名称", "考勤日期","周期", "组织名称" };
		
		ExcelUtil.setValueStyle(excel,sheet,0,Font.BOLDWEIGHT_BOLD,HSSFColor.GREY_25_PERCENT.index,titleAry);
		
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 0, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 1, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 2, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 3, 4000, "yyyy-MM-dd");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 4, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 5, 3000, "@");
		
		for (int i = 1; i <= attenceTimeList.length; i++) {
			ExcelUtil.values(sheet, 0, i, 3000,accounts);
			ExcelUtil.value(sheet, 1, i, 3000,null);
			ExcelUtil.values(sheet, 2, i, 4000, shiftNames);
			ExcelUtil.value(sheet, 3, i, 3000, new Object[]{attenceTimeList[i-1]});
			ExcelUtil.value(sheet, 4, i, 3000, new Object[]{DateUtil.getWeekOfDate(DateUtil.parseDate(attenceTimeList[i-1],"yyyy-MM-dd"))});
		}
		System.out.println("");
	}
	
	private void getExcelTemplate2(HSSFWorkbook excel, HSSFSheet sheet, Object[] accounts,
			Object[] shiftNames,
			Date startTime, Date endTime) throws ParseException {
		// TODO Auto-generated method stub
		List<String> titleList2 = new ArrayList<String>();
		List<String> titleList = new ArrayList<String>();
		titleList.add("员工编号");
		titleList.add("员工姓名");
		titleList.add("组织名称");
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		
		for (int j = 0; j <= betweenDays; j++) {
			Date attenceTime = DateUtil.addDay(startTime, j);
			String week = DateUtil.getWeekOfDate(attenceTime);
			String day = DateFormatUtil.format(attenceTime, "d");
			titleList2.add(week);
			titleList.add(day);
		}
		//第一行 时间范围
		String[] timeArray = new String[] { "排班时间范围",
				DateFormatUtil.formatDate(startTime),
				DateFormatUtil.formatDate(endTime) };
		timeArray = (String[]) ArrayUtils.addAll(timeArray,titleList2.toArray());
		ExcelUtil.setValueStyle(excel,sheet,0,Font.BOLDWEIGHT_BOLD,HSSFColor.GREY_25_PERCENT.index,timeArray);
		//第二行 标题
		ExcelUtil.setValueStyle(excel,sheet,1,Font.BOLDWEIGHT_BOLD,HSSFColor.SKY_BLUE.index,titleList.toArray());
		//第三行 内容
		ExcelUtil.values(sheet, 0, 2, 3000,accounts);
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 0, 4000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 1, 4000, "@");
		
		for (int i = 3; i < titleList.size(); i++) {
			ExcelUtil.values(sheet, i, 2, 3000,shiftNames);
			ExcelUtil.setDefaultColumnStyle(excel, sheet, i, 3000, "@");
		}
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
        AtsScheduleShift atsScheduleShift = atsScheduleShiftManager.getAtsScheduleShift(uId);
        String json = JSON.toJSONString(atsScheduleShift);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsScheduleShiftManager;
	}
	
	@Override
	public List<?> getPage(QueryFilter queryFilter) {
		String tenantId=ContextUtil.getCurrentTenantId();
		queryFilter.addFieldParam("a.TENANT_ID_", tenantId);
		return getBaseManager().getMybatisAll(queryFilter);
	}

}
