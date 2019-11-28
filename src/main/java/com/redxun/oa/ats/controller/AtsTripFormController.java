
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsTrip;
import com.redxun.oa.ats.manager.AtsTripManager;
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
 * 考勤出差单 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsTrip/")
public class AtsTripFormController extends BaseFormController {

    @Resource
    private AtsTripManager atsTripManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsTrip")
    public AtsTrip processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsTrip atsTrip = null;
        if (StringUtils.isNotEmpty(id)) {
            atsTrip = atsTripManager.get(id);
        } else {
            atsTrip = new AtsTrip();
        }

        return atsTrip;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤出差单")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsTrip") @Valid AtsTrip atsTrip, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsTrip.getId())) {
            atsTrip.setId(IdUtil.getId());
            atsTripManager.create(atsTrip);
            msg = getMessage("atsTrip.created", new Object[]{atsTrip.getIdentifyLabel()}, "[考勤出差单]成功创建!");
        } else {
            atsTripManager.update(atsTrip);
            msg = getMessage("atsTrip.updated", new Object[]{atsTrip.getIdentifyLabel()}, "[考勤出差单]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

