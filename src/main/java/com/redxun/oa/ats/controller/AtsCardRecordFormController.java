
package com.redxun.oa.ats.controller;

import java.util.Date;

import com.redxun.core.json.JsonResult;
import com.redxun.core.util.DateUtil;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsCardRecord;
import com.redxun.oa.ats.manager.AtsCardRecordManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
 * 打卡记录 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsCardRecord/")
public class AtsCardRecordFormController extends BaseFormController {

    @Resource
    private AtsCardRecordManager atsCardRecordManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsCardRecord")
    public AtsCardRecord processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsCardRecord atsCardRecord = null;
        if (StringUtils.isNotEmpty(id)) {
            atsCardRecord = atsCardRecordManager.get(id);
        } else {
            atsCardRecord = new AtsCardRecord();
        }

        return atsCardRecord;
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
    @LogEnt(action = "save", module = "oa", submodule = "打卡记录")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsCardRecord") @Valid AtsCardRecord atsCardRecord, String cardDate, BindingResult result) {
    	//设置打卡时间
    	Date date = DateUtil.parseDate(cardDate, "yyyy-MM-dd HH:mm:ss");
    	atsCardRecord.setCardDate(date);
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        if (StringUtils.isEmpty(atsCardRecord.getId())) {
            atsCardRecord.setId(IdUtil.getId());
            atsCardRecordManager.create(atsCardRecord);
            msg = getMessage("atsCardRecord.created", new Object[]{atsCardRecord.getIdentifyLabel()}, "[打卡记录]成功创建!");
        } else {
            atsCardRecordManager.update(atsCardRecord);
            msg = getMessage("atsCardRecord.updated", new Object[]{atsCardRecord.getIdentifyLabel()}, "[打卡记录]成功更新!");
        }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
    @RequestMapping(value = "deleteTest", method = RequestMethod.DELETE)
    @ResponseBody
    public JsonResult deleteTest(HttpServletRequest request,HttpServletResponse response) {
    	String test = request.getParameter("test");
    	
    	return new JsonResult<>(true, "测试DELETE成功,test:"+test);
    }
        
}

