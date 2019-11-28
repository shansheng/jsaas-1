
package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.bpm.core.entity.BpmGroupScript;
import com.redxun.bpm.core.manager.BpmGroupScriptManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 人员脚本 管理
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmGroupScript/")
public class BpmGroupScriptFormController extends BaseFormController {

    @Resource
    private BpmGroupScriptManager bpmGroupScriptManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmGroupScript")
    public BpmGroupScript processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmGroupScript bpmGroupScript = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmGroupScript = bpmGroupScriptManager.get(id);
        } else {
            bpmGroupScript = new BpmGroupScript();
        }

        return bpmGroupScript;
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
    @LogEnt(action = "save", module = "流程", submodule = "人员脚本")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmGroupScript") @Valid BpmGroupScript bpmGroupScript, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmGroupScript.getScriptId())) {
            bpmGroupScript.setScriptId(IdUtil.getId());
            bpmGroupScriptManager.create(bpmGroupScript);
            msg = getMessage("bpmGroupScript.created", new Object[]{bpmGroupScript.getIdentifyLabel()}, "[人员脚本]成功创建!");
        } else {
            bpmGroupScriptManager.update(bpmGroupScript);
            msg = getMessage("bpmGroupScript.updated", new Object[]{bpmGroupScript.getIdentifyLabel()}, "[人员脚本]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

