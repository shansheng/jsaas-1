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

import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.core.entity.SysTree;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.log.LogEnt;

/**
 * 业务流程解决方案管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmSolution/")
public class BpmSolutionFormController extends BaseFormController {

    @Resource
    private BpmSolutionManager bpmSolutionManager;
    @Resource
    private SysTreeManager sysTreeManager;
  
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmSolution")
    public BpmSolution processForm(HttpServletRequest request) {
        String solId = request.getParameter("solId");
        BpmSolution bpmSolution = null;
        if (StringUtils.isNotEmpty(solId)) {
            bpmSolution = bpmSolutionManager.get(solId);
        } else {
            bpmSolution = new BpmSolution();
            bpmSolution.setStep(0);
            bpmSolution.setStatus(BpmSolution.STATUS_CREATED);
        }

        return bpmSolution;
    }
    
    
    
    /**
     * 保存实体数据
     * @param request
     * @param bpmSolution
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "流程解决方案",params="solId")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmSolution") @Valid BpmSolution bpmSolution, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        /**
         * 检查别名
         */
        JsonResult rtn=bpmSolutionManager.getCanSave(bpmSolution);
        if(!rtn.isSuccess()) return rtn;
        
        
      //设置其分类
        String treeId=request.getParameter("treeId");
        if(StringUtils.isNotEmpty(treeId)){
        	SysTree sysTree=sysTreeManager.get(treeId);
        	bpmSolution.setTreeId(treeId);
        	bpmSolution.setTreePath(sysTree.getPath());
        }
		String isUseBmodel=request.getParameter("isUseBmodel");
		if(StringUtils.isEmpty(isUseBmodel)){
			bpmSolution.setIsUseBmodel(MBoolean.NO.toString());
		}
        String msg = null;
        if (StringUtils.isEmpty(bpmSolution.getSolId())) {
            bpmSolution.setSolId(idGenerator.getSID());
            bpmSolutionManager.create(bpmSolution);
            msg = getMessage("bpmSolution.created", new Object[]{bpmSolution.getIdentifyLabel()}, "业务流程解决方案成功创建!");
        } else {
            bpmSolutionManager.update(bpmSolution);
            msg = getMessage("bpmSolution.updated", new Object[]{bpmSolution.getIdentifyLabel()}, "业务流程解决方案成功更新!");
        }
        return new JsonResult(true, msg,bpmSolution);
    }
}

