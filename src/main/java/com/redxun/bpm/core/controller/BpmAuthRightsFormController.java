package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmAuthRights;
import com.redxun.bpm.core.manager.BpmAuthRightsManager;

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
 * [BpmAuthRights]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmAuthRights/")
public class BpmAuthRightsFormController extends BaseFormController {

    @Resource
    private BpmAuthRightsManager bpmAuthRightsManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmAuthRights")
    public BpmAuthRights processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmAuthRights bpmAuthRights = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmAuthRights = bpmAuthRightsManager.get(id);
        } else {
            bpmAuthRights = new BpmAuthRights();
        }

        return bpmAuthRights;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmAuthRights
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程定义授权")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmAuthRights") @Valid BpmAuthRights bpmAuthRights, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmAuthRights.getId())) {
            bpmAuthRights.setId(idGenerator.getSID());
            bpmAuthRightsManager.create(bpmAuthRights);
            msg = getMessage("bpmAuthRights.created", new Object[]{bpmAuthRights.getIdentifyLabel()}, "[BpmAuthRights]成功创建!");
        } else {
            bpmAuthRightsManager.update(bpmAuthRights);
            msg = getMessage("bpmAuthRights.updated", new Object[]{bpmAuthRights.getIdentifyLabel()}, "[BpmAuthRights]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

