
package com.redxun.oa.ats.controller;

import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsBaseItem;
import com.redxun.oa.ats.manager.AtsBaseItemManager;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import com.redxun.saweb.util.IdUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.redxun.sys.log.LogEnt;

/**
 * 基础数据 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsBaseItem/")
public class AtsBaseItemFormController extends BaseFormController {

    @Resource
    private AtsBaseItemManager atsBaseItemManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsBaseItem")
    public AtsBaseItem processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsBaseItem atsBaseItem = null;
        if (StringUtils.isNotEmpty(id)) {
            atsBaseItem = atsBaseItemManager.get(id);
        } else {
            atsBaseItem = new AtsBaseItem();
        }

        return atsBaseItem;
    }
    /**
     * 保存实体数据
     * @param request
     * @param orders
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @LogEnt(action = "save", module = "oa", submodule = "基础数据")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsBaseItem") @Valid AtsBaseItem atsBaseItem, BindingResult result) {

        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsBaseItem.getId())) {
            atsBaseItem.setId(IdUtil.getId());
            atsBaseItem.setIsSys(atsBaseItemManager.ISNOTSYS);
            atsBaseItemManager.create(atsBaseItem);
            msg = getMessage("atsBaseItem.created", new Object[]{atsBaseItem.getIdentifyLabel()}, "[基础数据]成功创建!");
        } else {
            atsBaseItemManager.update(atsBaseItem);
            msg = getMessage("atsBaseItem.updated", new Object[]{atsBaseItem.getIdentifyLabel()}, "[基础数据]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

