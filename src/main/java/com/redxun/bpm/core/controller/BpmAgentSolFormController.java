package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.bpm.core.manager.BpmAgentSolManager;

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
 * [BpmAgentSol]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmAgentSol/")
public class BpmAgentSolFormController extends BaseFormController {

    @Resource
    private BpmAgentSolManager bpmAgentSolManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmAgentSol")
    public BpmAgentSol processForm(HttpServletRequest request) {
        String asId = request.getParameter("asId");
        BpmAgentSol bpmAgentSol = null;
        if (StringUtils.isNotEmpty(asId)) {
            bpmAgentSol = bpmAgentSolManager.get(asId);
        } else {
            bpmAgentSol = new BpmAgentSol();
        }

        return bpmAgentSol;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmAgentSol
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "部分代理的流程方案")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmAgentSol") @Valid BpmAgentSol bpmAgentSol, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmAgentSol.getAsId())) {
            bpmAgentSol.setAsId(idGenerator.getSID());
            bpmAgentSolManager.create(bpmAgentSol);
            msg = getMessage("bpmAgentSol.created", new Object[]{bpmAgentSol.getIdentifyLabel()}, "[BpmAgentSol]成功创建!");
        } else {
            bpmAgentSolManager.update(bpmAgentSol);
            msg = getMessage("bpmAgentSol.updated", new Object[]{bpmAgentSol.getIdentifyLabel()}, "[BpmAgentSol]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

