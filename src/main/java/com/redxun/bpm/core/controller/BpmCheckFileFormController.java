package com.redxun.bpm.core.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmCheckFile;
import com.redxun.bpm.core.manager.BpmCheckFileManager;

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
 * [BpmCheckFile]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmCheckFile/")
public class BpmCheckFileFormController extends BaseFormController {

    @Resource
    private BpmCheckFileManager bpmCheckFileManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmCheckFile")
    public BpmCheckFile processForm(HttpServletRequest request) {
        String fileId = request.getParameter("fileId");
        BpmCheckFile bpmCheckFile = null;
        if (StringUtils.isNotEmpty(fileId)) {
            bpmCheckFile = bpmCheckFileManager.get(fileId);
        } else {
            bpmCheckFile = new BpmCheckFile();
        }

        return bpmCheckFile;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmCheckFile
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "审批意见附件")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmCheckFile") @Valid BpmCheckFile bpmCheckFile, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmCheckFile.getFileId())) {
            bpmCheckFile.setFileId(idGenerator.getSID());
            bpmCheckFileManager.create(bpmCheckFile);
            msg = getMessage("bpmCheckFile.created", new Object[]{bpmCheckFile.getIdentifyLabel()}, "[BpmCheckFile]成功创建!");
        } else {
            bpmCheckFileManager.update(bpmCheckFile);
            msg = getMessage("bpmCheckFile.updated", new Object[]{bpmCheckFile.getIdentifyLabel()}, "[BpmCheckFile]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

