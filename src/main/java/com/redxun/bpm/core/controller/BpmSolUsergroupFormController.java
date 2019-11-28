package com.redxun.bpm.core.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.bpm.core.manager.BpmSolUsergroupManager;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmSolUsergroup]管理
 * @author csx
 */
@Controller
@RequestMapping("/bpm/core/bpmSolUsergroup/")
public class BpmSolUsergroupFormController extends BaseFormController {

    @Resource
    private BpmSolUsergroupManager bpmSolUsergroupManager;
    
  
   
    /**
     * 保存实体数据
     * @param request
     * @param bpmSolUsergroup
     * @param result
     * @return
     * @throws IOException 
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "流程", submodule = "方案用户组配置")
    public JsonResult save(HttpServletRequest request,@RequestBody  BpmSolUsergroup bpmSolUsergroup) throws IOException {

        String msg = null;
        if (StringUtils.isEmpty(bpmSolUsergroup.getId())) {
            bpmSolUsergroup.setId(idGenerator.getSID());
            bpmSolUsergroupManager.create(bpmSolUsergroup);
            msg = getMessage("bpmSolUsergroup.created", new Object[]{bpmSolUsergroup.getGroupName()}, "用户组成功创建!");
        } else {
            bpmSolUsergroupManager.update(bpmSolUsergroup);
            msg = getMessage("bpmSolUsergroup.updated", new Object[]{bpmSolUsergroup.getGroupName()}, "用户组成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

