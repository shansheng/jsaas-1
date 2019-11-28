
package com.redxun.oa.ats.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsAttenceGroup;
import com.redxun.oa.ats.manager.AtsAttenceGroupManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.redxun.saweb.util.IdUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.sys.log.LogEnt;

/**
 * 考勤组 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceGroup/")
public class AtsAttenceGroupFormController extends BaseFormController {

    @Resource
    private AtsAttenceGroupManager atsAttenceGroupManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttenceGroup")
    public AtsAttenceGroup processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttenceGroup atsAttenceGroup = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttenceGroup = atsAttenceGroupManager.get(id);
        } else {
            atsAttenceGroup = new AtsAttenceGroup();
        }

        return atsAttenceGroup;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤组")
    public JsonResult save(HttpServletRequest request, @RequestBody @Valid JSONObject json, BindingResult result) {

    	AtsAttenceGroup atsAttenceGroup = JSON.toJavaObject(json, AtsAttenceGroup.class);
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsAttenceGroup.getId())) {
            atsAttenceGroup.setId(IdUtil.getId());
            atsAttenceGroupManager.save(atsAttenceGroup);
            msg = getMessage("atsAttenceGroup.created", new Object[]{atsAttenceGroup.getIdentifyLabel()}, "[考勤组]成功创建!");
        } else {
            atsAttenceGroupManager.updateAttenceGroup(atsAttenceGroup);
            msg = getMessage("atsAttenceGroup.updated", new Object[]{atsAttenceGroup.getIdentifyLabel()}, "[考勤组]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

