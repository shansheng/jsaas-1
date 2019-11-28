package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmOpinionLib;
import com.redxun.bpm.core.manager.BpmOpinionLibManager;

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
 * 审批意见管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmOpinionLib/")
public class BpmOpinionLibFormController extends BaseFormController {

    @Resource
    private BpmOpinionLibManager bpmOpinionLibManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmOpinionLib")
    public BpmOpinionLib processForm(HttpServletRequest request) {
        String opId = request.getParameter("opId");
        BpmOpinionLib bpmOpinionLib = null;
        if (StringUtils.isNotEmpty(opId)) {
            bpmOpinionLib = bpmOpinionLibManager.get(opId);
        } else {
            bpmOpinionLib = new BpmOpinionLib();
        }

        return bpmOpinionLib;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmOpinionLib
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "用户审批意见表")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmOpinionLib") @Valid BpmOpinionLib bpmOpinionLib, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmOpinionLib.getOpId())) {
            bpmOpinionLib.setOpId(idGenerator.getSID());
            bpmOpinionLib.setUserId(ContextUtil.getCurrentUserId());
            bpmOpinionLibManager.create(bpmOpinionLib);
            msg = getMessage("bpmOpinionLib.created", new Object[]{bpmOpinionLib.getIdentifyLabel()}, "审批意见成功创建!");
        } else {
        	bpmOpinionLib.setUserId(ContextUtil.getCurrentUserId());
            bpmOpinionLibManager.update(bpmOpinionLib);
            msg = getMessage("bpmOpinionLib.updated", new Object[]{bpmOpinionLib.getIdentifyLabel()}, "审批意见成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

