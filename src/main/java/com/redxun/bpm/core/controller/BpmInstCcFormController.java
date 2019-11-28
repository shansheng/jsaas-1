package com.redxun.bpm.core.controller;

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

import com.redxun.bpm.core.entity.BpmInstCc;
import com.redxun.bpm.core.entity.BpmInstCp;
import com.redxun.bpm.core.manager.BpmInstCcManager;
import com.redxun.bpm.core.manager.BpmInstCpManager;
import com.redxun.bpm.core.manager.BpmInstManager;
import com.redxun.core.json.JsonResult;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmInstCc]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmInstCc/")
public class BpmInstCcFormController extends BaseFormController {

    @Resource
    private BpmInstCcManager bpmInstCcManager;
    @Resource
    private BpmInstManager bpmInstManager;
    @Resource
    private BpmInstCpManager bpmInstCpManager;
    
    @Resource
    private UserService userService;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmInstCc")
    public BpmInstCc processForm(HttpServletRequest request) {
        String ccId = request.getParameter("ccId");
        BpmInstCc bpmInstCc = null;
        if (StringUtils.isNotEmpty(ccId)) {
            bpmInstCc = bpmInstCcManager.get(ccId);
        } else {
            bpmInstCc = new BpmInstCc();
        }

        return bpmInstCc;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmInstCc
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程抄送")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmInstCc") @Valid BpmInstCc bpmInstCc, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(bpmInstCc.getCcId())) {
        	String bpmInstId=request.getParameter("bpmInstId");
        	String nodeName=request.getParameter("nodeName2");
        	String subject=request.getParameter("subject");
            bpmInstCc.setCcId(idGenerator.getSID());
            bpmInstCc.setInstId(bpmInstId);
            bpmInstCc.setCreateBy(ContextUtil.getCurrentUserId());
            bpmInstCc.setCreateTime(new Date());
            bpmInstCc.setNodeName(nodeName);
            bpmInstCc.setFromUserId(ContextUtil.getCurrentUserId());
            bpmInstCc.setTenantId(ContextUtil.getCurrentTenantId());
            IUser osUser=userService.getByUserId(ContextUtil.getCurrentUserId());
            bpmInstCcManager.create(bpmInstCc);
           String ccuser= request.getParameter("ccUser");
            String[] ccUsers=ccuser.split(",");
           String ctxPath=request.getContextPath();
            
            for (String userId : ccUsers) {
				BpmInstCp bpmInstCp=new BpmInstCp();
				bpmInstCp.setCcId(bpmInstCc.getCcId());
				bpmInstCp.setCreateBy(ContextUtil.getCurrentUserId());
				bpmInstCp.setCreateTime(new Date());
				bpmInstCp.setIsRead("NO");
				bpmInstCp.setUserId(userId);
				bpmInstCp.setId(idGenerator.getSID());
				
				bpmInstCpManager.create(bpmInstCp);
			}
            msg = getMessage("bpmInstCc.created", new Object[]{bpmInstCc.getIdentifyLabel()}, "[BpmInstCc]成功创建!");
        } else {
            bpmInstCcManager.update(bpmInstCc);
            msg = getMessage("bpmInstCc.updated", new Object[]{bpmInstCc.getIdentifyLabel()}, "[BpmInstCc]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

