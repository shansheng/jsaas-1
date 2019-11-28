
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsShiftType;
import com.redxun.oa.ats.manager.AtsShiftTypeManager;
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
 * 班次类型 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftType/")
public class AtsShiftTypeFormController extends BaseFormController {

    @Resource
    private AtsShiftTypeManager atsShiftTypeManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsShiftType")
    public AtsShiftType processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsShiftType atsShiftType = null;
        if (StringUtils.isNotEmpty(id)) {
            atsShiftType = atsShiftTypeManager.get(id);
        } else {
            atsShiftType = new AtsShiftType();
        }

        return atsShiftType;
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
    @LogEnt(action = "save", module = "oa", submodule = "班次类型")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsShiftType") @Valid AtsShiftType atsShiftType, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsShiftType.getId())) {
            atsShiftType.setId(IdUtil.getId());
            atsShiftType.setIsSys(AtsConstant.NO);
            atsShiftTypeManager.create(atsShiftType);
            msg = getMessage("atsShiftType.created", new Object[]{atsShiftType.getIdentifyLabel()}, "[班次类型]成功创建!");
        } else {
            atsShiftTypeManager.update(atsShiftType);
            msg = getMessage("atsShiftType.updated", new Object[]{atsShiftType.getIdentifyLabel()}, "[班次类型]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

