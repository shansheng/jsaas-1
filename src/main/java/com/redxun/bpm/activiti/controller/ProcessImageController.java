package com.redxun.bpm.activiti.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.GraphicInfo;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.redxun.bpm.activiti.image.ProcessImageGenerator;
import com.redxun.bpm.activiti.service.ActInstService;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeStatus;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.FileUtil;

/**
 * 流程图产生的控制器
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/activiti/")
public class ProcessImageController {
	
	
	
	@Resource
	private RepositoryService repositoryService;
	
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
    @Resource
    private ActRepService actRepService;
	@Resource
	private ActInstService actInstService;
	@Resource
	private BpmInstManager bpmInstManager;
    @Resource
    private BpmDefManager bpmDefManager;
    @Resource
    private BpmTaskManager bpmTaskManager;
    @Resource
    private BpmRuPathManager bpmRuPathManager;
    
	/**
	 * 产生流程图
	 * 
	 * @param req
	 * @param resp
	 * @throws Exception
	 */
	@RequestMapping("processImage")
	public void processImage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		resp.setContentType("image/PNG");
		resp.setHeader("Pragma", "No-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);
		
		//文件输出
		String actDefId = req.getParameter("actDefId");
		String actInstId=req.getParameter("actInstId");
		String taskId=req.getParameter("taskId");
		String instId=req.getParameter("instId");
		OutputStream output=resp.getOutputStream();

		//输出图片
		if (StringUtils.isNotEmpty(actDefId)) {
			getImageStreamFromActDefId(actDefId,output);
		}else if(StringUtils.isNotEmpty(actInstId)){
			ProcessInstance processInst=runtimeService.createProcessInstanceQuery().processInstanceId(actInstId).singleResult();
			if(processInst==null){
				BpmInst bpmInst=bpmInstManager.getByActInstId(actInstId);
				getImageStreamFromInstId(bpmInst.getInstId(),output);
			}else{
				getImageStreamFromActInstId(processInst.getProcessInstanceId(),output);
			}
		}else if(StringUtils.isNotEmpty(taskId)){
			getImageStreamFromTaskId(taskId,output);
		}else if(StringUtils.isNotEmpty(instId)){
			getImageStreamFromInstId(instId,output);
		}
	}
	
	private void getImageStreamFromInstId(String instId,OutputStream output) throws Exception{
		BpmInst bpmInst=bpmInstManager.get(instId);
		BpmnModel bpmnModel = repositoryService.getBpmnModel(bpmInst.getActDefId());
		BpmDef bpmDef=bpmDefManager.get(bpmInst.getDefId());//getByActDefId(actDefId);
		String xml=actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
		
		generateArea(xml, bpmnModel);
		
		List<String> flowIdList=new ArrayList<String>();
		if(BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())){
			Collection<String> flowIds=actInstService.getJumpFlowsByActInstId(bpmInst.getActInstId());
			flowIdList.addAll(flowIds);
		}
		//Map<String,String> maps=bpmRuPathManager.getLatestStatus(bpmInst.getActInstId());
		Map<String,BpmNodeStatus> maps=bpmRuPathManager.getBpmInstNodeStatus(bpmInst.getActInstId());
		
		handleImage(bpmnModel, maps, flowIdList, output);
		
	}
	
	private void getImageStreamFromActInstId(String actInstId,OutputStream output) throws Exception{
		ProcessInstance processInst=runtimeService.createProcessInstanceQuery().processInstanceId(actInstId).singleResult();
		BpmnModel bpmnModel = repositoryService.getBpmnModel(processInst.getProcessDefinitionId());
		
		
		Collection<String> flowIds=actInstService.getJumpFlowsByActInstId(actInstId);
		List<String> flowIdList=new ArrayList<String>();
		flowIdList.addAll(flowIds);

		//Map<String,String> maps=bpmRuPathManager.getLatestStatus();
		Map<String,BpmNodeStatus> maps=bpmRuPathManager.getBpmInstNodeStatus(actInstId);
		handleImage(bpmnModel, maps, flowIdList, output);
	}
	
	private void getImageStreamFromTaskId(String taskId,OutputStream output) throws Exception{
		Task task=taskService.createTaskQuery().taskId(taskId).singleResult();
		//List<String> activityIds=runtimeService.getActiveActivityIds(task.getProcessInstanceId());
		BpmTask bpmTask=bpmTaskManager.get(taskId);
		//BpmInst bpmInst=bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		BpmDef bpmDef=bpmDefManager.getByActDefId(bpmTask.getProcDefId());
		String xml=actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
		BpmnModel bpmnModel = repositoryService.getBpmnModel(task.getProcessDefinitionId());
		generateArea(xml, bpmnModel);
		
		Collection<String> flowIds=actInstService.getJumpFlowsByActInstId(task.getProcessInstanceId());
		List<String> flowIdList=new ArrayList<String>();
		flowIdList.addAll(flowIds);
		//Map<String,String> maps=bpmRuPathManager.getLatestStatus(bpmTask.getProcInstId());
		Map<String,BpmNodeStatus> maps=bpmRuPathManager.getBpmInstNodeStatus(bpmTask.getProcInstId());
		handleImage(bpmnModel, maps, flowIdList, output);
		
	}
	
	private void getImageStreamFromActDefId(String actDefId,OutputStream output) throws Exception{
		BpmnModel bpmnModel = repositoryService.getBpmnModel(actDefId);
		BpmDef bpmDef=bpmDefManager.getByActDefId(actDefId);
		String xml=actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
		generateArea(xml,bpmnModel);
		handleImage(bpmnModel, output);
		 
	}
	
	private static final String activityFontName="黑体";
	private static final String labelFontName="黑体";
	
	/**
	 * 获取流程图流。
	 * @param bpmnModel
	 * @param maps
	 * @param flowIdList
	 * @return
	 * @throws IOException 
	 * @throws UnsupportedEncodingException 
	 */
	public static void handleImage(BpmnModel bpmnModel,Map<String,BpmNodeStatus> maps,List<String> flowIdList,OutputStream output) throws UnsupportedEncodingException, IOException{
		ProcessImageGenerator processImageGenerator =AppBeanUtil.getBean(ProcessImageGenerator.class);
		InputStream is = processImageGenerator.generateDiagram(bpmnModel, "png", maps,flowIdList, activityFontName, labelFontName, null, 1.0);
		FileUtil.inputToOut(is, output);
	}
	
	public static void handleImage(BpmnModel bpmnModel,OutputStream output) throws UnsupportedEncodingException, IOException{
		ProcessImageGenerator processImageGenerator =AppBeanUtil.getBean(ProcessImageGenerator.class);
		InputStream is =processImageGenerator.generateDiagram(bpmnModel, "png", activityFontName, labelFontName, null, 1.0);
		FileUtil.inputToOut(is, output);
	}
	
	public static void generateArea(String xml,BpmnModel bpmnModel) throws DocumentException{
		org.dom4j.Document document = DocumentHelper.parseText(xml);
		org.dom4j.Element root=document.getRootElement();
		List<org.dom4j.Element> childElements= root.element("process").elements("sequenceFlow");
		for (org.dom4j.Element element : childElements) {
			String sequenceId=element.attributeValue("id");
			List<org.dom4j.Element> flow=root.element("BPMNDiagram").element("BPMNPlane").elements("BPMNEdge");
			for (org.dom4j.Element flowEle : flow) {
				if(sequenceId.equals(flowEle.attributeValue("bpmnElement"))){
					double x=0;
					double y=0;
					double x2=0;
					double y2=0;
					int i=0;
					List<org.dom4j.Element> coord=flowEle.elements("waypoint");
					for (org.dom4j.Element  crd: coord) {
						i++;
						if(i==1){
							x=Double.parseDouble(crd.attributeValue("x"));
							y=Double.parseDouble(crd.attributeValue("y"));
						}
						if(i==2){
							x2=Double.parseDouble(crd.attributeValue("x"));
							y2=Double.parseDouble(crd.attributeValue("y"));
						}
					}
					GraphicInfo graphicInfo=new GraphicInfo();
					graphicInfo.setX((x+(x+(x+x2)/2)/2)/2);
					graphicInfo.setY((y+(y+(y+y2)/2)/2)/2);
					bpmnModel.addLabelGraphicInfo(sequenceId,graphicInfo);
				}
			}
		}
	}
	
	
	
}
