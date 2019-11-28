package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmInstCp;
import com.redxun.bpm.core.manager.BpmInstCpManager;

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
 * [BpmInstCp]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstCp/")
public class BpmInstCpFormController extends BaseFormController {

    @Resource
    private BpmInstCpManager bpmInstCpManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmInstCp")
    public BpmInstCp processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmInstCp bpmInstCp = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmInstCp = bpmInstCpManager.get(id);
        } else {
            bpmInstCp = new BpmInstCp();
        }

        return bpmInstCp;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmInstCp
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "抄送人员")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmInstCp") @Valid BpmInstCp bpmInstCp, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmInstCp.getId())) {
            bpmInstCp.setId(idGenerator.getSID());
            bpmInstCpManager.create(bpmInstCp);
            msg = getMessage("bpmInstCp.created", new Object[]{bpmInstCp.getIdentifyLabel()}, "[BpmInstCp]成功创建!");
        } else {
            bpmInstCpManager.update(bpmInstCp);
            msg = getMessage("bpmInstCp.updated", new Object[]{bpmInstCp.getIdentifyLabel()}, "[BpmInstCp]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

