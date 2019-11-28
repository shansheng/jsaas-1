package com.redxun.bpm.modeler.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.manager.BpmDefManager;

@Controller
@RequestMapping("/bpm/modeler/")
public class BpmModelerController{
	
	@Resource
	BpmDefManager bpmDefManager;
	@Resource
	ActRepService actRepService;
	@Resource(name = "iJson")
	private ObjectMapper objectMapper;
    
    /**
     * 查看明细
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("designer")
    public ModelAndView designer(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("defId");
        BpmDef bpmDef=bpmDefManager.get(pkId);
       
		ModelAndView mv=new ModelAndView("bpm/modeler/designer.jsp");
		if(StringUtils.isNotEmpty(bpmDef.getModelId())){
			String editorJson=actRepService.getEditorJsonByModelId(bpmDef.getModelId());
		
			ObjectNode modelNode = (ObjectNode) objectMapper.readTree(editorJson);
			
			//检查会签节点的情况，并且给他加上相应的处理
			//递归所有的节点
			//bpmDefManager.modifySignProperties(modelNode);
			//将json文件转换成 bpmnmodel对象。
			BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
			//转换成xml对象。
			byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(model, "UTF-8");
			String bpmnXml=new String(bpmnBytes,"UTF-8").replace("<?xml version=\"1.0\" encoding=\"UTF-8\"?>", "");
			mv.addObject("bpmnXml",bpmnXml);
			
		}else if(StringUtils.isNotEmpty(bpmDef.getActDepId())){
			String bpmnXml = actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
			mv.addObject("bpmnXml",bpmnXml);
		}
		
        return mv;
    }
}
