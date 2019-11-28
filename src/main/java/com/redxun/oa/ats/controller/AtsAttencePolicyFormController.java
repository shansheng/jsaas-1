
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsAttencePolicy;
import com.redxun.oa.ats.manager.AtsAttencePolicyManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.redxun.saweb.util.IdUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.sys.log.LogEnt;

/**
 * 考勤制度 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttencePolicy/")
public class AtsAttencePolicyFormController extends BaseFormController {

    @Resource
    private AtsAttencePolicyManager atsAttencePolicyManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttencePolicy")
    public AtsAttencePolicy processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttencePolicy atsAttencePolicy = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttencePolicy = atsAttencePolicyManager.get(id);
        } else {
            atsAttencePolicy = new AtsAttencePolicy();
        }

        return atsAttencePolicy;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤制度")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsAttencePolicy") @Valid AtsAttencePolicy atsAttencePolicy, String offLaterTime, String onLaterTime, BindingResult result) {
    	if(BeanUtil.isNotEmpty(offLaterTime)){
    		atsAttencePolicy.setOffLater(DateUtil.parseDate(offLaterTime, "HH:mm"));
    	}
    	if(BeanUtil.isNotEmpty(onLaterTime)){
    		atsAttencePolicy.setOnLater(DateUtil.parseDate(onLaterTime, "HH:mm"));
    	}
    	if(atsAttencePolicy.getIsDefault()==null) {
    		atsAttencePolicy.setIsDefault((short)0);
    	}
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsAttencePolicy.getId())) {
            atsAttencePolicy.setId(IdUtil.getId());
            atsAttencePolicyManager.create(atsAttencePolicy);
            msg = getMessage("atsAttencePolicy.created", new Object[]{atsAttencePolicy.getIdentifyLabel()}, "[考勤制度]成功创建!");
        } else {
            atsAttencePolicyManager.update(atsAttencePolicy);
            msg = getMessage("atsAttencePolicy.updated", new Object[]{atsAttencePolicy.getIdentifyLabel()}, "[考勤制度]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

