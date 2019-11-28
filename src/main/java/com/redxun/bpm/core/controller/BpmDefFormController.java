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

import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;

/**
 * 流程定义管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmDef/")
public class BpmDefFormController extends BaseFormController {

    @Resource
    private BpmDefManager bpmDefManager;
    @Resource
    private BpmSolutionManager bpmSolutionManager;
   
    
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmDef")
    public BpmDef processForm(HttpServletRequest request) {
        String defId = request.getParameter("defId");
        BpmDef bpmDef = null;
        if (StringUtils.isNotEmpty(defId)) {
            bpmDef = bpmDefManager.get(defId);
        } else {
            bpmDef = new BpmDef();
            bpmDef.setVersion(1);
            bpmDef.setStatus(BpmDef.STATUS_INIT);
        }

        return bpmDef;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmDef
     * @param result
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程定义")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmDef") @Valid BpmDef bpmDef, BindingResult result) throws Exception{

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String tenantId=ContextUtil.getCurrentTenantId();
        bpmDef.setTenantId(tenantId);
        
        String treeId=request.getParameter("treeId");
        String solId=request.getParameter("solId");
        if(StringUtils.isNotEmpty(treeId)){
        	bpmDef.setTreeId(treeId);
        }
        if(StringUtils.isNotEmpty(solId)) {
        	BpmSolution solution = bpmSolutionManager.get(solId);
        	bpmDef.setKey(solution.getKey());
        	bpmDef.setSubject(solution.getName());
        }
        
        String msg = null;
        if (StringUtils.isEmpty(bpmDef.getDefId())) {
        	JsonResult rtn= bpmDefManager.getCanSave(bpmDef);
            if(!rtn.isSuccess()) return rtn;
            bpmDef.setDefId(idGenerator.getSID());
            bpmDef.setMainDefId(idGenerator.getSID());
            bpmDef.setIsMain(MBoolean.YES.toString());
            //创建ModelId
            bpmDefManager.add(bpmDef);
            msg = getMessage("bpmDef.created", new Object[]{bpmDef.getIdentifyLabel()}, "流程定义成功创建!");
        } else {
            bpmDefManager.upd(bpmDef);
            msg = getMessage("bpmDef.updated", new Object[]{bpmDef.getIdentifyLabel()}, "流程定义成功更新!");
        }
        return new JsonResult(true, msg,bpmDef);
    }
}

