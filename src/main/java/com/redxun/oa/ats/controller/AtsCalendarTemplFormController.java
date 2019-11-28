
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
import com.redxun.oa.ats.entity.AtsCalendarTempl;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.manager.AtsCalendarTemplManager;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 日历模版 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsCalendarTempl/")
public class AtsCalendarTemplFormController extends BaseFormController {

    @Resource
    private AtsCalendarTemplManager atsCalendarTemplManager;

    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsCalendarTempl")
    public AtsCalendarTempl processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsCalendarTempl atsCalendarTempl = null;
        if (StringUtils.isNotEmpty(id)) {
            atsCalendarTempl = atsCalendarTemplManager.get(id);
        } else {
            atsCalendarTempl = new AtsCalendarTempl();
        }

        return atsCalendarTempl;
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
    @LogEnt(action = "save", module = "oa", submodule = "日历模版")
    public JsonResult save(HttpServletRequest request,  @RequestBody @Valid JSONObject json, BindingResult result) {

    	AtsCalendarTempl atsCalendarTempl=JSON.toJavaObject(json, AtsCalendarTempl.class);
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsCalendarTempl.getId())) {
            atsCalendarTempl.setId(IdUtil.getId());
            atsCalendarTempl.setIsSys(AtsConstant.NO);
            atsCalendarTemplManager.save(atsCalendarTempl);
            msg = getMessage("atsCalendarTempl.created", new Object[]{atsCalendarTempl.getIdentifyLabel()}, "[日历模版]成功创建!");
        } else {
            atsCalendarTemplManager.updateCalendar(atsCalendarTempl);
            msg = getMessage("atsCalendarTempl.updated", new Object[]{atsCalendarTempl.getIdentifyLabel()}, "[日历模版]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
}

