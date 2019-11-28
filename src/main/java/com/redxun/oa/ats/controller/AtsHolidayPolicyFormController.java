
package com.redxun.oa.ats.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.oa.ats.entity.AtsHolidayPolicy;
import com.redxun.oa.ats.manager.AtsHolidayPolicyManager;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 假期制度 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsHolidayPolicy/")
public class AtsHolidayPolicyFormController extends BaseFormController {

    @Resource
    private AtsHolidayPolicyManager atsHolidayPolicyManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsHolidayPolicy")
    public AtsHolidayPolicy processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsHolidayPolicy atsHolidayPolicy = null;
        if (StringUtils.isNotEmpty(id)) {
            atsHolidayPolicy = atsHolidayPolicyManager.get(id);
        } else {
            atsHolidayPolicy = new AtsHolidayPolicy();
        }

        return atsHolidayPolicy;
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
    @LogEnt(action = "save", module = "oa", submodule = "假期制度")
    public JsonResult save(HttpServletRequest request, @RequestBody @Valid JSONObject json, BindingResult result) {

    	AtsHolidayPolicy atsHolidayPolicy = JSON.toJavaObject(json, AtsHolidayPolicy.class);
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsHolidayPolicy.getId())) {
            atsHolidayPolicy.setId(IdUtil.getId());
            atsHolidayPolicyManager.save(atsHolidayPolicy);
            msg = getMessage("atsHolidayPolicy.created", new Object[]{atsHolidayPolicy.getIdentifyLabel()}, "[假期制度]成功创建!");
        } else {
            atsHolidayPolicyManager.updateByAtsHolidayPolicy(atsHolidayPolicy);
            msg = getMessage("atsHolidayPolicy.updated", new Object[]{atsHolidayPolicy.getIdentifyLabel()}, "[假期制度]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

