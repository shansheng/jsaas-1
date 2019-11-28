package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.bpm.core.entity.BpmSolTemplateRight;
import com.redxun.bpm.core.manager.BpmSolTemplateRightManager;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * [BpmSolTemplateRight]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmSolTemplateRight/")
public class BpmSolTemplateRightFormController extends BaseFormController {

    @Resource
    private BpmSolTemplateRightManager bpmSolTemplateRightManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmSolTemplateRight")
    public BpmSolTemplateRight processForm(HttpServletRequest request) {
        String rightId = request.getParameter("rightId");
        BpmSolTemplateRight bpmSolTemplateRight = null;
        if (StringUtils.isNotEmpty(rightId)) {
            bpmSolTemplateRight = bpmSolTemplateRightManager.get(rightId);
        } else {
            bpmSolTemplateRight = new BpmSolTemplateRight();
        }

        return bpmSolTemplateRight;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmSolTemplateRight
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmSolTemplateRight") @Valid BpmSolTemplateRight bpmSolTemplateRight, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmSolTemplateRight.getRightId())) {
            bpmSolTemplateRight.setRightId(idGenerator.getSID());
            bpmSolTemplateRightManager.create(bpmSolTemplateRight);
            msg = getMessage("bpmSolTemplateRight.created", new Object[]{bpmSolTemplateRight.getIdentifyLabel()}, "[BpmSolTemplateRight]成功创建!");
        } else {
            bpmSolTemplateRightManager.update(bpmSolTemplateRight);
            msg = getMessage("bpmSolTemplateRight.updated", new Object[]{bpmSolTemplateRight.getIdentifyLabel()}, "[BpmSolTemplateRight]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

