package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmInstAttach;
import com.redxun.bpm.core.manager.BpmInstAttachManager;

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
 * [BpmInstAttach]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstAttach/")
public class BpmInstAttachFormController extends BaseFormController {

    @Resource
    private BpmInstAttachManager bpmInstAttachManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmInstAttach")
    public BpmInstAttach processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmInstAttach bpmInstAttach = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmInstAttach = bpmInstAttachManager.get(id);
        } else {
            bpmInstAttach = new BpmInstAttach();
        }

        return bpmInstAttach;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmInstAttach
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程附件")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmInstAttach") @Valid BpmInstAttach bpmInstAttach, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmInstAttach.getId())) {
            bpmInstAttach.setId(idGenerator.getSID());
            bpmInstAttachManager.create(bpmInstAttach);
            msg = getMessage("bpmInstAttach.created", new Object[]{bpmInstAttach.getIdentifyLabel()}, "[BpmInstAttach]成功创建!");
        } else {
            bpmInstAttachManager.update(bpmInstAttach);
            msg = getMessage("bpmInstAttach.updated", new Object[]{bpmInstAttach.getIdentifyLabel()}, "[BpmInstAttach]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

