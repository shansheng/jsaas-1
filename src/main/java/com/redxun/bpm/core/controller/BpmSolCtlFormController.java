package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmSolCtl;
import com.redxun.bpm.core.manager.BpmSolCtlManager;

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
 * [BpmSolCtl]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmSolCtl/")
public class BpmSolCtlFormController extends BaseFormController {

    @Resource
    private BpmSolCtlManager bpmSolCtlManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmSolCtl")
    public BpmSolCtl processForm(HttpServletRequest request) {
        String rightId = request.getParameter("rightId");
        BpmSolCtl bpmSolCtl = null;
        if (StringUtils.isNotEmpty(rightId)) {
            bpmSolCtl = bpmSolCtlManager.get(rightId);
        } else {
            bpmSolCtl = new BpmSolCtl();
        }

        return bpmSolCtl;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmSolCtl
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "资源访问控制权限")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmSolCtl") @Valid BpmSolCtl bpmSolCtl, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmSolCtl.getRightId())) {
            bpmSolCtl.setRightId(idGenerator.getSID());
            bpmSolCtlManager.create(bpmSolCtl);
            msg = getMessage("bpmSolCtl.created", new Object[]{bpmSolCtl.getIdentifyLabel()}, "[BpmSolCtl]成功创建!");
        } else {
            bpmSolCtlManager.update(bpmSolCtl);
            msg = getMessage("bpmSolCtl.updated", new Object[]{bpmSolCtl.getIdentifyLabel()}, "[BpmSolCtl]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

