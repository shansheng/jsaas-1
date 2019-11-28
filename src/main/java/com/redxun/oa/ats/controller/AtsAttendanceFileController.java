
package com.redxun.oa.ats.controller;

import java.io.PrintWriter;
import java.text.ParseException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.MsgUtil;
import com.redxun.oa.ats.entity.AtsAttencePolicy;
import com.redxun.oa.ats.entity.AtsAttendanceFile;
import com.redxun.oa.ats.entity.AtsHolidayPolicy;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.oa.ats.manager.AtsAttencePolicyManager;
import com.redxun.oa.ats.manager.AtsAttendanceFileManager;
import com.redxun.oa.ats.manager.AtsHolidayPolicyManager;
import com.redxun.oa.ats.manager.AtsShiftInfoManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 考勤档案控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttendanceFile/")
public class AtsAttendanceFileController extends MybatisListController{
    @Resource
    private AtsAttendanceFileManager atsAttendanceFileManager;
    @Resource
    private AtsAttencePolicyManager atsAttencePolicyManager;
    @Resource
    private AtsHolidayPolicyManager atsHolidayPolicyManager;
    @Resource
    private AtsShiftInfoManager atsShiftInfoManager;
    @Resource
    private OsUserManager osUserManager;
  
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "考勤档案")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            atsAttendanceFileManager.delByIds(ids);
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
        AtsAttendanceFile atsAttendanceFile=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsAttendanceFile=atsAttendanceFileManager.get(pkId);
        }else{
        	atsAttendanceFile=new AtsAttendanceFile();
        }
        return getPathView(request).addObject("atsAttendanceFile",atsAttendanceFile);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsAttendanceFile atsAttendanceFile=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsAttendanceFile=atsAttendanceFileManager.get(pkId);
    	}else{
    		atsAttendanceFile=new AtsAttendanceFile();
    	}
    	return getPathView(request).addObject("atsAttendanceFile",atsAttendanceFile);
    }
    
    @RequestMapping("editDisUser")
    public ModelAndView editDisUser(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId=RequestUtil.getString(request, "userId");
    	AtsAttendanceFile atsAttendanceFile=null;
    	if(StringUtils.isNotEmpty(userId)){
    		atsAttendanceFile=new AtsAttendanceFile();
    		atsAttendanceFile.setUserId(userId);
    		atsAttendanceFile.setCardNumber(getCardNumber(userId));
    		AtsAttencePolicy ap = atsAttencePolicyManager.getDefaultAttencePolicy();
    		AtsHolidayPolicy hp = atsHolidayPolicyManager.getDefaultHolidayPolicy();
    		AtsShiftInfo si = atsShiftInfoManager.getDefaultShiftInfo();
    		atsAttendanceFile.setAttencePolicy(ap);
    		atsAttendanceFile.setHolidayPolicy(hp);
    		atsAttendanceFile.setDefaultShift(si);
    	}else{
    		atsAttendanceFile=new AtsAttendanceFile();
    	}
    	return getPathView(request).addObject("atsAttendanceFile",atsAttendanceFile).addObject("userId", userId);
    }
    
    private String getCardNumber(String userIds){
    	String[] userId = userIds.split(",");
    	StringBuffer cardNumber = new StringBuffer();
    	
    	for (int i = 0; i < userId.length; i++) {
    		OsUser osUser = osUserManager.get(userId[i]);
    		if(BeanUtil.isNotEmpty(osUser)){
    			cardNumber.append(osUser.getUserNo()+",");
    		}
    	}
    	return cardNumber.toString();
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
        AtsAttendanceFile atsAttendanceFile = atsAttendanceFileManager.getAtsAttendanceFile(uId);
        String json = JSON.toJSONString(atsAttendanceFile);
        return json;
    }
    
    
	/**
	 * 未建档人员
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("disUserList")
	public void disUserList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String export=request.getParameter("_export");
		//是否导出
		if(StringUtils.isNotEmpty(export)){
			String exportAll=request.getParameter("_all");
			if(StringUtils.isNotEmpty(exportAll)){
				exportAllPages(request,response);
			}else{
				exportCurPage(request,response);
			}
		}else{
			response.setContentType("application/json");
			QueryFilter queryFilter=getQueryFilter(request);
			List<AtsAttendanceFile> list=atsAttendanceFileManager.getDisUserList(queryFilter);
			JsonPageResult<AtsAttendanceFile> result=new JsonPageResult<AtsAttendanceFile>(list,queryFilter.getPage().getTotalItems());
			String jsonResult=iJson.toJson(result);
			PrintWriter pw=response.getWriter();
			pw.println(jsonResult);
			pw.close();
		}
	}
	
	/**
	 * 导出考勤档案
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportData")
	public void exportData(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Object[] accounts = atsAttendanceFileManager.getNotAttendance().toArray();
		Object[] isAttendance = new Object[]{"是","否"};
		Object[] attencePolicy = atsAttencePolicyManager.getAttencePolicy().toArray();
		Object[] holidayPolicy = atsHolidayPolicyManager.getHolidayPolicys().toArray();
		Object[] shiftNames = atsShiftInfoManager.shiftInfoNames().toArray();
		
		String fileName = "考勤档案列表";
		// 取得表的数据
		HSSFWorkbook excel = new HSSFWorkbook();
		HSSFSheet sheet = excel.createSheet(fileName);// 重命名当前处于工作状态的表的名称
		// 取得表的数据
		getExcelTemplate(excel,sheet, accounts, isAttendance, attencePolicy, holidayPolicy, shiftNames);
		ExcelUtil.downloadExcel(excel, fileName, response);
	}
	
	private void getExcelTemplate(HSSFWorkbook excel,HSSFSheet sheet, 
			Object[] accounts,Object[] isAttendance, Object[] attencePolicy,
			Object[] holidayPolicy, Object[] shiftNames) throws ParseException {
		// TODO Auto-generated method stub
		
		String [] titleAry =	new String[] {
				"员工编号",
				"员工姓名",
				"打卡考勤",
				"考勤制度",
				"假期制度",
				"默认班次",
				""
		};
		
		ExcelUtil.setValueStyle(excel,sheet,0,Font.BOLDWEIGHT_BOLD,HSSFColor.GREY_25_PERCENT.index,titleAry);
		
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 0, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 1, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 2, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 3, 3000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 4, 4000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 5, 4000, "@");
		ExcelUtil.setDefaultColumnStyle(excel, sheet, 6, 4000, "@");//去掉最后一格值
		
		/*if(BeanUtil.isEmpty(accounts)) {
			ExcelUtil.value(sheet, 0, 1, 3000, null);
		}else {
			ExcelUtil.values(sheet, 0, 1, 3000, accounts);
		}*/
		ExcelUtil.value(sheet, 1, 1, 3000, null);
		ExcelUtil.values(sheet, 2, 1, 3000, isAttendance);
		ExcelUtil.values(sheet, 3, 1, 3000, attencePolicy);
		ExcelUtil.values(sheet, 4, 1, 4000, holidayPolicy);
		ExcelUtil.values(sheet, 5, 1, 4000, shiftNames);
		ExcelUtil.value(sheet, 6, 1, 4000, null);
	}
	


	/**
	 * 导入数据保存
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("importData")
	@ResponseBody
	public JsonResult importData(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile file = request.getFile("file");
		try {
			atsAttendanceFileManager.importExcel(file.getInputStream());
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false, MsgUtil.getMessage());
		}
		String msg = MsgUtil.getMessage();
		if("".equals(msg)) {
			return new JsonResult(true,"没有考勤档案记录");
		}
		return new JsonResult(true,msg);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsAttendanceFileManager;
	}
	
	@Override
	public List<?> getPage(QueryFilter queryFilter) {
		String tenantId=ContextUtil.getCurrentTenantId();
		queryFilter.addFieldParam("a.TENANT_ID_", tenantId);
		return getBaseManager().getMybatisAll(queryFilter);
	}

}
