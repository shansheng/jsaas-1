
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsAttenceCalculate;
import com.redxun.oa.ats.manager.AtsAttenceCalculateManager;
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
 * 考勤计算 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceCalculate/")
public class AtsAttenceCalculateFormController extends BaseFormController {

    @Resource
    private AtsAttenceCalculateManager atsAttenceCalculateManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttenceCalculate")
    public AtsAttenceCalculate processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttenceCalculate atsAttenceCalculate = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttenceCalculate = atsAttenceCalculateManager.get(id);
        } else {
            atsAttenceCalculate = new AtsAttenceCalculate();
        }

        return atsAttenceCalculate;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤计算")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsAttenceCalculate") @Valid AtsAttenceCalculate atsAttenceCalculate, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsAttenceCalculate.getId())) {
            atsAttenceCalculate.setId(IdUtil.getId());
            atsAttenceCalculateManager.create(atsAttenceCalculate);
            msg = getMessage("atsAttenceCalculate.created", new Object[]{atsAttenceCalculate.getIdentifyLabel()}, "[考勤计算]成功创建!");
        } else {
            atsAttenceCalculateManager.update(atsAttenceCalculate);
            msg = getMessage("atsAttenceCalculate.updated", new Object[]{atsAttenceCalculate.getIdentifyLabel()}, "[考勤计算]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

