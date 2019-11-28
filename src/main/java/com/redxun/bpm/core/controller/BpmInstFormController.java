package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.manager.BpmInstManager;

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
 * [BpmInst]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmInst/")
public class BpmInstFormController extends BaseFormController {

    @Resource
    private BpmInstManager bpmInstManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmInst")
    public BpmInst processForm(HttpServletRequest request) {
        String instId = request.getParameter("instId");
        BpmInst bpmInst = null;
        if (StringUtils.isNotEmpty(instId)) {
            bpmInst = bpmInstManager.get(instId);
        } else {
            bpmInst = new BpmInst();
        }

        return bpmInst;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmInst
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程实例")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmInst") @Valid BpmInst bpmInst, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmInst.getInstId())) {
            bpmInst.setInstId(idGenerator.getSID());
            bpmInstManager.create(bpmInst);
            msg = getMessage("bpmInst.created", new Object[]{bpmInst.getIdentifyLabel()}, "[BpmInst]成功创建!");
        } else {
            bpmInstManager.update(bpmInst);
            msg = getMessage("bpmInst.updated", new Object[]{bpmInst.getIdentifyLabel()}, "[BpmInst]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

