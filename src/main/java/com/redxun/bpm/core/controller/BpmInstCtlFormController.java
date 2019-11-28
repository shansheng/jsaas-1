package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmInstCtl;
import com.redxun.bpm.core.manager.BpmInstCtlManager;

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
 * [BpmInstCtl]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstCtl/")
public class BpmInstCtlFormController extends BaseFormController {

    @Resource
    private BpmInstCtlManager bpmInstCtlManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmInstCtl")
    public BpmInstCtl processForm(HttpServletRequest request) {
        String ctlId = request.getParameter("ctlId");
        BpmInstCtl bpmInstCtl = null;
        if (StringUtils.isNotEmpty(ctlId)) {
            bpmInstCtl = bpmInstCtlManager.get(ctlId);
        } else {
            bpmInstCtl = new BpmInstCtl();
        }

        return bpmInstCtl;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmInstCtl
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程附件权限")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmInstCtl") @Valid BpmInstCtl bpmInstCtl, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmInstCtl.getCtlId())) {
            bpmInstCtl.setCtlId(idGenerator.getSID());
            bpmInstCtlManager.create(bpmInstCtl);
            msg = getMessage("bpmInstCtl.created", new Object[]{bpmInstCtl.getIdentifyLabel()}, "[BpmInstCtl]成功创建!");
        } else {
            bpmInstCtlManager.update(bpmInstCtl);
            msg = getMessage("bpmInstCtl.updated", new Object[]{bpmInstCtl.getIdentifyLabel()}, "[BpmInstCtl]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

