package com.redxun.bpm.form.controller;

import java.util.Date;

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

import com.redxun.bpm.form.entity.BpmMobileForm;
import com.redxun.bpm.form.manager.BpmMobileFormManager;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmMobileForm]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmMobileForm/")
public class BpmMobileFormFormController extends BaseFormController {

    @Resource
    private BpmMobileFormManager bpmMobileFormManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmMobileForm")
    public BpmMobileForm processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmMobileForm bpmMobileForm = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmMobileForm = bpmMobileFormManager.get(id);
        } else {
            bpmMobileForm = new BpmMobileForm();
        }

        return bpmMobileForm;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmMobileForm
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "手机业务表单视图")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmMobileForm") @Valid BpmMobileForm bpmMobileForm, BindingResult result) {
    	if(bpmMobileFormManager.isAliasExist(bpmMobileForm)){
    		return new JsonResult(false, "指定别名的表单已存在,请修改别名!");
    	}
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        bpmMobileForm.setFormHtml(bpmMobileForm.getFormHtml().replace("&nbsp;", ""));
        
        
        String msg = null;
        if (StringUtils.isEmpty(bpmMobileForm.getId())) {
            bpmMobileForm.setId(IdUtil.getId());
            bpmMobileForm.setUpdateTime(new Date());
            bpmMobileFormManager.create(bpmMobileForm);
            msg = getMessage("bpmMobileForm.created", new Object[]{bpmMobileForm.getName()}, "成功创建!");
        } else {
            bpmMobileFormManager.update(bpmMobileForm);
            msg = getMessage("bpmMobileForm.updated", new Object[]{bpmMobileForm.getName()}, "成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

