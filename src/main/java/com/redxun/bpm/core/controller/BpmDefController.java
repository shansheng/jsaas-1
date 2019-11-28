package com.redxun.bpm.core.controller;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.XmlUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 流程定义管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmDef/")
public class BpmDefController extends TenantListController{
    @Resource
    BpmDefManager bpmDefManager;
    @Resource
    BpmSolutionDao bpmSolutionDao;
    @Resource
    ActRepService actRepService;
    @Resource
    RepositoryService repositoryService;
    @Resource
    BpmInstManager bpmInstManager;
    
   
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		String tenantId=getCurTenantId(request);
		//查找分类下的模型
		String treeId=request.getParameter("treeId");
		
		if(StringUtils.isNotEmpty(treeId)){
			queryFilter.addFieldParam("TREE_ID_", treeId);
		}
		queryFilter.addFieldParam("TENANT_ID_", tenantId);
		queryFilter.addFieldParam("IS_MAIN_", MBoolean.YES.toString());
		queryFilter.addSortParam("CREATE_TIME_", "desc");
		return queryFilter;
	}
	
	
	
	@RequestMapping("getVersionsByKey")
	@ResponseBody
	public List<BpmDef> getVersionsByKey(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String defKey=request.getParameter("defKey");
		List<BpmDef> list= bpmDefManager.getByKey(defKey);
		return list;
	}
	
	/**
	 * 跳至上传BPMN文件的页
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("upBpmnFile")
	public ModelAndView upBpmnFile(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String defId=request.getParameter("defId");
		BpmDef bpmDef=null;
		if(StringUtils.isNotEmpty(defId)){
			 bpmDef=bpmDefManager.get(defId);
		}else{
			bpmDef=new BpmDef();
		}
		return getPathView(request).addObject("bpmDef", bpmDef);
	}
	
	/**
	 * 下载流程定义的BPMN文件
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("downloadBpmnFile")
	public void downloadBpmnFile(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String defId=request.getParameter("defId");
		BpmDef bpmDef=bpmDefManager.get(defId);
		String bpmnXml = actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
		byte[] outPutcontent = bpmnXml.getBytes("UTF-8");// 下载BPMN文件内容 
        response.setContentType("application/x-msdownload ");  
        response.setHeader("Content-Disposition", "attachment;filename="+bpmDef.getKey()+"-"+bpmDef.getVersion()+".bpmn");  
        OutputStream  out= response.getOutputStream();
        out.write(outPutcontent); // 写入文件  
        out.flush();  
        out.close();  
	}
	
	@RequestMapping("downloadDesign")
	public void downloadDesign(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String defId=request.getParameter("defId");
		BpmDef bpmDef=bpmDefManager.get(defId);
		String bpmnXml = actRepService.getEditorJsonByModelId(bpmDef.getModelId());
		byte[] outPutcontent = bpmnXml.getBytes("UTF-8");// 下载BPMN文件内容 
        response.setContentType("application/x-msdownload ");  
        response.setHeader("Content-Disposition", "attachment;filename="+bpmDef.getKey()+"-"+bpmDef.getVersion()+".json");
        OutputStream  out= response.getOutputStream();
        out.write(outPutcontent); // 写入文件  
        out.flush();  
        out.close();  
	}
	
	/**
	 * 上传BPMN文件，转给为设计器的文件
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("uploadBpmnFile")
	@LogEnt(action = "uploadBpmnFile", module = "流程", submodule = "流程定义")
	public ModelAndView uploadBpmnFile(MultipartHttpServletRequest request,HttpServletResponse response) throws Exception{
		String subject=request.getParameter("subject");
		String key=request.getParameter("key");
		String descp=request.getParameter("descp");
		String treeId=request.getParameter("treeId");
		String defId=request.getParameter("defId");
		//是否发布新版本
		String isDeployNew=request.getParameter("isDeployNew");
		//是否转为在线设计格式
		//String convertToDesign=request.getParameter("convertToDesign");
		
		BpmDef bpmDef=null;
		
		ModelAndView view=new ModelAndView("bpm/core/bpmDefUpBpmnFile.jsp");
		if(StringUtils.isNotEmpty(defId)){
			bpmDef=bpmDefManager.get(defId);
			bpmDef.setSubject(subject);
			bpmDef.setDescp(descp);
			bpmDef.setTreeId(treeId);
		}else{
			//检查KEY重复的问题
			bpmDef=new BpmDef();
			bpmDef.setSubject(subject);
			bpmDef.setDescp(descp);
			bpmDef.setStatus(BpmDef.STATUS_INIT);
			bpmDef.setVersion(1);
			bpmDef.setKey(key);
			bpmDef.setIsMain(MBoolean.YES.name());
			boolean isKeyExist=bpmDefManager.isExistKey(key, ContextUtil.getCurrentTenantId());
			bpmDef.setTreeId(treeId);
			if(isKeyExist){
				return view.addObject("success", false).addObject("msg", "流程Key("+key+")已经存在！").addObject("bpmDef", bpmDef);
			}
		}

		//是否上传
		boolean success=true;
		//操作提示信息
		String msg=null;
		
		XMLInputFactory xif = XmlUtil.createSafeXmlInputFactory();
		Map<String, MultipartFile> files = request.getFileMap();
		Iterator<MultipartFile> it = files.values().iterator();
		while(it.hasNext()){
			MultipartFile f = it.next();
			InputStream is = f.getInputStream();
			InputStreamReader in = new InputStreamReader(is, "UTF-8");
			XMLStreamReader xtr = xif.createXMLStreamReader(in);
	        BpmnModel bpmnModel = new BpmnXMLConverter().convertToBpmnModel(xtr);
	        
	        if (bpmnModel.getMainProcess() == null 
	        		|| bpmnModel.getMainProcess().getId() == null) {
	        	msg="上传流程文件解析有问题！";
	        } else {
	        	
		      BpmnJsonConverter converter = new BpmnJsonConverter();
	          ObjectNode modelNode = converter.convertToJson(bpmnModel);
	          
	          Model modelData = repositoryService.newModel();
	          
	          ObjectNode modelObjectNode = new ObjectMapper().createObjectNode();
	          modelObjectNode.put("name", subject);
	          modelObjectNode.put("revision", 1);
	          modelObjectNode.put("documentation", bpmDef.getDescp());
	          
	          modelData.setMetaInfo(modelObjectNode.toString());
	          modelData.setName(subject);
	          modelData.setTenantId(ContextUtil.getCurrentTenantId());
	          
	          repositoryService.saveModel(modelData);	          
	          //modelNode.put("resourceId", modelData.getId());
	          
	          logger.debug("json:"+modelNode.toString());
	          repositoryService.addModelEditorSource(modelData.getId(), modelNode.toString().getBytes("utf-8"));
	          
	          if(StringUtils.isEmpty(bpmDef.getDefId())){//创建新的流程定义
	        	  bpmDef.setMainDefId(idGenerator.getSID());
	        	  bpmDef.setModelId(modelData.getId());
		        
	        	  bpmDefManager.createEntity(bpmDef);
	          }else if("true".equals(isDeployNew)){//发布新的版本
	        	  //发布新的
	        	  bpmDefManager.doDeployNew(bpmDef, modelData.getId());
	          }else{//生成一新版本，关联该流程定义,不发布流程定义
	        	  bpmDefManager.doCopyNewVersion(bpmDef,modelData.getId());
	          }
	          
	          msg="成功上传BPMN流程文件！";
	          success=true;
	          
	        }
		}
        return view.addObject("success", success).addObject("msg", msg);
	}
	
	
	@RequestMapping("uploadDesignFile")
	@LogEnt(action = "上传设计文件", module = "流程", submodule = "流程定义")
	@ResponseBody
	public JsonResult uploadDesignFile(MultipartHttpServletRequest request) throws Exception{
		MultipartFile file=	request.getFile("designFile");
	    if(file==null){
	    	return new JsonResult(false,"请选择流程设计文件!");
	    }
	    String key = RequestUtil.getString(request, "key") ;
	    String tenantId=ContextUtil.getCurrentTenantId();
		boolean rtn=bpmDefManager.isExistKey(key, tenantId);
		if(rtn){
			return new JsonResult<>(false, "指定的KEY名称已经被使用!");
		}
	    String subject=request.getParameter("subject");
		String descp=request.getParameter("descp");
		String treeId=request.getParameter("treeId");
		
		//是否发布新版本
		boolean isDeployNew=RequestUtil.getString(request, "deploy").equals("on");
		
		BpmDef def=new BpmDef();
		def.setTreeId(treeId);
		def.setSubject(subject);
		def.setKey(key);
		def.setDescp(descp);
		
		String designContent=FileUtil.inputStream2String(file.getInputStream());
		
		try{
			bpmDefManager.createOrDeploy(def,designContent,isDeployNew);
		}
		catch(Exception ex){
			return new JsonResult(true,ex.getMessage());
		}
		
		return new JsonResult(true,"上传成功");
	}
	
	@RequestMapping("dialog")
	public ModelAndView dialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String single=request.getParameter("single");
		String multiSelect="true";
		if("true".equals(single)){
			multiSelect="false";
		}
		return getPathView(request).addObject("multiSelect", multiSelect);
	}
	/**
	 * 流程定义的对话框
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listForDialog")
	@ResponseBody
	public JsonPageResult<BpmDef> listForDialog(HttpServletRequest request,HttpServletResponse response) throws Exception{
		QueryFilter queryFilter=QueryFilterBuilder.createQueryFilter(request);
		//查找分类下的模型
		String treeId=request.getParameter("treeId");
		if(StringUtils.isNotEmpty(treeId)){
			queryFilter.addFieldParam("TREE_ID_", treeId);
		}
		queryFilter.addFieldParam("STATUS_", BpmDef.STATUS_DEPLOY);
		queryFilter.addFieldParam("IS_MAIN_", MBoolean.YES.toString());
		queryFilter.addSortParam("CREATE_TIME_", "desc");
		List list=bpmDefManager.getAll(queryFilter);
		return new JsonPageResult<BpmDef>(list, queryFilter.getPage().getTotalItems());
	}
	
	/**
	 * 主版本流程定义
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("listByMainDefId")
	@ResponseBody
	public List<BpmDef> listByMainDefId(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String mainDefId=request.getParameter("mainDefId");
		String tenantId=ContextUtil.getCurrentTenantId();
		List<BpmDef> list=bpmDefManager.getByMainDefId(tenantId,mainDefId);
		return list;
	}
	
	/**
	 * 获取当前版本的流程定义
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getByActDefId")
	@ResponseBody
	public BpmDef getByActDefId(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String actDefId=request.getParameter("actDefId");
		return bpmDefManager.getByActDefId(actDefId);
	}
	
	/**
	 * 设置为主版本
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("setMain")
	@ResponseBody
	@LogEnt(action = "setMain", module = "流程", submodule = "流程定义")
	public JsonResult setMain(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String defId=request.getParameter("defId");
		bpmDefManager.doSetMain(defId);
		return new JsonResult(true, "成功保存！");
	}
	
  
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程定义")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isEmpty(uId)){
        	JsonResult result=new JsonResult(false, "没有选择流程定义ID!");
        	return result;
        }
        StringBuffer msg=new StringBuffer();
        boolean success=true;
        String[] ids=uId.split(",");
        //检查是否存在流程实例，若存在，不允许删除
        for(String id:ids){
        	BpmDef def=this.bpmDefManager.get(id);
        	Integer rtn= bpmSolutionDao.getCountByActdefId(def.getActDefId());
        	if(rtn>0){
        		msg.append(def.getSubject() +",");
        		success=false;
        		continue;
        	}
        	bpmDefManager.delByDef(def);
        }
        JsonResult result=new JsonResult(true, "成功删除所选流程定义!");
        if(!success){
        	result=new JsonResult(false,msg +"已绑定流程方案不能删除!" );
        }
        return result;
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
        String actDefId=request.getParameter("actDefId");
        BpmDef bpmDef=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmDef=bpmDefManager.get(pkId);
        }else{
        	bpmDef=bpmDefManager.getByActDefId(actDefId);
        }
        
		ModelAndView mv=getPathView(request);
		if(StringUtils.isNotEmpty(bpmDef.getActDepId())){
			String bpmnXml = actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
			mv.addObject("bpmnXml",bpmnXml);
		}
		if(StringUtils.isNotEmpty(bpmDef.getModelId())){
			String editorJson=actRepService.getEditorJsonByModelId(bpmDef.getModelId());
			mv.addObject("editorJson",editorJson);
		}
        return mv.addObject("bpmDef",bpmDef);
    }
    

    
    /**
     * 写入流程定义XML，暂时不对操作用户开放该API
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    //@RequestMapping("saveXml")
    @ResponseBody
    public JsonResult saveXml(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String defId=request.getParameter("defId");
    	String actDefXml=request.getParameter("actDefXml");
    	BpmDef bpmDef=bpmDefManager.get(defId);
    	actRepService.doWriteXml(bpmDef.getActDepId(),actDefXml);
    	return new JsonResult(true,"成功写入");
    }
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmDef bpmDef=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmDef=bpmDefManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmDef.setDefId(null);
    		}
    	}else{
    		bpmDef=new BpmDef();
    	}
    	return getPathView(request).addObject("bpmDef",bpmDef);
    }
    
    
    @RequestMapping("copy")
    public ModelAndView copy(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("defId");
    	BpmDef bpmDef=bpmDefManager.get(pkId);
    	return getPathView(request).addObject("bpmDef",bpmDef);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmDefManager;
	}
	
	/**
	 * 显示流程定义XML
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("designSource")
	public ModelAndView designSource(HttpServletRequest request, HttpServletResponse response) throws Exception{
			String defId=request.getParameter("defId");
			BpmDef bpmDef=bpmDefManager.get(defId);
			ModelAndView mv=getPathView(request);
			if(StringUtils.isNotEmpty(bpmDef.getActDepId())){
				String bpmnXml = actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
				mv.addObject("bpmnXml",bpmnXml);
			}
			if(StringUtils.isNotEmpty(bpmDef.getModelId())){
				String editorJson=actRepService.getEditorJsonByModelId(bpmDef.getModelId());
				mv.addObject("editorJson",editorJson);
			}
			return mv;
	}
	

	
	@RequestMapping("copyDef")
	@ResponseBody
    public JsonResult copyDef(@RequestBody JSONObject jsonObj) {
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmDef bpmDef=jsonObj.toJavaObject(BpmDef.class);
		boolean deploy= jsonObj.getBoolean("deploy");
		boolean rtn=bpmDefManager.isExistKey(bpmDef.getKey(), tenantId);
		if(rtn){
			return new JsonResult<>(false, "指定的KEY名称已经被使用!");
		}
    	try {
			bpmDefManager.copyNew(bpmDef.getDefId(), bpmDef.getKey(), bpmDef.getSubject(),deploy);
		} catch (Exception e) {
			return new JsonResult<>(false, "复制失败");
		}
    	
    	return new JsonResult<>(true, "复制成功");
    	
    }
	

}
