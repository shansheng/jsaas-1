
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsHolidayPolicyDetail;
import com.redxun.oa.ats.manager.AtsHolidayPolicyDetailManager;
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
 * 假期制度明细 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsHolidayPolicyDetail/")
public class AtsHolidayPolicyDetailFormController extends BaseFormController {

    @Resource
    private AtsHolidayPolicyDetailManager atsHolidayPolicyDetailManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsHolidayPolicyDetail")
    public AtsHolidayPolicyDetail processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsHolidayPolicyDetail atsHolidayPolicyDetail = null;
        if (StringUtils.isNotEmpty(id)) {
            atsHolidayPolicyDetail = atsHolidayPolicyDetailManager.get(id);
        } else {
            atsHolidayPolicyDetail = new AtsHolidayPolicyDetail();
        }

        return atsHolidayPolicyDetail;
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
    @LogEnt(action = "save", module = "oa", submodule = "假期制度明细")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsHolidayPolicyDetail") @Valid AtsHolidayPolicyDetail atsHolidayPolicyDetail, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsHolidayPolicyDetail.getId())) {
            atsHolidayPolicyDetail.setId(IdUtil.getId());
            atsHolidayPolicyDetailManager.create(atsHolidayPolicyDetail);
            msg = getMessage("atsHolidayPolicyDetail.created", new Object[]{atsHolidayPolicyDetail.getIdentifyLabel()}, "[假期制度明细]成功创建!");
        } else {
            atsHolidayPolicyDetailManager.update(atsHolidayPolicyDetail);
            msg = getMessage("atsHolidayPolicyDetail.updated", new Object[]{atsHolidayPolicyDetail.getIdentifyLabel()}, "[假期制度明细]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

