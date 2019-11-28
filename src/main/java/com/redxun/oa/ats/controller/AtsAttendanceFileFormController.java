
package com.redxun.oa.ats.controller;

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

import com.redxun.core.json.JsonResult;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.entity.AtsAttendanceFile;
import com.redxun.oa.ats.manager.AtsAttendanceFileManager;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.sys.log.LogEnt;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 考勤档案 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttendanceFile/")
public class AtsAttendanceFileFormController extends BaseFormController {

    @Resource
    private AtsAttendanceFileManager atsAttendanceFileManager;
    @Resource
    private OsUserManager osUserManager;
    
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttendanceFile")
    public AtsAttendanceFile processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttendanceFile atsAttendanceFile = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttendanceFile = atsAttendanceFileManager.get(id);
        } else {
            atsAttendanceFile = new AtsAttendanceFile();
        }

        return atsAttendanceFile;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤档案")
    public JsonResult save(HttpServletRequest request, @ModelAttribute("atsAttendanceFile") @Valid AtsAttendanceFile atsAttendanceFile, String userIds, BindingResult result) {
    	if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        
        if(userIds!=null) {
    		String[] userId = userIds.split(",");
    		String[] cardNumber = new String[userId.length];
    		String cardNumbers = atsAttendanceFile.getCardNumber();
        	if(BeanUtil.isNotEmpty(cardNumbers)){
        		cardNumber = cardNumbers.split(",");
        	}else {
        		for (int j = 0; j < userId.length; j++) {
            		OsUser user = osUserManager.get(userId[j]);
            		cardNumber[j] = user.getUserNo();
    			}
        	}
        	if (StringUtils.isEmpty(atsAttendanceFile.getId())) {
                atsAttendanceFileManager.save(atsAttendanceFile,userId,cardNumber);
                msg = getMessage("atsAttendanceFile.created", new Object[]{atsAttendanceFile.getIdentifyLabel()}, "[考勤档案]成功创建!");
            } else {
                atsAttendanceFileManager.updateFile(atsAttendanceFile,userId,cardNumber);
                msg = getMessage("atsAttendanceFile.updated", new Object[]{atsAttendanceFile.getIdentifyLabel()}, "[考勤档案]成功更新!");
            }
        } else {
        	if (StringUtils.isEmpty(atsAttendanceFile.getId())) {
                atsAttendanceFileManager.create(atsAttendanceFile);
                msg = getMessage("atsAttendanceFile.created", new Object[]{atsAttendanceFile.getIdentifyLabel()}, "[考勤档案]成功创建!");
            } else {
                atsAttendanceFileManager.update(atsAttendanceFile);
                msg = getMessage("atsAttendanceFile.updated", new Object[]{atsAttendanceFile.getIdentifyLabel()}, "[考勤档案]成功更新!");
            }
        }
        
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
}

