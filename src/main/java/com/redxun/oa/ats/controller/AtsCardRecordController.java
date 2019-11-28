
package com.redxun.oa.ats.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.MsgUtil;
import com.redxun.oa.ats.entity.AtsCardRecord;
import com.redxun.oa.ats.manager.AtsCardRecordManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.export.PoiTableBuilder;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;
import com.redxun.ui.view.model.ExportFieldColumn;

/**
 * 打卡记录控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsCardRecord/")
public class AtsCardRecordController extends MybatisListController{
    @Resource
    AtsCardRecordManager atsCardRecordManager;
    @Resource
	protected PoiTableBuilder poiTableBuilder;
    @Resource
    private OsUserManager osUserManager;
    
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "oa", submodule = "打卡记录")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                atsCardRecordManager.delete(id);
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
        AtsCardRecord atsCardRecord=null;
        if(StringUtils.isNotEmpty(pkId)){
           atsCardRecord=atsCardRecordManager.get(pkId);
        }else{
        	atsCardRecord=new AtsCardRecord();
        }
        return getPathView(request).addObject("atsCardRecord",atsCardRecord);
    }
    
    /**
	 * 分页返回我的查询列表，包括导出单页，所有页
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("myListData")
	public void myListData(HttpServletRequest request,HttpServletResponse response) throws Exception{
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
			QueryFilter queryFilter = getQueryFilter(request);
	   		queryFilter.addFieldParam("CARD_NUMBER", osUserManager.get(ContextUtil.getCurrentUserId()).getUserNo());
	   		List<AtsCardRecord> list= atsCardRecordManager.getMybatisAll(queryFilter);
	   		JsonPageResult<?> result=new JsonPageResult(list,queryFilter.getPage().getTotalItems());
			String jsonResult=iJson.toJson(result);
			PrintWriter pw=response.getWriter();
			pw.println(jsonResult);
			pw.close();
		}
	}
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	AtsCardRecord atsCardRecord=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		atsCardRecord=atsCardRecordManager.get(pkId);
    	}else{
    		atsCardRecord=new AtsCardRecord();
    	}
    	return getPathView(request).addObject("atsCardRecord",atsCardRecord);
    }
    
    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=ContextUtil.getCurrentUserId();
    	OsUser osUser=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		osUser=osUserManager.get(pkId);
    	}else{
    		osUser=new OsUser();
    	}
    	return getPathView(request).addObject("osUser",osUser);
    }
    
    /**
   	 * 导出我的打卡记录
   	 * 
   	 * @param request
   	 * @param response
   	 * @throws Exception
   	 */
   	@RequestMapping("exportMyData")
   	public void exportMyData(HttpServletRequest request,
   			HttpServletResponse response) throws Exception {
   		QueryFilter queryFilter = getQueryFilter(request);
   		queryFilter.addFieldParam("CARD_NUMBER", osUserManager.get(ContextUtil.getCurrentUserId()).getUserNo());
   		List<AtsCardRecord> list= atsCardRecordManager.getDataAll(queryFilter);
   		export(null,response,list);
   	}
    
    /**
	 * 导出打卡记录
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("exportData")
	public void exportData(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String isTemp = request.getParameter("isTemp");
		QueryFilter queryFilter = getQueryFilter(request);
		try {
			List<AtsCardRecord> list= atsCardRecordManager.getDataAll(queryFilter);
			export(isTemp,response,list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void export(String isTemp,HttpServletResponse response,List<AtsCardRecord> list) {
		JSONArray rowData = new JSONArray();
		List<ExportFieldColumn> headMap = new ArrayList<ExportFieldColumn>();
		String fileName = "打卡记录模板";

		String[] titleAry = new String[] { "员工编号", "打卡日期", "打卡时间", "打卡位置" };
		String[] filedAry = new String[] { "cardNumber", "cardDate", "cardTime", "cardPlace"};
		for (int i = 0; i < titleAry.length; i++) {
			ExportFieldColumn column = new ExportFieldColumn();
			column.setField(filedAry[i]);
			column.setWidth(3000);
			column.setColspan(1);
			column.setHeader(titleAry[i]);
			column.setChildColumn(new ArrayList<ExportFieldColumn>());
			headMap.add(column);
		}
		if(!"true".equals(isTemp)) {
			headMap.clear();
			fileName = "打卡记录明细";
			titleAry = new String[] { "员工编号", "打卡日期", "打卡时间", "打卡来源", "打卡位置" };
			filedAry = new String[] { "cardNumber", "cardDate", "cardTime", "cardSourceName", "cardPlace"};
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
				AtsCardRecord atsCardRecord = list.get(i);
				rowData.add(atsCardRecord);
			}
		}
		// 取得表的数据
		ExcelUtil.downloadExcelFile(fileName, headMap, rowData, response);
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
		try {
			String fileName = file.getOriginalFilename();
			String extName = fileName.substring(fileName.lastIndexOf(".") + 1,
					fileName.length());
			if (extName.equalsIgnoreCase("xlsx")
					|| extName.equalsIgnoreCase("xls")) {
				boolean isXls = ExcelUtil.getExcelInfo(fileName);
				atsCardRecordManager.importExcel(file.getInputStream(),isXls);
			}
			String msg = MsgUtil.getMessage();
			if("".equals(msg)) {
				return new JsonResult(true,"没有打卡记录");
			}
			return new JsonResult(true,msg);
		} catch (Exception e) {
			e.printStackTrace();
			return new JsonResult(false,MsgUtil.getMessage());
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
        AtsCardRecord atsCardRecord = atsCardRecordManager.getAtsCardRecord(uId);
        String json = JSON.toJSONString(atsCardRecord);
        return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return atsCardRecordManager;
	}

}
