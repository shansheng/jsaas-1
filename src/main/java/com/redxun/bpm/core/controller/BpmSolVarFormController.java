package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.manager.BpmSolVarManager;

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
 * [BpmSolVar]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmSolVar/")
public class BpmSolVarFormController extends BaseFormController {

    @Resource
    private BpmSolVarManager bpmSolVarManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmSolVar")
    public BpmSolVar processForm(HttpServletRequest request) {
        String varId = request.getParameter("varId");
        BpmSolVar bpmSolVar = null;
        if (StringUtils.isNotEmpty(varId)) {
            bpmSolVar = bpmSolVarManager.get(varId);
        } else {
            bpmSolVar = new BpmSolVar();
        }

        return bpmSolVar;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmSolVar
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程解决方案变量")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmSolVar") @Valid BpmSolVar bpmSolVar, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmSolVar.getVarId())) {
            bpmSolVar.setVarId(idGenerator.getSID());
            bpmSolVarManager.create(bpmSolVar);
            msg = getMessage("bpmSolVar.created", new Object[]{bpmSolVar.getIdentifyLabel()}, "[BpmSolVar]成功创建!");
        } else {
            bpmSolVarManager.update(bpmSolVar);
            msg = getMessage("bpmSolVar.updated", new Object[]{bpmSolVar.getIdentifyLabel()}, "[BpmSolVar]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

