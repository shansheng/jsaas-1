package com.redxun.sys.core.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.org.api.model.ITenant;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.core.entity.SysDic;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.entity.SysTreeCat;
import com.redxun.sys.core.manager.SysDicManager;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;
import com.thoughtworks.xstream.XStream;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * 数据字典管理
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/sys/core/sysDic/")
public class SysDicController extends BaseListController{
    @Resource
    SysDicManager sysDicManager;
    @Resource
    SysTreeManager sysTreeManager;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
            	SysDic sysDic=sysDicManager.get(id);
            	if(sysDic==null){
            		continue;
            	}
            	if(StringUtils.isEmpty(sysDic.getPath())){
            		sysDicManager.delete(id);
            		CacheUtil.delCache("SYS_DIC_" + sysDic.getTypeId());
            	}else{
            		List<SysDic> dicList=sysDicManager.getByPath(sysDic.getPath());
            		for(SysDic dic:dicList){
            			sysDicManager.delete(dic.getDicId());
            			CacheUtil.delCache("SYS_DIC_" + dic.getTypeId());
            		}
            	}
            }
        }
        return new JsonResult(true,"成功删除！");
    }
   
    /**
     * 进入某一个数据字典项的分类维护
     * @param catKey
     * @param dicKey
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("{catKey}/{dicKey}/oneMgr")
    public ModelAndView oneMgr(@PathVariable("catKey")String catKey,
    		@PathVariable("dicKey")String dicKey,HttpServletRequest request,HttpServletResponse response) throws Exception{
    	
    	SysTree sysTree=sysTreeManager.getByKey(dicKey, catKey, ContextUtil.getCurrentTenantId());
    	
    	ModelAndView mv=new ModelAndView("sys/core/sysDicOneMgr.jsp");
    	
    	if(sysTree!=null){
    		mv.addObject("treeId",sysTree.getTreeId());
    		mv.addObject("showType",sysTree.getDataShowType());
    		mv.addObject("sysTree",sysTree);
    	}
    	mv.addObject("catKey",catKey);
    	
    	return mv;
    }
    
    /**
     *  按树分类获得数据字典列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("listByTreeId")
    @ResponseBody
    public List<SysDic> listByTreeId(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	String treeId=request.getParameter("treeId");
    	List dicList=sysDicManager.getByTreeId(treeId);
    	return dicList;
    }
    
    @RequestMapping("delByTreeId")
    @ResponseBody
    public JsonResult delByTreeId(HttpServletRequest request,HttpServletResponse response)throws Exception{
    	String treeId=request.getParameter("treeId");
    	SysTree sysTree=sysTreeManager.get(treeId);
    	JsonResult result=new JsonResult(true,"成功删除！");
    	if(sysTree==null){
    		return result;
    	}
  
    	String path=sysTree.getPath();
    	//仅删除当前节点及其数据字典
    	if(StringUtils.isEmpty(path)){
    		List<SysDic> dicList=sysDicManager.getByTreeId(treeId);
    		for(SysDic dic:dicList){
    			sysDicManager.delete(dic.getDicId());
    		}
    		sysTreeManager.delete(treeId);
    		CacheUtil.delCache("SYS_DIC_" + treeId);
    		return result;
    	}
    	
    	
		List<SysTree> trees=sysTreeManager.getByPath(sysTree.getPath());
		for(SysTree tree:trees){
			List<SysDic> dicList=sysDicManager.getByTreeId(tree.getTreeId());
    		for(SysDic dic:dicList){
    			sysDicManager.delete(dic.getDicId());
    		}
    		sysTreeManager.delete(tree.getTreeId());
    		CacheUtil.delCache("SYS_DIC_" + tree.getTreeId());
		}

    	return result;
    	
    }
    
    public static  void main(String []args){
    	String path="1.2.3.";
    	
    	int index=path.lastIndexOf(".");
    	while(index>0){
    		path=path.substring(0,index);
    		index=path.lastIndexOf(".");
    		System.out.println("index:"+ path+".");
    	}
    }
    
    /**
     * 按类别Key查询数据列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("listByKey")
    @ResponseBody
    public List<SysDic> listByKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String catKey=request.getParameter("catKey");
    	String key=request.getParameter("key");
    	if(StringUtils.isEmpty(catKey)){
    		catKey=SysTreeCat.CAT_DIM;
    	}
    	SysTree sysTree=sysTreeManager.getByKey(key, catKey, ITenant.ADMIN_TENANT_ID);
    	
    	if(sysTree==null){
    		logger.error("not found the key " + key +" as dic list");
    		return new ArrayList<SysDic>();
    	}
    	List<SysDic> dicList=sysDicManager.getByTreeId(sysTree.getTreeId());
    	return dicList;
    }
    
    /**
     * 按分类节点获得数据字典列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @Deprecated
    @RequestMapping("getByDicKey")
    @ResponseBody
    public List<SysDic> getByDicKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String dicKey=request.getParameter("dicKey");
    	SysTree sysTree=sysTreeManager.getByKey(dicKey);
    	List sysDics=new ArrayList<SysDic>();
    	if(sysTree==null) {
    		return sysDics;
    	}
    	sysDics=sysDicManager.getByTreeId(sysTree.getTreeId());
    	return sysDics;
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
        SysDic sysDic=null;
        if(StringUtils.isNotBlank(pkId)){
           sysDic=sysDicManager.get(pkId);
        }else{
        	sysDic=new SysDic();
        }
        return getPathView(request).addObject("sysDic",sysDic);
    }

    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	SysDic sysDic=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		sysDic=sysDicManager.get(pkId);
    		if("true".equals(forCopy)){
    			sysDic.setDicId(null);
    		}
    	}else{
    		sysDic=new SysDic();
    	}
    	return getPathView(request).addObject("sysDic",sysDic);
    }
    
    /**
	 * 批量数据字典
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("batchSave")
	@ResponseBody
	public JsonResult batchSave(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String treeId=request.getParameter("treeId");
		SysTree sysTree=sysTreeManager.get(treeId);
		String gridData=request.getParameter("gridData");
		genDics(gridData,null,sysTree);
		return new JsonResult(true,"成功保存数据字典！");
	}
	/**
	 * 行保存
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("rowSave")
	@ResponseBody
	public JsonResult rowSave(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String treeId=request.getParameter("treeId");
		SysTree sysTree=sysTreeManager.get(treeId);
		String data=request.getParameter("data");
		JsonConfig jsonConfig=new JsonConfig();
		jsonConfig.setExcludes(new String[]{"children"});
		JSONObject jsonObj=JSONObject.fromObject(data,jsonConfig);
		SysDic sysDic=(SysDic)JSONObject.toBean(jsonObj, SysDic.class);
		if(StringUtils.isEmpty(sysDic.getDicId())){
			sysDic.setDicId(idGenerator.getSID());
			if(StringUtils.isNotEmpty(sysDic.getParentId())){
				SysDic parentDic=sysDicManager.get(sysDic.getParentId());
				sysDic.setPath(parentDic.getPath()+sysDic.getDicId()+".");
				sysDicManager.update(parentDic);
			}else{
				sysDic.setPath("0."+sysDic.getDicId()+".");
			}
			sysDic.setSysTree(sysTree);
			sysDicManager.create(sysDic);
		}else{
			sysDicManager.update(sysDic);
		}
		return new JsonResult(true,"成功保存数组字典-"+sysDic.getName(),sysDic);
	}
	
	/**
	 * 产生数据项及上下级关系
	 * @param menuJson
	 * @param parentMenu
	 * @param subsystem
	 */
	private void genDics(String groupJson,SysDic parentDic,SysTree sysTree){
		JSONArray jsonArray = JSONArray.fromObject(groupJson);
		for(int i=0;i<jsonArray.size();i++){
			 JSONObject jsonObj=jsonArray.getJSONObject(i);
	            Object dicId = jsonObj.get("dicId");
	            SysDic sysDic=null;
	            //是否为创建
	            boolean isCreated=false;
	            if(dicId==null){
	            	sysDic=new SysDic();
	            	sysDic.setDicId(idGenerator.getSID());
	            	sysDic.setSysTree(sysTree);
	            	isCreated=true;
	            }else{
	            	sysDic=sysDicManager.get(dicId.toString());
	            }
	            
	            if(sysDic==null) continue;
	            
	            String name=jsonObj.getString("name");
	            String key=jsonObj.getString("key");
	            String value=jsonObj.getString("value");
	            String descp=JSONUtil.getString(jsonObj,"descp");
	            int sn=JSONUtil.getInt(jsonObj,"sn");
	            
	            sysDic.setName(name);
	            sysDic.setKey(key);
	            sysDic.setValue(value);
	            sysDic.setDescp(descp);
	            sysDic.setSn(sn);
	            
	            if(parentDic==null){
	            	sysDic.setParentId("0");
	            	sysDic.setPath("0."+sysDic.getDicId()+".");
	            }else{
	            	sysDic.setParentId(parentDic.getDicId());
	            	sysDic.setPath(parentDic.getPath()+sysDic.getDicId()+".");
	            }
	            
	            String children = JSONUtil.getString(jsonObj,"children");
	            if(StringUtils.isNotEmpty(children)){
	            	genDics(children, sysDic, sysTree);
	            }
	            if(isCreated){
	            	sysDicManager.create(sysDic);
	            }else{
	            	sysDicManager.update(sysDic);
	            }
		}
		//同时需要更新这个缓存
		CacheUtil.delCache("SYS_DIC_" + sysTree.getTreeId());
		
	}
    
	/**
	 * 根据SysTree的Key和数字字典的key获取对应分类下的子节点数据字典
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listByTreeKeyAndDicKey")
	@ResponseBody
	public List<SysDic> listByTreeKeyAndDicKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String key=request.getParameter("key");
		String dicKey=request.getParameter("dicKey");
		SysTree sysTree=sysTreeManager.getByKey(key);
		List<SysDic> sysDics=sysDicManager.getByParentId(sysTree.getTreeId(),dicKey);
		return sysDics;
	}
	
	@RequestMapping("listByTreeKey")
	@ResponseBody
	public List<SysDic> listByTreeKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String key=request.getParameter("key");
		List<SysDic> sysDics=sysDicManager.getByTreeKey(key);
		return sysDics;
	}
	
	/**
	 * 根据主键获取对应分类下的数据字典
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listByDicId")
	@ResponseBody
	public JsonResult listByDicId(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String dicId=request.getParameter("dicId");
		SysDic sysDic=sysDicManager.get(dicId);
		List<SysDic> sysDics=sysDicManager.getBySysTreeId(sysDic.getSysTree().getTreeId());
		Map<String, String> sysDicSet=new HashMap<String, String>();
		for (int i = 0; i < sysDics.size(); i++) {
			SysDic tmpSysdic=sysDics.get(i);
			if(i==0){
				sysDicSet.put("dbtype", tmpSysdic.getSysTree().getKey());
				continue;
			}
			if("dbname".equals(tmpSysdic.getKey()))
				sysDicSet.put("dbname", tmpSysdic.getValue());
			if("dburl".equals(tmpSysdic.getKey()))
				sysDicSet.put("dburl", tmpSysdic.getValue());
			if("dbdriver".equals(tmpSysdic.getKey()))
				sysDicSet.put("dbdriver", tmpSysdic.getValue());
			
		}
		return new JsonResult(true,"", sysDicSet);
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
		String key = request.getParameter("key");
		String catKey = request.getParameter("catKey");
		String tenentId = ContextUtil.getCurrentTenantId();
		
		SysTree sysTree=sysTreeManager.getByKey(key, catKey, tenentId);
		List<SysTree> list = sysTreeManager.getByTreeIdNameCatKey(tenentId, sysTree.getPath(), catKey);
		for (SysTree sysTree2 : list) {
			//获取数据字典
			List<SysDic> sysDics=sysDicManager.getBySysTreeId(sysTree2.getTreeId());
			sysTree2.setSysDics(sysDics);
			response.setContentType("application/zip");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String downFileName = "Sys-Dic-" + sdf.format(new Date());
			response.addHeader("Content-Disposition", "attachment; filename=\"" + downFileName + ".zip\"");
		}
		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						response.getOutputStream());
		for (SysTree tree : list) {
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			// 生成XML
			String xml = xstream.toXML(tree);
				
			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(tree.getName() + ".xml"));
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
	@LogEnt(action = "importDirect", module = "数据字典", submodule = "数据字典设计")
	public ModelAndView importDirect(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile f = request.getFile("zipFile");
		String path = request.getParameter("path");
		ProcessHandleHelper.clearProcessMessage();
		
		sysDicManager.doImport(f,path);
		
		Set<String> msgSet= ProcessHandleHelper.getProcessMessage().getErrorMsges();
		
		return getPathView(request).addObject("msgSet", msgSet);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return sysDicManager;
	}

}
