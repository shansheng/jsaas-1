
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsImportPlan;
import com.redxun.oa.ats.manager.AtsImportPlanManager;
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
 * 打卡导入方案 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsImportPlan/")
public class AtsImportPlanFormController extends BaseFormController {

    @Resource
    private AtsImportPlanManager atsImportPlanManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsImportPlan")
    public AtsImportPlan processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsImportPlan atsImportPlan = null;
        if (StringUtils.isNotEmpty(id)) {
            atsImportPlan = atsImportPlanManager.get(id);
        } else {
            atsImportPlan = new AtsImportPlan();
        }

        return atsImportPlan;
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
    @LogEnt(action = "save", module = "oa", submodule = "打卡导入方案")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsImportPlan") @Valid AtsImportPlan atsImportPlan, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsImportPlan.getId())) {
            atsImportPlan.setId(IdUtil.getId());
            atsImportPlanManager.create(atsImportPlan);
            msg = getMessage("atsImportPlan.created", new Object[]{atsImportPlan.getIdentifyLabel()}, "[打卡导入方案]成功创建!");
        } else {
            atsImportPlanManager.update(atsImportPlan);
            msg = getMessage("atsImportPlan.updated", new Object[]{atsImportPlan.getIdentifyLabel()}, "[打卡导入方案]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

