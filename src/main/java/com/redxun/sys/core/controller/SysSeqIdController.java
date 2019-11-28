package com.redxun.sys.core.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpmclient.model.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysSeqId;
import com.redxun.sys.core.manager.SysSeqIdManager;
import com.redxun.sys.log.LogEnt;
import com.thoughtworks.xstream.XStream;

/**
 * [SysSeqId]管理
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/core/sysSeqId/")
public class SysSeqIdController extends MybatisListController{
    @Resource
    SysSeqIdManager sysSeqIdManager;
   
    

   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                sysSeqIdManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
    }
    
    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request,HttpServletResponse response){
    	String tenantId=ITenant.ADMIN_TENANT_ID;
    	return this.getPathView(request).addObject("tenantId", tenantId);
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
        String pkId=request.getParameter("pkId");
        SysSeqId sysSeqId=null;
        if(StringUtils.isNotEmpty(pkId)){
           sysSeqId=sysSeqIdManager.get(pkId);
        }else{
        	sysSeqId=new SysSeqId();
        	//默认为长度为
        	sysSeqId.setLen(12);
        	sysSeqId.setInitVal(1);
        	sysSeqId.setGenType(SysSeqId.GEN_TYPE_AUTO);
        }
        return getPathView(request).addObject("sysSeqId",sysSeqId);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	SysSeqId sysSeqId=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysSeqId=sysSeqIdManager.get(pkId);
    		if("true".equals(forCopy)){
    			sysSeqId.setSeqId(null);
    		}
    	}else{
    		sysSeqId=new SysSeqId();
    	}
    	return getPathView(request).addObject("sysSeqId",sysSeqId);
    }
    
    @RequestMapping("getInstAllSeq")
    @ResponseBody
    public JsonPageResult<SysSeqId> getInstAllSeq(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	QueryFilter queryFilter =QueryFilterBuilder.createQueryFilter(request);
    	queryFilter.addFieldParam("TENANT_ID_", ITenant.ADMIN_TENANT_ID);
    	List<SysSeqId> sIds=new ArrayList<SysSeqId>();
    	String key=request.getParameter("key");
    	if(StringUtils.isEmpty(key))
    		sIds=sysSeqIdManager.getAll(queryFilter);
    	else{
    		queryFilter.addLeftLikeFieldParam("ALIAS_",key);
    		sIds=sysSeqIdManager.getAll(queryFilter);
    	}
    	return new JsonPageResult<SysSeqId>(true, sIds, queryFilter.getPage().getTotalItems(), "成功查询");
    }
    
    @RequestMapping("getNameById")
    @ResponseBody
    public String getNameById(HttpServletRequest request,HttpServletResponse response){
    	String id=RequestUtil.getString(request, "id");
    	SysSeqId sysSeqId=sysSeqIdManager.get(id);
    	String name=sysSeqId.getName();
    	return name;
    }
    
    @RequestMapping("genNo_{alias}")
    @ResponseBody
    public String genNo(@PathVariable(value="alias") String alias){
    	String tenantId=ContextUtil.getCurrentTenantId();
    	String no= sysSeqIdManager.genSequenceNo(alias, tenantId);
		return no;
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
		
		List<SysSeqId> list=sysSeqIdManager.getSysSeqIdByIds(key);
		
		response.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "Sys-Seq-Id-" + sdf.format(new Date());
		response.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						response.getOutputStream());
		
		for (SysSeqId sysSeqId : list) {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			// 生成XML
			String xml = xstream.toXML(sysSeqId);
			
			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(sysSeqId.getName() + ".xml"));
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
	@LogEnt(action = "importDirect", module = "流水号", submodule = "流水号设计")
	public ModelAndView importDirect(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile f = request.getFile("zipFile");
		ProcessHandleHelper.clearProcessMessage();
		
		sysSeqIdManager.doImport(f);
		
		Set<String> msgSet= ProcessHandleHelper.getProcessMessage().getErrorMsges();
		
		return getPathView(request).addObject("msgSet", msgSet);
	}
    

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysSeqIdManager;
	}

}
