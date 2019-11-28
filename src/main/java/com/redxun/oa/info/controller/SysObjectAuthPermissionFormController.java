
package com.redxun.oa.info.controller;

import java.util.Iterator;
import java.util.Set;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmAuthRights;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.info.entity.SysObjectAuthPermission;
import com.redxun.oa.info.manager.SysObjectAuthPermissionManager;

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
 * 系统对象授权表 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/info/sysObjectAuthPermission/")
public class SysObjectAuthPermissionFormController extends BaseFormController {

    @Resource
    private SysObjectAuthPermissionManager sysObjectAuthPermissionManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("sysObjectAuthPermission")
    public SysObjectAuthPermission processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        SysObjectAuthPermission sysObjectAuthPermission = null;
        if (StringUtils.isNotEmpty(id)) {
            sysObjectAuthPermission = sysObjectAuthPermissionManager.get(id);
        } else {
            sysObjectAuthPermission = new SysObjectAuthPermission();
        }

        return sysObjectAuthPermission;
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
    @LogEnt(action = "save", module = "oa", submodule = "系统对象授权表")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("sysObjectAuthPermission") @Valid SysObjectAuthPermission sysObjectAuthPermission, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(sysObjectAuthPermission.getId())) {
            sysObjectAuthPermission.setId(IdUtil.getId());
            sysObjectAuthPermissionManager.create(sysObjectAuthPermission);
            msg = getMessage("sysObjectAuthPermission.created", new Object[]{sysObjectAuthPermission.getIdentifyLabel()}, "[系统对象授权表]成功创建!");
        } else {
            sysObjectAuthPermissionManager.update(sysObjectAuthPermission);
            msg = getMessage("sysObjectAuthPermission.updated", new Object[]{sysObjectAuthPermission.getIdentifyLabel()}, "[系统对象授权表]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    

}

