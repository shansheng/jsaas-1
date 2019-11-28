package com.redxun.bpm.form.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.form.entity.BpmFormTemplate;
import com.redxun.bpm.form.manager.BpmFormTemplateManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * [BpmFormTemplate]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/form/bpmFormTemplate/")
public class BpmFormTemplateFormController extends BaseFormController {

    @Resource
    private BpmFormTemplateManager bpmFormTemplateManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmFormTemplate")
    public BpmFormTemplate processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmFormTemplate bpmFormTemplate = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmFormTemplate = bpmFormTemplateManager.get(id);
        } else {
            bpmFormTemplate = new BpmFormTemplate();
        }

        return bpmFormTemplate;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmFormTemplate
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "表单模板")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmFormTemplate") @Valid BpmFormTemplate bpmFormTemplate, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmFormTemplate.getId())) {
            bpmFormTemplate.setId(idGenerator.getSID());
            bpmFormTemplateManager.create(bpmFormTemplate);
            msg = getMessage("bpmFormTemplate.created", new Object[]{bpmFormTemplate.getName()}, "成功创建!");
        } else {
            bpmFormTemplateManager.update(bpmFormTemplate);
            msg = getMessage("bpmFormTemplate.updated", new Object[]{bpmFormTemplate.getName()}, "成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

