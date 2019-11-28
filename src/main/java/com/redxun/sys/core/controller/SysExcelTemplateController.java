
package com.redxun.sys.core.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysExcelTemplate;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.FileOperatorFactory;
import com.redxun.sys.core.manager.IFileOperator;
import com.redxun.sys.core.manager.SysExcelTemplateManager;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.util.ExcelUtil;

/**
 * sys_excel_template控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/core/sysExcelTemplate/")
public class SysExcelTemplateController extends MybatisListController{
    @Resource
    SysExcelTemplateManager sysExcelTemplateManager;
    @Resource
    SysFileManager sysFileManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		return queryFilter;
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "sys", submodule = "sys_excel_template")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysExcelTemplateManager.delete(id);
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
        SysExcelTemplate sysExcelTemplate=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysExcelTemplate=sysExcelTemplateManager.get(pkId);
        }else{
        	sysExcelTemplate=new SysExcelTemplate();
        }
        return getPathView(request).addObject("sysExcelTemplate",sysExcelTemplate);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysExcelTemplate sysExcelTemplate=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysExcelTemplate=sysExcelTemplateManager.get(pkId);
    	}else{
    		sysExcelTemplate=new SysExcelTemplate();
    	}
    	return getPathView(request).addObject("sysExcelTemplate",sysExcelTemplate);
    }
    
    @RequestMapping("excelImport")
    public ModelAndView test(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	SysExcelTemplate template=sysExcelTemplateManager.get(pkId);
    
    	return getPathView(request)
    			.addObject("template",template);
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
    public SysExcelTemplate getJson(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String uId=RequestUtil.getString(request, "id");    	
        SysExcelTemplate sysExcelTemplate = sysExcelTemplateManager.get(uId);
        return sysExcelTemplate;
    }
    
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "sys", submodule = "sys_excel_template")
    public JsonResult save(HttpServletRequest request, @RequestBody SysExcelTemplate sysExcelTemplate, BindingResult result) throws Exception  {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        boolean rtn= sysExcelTemplateManager.isAliasExist(sysExcelTemplate);
        if(rtn){
        	return new JsonResult(false, "EXCEL模版存在!") ;
        }
        
        String msg = null;
        if (StringUtils.isEmpty(sysExcelTemplate.getId())) {
        	sysExcelTemplate.setId(IdUtil.getId());
            sysExcelTemplateManager.create(sysExcelTemplate);
            msg = getMessage("sysExcelTemplate.created", new Object[]{sysExcelTemplate.getIdentifyLabel()}, "[sys_excel_template]成功创建!");
        } else {
        	String id=sysExcelTemplate.getId();
        	SysExcelTemplate oldEnt=sysExcelTemplateManager.get(id);
        	BeanUtil.copyNotNullProperties(oldEnt, sysExcelTemplate);
            sysExcelTemplateManager.update(oldEnt);
       
            msg = getMessage("sysExcelTemplate.updated", new Object[]{sysExcelTemplate.getIdentifyLabel()}, "[sys_excel_template]成功更新!");
        }
        return new JsonResult(true, msg);
    }
    
	/**
	 * 获取excel头
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "getHeader")
	@ResponseBody
	public JsonResult getHeader(HttpServletRequest request,HttpServletResponse response) {
		String excelId=RequestUtil.getString(request, "excelId");
		Integer sheet=RequestUtil.getInt(request, "sheet");
		Integer headStart=RequestUtil.getInt(request, "headStart");
		
		String fileSystem=SysPropertiesUtil.getGlobalProperty("fileSystem","file");
		IFileOperator operator=FileOperatorFactory.getByType(fileSystem);
		SysFile sysFile= sysFileManager.get(excelId);
		byte[] bytes= operator.getFile(sysFile.getPath());
		String file=sysFile.getFileName() ;
		InputStream is=new ByteArrayInputStream(bytes);
		JsonResult result= ExcelUtil. getExcelHeader(file, is, sheet, headStart);
		return result;
	}
	
	/**
	 * 上传测试。
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "uploadExcel")
	@ResponseBody
	public JsonResult uploadTest(MultipartHttpServletRequest request,HttpServletResponse response) {
		JsonResult result=new JsonResult(true);
		String alias=RequestUtil.getString(request, "alias");
		try{
			Map<String, MultipartFile> files = request.getFileMap();
			Iterator<MultipartFile> it = files.values().iterator();
			MultipartFile multipartFile= it.next();
			
			String fileName = multipartFile.getOriginalFilename().toLowerCase();
			if(!fileName.endsWith("xls") && !fileName.endsWith("xlsx") ){
				result.setSuccess(false);
				result.setMessage("上传文件必须为EXCEL文件!");
				return result;
			}
			
			String uploadId=IdUtil.getId();
			byte[] bytes = multipartFile.getBytes();
			InputStream is=new ByteArrayInputStream(bytes);
			//String uploadId, String fileId,String appId
			
			sysExcelTemplateManager.saveToTable(uploadId, "-1", "uploadTest", alias,"",is, fileName);
			
			
			result.setData(uploadId);
			
		}
		catch(Exception ex){
			result.setSuccess(false);
			result.setMessage("测试EXCEL导入失败!");
			result.setData(ex.getMessage());
		}
		
		return result;
	}
	
	@RequestMapping(value = "removeTest")
	@ResponseBody
	public JsonResult removeTest(HttpServletRequest request,HttpServletResponse response) { 
		String alias=RequestUtil.getString(request, "alias");
		
		return new JsonResult(true);
	}
	


	@RequestMapping(value = "templateUpload")
	@ResponseBody
	public JsonResult templateUpload(MultipartHttpServletRequest request,HttpServletResponse response) {
		JsonResult result=new JsonResult(true);
		try {
			Map<String, MultipartFile> files = request.getFileMap();
			Iterator<MultipartFile> it = files.values().iterator();
			MultipartFile multipartFile= it.next();
			
			String fileName = multipartFile.getOriginalFilename();
			if(!fileName.endsWith("xls") && !fileName.endsWith("xlsx") ){
				result.setSuccess(false);
				result.setMessage("上传文件必须为EXCEL文件!");
				return result;
			}
			
			byte[] bytes = multipartFile.getBytes();
			
			SysFile file= sysFileManager.createFile(fileName, bytes,"tempate");
			
			InputStream stream= new ByteArrayInputStream(bytes);  
			
			Workbook workbook=ExcelUtil.getWorkBook(fileName,stream);
			int amount=workbook.getNumberOfSheets();
			JSONArray ary=new JSONArray();
			for(int i=0;i<amount;i++){
				Sheet sheet=workbook.getSheetAt(i);
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("idx", i);
				jsonObject.put("name", sheet.getSheetName());
				ary.add(jsonObject);
			}
			
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("fileId", file.getFileId());
			jsonObject.put("sheets", ary);
			
			result.setData(jsonObject);
		
		} catch (IOException e) {
			result.setMessage("上传失败");
			result.setSuccess(false);
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysExcelTemplateManager;
	}
}
