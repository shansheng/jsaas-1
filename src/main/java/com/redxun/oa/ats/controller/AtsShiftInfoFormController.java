
package com.redxun.oa.ats.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.oa.ats.manager.AtsShiftInfoManager;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.LogEnt;

/**
 * 班次设置 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsShiftInfo/")
public class AtsShiftInfoFormController extends BaseFormController {

    @Resource
    private AtsShiftInfoManager atsShiftInfoManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsShiftInfo")
    public AtsShiftInfo processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsShiftInfo atsShiftInfo = null;
        if (StringUtils.isNotEmpty(id)) {
            atsShiftInfo = atsShiftInfoManager.get(id);
        } else {
            atsShiftInfo = new AtsShiftInfo();
        }

        return atsShiftInfo;
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
    @LogEnt(action = "save", module = "oa", submodule = "班次设置")
    public JsonResult save(HttpServletRequest request, @RequestBody @Valid JSONObject json, BindingResult result) throws Exception{
    	
    	AtsShiftInfo atsShiftInfo = JSON.toJavaObject(json, AtsShiftInfo.class);
    	
    	if(BeanUtil.isEmpty(atsShiftInfo.getIsDefault())){
    		atsShiftInfo.setIsDefault((short)0);
    	}
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        
        AtsShiftInfo temp = atsShiftInfoManager.getByShiftName(atsShiftInfo.getName());
    	if(BeanUtil.isNotEmpty(temp) && !atsShiftInfo.getPkId().equals(temp.getPkId())) {
    		return new JsonResult(false, "班次名称重复！");
    	}
        String msg = null;
        if (StringUtils.isEmpty(atsShiftInfo.getId())) {
        	atsShiftInfo.setId(IdUtil.getId());
            atsShiftInfoManager.save(atsShiftInfo);
            msg = getMessage("atsShiftInfo.created", new Object[]{atsShiftInfo.getIdentifyLabel()}, "[班次设置]成功创建!");
        } else {
            atsShiftInfoManager.updateShiftInfo(atsShiftInfo);
            msg = getMessage("atsShiftInfo.updated", new Object[]{atsShiftInfo.getIdentifyLabel()}, "[班次设置]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

