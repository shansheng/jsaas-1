
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
import com.redxun.oa.ats.entity.AtsAttenceCycle;
import com.redxun.oa.ats.manager.AtsAttenceCycleManager;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 考勤周期 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceCycle/")
public class AtsAttenceCycleFormController extends BaseFormController {

    @Resource
    private AtsAttenceCycleManager atsAttenceCycleManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttenceCycle")
    public AtsAttenceCycle processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttenceCycle atsAttenceCycle = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttenceCycle = atsAttenceCycleManager.get(id);
        } else {
            atsAttenceCycle = new AtsAttenceCycle();
        }

        return atsAttenceCycle;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤周期")
    public JsonResult save(HttpServletRequest request, @RequestBody @Valid JSONObject json, BindingResult result) {

    	AtsAttenceCycle atsAttenceCycle=JSON.toJavaObject(json, AtsAttenceCycle.class);
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsAttenceCycle.getId())) {
            atsAttenceCycle.setId(IdUtil.getId());
            atsAttenceCycleManager.save(atsAttenceCycle);
            msg = getMessage("atsAttenceCycle.created", new Object[]{atsAttenceCycle.getIdentifyLabel()}, "[考勤周期]成功创建!");
        } else {
        	atsAttenceCycle.setStartMonth(atsAttenceCycle.getMonth().shortValue());
            atsAttenceCycleManager.updateAttenceCycle(atsAttenceCycle);
            msg = getMessage("atsAttenceCycle.updated", new Object[]{atsAttenceCycle.getIdentifyLabel()}, "[考勤周期]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

