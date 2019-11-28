package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmAuthDef;
import com.redxun.bpm.core.manager.BpmAuthDefManager;

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
 * [BpmAuthDef]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmAuthDef/")
public class BpmAuthDefFormController extends BaseFormController {

    @Resource
    private BpmAuthDefManager bpmAuthDefManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmAuthDef")
    public BpmAuthDef processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmAuthDef bpmAuthDef = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmAuthDef = bpmAuthDefManager.get(id);
        } else {
            bpmAuthDef = new BpmAuthDef();
        }

        return bpmAuthDef;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmAuthDef
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "授权流程定义")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmAuthDef") @Valid BpmAuthDef bpmAuthDef, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmAuthDef.getId())) {
            bpmAuthDef.setId(idGenerator.getSID());
            bpmAuthDefManager.create(bpmAuthDef);
            msg = getMessage("bpmAuthDef.created", new Object[]{bpmAuthDef.getIdentifyLabel()}, "[BpmAuthDef]成功创建!");
        } else {
            bpmAuthDefManager.update(bpmAuthDef);
            msg = getMessage("bpmAuthDef.updated", new Object[]{bpmAuthDef.getIdentifyLabel()}, "[BpmAuthDef]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

