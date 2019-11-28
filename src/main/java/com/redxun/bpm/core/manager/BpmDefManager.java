package com.redxun.bpm.core.manager;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.constants.StencilConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.impl.persistence.entity.ModelEntity;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.util.BpmCacheUtil;
import com.redxun.bpm.core.dao.BpmDefDao;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.json.JsonResult;
import com.redxun.core.json.JsonResultUtil;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;

/**
 * <pre>
 * 描述：BpmDef业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmDefManager extends MybatisBaseManager<BpmDef> implements ModelDataJsonConstants {
//	@Resource
//	private BpmDefDao bpmDefDao;
	@Resource
	private RepositoryService repositoryService;
	
	@Resource
	private ActRepService actRepService;

	@Resource(name = "iJson")
	private ObjectMapper objectMapper;
	
	@Resource
	private BpmDefDao bpmDefDao;
	@Resource
	private BpmSolutionDao bpmSolutionDao;
	@Resource
	private CommonDao commonDao;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmDefDao;
	}
	/**
	 * 按Activiti流程定义ID获得流程定义
	 * @param actDefId
	 * @return
	 */
	public BpmDef getByActDefId(String actDefId){
		return bpmDefDao.getByActDefId(actDefId);
	}
	

	
	/**
	 * 根据
	 * @param key
	 * @return
	 */
	public List<BpmDef> getByKey(String key){
		String tenantId=ContextUtil.getCurrentTenantId();
		return bpmDefDao.getByKey(key, tenantId);
	}
	
	/**
	 * 获得有效的流程定义
	 * @param actDefId 传入Activiti流定义Id
	 * @param defKey 传入流程定义Key
	 * @return
	 */
	public BpmDef getValidBpmDef(String actDefId,String defKey){
		BpmDef bpmDef=null;
		if(StringUtils.isNotEmpty(actDefId)){
			bpmDef=getByActDefId(actDefId);
			if(bpmDef!=null){
				return bpmDef;
			}
		}
		if(StringUtils.isNotEmpty(defKey)){
			bpmDef=getLatestBpmByKey(defKey, ContextUtil.getCurrentTenantId());
		}
		return bpmDef;
	}
	/**
	 * 获得该Key对应的流程定义的最新版本
	 * @param key
	 * @param tenantId
	 * @return
	 */
	public BpmDef getLatestBpmByKey(String key,String tenantId){
		BpmDef bpmDef=this.bpmDefDao.getByKeyMain(key, tenantId);
		if(bpmDef!=null) return bpmDef;
		
		Integer version= bpmDefDao .getMaxVersion(tenantId, key);
		if(version!=null && version>0){
			bpmDef=bpmDefDao.getByKeyVersion(tenantId, key, version);
		}
		return bpmDef;
	}
	
	/**
	 * 判断Key是否已经存在
	 * @param key
	 * @param tenantId
	 * @return
	 */
	public boolean isExistKey(String key,String tenantId){
		BpmDef def=new BpmDef();
		def.setKey(key);
		def.setTenantId(tenantId);
		
		return  bpmDefDao.getCountByKey(def);
		
		
	}

	/**
	 * 通过ModeId获得流程定义
	 * 
	 * @param modelId
	 * @return
	 */
	public BpmDef getByModelId(String modelId) {
		return bpmDefDao.getByModelId(modelId);
	}

	/**
	 * 发布新版本的流程定义
	 * 
	 * @param oldBpmDef
	 * @param newModelId
	 * @param actDepId
	 *            Activiti流程发布ID
	 * @param actDefId
	 *            Activiti流程定义ID
	 * @return
	 */
	public BpmDef doDeployNew(BpmDef oldBpmDef, String newModelId, String actDepId, String actDefId) {
		// 修改旧的版本为次版本
		bpmDefDao.updateIsMainByMailDefId(oldBpmDef.getMainDefId(), MBoolean.NO.name());
		// 生成新版本及更新流程定义的ModelId
		BpmDef newBpmDef = new BpmDef();
		BeanUtil.copyProperties(newBpmDef, oldBpmDef);
		newBpmDef.setDefId(IdUtil.getId());
		newBpmDef.setIsMain(MBoolean.YES.toString());
		newBpmDef.setModelId(newModelId);
		newBpmDef.setActDepId(actDepId);
		newBpmDef.setActDefId(actDefId);
		newBpmDef.setStatus(BpmDef.STATUS_DEPLOY);
		Integer maxVersion=bpmDefDao.getMaxVersion(ContextUtil.getCurrentTenantId(), oldBpmDef.getKey());
		if(maxVersion==null) maxVersion=0;
		newBpmDef.setVersion(maxVersion + 1);
		// 一定需要调用父类来创建,否则会产生很多额外的不相关的信息
		super.create(newBpmDef);

		return newBpmDef;
	}

	/**
	 * 按MainDefId查找历史版本
	 * @param tenantId
	 * @param mainDefId
	 * @return
	 */
	public List<BpmDef> getByMainDefId(String tenantId, String mainDefId) {
		return bpmDefDao.getByMainDefId(tenantId, mainDefId);
	}
	
	/**
	 * 创建实体
	 * @param entity
	 */
	public void createEntity(BpmDef entity){
		super.create(entity);
	}

	/**
	 * 1.添加ACT_RE_MODEL 记录。
	 * 2.添加设计json数据 ，存放到ACT_RE_BYTEARRAY中。
	 * 	数据格式如下：
	 * 	<pre>
	 * 	{
		    "id": "canvas",
		    "resourceId": "canvas",
		    "stencilset": {
		        "namespace": "http://b3mn.org/stencilset/bpmn2.0#"
		    },
		    "properties": {
		        "process_id": "chinaesetest",
		        "name": "中文测试",
		        "documentation": "",
		        "process_version": 1,
		        "process_author": "张三"
		    }
		}
	 *  </pre>
	 * @param entity
	 * @return
	 */
	public Model createModel(BpmDef entity){
		
		ObjectNode editorNode = objectMapper.createObjectNode();
		editorNode.put("id", "canvas");
		editorNode.put("resourceId", "canvas");
		ObjectNode stencilSetNode = objectMapper.createObjectNode();
		stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
		editorNode.set("stencilset", stencilSetNode);
		//
		ObjectNode propertiesNode = objectMapper.createObjectNode();
		propertiesNode.put("process_id", entity.getKey());
		propertiesNode.put("name", entity.getSubject());
		propertiesNode.put("documentation", entity.getDescp());
		propertiesNode.put("process_version", entity.getVersion());
		propertiesNode.put("process_author", ContextUtil.getCurrentUser().getFullname());
		editorNode.set("properties", propertiesNode);

		Model modelData = repositoryService.newModel();

		ObjectNode modelObjectNode = objectMapper.createObjectNode();
		modelObjectNode.put(MODEL_NAME, (String) entity.getSubject());
		modelObjectNode.put(MODEL_REVISION, 1);
		String description = null;
		if (StringUtils.isNotEmpty(entity.getDescp())) {
			description = entity.getDescp();
		} else {
			description = "";
		}
		modelObjectNode.put(MODEL_DESCRIPTION, description);
		modelData.setMetaInfo(modelObjectNode.toString());
		modelData.setName(entity.getSubject());
		modelData.setKey(entity.getKey());

		repositoryService.saveModel(modelData);
		try {
			repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return modelData;
	}
	
	
	
	
	
	/**
	 * 发布新的版本
	 * @param oldBpmDef
	 * @param modelId
	 * @throws IOException
	 */
	public void doDeployNew(BpmDef oldBpmDef,String modelId) throws IOException{
		// 发布流程
		Deployment deployment = doDeployModel(modelId);
		
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
		oldBpmDef.setSubject(processDefinition.getName());
		// 更新扩展流程定义表信息
		doDeployNew(oldBpmDef,modelId, deployment.getId(), processDefinition.getId());
	}
	/**
	 * 生成新的流程定义版本，但不发布流程
	 * @param oldBpmDef
	 * @param modelId
	 */
	public BpmDef doCopyNewVersion(BpmDef oldBpmDef,String modelId){
		BpmDef newBpmDef = new BpmDef();
		BeanUtil.copyProperties(newBpmDef, oldBpmDef);
		newBpmDef.setDefId(IdUtil.getId());
		newBpmDef.setIsMain(MBoolean.NO.name());
		newBpmDef.setModelId(modelId);
		newBpmDef.setStatus(BpmDef.STATUS_INIT);
		newBpmDef.setActDefId(null);
		newBpmDef.setActDepId(null);
		Integer maxVersion=bpmDefDao.getMaxVersion(ContextUtil.getCurrentTenantId(),oldBpmDef.getKey());
		//获得最大的版本号数
		newBpmDef.setVersion(maxVersion + 1);
		// 一定需要调用父类来创建,否则会产生很多额外的不相关的信息
		super.create(newBpmDef);
		return newBpmDef;
		
		
	}
	
	
	/**
	 * 根据defKey 获取流程最大的版本。
	 * @param defKey
	 * @param tenantId
	 * @return
	 */
	public Integer getMaxVersions(String defKey,String tenantId){
		Integer maxVersion=bpmDefDao.getMaxVersion(tenantId,defKey);
		if(maxVersion==null) return 0;
		return maxVersion;
	}
	
	
	
	/**
	 * 发布流程定义
	 * 
	 * @param modelId
	 * @return
	 * @throws JsonProcessingException
	 * @throws IOException
	 */
	public Deployment doDeployModel(String modelId) throws JsonProcessingException, IOException {
		Model modelData = repositoryService.getModel(modelId);

		String data = new String(repositoryService.getModelEditorSource(modelId), "UTF-8");

		ObjectNode modelNode = (ObjectNode) objectMapper.readTree(data);
		
		//检查会签节点的情况，并且给他加上相应的处理
		//递归所有的节点
		modifySignProperties(modelNode);
		modifyServiceTask(modelNode);
		//将json文件转换成 bpmnmodel对象。
		BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
		//转换成xml对象。
		byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(model, "UTF-8");
		
		logger.debug("bpmnXml:"+new String(bpmnBytes, "UTF-8"));

		String processName = modelData.getName() + ".bpmn20.xml";
		//发布流程定义。
		Deployment deployment = repositoryService.createDeployment().name(modelData.getName())
				.addString(processName, new String(bpmnBytes, "UTF-8")).deploy();
		return deployment;
	}
	
	/**
	 * 加上会签解析的属性，以使不需要用户输入脚本表达式
	 * @param objNode
	 */
	public void modifySignProperties(ObjectNode objNode){
		ArrayNode arrayNodes=(ArrayNode)objNode.get("childShapes");
		for(int i=0;i<arrayNodes.size();i++){
			ObjectNode node=(ObjectNode)arrayNodes.get(i);
			ObjectNode properties=(ObjectNode)node.get("properties");
			JsonNode multiinstance_type=(JsonNode)properties.get("multiinstance_type");
			
			if(multiinstance_type==null || "None".equals(multiinstance_type.textValue())) continue;
			
			
			
			properties.put(StencilConstants.PROPERTY_MULTIINSTANCE_COLLECTION, "${counterSignService.getUsers(execution)}");
			properties.put(StencilConstants.PROPERTY_MULTIINSTANCE_CONDITION, "${counterSignService.isComplete(execution)}");
			//递归
			modifySignProperties(node);
		}
	}

	/**
	 * 更新Model的设计内容
	 * 
	 * @param model
	 * @param name
	 * @param description
	 * @param designJson
	 * @throws Exception
	 */
	public void updateModel(Model model, String name, String description, String designJson) throws Exception {
		ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
		modelJson.put(MODEL_NAME, name);
		modelJson.put(MODEL_DESCRIPTION, description);
		model.setMetaInfo(modelJson.toString());
		model.setName(name);

		repositoryService.saveModel(model);
		// 加入设计文件
		repositoryService.addModelEditorSource(model.getId(), designJson.getBytes("utf-8"));

	}

	/**
	 * 更新模块的名称及描述，同事更新Activiti模块的设计文件
	 * 
	 * @param model
	 * @param name
	 * @param description
	 * @param designJson
	 * @throws Exception
	 */
	public void updateDef(Model model, String name, String description, String designJson) throws Exception {

		updateModel(model, name, description, designJson);

		BpmDef bpmDef = getByModelId(model.getId());

		if (bpmDef != null) {
			JSONObject json = JSONObject.parseObject(designJson);
			String processId = json.getJSONObject("properties").getString("process_id");
			bpmDef.setKey(processId);
			bpmDef.setSubject(name);
			bpmDef.setDescp(description);
			bpmDefDao.update(bpmDef);
		}
	}
	
	/**
	 * 创建ACT_RE_MODEL
	 * @param name
	 * @param descp
	 * @param designJson
	 * @return
	 * @throws Exception
	 */
	public Model createModel(String name,String key, String descp,String designJson) throws Exception{
		ObjectNode modelJson = objectMapper.createObjectNode();
		modelJson.put(MODEL_NAME, (String) name);
		modelJson.put(MODEL_REVISION, 1);
		Model newModel = repositoryService.newModel();
		newModel.setMetaInfo(modelJson.toString());
		newModel.setName(name);
		newModel.setKey(key);
		
		repositoryService.saveModel(newModel);
		//保存设计的json 数据，并更新 ACT_RE_MODEL 关联字段 EDITOR_SOURCE_VALUE_ID_
		repositoryService.addModelEditorSource(newModel.getId(), designJson.getBytes("utf-8"));
		return newModel;
	}
	
	/**
	 * 创建流程定义。
	 * <pre>
	 * 1.创建MODEL。
	 * 	1.在ACT_RE_MODEL 添加记录。
	 * 	2.将流程设计的JSON文件存储到ACT_RE_BYTEARRAY表，并将BYTEARRAY主键ID存放在ACT_RE_MODEL 的EDITOR_SOURCE_VALUE_ID_ 字段中。
	 * 2.发布流程定义
	 * 	1.获取ACT_RE_MODEL记录对象。
	 * 	2.根据model 对象的 EDITOR_SOURCE_VALUE_ID_ 字段获取流程设计的JSON取出来。
	 *  3.修改此JSON，增加会签等功能。
	 *  4.将JSON转换成 BpmnModel 对象。
	 *  5.将 BpmnModel 转换为bpmn的XML。
	 *  
	 * </pre>
	 * @param bpmDef
	 * @param designJson
	 * @return
	 */
	public BpmDef createAndDeploy(BpmDef bpmDef,String designJson) throws Exception{
		
		String tenantId=ContextUtil.getCurrentTenantId();
		
		Integer version=this.getMaxVersions(bpmDef.getKey(), tenantId);
		
		bpmDef.setVersion(version+1);
		
		
		bpmDef.setMainDefId(IdUtil.getId());
		bpmDef.setTenantId(tenantId);
		
		Model newModel=createModel(bpmDef.getSubject(),bpmDef.getKey(),bpmDef.getDescp(),designJson);
		
		// 发布流程
		Deployment deployment = doDeployModel(newModel.getId());
		// 发布流程定义
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
		
		bpmDef.setActDefId(processDefinition.getId());
		bpmDef.setActDepId(deployment.getId());
		bpmDef.setDefId(IdUtil.getId());
		bpmDef.setModelId(newModel.getId());
		bpmDef.setTreeId(null);
		
		//判断流程定义是否已经存在，存在更新
		Boolean isExist = bpmDefDao.getCountByKey(bpmDef);
		if(isExist) {
			BpmDef sourceDef = bpmDefDao.getByKeyMain(bpmDef.getKey(), tenantId);
			bpmDef.setDefId(sourceDef.getDefId());
			bpmDefDao.update(bpmDef);
		} else {
			create(bpmDef);
		}
		
		return bpmDef;
	}
	
	
	public void add(BpmDef entity) {

		Model model=createModel(entity);
		
		entity.setModelId(model.getId());

		super.create(entity);
	}
	
	/**
	 * 更新并升级新的版本
	 * @param newBpmDef  新的BpmDef
	 * @param oldBpmDef  旧的BpmDef
	 * @param designJson
	 * @return
	 * @throws IOException 
	 * @throws JsonProcessingException 
	 */
	public BpmDef updateAndDeployNew(BpmDef newBpmDef,BpmDef oldBpmDef,String designJson) throws Exception{
		//创建新版本
		BpmDef nvBpmDef=new BpmDef();
		
		try{
			BeanUtil.copyNotNullProperties(nvBpmDef,newBpmDef);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		nvBpmDef.setDefId(IdUtil.getId());
		nvBpmDef.setMainDefId(oldBpmDef.getMainDefId());
		nvBpmDef.setVersion(oldBpmDef.getVersion()+1);
	
		//把旧的版本改为非主版本
		oldBpmDef.setIsMain(MBoolean.NO.name());
		update(oldBpmDef);
		nvBpmDef.setIsMain(MBoolean.YES.name());
		//发布Activiti的流程
		
		//创建BPMN Model的值
		Model newModel=createModel(newBpmDef.getSubject(), newBpmDef.getKey(), newBpmDef.getDescp(), designJson);
		// 发布流程
		Deployment deployment = doDeployModel(newModel.getId());
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
		nvBpmDef.setModelId(newModel.getId());
		nvBpmDef.setActDepId(deployment.getId());
		nvBpmDef.setActDefId(processDefinition.getId());
		
		super.create(nvBpmDef);
		
		return nvBpmDef;
	}
	
	
	
	/**
	 * 修改设计器的文件及发布后的文件
	 * @param model
	 * @param name
	 * @param description
	 * @param designJson
	 * @throws Exception
	 */
	public void updateDefAndModifyActivitiDef(Model model,String name,String description,String designJson) throws Exception{
		updateModel(model, name, description, designJson);
		BpmDef bpmDef = getByModelId(model.getId());
		//直接修改XML
		if(StringUtils.isNotEmpty(bpmDef.getActDepId())){
			String processName = model.getName() + ".bpmn20.xml";
			String data = new String(repositoryService.getModelEditorSource(model.getId()), "UTF-8");
			final ObjectNode modelNode = (ObjectNode) objectMapper.readTree(data);
			//检查会签节点的情况，并且给他加上相应的处理
			//递归所有的节点
			modifySignProperties(modelNode);
			modifyServiceTask(modelNode);
			
			BpmnModel bpmModel = new BpmnJsonConverter().convertToBpmnModel(modelNode);
			byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(bpmModel, "UTF-8");
			Deployment deployment = repositoryService.createDeployment().name(model.getName())
					.addString(processName, new String(bpmnBytes, "UTF-8")).deploy();
			ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
			bpmDef.setActDefId(processDefinition.getId());
			actRepService.doModifyXmlAndClearCache(bpmDef.getActDefId(), bpmDef.getActDepId(), new String(bpmnBytes, "UTF-8"));
			BpmCacheUtil.clearCache(bpmDef.getActDefId());
		}
		if (bpmDef != null) {
			JSONObject json = JSONObject.parseObject(designJson);
			String processId = json.getJSONObject("properties").getString("process_id");
			bpmDef.setKey(processId);
			bpmDef.setSubject(name);
			bpmDef.setDescp(description);
			bpmDefDao.update(bpmDef);
			List<BpmSolution> bpmSolutions = bpmSolutionDao.getByDefKey(processId, ContextUtil.getCurrentTenantId());
			for (BpmSolution bpmSolution : bpmSolutions) {
				bpmSolution.setActDefId(bpmDef.getActDefId());
				bpmSolutionDao.update(bpmSolution);
			}
		}
	}
	
	private void modifyServiceTask(ObjectNode objNode){
		ArrayNode arrayNodes=(ArrayNode)objNode.get("childShapes");
		if(arrayNodes==null || arrayNodes.size()==0) return;
		for(int i=0;i<arrayNodes.size();i++){
			ObjectNode node=(ObjectNode)arrayNodes.get(i);
			ObjectNode stencil=(ObjectNode)node.get("stencil");
			ObjectNode properties=(ObjectNode)node.get("properties");
			JsonNode id=(JsonNode)stencil.get("id");
			
			String val= id.asText();
			if("ServiceTask".equals(val)) {
				properties.put(StencilConstants.PROPERTY_SERVICETASK_DELEGATE_EXPRESSION, "${serviceTask}");
				properties.remove(StencilConstants.PROPERTY_SERVICETASK_CLASS);
			}
			
			modifyServiceTask(node);
			
		}
	}
	
	public void doDeployModelAndUpdDef(Model model, String name, String description, String designJson) throws Exception {
		updateModel(model, name, description, designJson);
		Deployment deployment = doDeployModel(model.getId());
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
		BpmDef bpmDef = getByModelId(model.getId());
		if (bpmDef != null) {
			JSONObject json = JSONObject.parseObject(designJson);
			String processId = json.getJSONObject("properties").getString("process_id");
			bpmDef.setKey(processId);
			bpmDef.setActDepId(deployment.getId());
			bpmDef.setActDefId(processDefinition.getId());
			bpmDef.setSubject(name);
			bpmDef.setDescp(description);
			bpmDef.setStatus(BpmDef.STATUS_DEPLOY);
			update(bpmDef);
		}
	}

	/**
	 * 发布新版本
	 * 
	 * @param model
	 * @param name
	 * @param description
	 * @param designJson
	 * //@param solId 流程解决方案Id
	 * @throws Exception
	 */
	public void doDeployNewVersion(Model model, String name, String description, String designJson) throws Exception {
		
		ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
		Model newModel = repositoryService.newModel();
		modelJson.put(MODEL_NAME, name);
		modelJson.put(MODEL_DESCRIPTION, description);
		newModel.setMetaInfo(modelJson.toString());
		ObjectNode editorJson = (ObjectNode) objectMapper.readTree(designJson);

		ObjectNode propertiesNode = (ObjectNode) editorJson.get("properties");
		if (propertiesNode != null) {
			propertiesNode.put("name", name);
			propertiesNode.put("documentation", description);
			propertiesNode.put("process_author", ContextUtil.getCurrentUser().getFullname());
		}
		newModel.setName(name);
		repositoryService.saveModel(newModel);
		// 增加两附加资源文件
		repositoryService.addModelEditorSource(newModel.getId(), editorJson.toString().getBytes("utf-8"));
		deploy(model.getId(),newModel.getId());
	}
	
	/**
	 * 删除流程定义相关数据。
	 * @param defId
	 */
	public void delByDef(BpmDef def){
		
		if(def==null) return;
		
		//删除流程定义
		SqlModel procDefModel=new SqlModel("delete from act_re_procdef   where  ID_=#{actDefId}");
		procDefModel.addParam("actDefId", def.getActDefId());
		commonDao.execute(procDefModel);
		
		
		
		//删除act_re_model
		SqlModel actModel=new SqlModel("delete from  act_re_model  where ID_=#{actModelId}");
		actModel.addParam("actModelId", def.getModelId());
		commonDao.execute(actModel);
		
		//删除模型的数据
		SqlModel designModel=new SqlModel("delete from act_ge_bytearray where id_=(select A.EDITOR_SOURCE_VALUE_ID_ "
				+ " from act_re_model a where a.ID_=#{actModelId})");
		designModel.addParam("actModelId", def.getModelId());
		commonDao.execute(designModel);
		
		//删除发布的流程定义文件
		SqlModel deployDefModel=new SqlModel("delete from act_ge_bytearray  where DEPLOYMENT_ID_=#{deployId}");
		deployDefModel.addParam("deployId", def.getActDepId());
		commonDao.execute(deployDefModel);
		
		//删除 deployment
		SqlModel deployModel=new SqlModel("delete from act_re_deployment  where ID_=#{deployId}");
		deployModel.addParam("deployId", def.getActDepId());
		commonDao.execute(deployModel);
		
		bpmDefDao.delete(def.getDefId());
	}

	/**
	 * 按主ID删除
	 * 
	 * @param mainId
	 */
	public void delByMainDefId(String mainId) {
		bpmDefDao.delByMainDefId(mainId);
	}

	/**
	 * 把当前流程定义设置为主版本
	 * 
	 * @param defId
	 */
	public void doSetMain(String defId) {
		BpmDef bpmDef = get(defId);
		bpmDefDao.updateIsMainByMailDefId(bpmDef.getMainDefId(), MBoolean.NO.toString());
		bpmDef.setIsMain(MBoolean.YES.toString());
		bpmDefDao.update(bpmDef);
	}
	
	/**
	 * 判断是否能够保存。
	 * @param bpmDef
	 * @return
	 */
	public JsonResult getCanSave(BpmDef bpmDef){
		JsonResult result=JsonResultUtil.success();
		if(StringUtil.isEmpty(bpmDef.getDefId())){
			boolean rtn=bpmDefDao.getCountByKey(bpmDef);
			if(rtn){
				result= JsonResultUtil.fail("流程key已经存在!");
			}
		}
		else{
			int rtn= bpmDefDao.getCountByKeyAndId(bpmDef);
			if(rtn==0){
				result= JsonResultUtil.fail("不能修改流程定义KEY!");
			}
		}
		return result;
	}
	
	/**
	 * 拷贝过程。
	 * <pre>
	 * 	1.根据defId 获取流程定义。
	 *  2.根据modelId 获取设计的 JSON。
	 *  3.新建 act_re_model 数据。
	 *  4.新建 BPM_DEF
	 *  5.添加 设计的流程定义。
	 * </pre>
	 * @param defId
	 * @param key
	 * @param name
	 * @throws UnsupportedEncodingException
	 */
	public void copyNew(String defId,String key,String name,boolean deploy) throws Exception{
		BpmDef bpmDef = get(defId);
		String modelId=bpmDef.getModelId();
		String designSource=actRepService.getEditorJsonByModelId(modelId);
		String newDefId=IdUtil.getId();
			
		BpmDef  newDef=new BpmDef();
		newDef.setSubject(name);
		newDef.setKey(key);
		newDef.setMainDefId(newDefId);
		newDef.setTreeId(bpmDef.getTreeId());
				
		createOrDeploy(newDef, designSource,deploy);
	}
	
	private void addDesign(String modelId,String key,String name,String designSource) throws UnsupportedEncodingException{
		JSONObject jsonDesign=JSONObject.parseObject(designSource);
		jsonDesign.put("resourceId", modelId);
		JSONObject jsonPro=jsonDesign.getJSONObject("properties");
		
		jsonPro.put("process_id", key);
		jsonPro.put("name", name);
		
		String design=jsonDesign.toJSONString();
		
		repositoryService.addModelEditorSource(modelId, design.getBytes("utf-8"));
	}
	
	public void createOrDeploy(BpmDef bpmDef,String designSource,boolean deploy) throws Exception{
		String name=bpmDef.getSubject();
		String key=bpmDef.getKey();
		//添加 ACT_RE_MODEL
		ModelEntity newModel = (ModelEntity) repositoryService.newModel();
		JSONObject json=new JSONObject();
		json.put("name", name);
		newModel.setKey(key);
		newModel.setName(name);
		newModel.setVersion(1);
		newModel.setMetaInfo(json.toJSONString());
		repositoryService.saveModel(newModel);
		
		String newDefId=IdUtil.getId();
		String modelId=newModel.getId();
		
		//插入 BPM_DEF
		BpmDef  newDef=new BpmDef();
		newDef.setIsMain(MBoolean.YES.toString());
		newDef.setActDefId("");
		newDef.setActDepId("");
		newDef.setSubject(name);
		newDef.setKey(key);
		newDef.setMainDefId(newDefId);
		newDef.setTreeId(bpmDef.getTreeId());
		newDef.setModelId(modelId);
		newDef.setVersion(1);
		newDef.setStatus(BpmDef.STATUS_INIT);
		newDef.setTenantId(bpmDef.getTenantId());
		newDef.setDefId(newDefId);
		bpmDefDao.create(newDef);
		
		//添加设计文件
		addDesign(modelId,key,name,designSource);
		//是否发布
		if(deploy){
			Deployment deployment = doDeployModel(modelId);
			ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
			
			BpmDef oldBpmDef = getByModelId(modelId);
			oldBpmDef.setActDepId(processDefinition.getDeploymentId());
			oldBpmDef.setActDefId(processDefinition.getId());
			oldBpmDef.setStatus(BpmDef.STATUS_DEPLOY);
			update(oldBpmDef);
		}
		
		
	}
	
	/**
	 * 发布流程
	 * @param modelId
	 * @throws JsonProcessingException
	 * @throws IOException
	 */
	private void deploy(String modelId,String newModelId) throws JsonProcessingException, IOException{
		// 发布流程
		Deployment deployment = doDeployModel(newModelId);
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
		
		BpmDef oldBpmDef = getByModelId(modelId);
		oldBpmDef.setKey(processDefinition.getKey());
		oldBpmDef.setSubject(processDefinition.getName());
		// 更新扩展流程定义表信息
		doDeployNew(oldBpmDef,newModelId, deployment.getId(), processDefinition.getId());
	}
	public void upd(BpmDef bpmDef) throws Exception {
		Model model = repositoryService.getModel(bpmDef.getModelId());
		String name = bpmDef.getSubject();
		String description = bpmDef.getDescp();
		ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
		modelJson.put(MODEL_NAME, name);
		modelJson.put(MODEL_DESCRIPTION, description);
		model.setMetaInfo(modelJson.toString());
		model.setName(name);

		repositoryService.saveModel(model);
		String designJson = new String(repositoryService.getModelEditorSource(model.getId()),"utf-8");
		if(StringUtil.isNotEmpty(designJson)) {
			JSONObject json = JSONObject.parseObject(designJson);
			JSONObject properties = json.getJSONObject("properties");
			properties.put("process_id",bpmDef.getKey());
			properties.put("name", bpmDef.getSubject());
			properties.put("documentation", bpmDef.getDescp());
			json.put("properties", properties);
			// 加入设计文件
			repositoryService.addModelEditorSource(model.getId(), json.toJSONString().getBytes("utf-8"));
		}
		
		super.update(bpmDef);
	}
	
}