package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmTestSol;
import com.redxun.bpm.core.manager.BpmTestSolManager;

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
 * [BpmTestSol]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmTestSol/")
public class BpmTestSolFormController extends BaseFormController {

    @Resource
    private BpmTestSolManager bpmTestSolManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmTestSol")
    public BpmTestSol processForm(HttpServletRequest request) {
        String testSolId = request.getParameter("testSolId");
        BpmTestSol bpmTestSol = null;
        if (StringUtils.isNotEmpty(testSolId)) {
            bpmTestSol = bpmTestSolManager.get(testSolId);
        } else {
            bpmTestSol = new BpmTestSol();
        }

        return bpmTestSol;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmTestSol
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "测试方案")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmTestSol") @Valid BpmTestSol bpmTestSol, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmTestSol.getTestSolId())) {
            bpmTestSol.setTestSolId(idGenerator.getSID());
            bpmTestSolManager.create(bpmTestSol);
            msg = getMessage("bpmTestSol.created", new Object[]{bpmTestSol.getTestNo()}, "成功创建!");
        } else {
            bpmTestSolManager.update(bpmTestSol);
            msg = getMessage("bpmTestSol.updated", new Object[]{bpmTestSol.getTestNo()}, "成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

