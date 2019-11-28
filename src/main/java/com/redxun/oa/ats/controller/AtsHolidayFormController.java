
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsHoliday;
import com.redxun.oa.ats.manager.AtsHolidayManager;
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
 * 考勤请假单 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsHoliday/")
public class AtsHolidayFormController extends BaseFormController {

    @Resource
    private AtsHolidayManager atsHolidayManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsHoliday")
    public AtsHoliday processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsHoliday atsHoliday = null;
        if (StringUtils.isNotEmpty(id)) {
            atsHoliday = atsHolidayManager.get(id);
        } else {
            atsHoliday = new AtsHoliday();
        }

        return atsHoliday;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤请假单")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsHoliday") @Valid AtsHoliday atsHoliday, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsHoliday.getId())) {
            atsHoliday.setId(IdUtil.getId());
            atsHolidayManager.create(atsHoliday);
            msg = getMessage("atsHoliday.created", new Object[]{atsHoliday.getIdentifyLabel()}, "[考勤请假单]成功创建!");
        } else {
            atsHolidayManager.update(atsHoliday);
            msg = getMessage("atsHoliday.updated", new Object[]{atsHoliday.getIdentifyLabel()}, "[考勤请假单]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

