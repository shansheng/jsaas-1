package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmInstRead;
import com.redxun.bpm.core.manager.BpmInstReadManager;

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
 * [BpmInstRead]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstRead/")
public class BpmInstReadFormController extends BaseFormController {

    @Resource
    private BpmInstReadManager bpmInstReadManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmInstRead")
    public BpmInstRead processForm(HttpServletRequest request) {
        String readId = request.getParameter("readId");
        BpmInstRead bpmInstRead = null;
        if (StringUtils.isNotEmpty(readId)) {
            bpmInstRead = bpmInstReadManager.get(readId);
        } else {
            bpmInstRead = new BpmInstRead();
        }

        return bpmInstRead;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmInstRead
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程阅读记录")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmInstRead") @Valid BpmInstRead bpmInstRead, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmInstRead.getReadId())) {
            bpmInstRead.setReadId(idGenerator.getSID());
            bpmInstReadManager.create(bpmInstRead);
            msg = getMessage("bpmInstRead.created", new Object[]{bpmInstRead.getIdentifyLabel()}, "[BpmInstRead]成功创建!");
        } else {
            bpmInstReadManager.update(bpmInstRead);
            msg = getMessage("bpmInstRead.updated", new Object[]{bpmInstRead.getIdentifyLabel()}, "[BpmInstRead]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

