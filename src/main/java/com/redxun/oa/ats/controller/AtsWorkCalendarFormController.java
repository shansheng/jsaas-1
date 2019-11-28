
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsWorkCalendar;
import com.redxun.oa.ats.manager.AtsWorkCalendarManager;
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
 * 工作日历 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsWorkCalendar/")
public class AtsWorkCalendarFormController extends BaseFormController {

    @Resource
    private AtsWorkCalendarManager atsWorkCalendarManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsWorkCalendar")
    public AtsWorkCalendar processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsWorkCalendar atsWorkCalendar = null;
        if (StringUtils.isNotEmpty(id)) {
            atsWorkCalendar = atsWorkCalendarManager.get(id);
        } else {
            atsWorkCalendar = new AtsWorkCalendar();
        }

        return atsWorkCalendar;
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
    @LogEnt(action = "save", module = "oa", submodule = "工作日历")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsWorkCalendar") @Valid AtsWorkCalendar atsWorkCalendar, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsWorkCalendar.getId())) {
            atsWorkCalendar.setId(IdUtil.getId());
            atsWorkCalendarManager.create(atsWorkCalendar);
            msg = getMessage("atsWorkCalendar.created", new Object[]{atsWorkCalendar.getIdentifyLabel()}, "[工作日历]成功创建!");
        } else {
            atsWorkCalendarManager.update(atsWorkCalendar);
            msg = getMessage("atsWorkCalendar.updated", new Object[]{atsWorkCalendar.getIdentifyLabel()}, "[工作日历]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

