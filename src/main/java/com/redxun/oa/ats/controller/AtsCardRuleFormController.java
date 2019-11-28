
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsCardRule;
import com.redxun.oa.ats.manager.AtsCardRuleManager;
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
 * 取卡规则 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsCardRule/")
public class AtsCardRuleFormController extends BaseFormController {

    @Resource
    private AtsCardRuleManager atsCardRuleManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsCardRule")
    public AtsCardRule processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsCardRule atsCardRule = null;
        if (StringUtils.isNotEmpty(id)) {
            atsCardRule = atsCardRuleManager.get(id);
        } else {
            atsCardRule = new AtsCardRule();
        }

        return atsCardRule;
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
    @LogEnt(action = "save", module = "oa", submodule = "取卡规则")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsCardRule") @Valid AtsCardRule atsCardRule, BindingResult result) {

    	if(atsCardRule.getIsDefault()==null) {//默认为否
    		atsCardRule.setIsDefault((short)0);
    	}
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsCardRule.getId())) {
            atsCardRule.setId(IdUtil.getId());
            atsCardRuleManager.create(atsCardRule);
            msg = getMessage("atsCardRule.created", new Object[]{atsCardRule.getIdentifyLabel()}, "[取卡规则]成功创建!");
        } else {
            atsCardRuleManager.update(atsCardRule);
            msg = getMessage("atsCardRule.updated", new Object[]{atsCardRule.getIdentifyLabel()}, "[取卡规则]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

