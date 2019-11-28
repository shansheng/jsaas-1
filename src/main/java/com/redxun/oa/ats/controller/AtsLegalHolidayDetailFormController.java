
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsLegalHolidayDetail;
import com.redxun.oa.ats.manager.AtsLegalHolidayDetailManager;
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
 * 法定节假日明细 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsLegalHolidayDetail/")
public class AtsLegalHolidayDetailFormController extends BaseFormController {

    @Resource
    private AtsLegalHolidayDetailManager atsLegalHolidayDetailManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsLegalHolidayDetail")
    public AtsLegalHolidayDetail processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsLegalHolidayDetail atsLegalHolidayDetail = null;
        if (StringUtils.isNotEmpty(id)) {
            atsLegalHolidayDetail = atsLegalHolidayDetailManager.get(id);
        } else {
            atsLegalHolidayDetail = new AtsLegalHolidayDetail();
        }

        return atsLegalHolidayDetail;
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
    @LogEnt(action = "save", module = "oa", submodule = "法定节假日明细")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsLegalHolidayDetail") @Valid AtsLegalHolidayDetail atsLegalHolidayDetail, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsLegalHolidayDetail.getId())) {
            atsLegalHolidayDetail.setId(IdUtil.getId());
            atsLegalHolidayDetailManager.create(atsLegalHolidayDetail);
            msg = getMessage("atsLegalHolidayDetail.created", new Object[]{atsLegalHolidayDetail.getIdentifyLabel()}, "[法定节假日明细]成功创建!");
        } else {
            atsLegalHolidayDetailManager.update(atsLegalHolidayDetail);
            msg = getMessage("atsLegalHolidayDetail.updated", new Object[]{atsLegalHolidayDetail.getIdentifyLabel()}, "[法定节假日明细]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

