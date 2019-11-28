
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsAttenceGroupDetail;
import com.redxun.oa.ats.manager.AtsAttenceGroupDetailManager;
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
 * 考勤组明细 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceGroupDetail/")
public class AtsAttenceGroupDetailFormController extends BaseFormController {

    @Resource
    private AtsAttenceGroupDetailManager atsAttenceGroupDetailManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttenceGroupDetail")
    public AtsAttenceGroupDetail processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttenceGroupDetail atsAttenceGroupDetail = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttenceGroupDetail = atsAttenceGroupDetailManager.get(id);
        } else {
            atsAttenceGroupDetail = new AtsAttenceGroupDetail();
        }

        return atsAttenceGroupDetail;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤组明细")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsAttenceGroupDetail") @Valid AtsAttenceGroupDetail atsAttenceGroupDetail, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsAttenceGroupDetail.getId())) {
            atsAttenceGroupDetail.setId(IdUtil.getId());
            atsAttenceGroupDetailManager.create(atsAttenceGroupDetail);
            msg = getMessage("atsAttenceGroupDetail.created", new Object[]{atsAttenceGroupDetail.getIdentifyLabel()}, "[考勤组明细]成功创建!");
        } else {
            atsAttenceGroupDetailManager.update(atsAttenceGroupDetail);
            msg = getMessage("atsAttenceGroupDetail.updated", new Object[]{atsAttenceGroupDetail.getIdentifyLabel()}, "[考勤组明细]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

