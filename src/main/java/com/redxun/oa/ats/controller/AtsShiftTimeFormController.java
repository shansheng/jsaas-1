
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsShiftTime;
import com.redxun.oa.ats.manager.AtsShiftTimeManager;
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
 * 班次时间设置 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftTime/")
public class AtsShiftTimeFormController extends BaseFormController {

    @Resource
    private AtsShiftTimeManager atsShiftTimeManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsShiftTime")
    public AtsShiftTime processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsShiftTime atsShiftTime = null;
        if (StringUtils.isNotEmpty(id)) {
            atsShiftTime = atsShiftTimeManager.get(id);
        } else {
            atsShiftTime = new AtsShiftTime();
        }

        return atsShiftTime;
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
    @LogEnt(action = "save", module = "oa", submodule = "班次时间设置")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsShiftTime") @Valid AtsShiftTime atsShiftTime, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsShiftTime.getId())) {
            atsShiftTime.setId(IdUtil.getId());
            atsShiftTimeManager.create(atsShiftTime);
            msg = getMessage("atsShiftTime.created", new Object[]{atsShiftTime.getIdentifyLabel()}, "[班次时间设置]成功创建!");
        } else {
            atsShiftTimeManager.update(atsShiftTime);
            msg = getMessage("atsShiftTime.updated", new Object[]{atsShiftTime.getIdentifyLabel()}, "[班次时间设置]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

