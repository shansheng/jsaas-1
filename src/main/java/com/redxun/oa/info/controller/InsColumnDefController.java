
package com.redxun.oa.info.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.json.JsonPageResult;
import com.thoughtworks.xstream.XStream;
import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.info.entity.InsColumnDef;
import com.redxun.oa.info.manager.InsColumnDefManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseMybatisListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;

import freemarker.template.TemplateException;

/**
 * ins_column_def控制器
 * @author mansan
 */
@Controller
@RequestMapping("/oa/info/insColumnDef/")
public class InsColumnDefController extends BaseMybatisListController{
    @Resource
    InsColumnDefManager insColumnDefManager;
    @Resource
	private FreemarkEngine freemarkEngine;
    @Resource
    private GroovyEngine groovyEngine;
   


	@SuppressWarnings("rawtypes")
	@Override
	public ExtBaseManager getBaseManager() {
		return insColumnDefManager;
	}
   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=RequestUtil.getString(request, "ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                insColumnDefManager.delete(id);
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
        InsColumnDef insColumnDef=null;
        if(StringUtils.isNotEmpty(pkId)){
           insColumnDef=insColumnDefManager.get(pkId);
        }else{
        	insColumnDef=new InsColumnDef();
        }
        return getPathView(request).addObject("insColumnDef",insColumnDef);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=RequestUtil.getString(request, "pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	InsColumnDef insColumnDef=null;
    	StringBuffer tabGroupsName = new StringBuffer();
    	StringBuffer tab = new StringBuffer();
    	if(StringUtils.isNotEmpty(pkId)){
    		insColumnDef=insColumnDefManager.get(pkId);
    		if("true".equals(forCopy)){
    			insColumnDef.setColId(null);
    		}
    		if(StringUtil.isNotEmpty(insColumnDef.getTabGroups())){
    			String[] tabs = insColumnDef.getTabGroups().split(",");
    			for (int i = 0; i < tabs.length; i++) {
    				InsColumnDef temp = insColumnDefManager.get(tabs[i]);
    				if(temp!=null) {
    					tabGroupsName.append(temp.getName()+",");
    					tab.append(tabs[i]+",");
    				}
				}
    			tabGroupsName.deleteCharAt(tabGroupsName.length()-1);
    			tab.deleteCharAt(tab.length()-1);
    			insColumnDef.setTabGroups(tab.toString());
    		}
    	}else{
    		insColumnDef=new InsColumnDef();
    	}
    	return getPathView(request).addObject("insColumnDef",insColumnDef).addObject("tabGroupsName",tabGroupsName);
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
        InsColumnDef insColumnDef = insColumnDefManager.getInsColumnDef(uId);
        String json = JSONObject.toJSONString(insColumnDef);
        return json;
    }
    
    @RequestMapping("getByType")
    @ResponseBody
    public List<InsColumnDef> getByType(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String type=request.getParameter("type");
    	String tenantId=request.getParameter("tenantId");
       List<InsColumnDef> insColumnDefs = insColumnDefManager.getAllByType(type, tenantId);
       return insColumnDefs;
    }
    
    @RequestMapping(value="getColHtml")
    @ResponseBody
    public String getColHtml(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String userId = ContextUtil.getCurrentUserId();
    	String ctxPath = request.getContextPath();
    	//获取栏目ID
    	String colId=RequestUtil.getString(request, "colId");
    	String html = insColumnDefManager.getColHtml(colId, ctxPath);
        return html; 
    }
    
    @RequestMapping(value="getAllCol")
    @ResponseBody
    public List<InsColumnDef> getAllCol(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	List<InsColumnDef> cols = insColumnDefManager.getAllAndPublic();
    	return cols;
    }

	@RequestMapping("search")
	@ResponseBody
	public JsonPageResult<InsColumnDef> search(HttpServletRequest request, HttpServletResponse response) throws Exception{
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		String name=request.getParameter("name");
		String key=request.getParameter("key");
		if(StringUtils.isNotEmpty(name)){
			queryFilter.addLikeFieldParam("NAME_", "%" +name + "%");
		}
		if(StringUtils.isNotEmpty(key)){
			queryFilter.addLikeFieldParam("KEY_", "%" +key + "%");
		}
		queryFilter.addFieldParam("TENANT_ID_",ContextUtil.getCurrentTenantId());
		List<InsColumnDef> list=insColumnDefManager.getAll(queryFilter);
		return new JsonPageResult<InsColumnDef>(list, queryFilter.getPage().getTotalItems());
	}

	/**
	 * 获得租户的栏目列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getNewsColumns")
	@ResponseBody
	public List<InsColumnDef> getNewsColumns(HttpServletRequest request, HttpServletResponse response) throws Exception {
		QueryFilter qf = new QueryFilter();
		qf.addFieldParam("IS_NEWS_", "YES");
		qf.addFieldParam("TENANT_ID_", ContextUtil.getCurrentTenantId());
		List<InsColumnDef> insColumns = insColumnDefManager.getAll(qf);
		return insColumns;
	}
	
	@RequestMapping("getSQLHtml")
	@ResponseBody
	public JsonResult getSQLHtml(HttpServletRequest request, HttpServletResponse response) throws IOException, TemplateException{
		Map<String,Object> params = new HashMap<String, Object>();
		String json = RequestUtil.getString(request, "resultField");
		String bokey = RequestUtil.getString(request, "bokey");
		JSONArray arr = JSONArray.parseArray(json);
		Iterator<Object> it = arr.iterator();
		Map<String,String> map = new HashMap<String, String>();
		while(it.hasNext()) {
		     JSONObject ob = (JSONObject) it.next();
		     String fieldName = ob.getString("fieldName");
		     map.put(fieldName, fieldName);
		}
		params.put("map", map);
		params.put("bokey", bokey);
		String html=freemarkEngine.mergeTemplateIntoString("list/insportalBoListTemp.ftl", params);

		
		return new JsonResult(true, "", html);
	}

	/**
	 * Author: Louis
	 * 导出
	 * @param req Request
	 * @param res Response
	 * @throws Exception
     */
	@RequestMapping("doExport")
	public void doExport(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String ids = RequestUtil.getString(req, "ids"); //传入的ids
		String expStr = RequestUtil.getString(req, "expOptions"); //导出选项
		Set<String> extOptions = new HashSet<>();
		extOptions.addAll(Arrays.asList(expStr.split(",")));

		List<InsColumnDef> columnDefList = insColumnDefManager.getColumnDefExtById(ids, extOptions);

		res.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new Date());
		String downFileName = "InsColumnDef-" + date;
		res.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");

		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						res.getOutputStream());

		for (InsColumnDef col : columnDefList) {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			String xml = xstream.toXML(col);

			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(col.getName() + ".xml"));
			InputStream is = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			IOUtils.copy(is, zipOutputStream);
			zipOutputStream.closeArchiveEntry();
		}
		zipOutputStream.close();
	}

	/**
	 * Author: Louis
	 * 导入
	 * @param req Request
	 * @param res Response
	 * @return 返回值
	 * @throws Exception
     */
	@RequestMapping("importDirect")
	public ModelAndView importDirect(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception {
		MultipartFile file = req.getFile("zipFile");

		String setting = req.getParameter("importSetting");

		insColumnDefManager.doImport(file, setting);
		ProcessHandleHelper.initProcessMessage();
		Set<String> msgSet = ProcessHandleHelper.getProcessMessage().getErrorMsges();
		return getPathView(req).addObject("msgSet", msgSet);
	}
}
