package com.redxun.sys.db.controller;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.redxun.sys.db.manager.SysSqlCustomQueryManager;
import com.redxun.sys.db.manager.SysSqlCustomQueryUtil;
import com.redxun.sys.log.LogEnt;
import com.thoughtworks.xstream.XStream;
/**
 * 自定义查询控制器
 * 
 * @author cjx
 */
@Controller
@RequestMapping("/sys/db/sysSqlCustomQuery/")
public class SysSqlCustomQueryController extends MybatisListController {
	@Resource
	SysSqlCustomQueryManager sysSqlCustomQueryManager;
	
	
	
	@RequestMapping("del")
	@ResponseBody
	public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uId = RequestUtil.getString(request, "ids");
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				sysSqlCustomQueryManager.delete(id);
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
		SysSqlCustomQuery sysSqlCustomQuery = null;
		if (StringUtils.isNotEmpty(pkId)) {
			sysSqlCustomQuery = sysSqlCustomQueryManager.get(pkId);
		} else {
			sysSqlCustomQuery = new SysSqlCustomQuery();
		}
		return getPathView(request).addObject("sysSqlCustomQuery", sysSqlCustomQuery);
	}
	
	@RequestMapping("getById")
	@ResponseBody
	public SysSqlCustomQuery getById(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "id");
		SysSqlCustomQuery sysSqlCustomQuery = sysSqlCustomQueryManager.get(pkId);
		return sysSqlCustomQuery;
	}
	
	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		// 复制添加
		String forCopy = request.getParameter("forCopy");
		SysSqlCustomQuery sysSqlCustomQuery = null;
		if (StringUtils.isNotEmpty(pkId)) {
			sysSqlCustomQuery = sysSqlCustomQueryManager.get(pkId);
			if ("true".equals(forCopy)) {
				sysSqlCustomQuery.setId(null);
			}
		} else {
			sysSqlCustomQuery = new SysSqlCustomQuery();
			sysSqlCustomQuery.setSqlBuildType(SysSqlCustomQuery.BUILD_TYPE_FREEMARKSQL);
		}
		return getPathView(request).addObject("sysSqlCustomQuery", sysSqlCustomQuery);
	}
	
	@RequestMapping("preview")
	public ModelAndView preview(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		
		SysSqlCustomQuery	sysSqlCustomQuery = sysSqlCustomQueryManager.get(pkId);
		JSONArray whereColumns=new JSONArray();
		if(StringUtil.isNotEmpty(sysSqlCustomQuery.getWhereField())){
			JSONArray jsonArray=JSONArray.parseArray(sysSqlCustomQuery.getWhereField());
			for(int i=0;i<jsonArray.size();i++){
				JSONObject obj=jsonArray.getJSONObject(i);
				String valueSource=obj.getString("valueSource");
				if("param".equals(valueSource)){
					whereColumns.add(obj);
				}
			}
		}
		request.setAttribute("whereList", whereColumns);
			
	
		return getPathView(request).addObject("sysSqlCustomQuery", sysSqlCustomQuery);
	}
	
	@RequestMapping("help")
	public ModelAndView help(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		SysSqlCustomQuery sysSqlCustomQuery = null;
		if (StringUtil.isNotEmpty(pkId)) {
			sysSqlCustomQuery = sysSqlCustomQueryManager.get(pkId);
		} else {
			sysSqlCustomQuery = new SysSqlCustomQuery();
		}
		return getPathView(request).addObject("sysSqlCustomQuery", sysSqlCustomQuery);
	}
	
	/**
	 * 
	 * 查询json
	 * doQuery("user",{user:'aaa',page:0},function(data){
	 * })
	 * 
	 * function doQuery(alias,params,callBack){
	 *  params.alias=alias;
	 *  
	 * }
	 * @Description
	 * @Title queryForJson
	 * @param @param request
	 * @param @param response
	 * @param @return
	 * @param @throws Exception 参数说明
	 * @return JsonResult 返回类型
	 * @throws
	 */
	@RequestMapping(value = "queryForJson_{alias}")
	@ResponseBody
	public JsonResult queryForJson(HttpServletRequest request, HttpServletResponse response,@PathVariable(value="alias") String alias) throws Exception {
		if(StringUtils.isEmpty(alias)) return new JsonResult<Void>(false, "请输入别名");
		String jsonStr = request.getParameter("params");
		
		JsonResult result=SysSqlCustomQueryUtil.queryForJson(alias, jsonStr);
		
		return result;
		
	}
	
	
	
	
	/**
	 * 通过sql查询列名(先通过自定义sql管理的key找出sql)
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = {"/listColumnByKeyForJson"})
	@ResponseBody
	public JsonResult listColumnByKeyForJson(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String key=request.getParameter("key");
		SysSqlCustomQuery sysSqlCustomQuery = sysSqlCustomQueryManager.getByKey(key);
		return new JsonResult(true,"",sysSqlCustomQuery);
	}
	
	@RequestMapping("search")
	@ResponseBody
	public List<SysSqlCustomQuery> search(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		List<SysSqlCustomQuery> querys=sysSqlCustomQueryManager.getAll(queryFilter);
		return querys;
	}
	
	@RequestMapping("getList")
	@ResponseBody
	public List<SysSqlCustomQuery> getList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tenantId= ContextUtil.getCurrentTenantId();
		List<SysSqlCustomQuery> querys=sysSqlCustomQueryManager.getByTenantId(tenantId);
		return querys;
	}
	
	
	
	/**
	 * 导出业务列表
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
		
		List<SysSqlCustomQuery> list=sysSqlCustomQueryManager.getSysSqlCustomQueryByIds(key);
		
		response.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "Sys-Sql-CustomQuery-" + sdf.format(new Date());
		response.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						response.getOutputStream());
		
		for (SysSqlCustomQuery query : list) {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			// 生成XML
			String xml = xstream.toXML(query);
			
			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(query.getName() + ".xml"));
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
	@LogEnt(action = "importDirect", module = "查询", submodule = "查询设计")
	public ModelAndView importDirect(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile f = request.getFile("zipFile");
		ProcessHandleHelper.clearProcessMessage();
		
		sysSqlCustomQueryManager.doImport(f);
		
		Set<String> msgSet= ProcessHandleHelper.getProcessMessage().getErrorMsges();
		
		return getPathView(request).addObject("msgSet", msgSet);
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return sysSqlCustomQueryManager;
	}
}
