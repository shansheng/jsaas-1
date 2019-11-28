package com.redxun.bpm.integrate.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.integrate.entity.BpmModuleBind;
import com.redxun.bpm.integrate.manager.BpmModuleBindManager;

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
 * 业务流程模块绑定管理
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/integrate/bpmModuleBind/")
public class BpmModuleBindFormController extends BaseFormController {

    @Resource
    private BpmModuleBindManager bpmModuleBindManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmModuleBind")
    public BpmModuleBind processForm(HttpServletRequest request) {
        String bindId = request.getParameter("bindId");
        BpmModuleBind bpmModuleBind = null;
        if (StringUtils.isNotEmpty(bindId)) {
            bpmModuleBind = bpmModuleBindManager.get(bindId);
        } else {
            bpmModuleBind = new BpmModuleBind();
        }

        return bpmModuleBind;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmModuleBind
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程模块方案绑定")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmModuleBind") @Valid BpmModuleBind bpmModuleBind, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmModuleBind.getBindId())) {
            bpmModuleBind.setBindId(idGenerator.getSID());
            bpmModuleBindManager.create(bpmModuleBind);
            msg = getMessage("bpmModuleBind.created", new Object[]{bpmModuleBind.getIdentifyLabel()}, "业务流程模块绑定成功创建!");
        } else {
            bpmModuleBindManager.update(bpmModuleBind);
            msg = getMessage("bpmModuleBind.updated", new Object[]{bpmModuleBind.getIdentifyLabel()}, "业务流程模块绑定成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

