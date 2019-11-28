
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsScheduleShift;
import com.redxun.oa.ats.manager.AtsScheduleShiftManager;
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
 * 排班列表 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsScheduleShift/")
public class AtsScheduleShiftFormController extends BaseFormController {

    @Resource
    private AtsScheduleShiftManager atsScheduleShiftManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsScheduleShift")
    public AtsScheduleShift processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsScheduleShift atsScheduleShift = null;
        if (StringUtils.isNotEmpty(id)) {
            atsScheduleShift = atsScheduleShiftManager.get(id);
        } else {
            atsScheduleShift = new AtsScheduleShift();
        }

        return atsScheduleShift;
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
    @LogEnt(action = "save", module = "oa", submodule = "排班列表")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsScheduleShift") @Valid AtsScheduleShift atsScheduleShift, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsScheduleShift.getId())) {
            atsScheduleShift.setId(IdUtil.getId());
            atsScheduleShiftManager.create(atsScheduleShift);
            msg = getMessage("atsScheduleShift.created", new Object[]{atsScheduleShift.getIdentifyLabel()}, "[排班列表]成功创建!");
        } else {
            atsScheduleShiftManager.update(atsScheduleShift);
            msg = getMessage("atsScheduleShift.updated", new Object[]{atsScheduleShift.getIdentifyLabel()}, "[排班列表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

