package com.redxun.bpm.def.controller;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.XmlUtil;
import com.redxun.sys.log.LogEnt;
/**
 * Activiti实体模型控制类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/def/repModel/")
public class RepModelController implements ModelDataJsonConstants{
	@Resource
	RepositoryService repositoryService;
	
	/**
	 * 创建流程定义设计模型
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("newModel")
	@ResponseBody
	@LogEnt(action = "newModel", module = "流程", submodule = "流程定义设计模型")
	public JsonResult newModel(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String name=request.getParameter("name");
		String descp=request.getParameter("descp");
				
		 ObjectMapper objectMapper = new ObjectMapper();
         ObjectNode editorNode = objectMapper.createObjectNode();
         editorNode.put("id", "canvas");
         editorNode.put("resourceId", "canvas");
         ObjectNode stencilSetNode = objectMapper.createObjectNode();
         stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
         editorNode.set("stencilset", stencilSetNode);
         Model modelData = repositoryService.newModel();
         
         ObjectNode modelObjectNode = objectMapper.createObjectNode();
         modelObjectNode.put(MODEL_NAME, (String) name);
         modelObjectNode.put(MODEL_REVISION, 1);
         String description = null;
         if (StringUtils.isNotEmpty(descp)) {
           description = descp;
         } else {
           description = "";
         }
         modelObjectNode.put(MODEL_DESCRIPTION, description);
         modelData.setMetaInfo(modelObjectNode.toString());
         modelData.setName(name);
         
         repositoryService.saveModel(modelData);
         repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));
         return new JsonResult(true,"成功创建！");
	}
	
	/**
	 * 发布流程设计模型
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("deployModel")
	@ResponseBody
	@LogEnt(action = "deployModel", module = "流程", submodule = "流程定义设计模型")
	public JsonResult deployModel(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String modelId=request.getParameter("modelId");
		Model modelData = repositoryService.getModel(modelId);
		final ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelId));
		BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
		byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(model);
		    
		String processName = modelData.getName() + ".bpmn20.xml";
		Deployment deployment = repositoryService.createDeployment()
		            .name(modelData.getName())
		            .addString(processName, new String(bpmnBytes))
		            .deploy();
		
		
		
		
		return new JsonResult(true,"成功发布");
	}
	
	/**
	 * 上传bpmn文件至管理后台，并转成activiti-modeler格式文件 文件后缀名为.bpmn20.xml或.bpmn
	 * @param reqeust
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public JsonResult convertBpmnFileToModel(HttpServletRequest reqeust,HttpServletResponse response) throws Exception{
		String fileId=reqeust.getParameter("fileId");
		//TODO
		String fullPath="";
		
        XMLInputFactory xif = XmlUtil.createSafeXmlInputFactory();
        InputStreamReader in = new InputStreamReader(new ByteArrayInputStream(IOUtils.toByteArray(new FileInputStream(fullPath))), "UTF-8");
        XMLStreamReader xtr = xif.createXMLStreamReader(in);
        BpmnModel bpmnModel = new BpmnXMLConverter().convertToBpmnModel(xtr);
        
        String processName = null;
        if (StringUtils.isNotEmpty(bpmnModel.getMainProcess().getName())) {
          processName = bpmnModel.getMainProcess().getName();
        } else {
          processName = bpmnModel.getMainProcess().getId();
        }
        
        Model modelData = repositoryService.newModel();
        ObjectNode modelObjectNode = new ObjectMapper().createObjectNode();
        modelObjectNode.put(MODEL_NAME, processName);
        modelObjectNode.put(MODEL_REVISION, 1);
        modelData.setMetaInfo(modelObjectNode.toString());
        modelData.setName(processName);
        
        repositoryService.saveModel(modelData);
        
        BpmnJsonConverter jsonConverter = new BpmnJsonConverter();
        ObjectNode editorNode = jsonConverter.convertToJson(bpmnModel);
        
        repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));
        
        return new JsonResult(true,"成功转换！");
	}
	
	
}
