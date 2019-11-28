package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmRemindInst;
import com.redxun.bpm.core.manager.BpmRemindInstManager;

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
 * [BpmRemindInst]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmRemindInst/")
public class BpmRemindInstFormController extends BaseFormController {

    @Resource
    private BpmRemindInstManager bpmRemindInstManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmRemindInst")
    public BpmRemindInst processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmRemindInst bpmRemindInst = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmRemindInst = bpmRemindInstManager.get(id);
        } else {
            bpmRemindInst = new BpmRemindInst();
        }

        return bpmRemindInst;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmRemindInst
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "催办实例")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmRemindInst") @Valid BpmRemindInst bpmRemindInst, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmRemindInst.getId())) {
            bpmRemindInst.setId(idGenerator.getSID());
            bpmRemindInstManager.create(bpmRemindInst);
            msg = getMessage("bpmRemindInst.created", new Object[]{bpmRemindInst.getIdentifyLabel()}, "[BpmRemindInst]成功创建!");
        } else {
            bpmRemindInstManager.update(bpmRemindInst);
            msg = getMessage("bpmRemindInst.updated", new Object[]{bpmRemindInst.getIdentifyLabel()}, "[BpmRemindInst]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

