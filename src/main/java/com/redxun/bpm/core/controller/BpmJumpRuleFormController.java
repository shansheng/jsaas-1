
package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.bpm.core.entity.BpmJumpRule;
import com.redxun.bpm.core.manager.BpmJumpRuleManager;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import com.redxun.saweb.util.IdUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.redxun.sys.log.LogEnt;

/**
 * 流程跳转规则 管理
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmJumpRule/")
public class BpmJumpRuleFormController extends BaseFormController {

    @Resource
    private BpmJumpRuleManager bpmJumpRuleManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmJumpRule")
    public BpmJumpRule processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmJumpRule bpmJumpRule = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmJumpRule = bpmJumpRuleManager.get(id);
        } else {
            bpmJumpRule = new BpmJumpRule();
        }

        return bpmJumpRule;
    }
    /**
     * 保存实体数据
     * @param request
     * @param orders
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "bpm", submodule = "流程跳转规则")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmJumpRule") @Valid BpmJumpRule bpmJumpRule, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmJumpRule.getId())) {
            bpmJumpRule.setId(IdUtil.getId());
            bpmJumpRuleManager.create(bpmJumpRule);
            msg = getMessage("bpmJumpRule.created", new Object[]{bpmJumpRule.getIdentifyLabel()}, "[流程跳转规则]成功创建!");
        } else {
            bpmJumpRuleManager.update(bpmJumpRule);
            msg = getMessage("bpmJumpRule.updated", new Object[]{bpmJumpRule.getIdentifyLabel()}, "[流程跳转规则]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

