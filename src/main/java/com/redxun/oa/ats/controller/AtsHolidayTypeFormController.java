
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsHolidayType;
import com.redxun.oa.ats.manager.AtsHolidayTypeManager;
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
 * 假期类型 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsHolidayType/")
public class AtsHolidayTypeFormController extends BaseFormController {

    @Resource
    private AtsHolidayTypeManager atsHolidayTypeManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsHolidayType")
    public AtsHolidayType processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsHolidayType atsHolidayType = null;
        if (StringUtils.isNotEmpty(id)) {
            atsHolidayType = atsHolidayTypeManager.get(id);
        } else {
            atsHolidayType = new AtsHolidayType();
        }

        return atsHolidayType;
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
    @LogEnt(action = "save", module = "oa", submodule = "假期类型")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsHolidayType") @Valid AtsHolidayType atsHolidayType, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsHolidayType.getId())) {
            atsHolidayType.setId(IdUtil.getId());
            atsHolidayType.setIsSys(AtsConstant.NO);
            atsHolidayTypeManager.create(atsHolidayType);
            msg = getMessage("atsHolidayType.created", new Object[]{atsHolidayType.getIdentifyLabel()}, "[假期类型]成功创建!");
        } else {
            atsHolidayTypeManager.update(atsHolidayType);
            msg = getMessage("atsHolidayType.updated", new Object[]{atsHolidayType.getIdentifyLabel()}, "[假期类型]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

