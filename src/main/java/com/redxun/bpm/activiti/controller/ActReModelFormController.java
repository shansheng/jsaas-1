package com.redxun.bpm.activiti.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.activiti.entity.ActReModel;
import com.redxun.bpm.activiti.manager.ActReModelManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 流程定义模型管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/activiti/actReModel/")
public class ActReModelFormController extends BaseFormController implements ModelDataJsonConstants{
	@Resource
	RepositoryService repositoryService;
    @Resource
    private ActReModelManager actReModelManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("actReModel")
    public ActReModel processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        ActReModel actReModel = null;
        if (StringUtils.isNotEmpty(id)) {
            actReModel = actReModelManager.get(id);
        } else {
            actReModel = new ActReModel();
        }

        return actReModel;
    }
    /**
     * 保存实体数据
     * @param request
     * @param actReModel
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "模型设计")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("actReModel") @Valid ActReModel actReModel, BindingResult result) throws Exception {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(actReModel.getId())) {
            //actReModel.setId(idGenerator.getSID());
            //actReModelManager.create(actReModel);
            
            String descp=request.getParameter("description");
            ObjectMapper objectMapper = new ObjectMapper();
            ObjectNode editorNode = objectMapper.createObjectNode();
            editorNode.put("id", "canvas");
            editorNode.put("resourceId", "canvas");
            ObjectNode stencilSetNode = objectMapper.createObjectNode();
            stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
            editorNode.set("stencilset", stencilSetNode);
            Model modelData = repositoryService.newModel();
            
            ObjectNode modelObjectNode = objectMapper.createObjectNode();
            modelObjectNode.put(MODEL_NAME, actReModel.getName());
            modelObjectNode.put(MODEL_REVISION, 1);
            //String description = null;
           
            modelObjectNode.put(MODEL_DESCRIPTION, descp);
            modelData.setMetaInfo(modelObjectNode.toString());
            modelData.setName(actReModel.getName());
            
            repositoryService.saveModel(modelData);
            repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));
            
            msg = getMessage("actReModel.created", new Object[]{actReModel.getIdentifyLabel()}, "流程定义模型成功创建!");
        } else {
            actReModelManager.update(actReModel);
            msg = getMessage("actReModel.updated", new Object[]{actReModel.getIdentifyLabel()}, "流程定义模型成功更新!");
        }

        return new JsonResult(true, msg);
    }
}

