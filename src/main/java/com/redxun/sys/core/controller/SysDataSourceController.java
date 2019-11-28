
package com.redxun.sys.core.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.pool.DruidDataSource;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysDataSource;
import com.redxun.sys.core.manager.SysDataSourceManager;
import com.redxun.sys.log.LogEnt;
import com.thoughtworks.xstream.XStream;

/**
 * 数据源定义管理控制器
 * @author ray
 */
@Controller
@RequestMapping("/sys/core/sysDataSource/")
public class SysDataSourceController extends MybatisListController{
    @Resource
    SysDataSourceManager sysDataSourceManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
            	SysDataSource datasource=sysDataSourceManager.get(id);
            	String alias=datasource.getAlias();
            	DruidDataSource ds= (DruidDataSource) DataSourceUtil.getDataSourceByAlias(alias);
            	
            	//删除时关闭数据源。
            	if(ds!=null){
            		DataSourceUtil.removeDataSource(alias);
            		ds.close();
            	}
                sysDataSourceManager.delete(id);
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
        SysDataSource sysDataSource=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysDataSource=sysDataSourceManager.get(pkId);
        }else{
        	sysDataSource=new SysDataSource();
        }
        return getPathView(request).addObject("sysDataSource",sysDataSource);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	SysDataSource sysDataSource=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysDataSource=sysDataSourceManager.get(pkId);
    		if("true".equals(forCopy)){
    			sysDataSource.setId(null);
    		}
    	}else{
    		sysDataSource=new SysDataSource();
    		String json=readJson();
    		sysDataSource.setInitOnStart("yes");
    		sysDataSource.setEnabled("yes");
    		sysDataSource.setDbType("mysql");
    		sysDataSource.setSetting(json);
    		
    	}
    	return getPathView(request).addObject("sysDataSource",sysDataSource);
    }
    
    private String readJson(){
    	String path=FileUtil.getClassesPath() + "/config/dataSource.json";
		String json=FileUtil.readFile(path);
		return json;
    }

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysDataSourceManager;
	}
	
	@RequestMapping("testConnect")
	@ResponseBody
	public JsonResult testConnect(HttpServletRequest request, @ModelAttribute("sysDataSource") @Valid SysDataSource sysDataSource) {

        if(sysDataSourceManager.isExist(sysDataSource)){
        	return new JsonResult(false, "数据源已经存在!");
        }
        JsonResult rtn= sysDataSourceManager.checkConnection(sysDataSource);
        return rtn;
	}
	
	/**
	 * 导出
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("doExport")
	// @ResponseBody
	public void doExport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String keys = request.getParameter("keys");

		String[] key = keys.split("[,]");
		
		List<SysDataSource> list=sysDataSourceManager.getSysDataSourceByIds(key);
		
		response.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "Sys-Data-Source-" + sdf.format(new Date());
		response.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						response.getOutputStream());
		
		for (SysDataSource sysDataSource : list) {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			// 生成XML
			String xml = xstream.toXML(sysDataSource);
			
			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(sysDataSource.getName() + ".xml"));
			InputStream is = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			IOUtils.copy(is, zipOutputStream);
			zipOutputStream.closeArchiveEntry();
			
		}
		zipOutputStream.close();
		
	}
	
	/**
	 * 直接导入,不进行结果检查,存在则更新，不存在则添加
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("importDirect")
	@LogEnt(action = "importDirect", module = "数据源", submodule = "数据源设计")
	public ModelAndView importDirect(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile f = request.getFile("zipFile");
		ProcessHandleHelper.clearProcessMessage();
		
		sysDataSourceManager.doImport(f);
		
		Set<String> msgSet= ProcessHandleHelper.getProcessMessage().getErrorMsges();
		
		return getPathView(request).addObject("msgSet", msgSet);
	}

}
