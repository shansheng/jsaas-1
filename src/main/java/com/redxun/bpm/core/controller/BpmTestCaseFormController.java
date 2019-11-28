package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmTestCase;
import com.redxun.bpm.core.manager.BpmTestCaseManager;

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
 * [BpmTestCase]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmTestCase/")
public class BpmTestCaseFormController extends BaseFormController {

    @Resource
    private BpmTestCaseManager bpmTestCaseManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmTestCase")
    public BpmTestCase processForm(HttpServletRequest request) {
        String testId = request.getParameter("testId");
        BpmTestCase bpmTestCase = null;
        if (StringUtils.isNotEmpty(testId)) {
            bpmTestCase = bpmTestCaseManager.get(testId);
        } else {
            bpmTestCase = new BpmTestCase();
        }

        return bpmTestCase;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmTestCase
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "测试用例")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmTestCase") @Valid BpmTestCase bpmTestCase, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmTestCase.getTestId())) {
            bpmTestCase.setTestId(idGenerator.getSID());
            bpmTestCaseManager.create(bpmTestCase);
            msg = getMessage("bpmTestCase.created", new Object[]{bpmTestCase.getIdentifyLabel()}, "[BpmTestCase]成功创建!");
        } else {
            bpmTestCaseManager.update(bpmTestCase);
            msg = getMessage("bpmTestCase.updated", new Object[]{bpmTestCase.getIdentifyLabel()}, "[BpmTestCase]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

