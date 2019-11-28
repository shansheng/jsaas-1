package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmRuPath;
import com.redxun.bpm.core.manager.BpmRuPathManager;

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
 * [BpmRuPath]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmRuPath/")
public class BpmRuPathFormController extends BaseFormController {

    @Resource
    private BpmRuPathManager bpmRuPathManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmRuPath")
    public BpmRuPath processForm(HttpServletRequest request) {
        String pathId = request.getParameter("pathId");
        BpmRuPath bpmRuPath = null;
        if (StringUtils.isNotEmpty(pathId)) {
            bpmRuPath = bpmRuPathManager.get(pathId);
        } else {
            bpmRuPath = new BpmRuPath();
        }

        return bpmRuPath;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmRuPath
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程实例运行路线")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmRuPath") @Valid BpmRuPath bpmRuPath, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmRuPath.getPathId())) {
            bpmRuPath.setPathId(idGenerator.getSID());
            bpmRuPathManager.create(bpmRuPath);
            msg = getMessage("bpmRuPath.created", new Object[]{bpmRuPath.getIdentifyLabel()}, "[BpmRuPath]成功创建!");
        } else {
            bpmRuPathManager.update(bpmRuPath);
            msg = getMessage("bpmRuPath.updated", new Object[]{bpmRuPath.getIdentifyLabel()}, "[BpmRuPath]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

