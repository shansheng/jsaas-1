package com.redxun.bpm.core.controller;

import java.util.Collection;
import java.util.Iterator;

import com.redxun.core.json.JsonResult;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;
import com.redxun.bpm.core.entity.BpmAgent;
import com.redxun.bpm.core.entity.BpmAgentSol;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmAgentManager;
import com.redxun.bpm.core.manager.BpmAgentSolManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 流程代理设置管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmAgent/")
public class BpmAgentFormController extends BaseFormController {

    @Resource
    private BpmAgentManager bpmAgentManager;
    @Resource
    private BpmAgentSolManager bpmAgentSolManager;
    @Resource
    private BpmSolutionManager bpmSolutionManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("bpmAgent")
    public BpmAgent processForm(HttpServletRequest request) {
        String agentId = request.getParameter("agentId");
        BpmAgent bpmAgent = null;
        if (StringUtils.isNotEmpty(agentId)) {
            bpmAgent = bpmAgentManager.get(agentId);
        } else {
            bpmAgent = new BpmAgent();
            bpmAgent.setAgentUserId(ContextUtil.getCurrentUserId());
        }
        return bpmAgent;
    }
    
    
    /**
     * 保存实体数据
     * @param request
     * @param bpmAgent
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "方案代理")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("bpmAgent") @Valid BpmAgent bpmAgent, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        
        String sols=request.getParameter("sols");
        if(BpmAgent.TYPE_PART.equals(bpmAgent.getType())){
        	
        	JSONArray solArr=JSONArray.fromObject(sols);
        	Collection<BpmAgentSol> basCols=JSONArray.toCollection(solArr, BpmAgentSol.class);
        	bpmAgent.setBpmAgentSols(basCols);
        	
        }
        
        String msg = null;
        if (StringUtils.isEmpty(bpmAgent.getAgentId())) {
            bpmAgent.setAgentId(IdUtil.getId());
            bpmAgentManager.create(bpmAgent);
            msg = getMessage("bpmAgent.created", new Object[]{bpmAgent.getIdentifyLabel()}, "流程代理设置成功创建!");
        } else {
            bpmAgentManager.update(bpmAgent);
            msg = getMessage("bpmAgent.updated", new Object[]{bpmAgent.getIdentifyLabel()}, "流程代理设置成功更新!");
        }
        return new JsonResult(true, msg);
    }
}

