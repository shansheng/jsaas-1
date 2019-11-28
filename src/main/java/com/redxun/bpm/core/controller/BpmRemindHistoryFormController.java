package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmRemindHistory;
import com.redxun.bpm.core.manager.BpmRemindHistoryManager;

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
 * [BpmRemindHistory]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmRemindHistory/")
public class BpmRemindHistoryFormController extends BaseFormController {

    @Resource
    private BpmRemindHistoryManager bpmRemindHistoryManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmRemindHistory")
    public BpmRemindHistory processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmRemindHistory bpmRemindHistory = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmRemindHistory = bpmRemindHistoryManager.get(id);
        } else {
            bpmRemindHistory = new BpmRemindHistory();
        }

        return bpmRemindHistory;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmRemindHistory
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "催办历史")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmRemindHistory") @Valid BpmRemindHistory bpmRemindHistory, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmRemindHistory.getId())) {
            bpmRemindHistory.setId(idGenerator.getSID());
            bpmRemindHistoryManager.create(bpmRemindHistory);
            msg = getMessage("bpmRemindHistory.created", new Object[]{bpmRemindHistory.getIdentifyLabel()}, "[BpmRemindHistory]成功创建!");
        } else {
            bpmRemindHistoryManager.update(bpmRemindHistory);
            msg = getMessage("bpmRemindHistory.updated", new Object[]{bpmRemindHistory.getIdentifyLabel()}, "[BpmRemindHistory]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

