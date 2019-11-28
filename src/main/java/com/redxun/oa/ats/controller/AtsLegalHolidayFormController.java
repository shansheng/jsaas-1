
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
import com.redxun.oa.ats.entity.AtsLegalHoliday;
import com.redxun.oa.ats.manager.AtsLegalHolidayManager;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 法定节假日 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsLegalHoliday/")
public class AtsLegalHolidayFormController extends BaseFormController {

    @Resource
    private AtsLegalHolidayManager atsLegalHolidayManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsLegalHoliday")
    public AtsLegalHoliday processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsLegalHoliday atsLegalHoliday = null;
        if (StringUtils.isNotEmpty(id)) {
            atsLegalHoliday = atsLegalHolidayManager.get(id);
        } else {
            atsLegalHoliday = new AtsLegalHoliday();
        }

        return atsLegalHoliday;
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
    @LogEnt(action = "save", module = "oa", submodule = "法定节假日")
    public JsonResult save(HttpServletRequest request, @RequestBody @Valid JSONObject json, BindingResult result) {

    	AtsLegalHoliday atsLegalHoliday = JSON.toJavaObject(json, AtsLegalHoliday.class);
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsLegalHoliday.getId())) {
            atsLegalHoliday.setId(IdUtil.getId());
            atsLegalHolidayManager.save(atsLegalHoliday);
            msg = getMessage("atsLegalHoliday.created", new Object[]{atsLegalHoliday.getIdentifyLabel()}, "[法定节假日]成功创建!");
        } else {
            atsLegalHolidayManager.updateLegalHoliday(atsLegalHoliday);
            msg = getMessage("atsLegalHoliday.updated", new Object[]{atsLegalHoliday.getIdentifyLabel()}, "[法定节假日]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
   
}

