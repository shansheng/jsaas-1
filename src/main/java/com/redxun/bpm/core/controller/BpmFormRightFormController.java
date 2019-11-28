
package com.redxun.bpm.core.controller;

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

import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 表单权限 管理
 * @author ray
 */
@Controller
@RequestMapping("/bpm/core/bpmFormRight/")
public class BpmFormRightFormController extends BaseFormController {

    @Resource
    private BpmFormRightManager bpmFormRightManager;
    @Resource
    private BpmFormViewManager bpmFormViewManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmFormRight")
    public BpmFormRight processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmFormRight bpmFormRight = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmFormRight = bpmFormRightManager.get(id);
        } else {
            bpmFormRight = new BpmFormRight();
        }

        return bpmFormRight;
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
    @LogEnt(action = "save", module = "bpm", submodule = "表单权限")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmFormRight") @Valid BpmFormRight bpmFormRight, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        bpmFormRightManager.delBySolForm(bpmFormRight);
    	
        bpmFormRight.setId(IdUtil.getId());
        
        String tenantId=ContextUtil.getCurrentTenantId();
        
        BpmFormView formView= bpmFormViewManager.getLatestByKey(bpmFormRight.getFormAlias(), tenantId);
        
        bpmFormRight.setBoDefId(formView.getBoDefId());
        
        
        bpmFormRightManager.create(bpmFormRight);
        
        String msg = getMessage("bpmFormRight.created", new Object[]{bpmFormRight.getIdentifyLabel()}, "[表单权限]保存成功!");
        
        
        JsonResult json= new JsonResult(true, msg);
        json.setData(bpmFormRight.getId());
        return json;
    }
}

