
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsShiftRuleDetail;
import com.redxun.oa.ats.manager.AtsShiftRuleDetailManager;
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
 * 轮班规则明细 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftRuleDetail/")
public class AtsShiftRuleDetailFormController extends BaseFormController {

    @Resource
    private AtsShiftRuleDetailManager atsShiftRuleDetailManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsShiftRuleDetail")
    public AtsShiftRuleDetail processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsShiftRuleDetail atsShiftRuleDetail = null;
        if (StringUtils.isNotEmpty(id)) {
            atsShiftRuleDetail = atsShiftRuleDetailManager.get(id);
        } else {
            atsShiftRuleDetail = new AtsShiftRuleDetail();
        }

        return atsShiftRuleDetail;
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
    @LogEnt(action = "save", module = "oa", submodule = "轮班规则明细")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsShiftRuleDetail") @Valid AtsShiftRuleDetail atsShiftRuleDetail, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsShiftRuleDetail.getId())) {
            atsShiftRuleDetail.setId(IdUtil.getId());
            atsShiftRuleDetailManager.create(atsShiftRuleDetail);
            msg = getMessage("atsShiftRuleDetail.created", new Object[]{atsShiftRuleDetail.getIdentifyLabel()}, "[轮班规则明细]成功创建!");
        } else {
            atsShiftRuleDetailManager.update(atsShiftRuleDetail);
            msg = getMessage("atsShiftRuleDetail.updated", new Object[]{atsShiftRuleDetail.getIdentifyLabel()}, "[轮班规则明细]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

