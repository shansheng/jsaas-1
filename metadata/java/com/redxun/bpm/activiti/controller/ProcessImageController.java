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
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.DocumentException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.redxun.bpm.activiti.service.ActInstService;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.bpm.core.manager.BpmRuPathManager;
import com.redxun.bpm.core.manager.BpmTaskManager;
import com.redxun.core.util.FileUtil;
import com.redxun.sys.core.util.JsaasUtil;

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
	
	private Log logger=LogFactory.getLog(ProcessImageController.class);
	
	
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
	
	private void getImageStreamFromInstId(String instId,OutputStream output) throws DocumentException, UnsupportedEncodingException, IOException{
		BpmInst bpmInst=bpmInstManager.get(instId);
		BpmnModel bpmnModel = repositoryService.getBpmnModel(bpmInst.getActDefId());
		BpmDef bpmDef=bpmDefManager.get(bpmInst.getDefId());//getByActDefId(actDefId);
		String xml=actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());

		JsaasUtil.generateArea(xml, bpmnModel);
		
		List<String> flowIdList=new ArrayList<String>();
		if(BpmInst.STATUS_RUNNING.equals(bpmInst.getStatus())){
			Collection<String> flowIds=actInstService.getJumpFlowsByActInstId(bpmInst.getActInstId());
			flowIdList.addAll(flowIds);
		}
		Map<String,String> maps=bpmRuPathManager.getLatestStatus(bpmInst.getActInstId());
		JsaasUtil.handleImage(bpmnModel,maps,flowIdList,output);
		
	}
	
	private void getImageStreamFromActInstId(String actInstId,OutputStream output) throws UnsupportedEncodingException, IOException{
		ProcessInstance processInst=runtimeService.createProcessInstanceQuery().processInstanceId(actInstId).singleResult();
		BpmnModel bpmnModel = repositoryService.getBpmnModel(processInst.getProcessDefinitionId());
		
		
		Collection<String> flowIds=actInstService.getJumpFlowsByActInstId(actInstId);
		List<String> flowIdList=new ArrayList<String>();
		flowIdList.addAll(flowIds);

		Map<String,String> maps=bpmRuPathManager.getLatestStatus(actInstId);
		JsaasUtil.handleImage(bpmnModel,maps,flowIdList,output);
	}
	
	private void getImageStreamFromTaskId(String taskId,OutputStream output) throws DocumentException, UnsupportedEncodingException, IOException{
		Task task=taskService.createTaskQuery().taskId(taskId).singleResult();
		//List<String> activityIds=runtimeService.getActiveActivityIds(task.getProcessInstanceId());
		BpmTask bpmTask=bpmTaskManager.get(taskId);
		//BpmInst bpmInst=bpmInstManager.getByActInstId(bpmTask.getProcInstId());
		BpmDef bpmDef=bpmDefManager.getByActDefId(bpmTask.getProcDefId());
		String xml=actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
		BpmnModel bpmnModel = repositoryService.getBpmnModel(task.getProcessDefinitionId());
		JsaasUtil.generateArea(xml, bpmnModel);
		
		Collection<String> flowIds=actInstService.getJumpFlowsByActInstId(task.getProcessInstanceId());
		List<String> flowIdList=new ArrayList<String>();
		flowIdList.addAll(flowIds);
		Map<String,String> maps=bpmRuPathManager.getLatestStatus(bpmTask.getProcInstId());
		JsaasUtil.handleImage(bpmnModel, output);
		
	}
	
	private void getImageStreamFromActDefId(String actDefId,OutputStream output) throws DocumentException, UnsupportedEncodingException, IOException{
		BpmnModel bpmnModel = repositoryService.getBpmnModel(actDefId);
		BpmDef bpmDef=bpmDefManager.getByActDefId(actDefId);
		String xml=actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
		JsaasUtil.generateArea(xml,bpmnModel);
		JsaasUtil.handleImage(bpmnModel, output);
		 
	}
	
	
	
}
