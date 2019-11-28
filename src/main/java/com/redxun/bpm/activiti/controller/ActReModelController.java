package com.redxun.bpm.activiti.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.validation.ValidationError;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.activiti.entity.ActReModel;
import com.redxun.bpm.activiti.manager.ActReModelManager;

/**
 * [ActReModel]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/activiti/actReModel/")
public class ActReModelController extends BaseListController{
    @Resource
    ActReModelManager actReModelManager;
    @Resource
    RepositoryService repositoryService;
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "模型设计")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                actReModelManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
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
        ActReModel actReModel=null;
        if(StringUtils.isNotBlank(pkId)){
           actReModel=actReModelManager.get(pkId);
        }else{
        	actReModel=new ActReModel();
        }
        return getPathView(request).addObject("actReModel",actReModel);
    }
    
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	ActReModel actReModel=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		actReModel=actReModelManager.get(pkId);
    		if("true".equals(forCopy)){
    			actReModel.setId(null);
    		}
    	}else{
    		actReModel=new ActReModel();
    	}
    	return getPathView(request).addObject("actReModel",actReModel);
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
	@LogEnt(action = "deploy", module = "流程", submodule = "模型设计")
	public JsonResult deployModel(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String modelId=request.getParameter("modelId");
		Model modelData = repositoryService.getModel(modelId);
		final ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelId));
		BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
		//校验model
		List<ValidationError> errors= repositoryService.validateProcess(model);
		
		if(errors.size()>0){
			StringBuffer errSb=new StringBuffer();
			for(ValidationError ve:errors){
				errSb.append(ve.toString()).append("\n");
			}
			return new JsonResult(false,errSb.toString());
		}
		
		byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(model);
		    
		String processName = modelData.getName() + ".bpmn20.xml";
		Deployment deployment = repositoryService.createDeployment()
		            .name(modelData.getName())
		            .addString(processName, new String(bpmnBytes))
		            .deploy();
		
		ActReModel actReModel=actReModelManager.get(modelId);
		actReModel.setDeploymentId(deployment.getId());
		actReModelManager.update(actReModel);
		
		return new JsonResult(true,"成功发布!");
	}

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return actReModelManager;
	}

}
