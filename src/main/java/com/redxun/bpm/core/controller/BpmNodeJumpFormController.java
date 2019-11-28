package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;

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
 * [BpmNodeJump]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmNodeJump/")
public class BpmNodeJumpFormController extends BaseFormController {

    @Resource
    private BpmNodeJumpManager bpmNodeJumpManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmNodeJump")
    public BpmNodeJump processForm(HttpServletRequest request) {
        String jumpId = request.getParameter("jumpId");
        BpmNodeJump bpmNodeJump = null;
        if (StringUtils.isNotEmpty(jumpId)) {
            bpmNodeJump = bpmNodeJumpManager.get(jumpId);
        } else {
            bpmNodeJump = new BpmNodeJump();
        }

        return bpmNodeJump;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmNodeJump
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程流转记录")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmNodeJump") @Valid BpmNodeJump bpmNodeJump, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmNodeJump.getJumpId())) {
            bpmNodeJumpManager.create(bpmNodeJump);
            msg = getMessage("bpmNodeJump.created", new Object[]{bpmNodeJump.getIdentifyLabel()}, "[BpmNodeJump]成功创建!");
        } else {
            bpmNodeJumpManager.update(bpmNodeJump);
            msg = getMessage("bpmNodeJump.updated", new Object[]{bpmNodeJump.getIdentifyLabel()}, "[BpmNodeJump]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

