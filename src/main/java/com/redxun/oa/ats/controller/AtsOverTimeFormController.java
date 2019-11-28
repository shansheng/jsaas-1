
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsOverTime;
import com.redxun.oa.ats.manager.AtsOverTimeManager;
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
 * 考勤加班单 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsOverTime/")
public class AtsOverTimeFormController extends BaseFormController {

    @Resource
    private AtsOverTimeManager atsOverTimeManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsOverTime")
    public AtsOverTime processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsOverTime atsOverTime = null;
        if (StringUtils.isNotEmpty(id)) {
            atsOverTime = atsOverTimeManager.get(id);
        } else {
            atsOverTime = new AtsOverTime();
        }

        return atsOverTime;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤加班单")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsOverTime") @Valid AtsOverTime atsOverTime, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsOverTime.getId())) {
            atsOverTime.setId(IdUtil.getId());
            atsOverTimeManager.create(atsOverTime);
            msg = getMessage("atsOverTime.created", new Object[]{atsOverTime.getIdentifyLabel()}, "[考勤加班单]成功创建!");
        } else {
            atsOverTimeManager.update(atsOverTime);
            msg = getMessage("atsOverTime.updated", new Object[]{atsOverTime.getIdentifyLabel()}, "[考勤加班单]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

