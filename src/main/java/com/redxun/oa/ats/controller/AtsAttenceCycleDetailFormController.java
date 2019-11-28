
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsAttenceCycleDetail;
import com.redxun.oa.ats.manager.AtsAttenceCycleDetailManager;
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
 * 考勤周期明细 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceCycleDetail/")
public class AtsAttenceCycleDetailFormController extends BaseFormController {

    @Resource
    private AtsAttenceCycleDetailManager atsAttenceCycleDetailManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttenceCycleDetail")
    public AtsAttenceCycleDetail processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttenceCycleDetail atsAttenceCycleDetail = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttenceCycleDetail = atsAttenceCycleDetailManager.get(id);
        } else {
            atsAttenceCycleDetail = new AtsAttenceCycleDetail();
        }

        return atsAttenceCycleDetail;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤周期明细")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsAttenceCycleDetail") @Valid AtsAttenceCycleDetail atsAttenceCycleDetail, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsAttenceCycleDetail.getId())) {
            atsAttenceCycleDetail.setId(IdUtil.getId());
            atsAttenceCycleDetailManager.create(atsAttenceCycleDetail);
            msg = getMessage("atsAttenceCycleDetail.created", new Object[]{atsAttenceCycleDetail.getIdentifyLabel()}, "[考勤周期明细]成功创建!");
        } else {
            atsAttenceCycleDetailManager.update(atsAttenceCycleDetail);
            msg = getMessage("atsAttenceCycleDetail.updated", new Object[]{atsAttenceCycleDetail.getIdentifyLabel()}, "[考勤周期明细]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

