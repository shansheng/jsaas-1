package com.redxun.bpm.form.controller;

import java.io.IOException;

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

import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.manager.SysTreeManager;
import com.redxun.sys.core.util.JsaasUtil;
import com.redxun.sys.log.LogEnt;

import freemarker.template.TemplateException;

/**
 * 业务表单视图管理
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/form/bpmFormView/")
public class BpmFormViewFormController extends BaseFormController {

    @Resource
    private BpmFormViewManager bpmFormViewManager;
    @Resource
    private SysTreeManager sysTreeManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmFormView")
    public BpmFormView processForm(HttpServletRequest request) {
        String viewId = request.getParameter("viewId");
        BpmFormView bpmFormView = null;
        if (StringUtils.isNotEmpty(viewId)) {
            bpmFormView = bpmFormViewManager.get(viewId);
        } else {
            bpmFormView = new BpmFormView();
            bpmFormView.setVersion(1);
            bpmFormView.setIsMain(MBoolean.YES.toString());
            bpmFormView.setStatus(BpmFormView.STATUS_INIT);
        }
        
        String isBindMd=request.getParameter("isBindMd");
        if(StringUtils.isEmpty(isBindMd)){
        	bpmFormView.setIsBindMd(MBoolean.NO.name());
        }
        return bpmFormView;
    }
    /**
     * 保存实体数据
     * @param request
     * @param bpmFormView
     * @param result
     * @return
     * @throws TemplateException 
     * @throws IOException 
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "业务表单视图")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmFormView") @Valid BpmFormView bpmFormView, BindingResult result) throws IOException, TemplateException {
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        boolean rtn=bpmFormViewManager.isAliasExist(bpmFormView);
        if(rtn){
        	return new JsonResult(false, "表单key重复!");
        }
        
        
        String msg = null;
        String deploy=request.getParameter("deploy");
        if("true".equals(deploy)){
        	bpmFormView.setStatus(BpmFormView.STATUS_DEPLOYED);
        }
        String deployNew=request.getParameter("deployNew");
        //设置其分类
        String treeId=request.getParameter("treeId");
        if(StringUtils.isNotEmpty(treeId)){
        	bpmFormView.setTreeId(treeId);
        }
        String template=JsaasUtil.convertToFreemakTemplate(bpmFormView.getTemplateView());

        bpmFormView.setTemplate(template);
        
        if (StringUtils.isEmpty(bpmFormView.getViewId())) {
        	String id=IdUtil.getId();
            bpmFormView.setViewId(id);
            bpmFormViewManager.create(bpmFormView);
            msg = getMessage("bpmFormView.created", new Object[]{bpmFormView.getIdentifyLabel()}, "业务表单视图成功创建!");
        } else {
            if("true".equals(deployNew)){
            	bpmFormViewManager.doDeployNewVersion(bpmFormView);
            	msg=getMessage("bpmFormView.deploy",new Object[]{},"成功发布业务表单视图！");
            }else{
            	bpmFormViewManager.update(bpmFormView);
            	msg = getMessage("bpmFormView.updated", new Object[]{bpmFormView.getIdentifyLabel()}, "业务表单视图成功更新!");
            }
        }
        return new JsonResult(true, msg,bpmFormView);
    }
}

