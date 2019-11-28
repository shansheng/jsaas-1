
package com.redxun.oa.ats.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsShiftRule;
import com.redxun.oa.ats.manager.AtsShiftRuleManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.redxun.saweb.util.IdUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.sys.log.LogEnt;

/**
 * 轮班规则 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftRule/")
public class AtsShiftRuleFormController extends BaseFormController {

    @Resource
    private AtsShiftRuleManager atsShiftRuleManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsShiftRule")
    public AtsShiftRule processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsShiftRule atsShiftRule = null;
        if (StringUtils.isNotEmpty(id)) {
            atsShiftRule = atsShiftRuleManager.get(id);
        } else {
            atsShiftRule = new AtsShiftRule();
        }

        return atsShiftRule;
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
    @LogEnt(action = "save", module = "oa", submodule = "轮班规则")
    public JsonResult save(HttpServletRequest request, @RequestBody @Valid JSONObject json, BindingResult result) {

    	AtsShiftRule atsShiftRule = JSON.toJavaObject(json, AtsShiftRule.class);
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsShiftRule.getId())) {
            atsShiftRule.setId(IdUtil.getId());
            atsShiftRuleManager.save(atsShiftRule);
            msg = getMessage("atsShiftRule.created", new Object[]{atsShiftRule.getIdentifyLabel()}, "[轮班规则]成功创建!");
        } else {
            atsShiftRuleManager.updateShiftRule(atsShiftRule);
            msg = getMessage("atsShiftRule.updated", new Object[]{atsShiftRule.getIdentifyLabel()}, "[轮班规则]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

