package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmAuthSetting;
import com.redxun.bpm.core.manager.BpmAuthSettingManager;

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
 * [BpmAuthSetting]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmAuthSetting/")
public class BpmAuthSettingFormController extends BaseFormController {

    @Resource
    private BpmAuthSettingManager bpmAuthSettingManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmAuthSetting")
    public BpmAuthSetting processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmAuthSetting bpmAuthSetting = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmAuthSetting = bpmAuthSettingManager.get(id);
        } else {
            bpmAuthSetting = new BpmAuthSetting();
        }

        return bpmAuthSetting;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmAuthSetting
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程定义授权管理")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmAuthSetting") @Valid BpmAuthSetting bpmAuthSetting, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmAuthSetting.getId())) {
            bpmAuthSetting.setId(idGenerator.getSID());
            bpmAuthSettingManager.create(bpmAuthSetting);
            msg = getMessage("bpmAuthSetting.created", new Object[]{bpmAuthSetting.getIdentifyLabel()}, "[BpmAuthSetting]成功创建!");
        } else {
            bpmAuthSettingManager.update(bpmAuthSetting);
            msg = getMessage("bpmAuthSetting.updated", new Object[]{bpmAuthSetting.getIdentifyLabel()}, "[BpmAuthSetting]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

