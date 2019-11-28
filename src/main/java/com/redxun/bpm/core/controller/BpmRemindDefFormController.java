package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmRemindDef;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmRemindDefManager;

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
 * [BpmRemindDef]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmRemindDef/")
public class BpmRemindDefFormController extends BaseFormController {

    @Resource
    private BpmRemindDefManager bpmRemindDefManager;
    @Resource
    private BpmSolutionDao bpmSolutionDao;
    
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmRemindDef")
    public BpmRemindDef processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        BpmRemindDef bpmRemindDef = null;
        if (StringUtils.isNotEmpty(id)) {
            bpmRemindDef = bpmRemindDefManager.get(id);
        } else {
            bpmRemindDef = new BpmRemindDef();
        }

        return bpmRemindDef;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmRemindDef
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "催办定义")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmRemindDef") @Valid BpmRemindDef bpmRemindDef, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmRemindDef.getId())) {
            bpmRemindDef.setId(idGenerator.getSID());
            BpmSolution bpmSolution= bpmSolutionDao.get(bpmRemindDef.getSolId());
            bpmRemindDef.setActDefId(bpmSolution.getActDefId());
            bpmRemindDef.setSolutionName(bpmSolution.getName());
            bpmRemindDefManager.create(bpmRemindDef);
            msg = getMessage("bpmRemindDef.created", new Object[]{bpmRemindDef.getName()}, "成功创建!");
        } else {
            bpmRemindDefManager.update(bpmRemindDef);
            msg = getMessage("bpmRemindDef.updated", new Object[]{bpmRemindDef.getName()}, "成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

