
package com.redxun.oa.ats.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.controller.BaseFormController;
import com.redxun.oa.ats.entity.AtsAttenceCalculateSet;
import com.redxun.oa.ats.manager.AtsAttenceCalculateSetManager;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.redxun.saweb.util.IdUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.sys.log.LogEnt;

/**
 * 考勤计算设置 管理
 * @author mansan
 */
@Controller
@RequestMapping("/oa/ats/atsAttenceCalculateSet/")
public class AtsAttenceCalculateSetFormController extends BaseFormController {

    @Resource
    private AtsAttenceCalculateSetManager atsAttenceCalculateSetManager;
    /**
     * 处理表单
     * @param request
     * @return
     */
    @ModelAttribute("atsAttenceCalculateSet")
    public AtsAttenceCalculateSet processForm(HttpServletRequest request) {
        String id = request.getParameter("id");
        AtsAttenceCalculateSet atsAttenceCalculateSet = null;
        if (StringUtils.isNotEmpty(id)) {
            atsAttenceCalculateSet = atsAttenceCalculateSetManager.get(id);
        } else {
            atsAttenceCalculateSet = new AtsAttenceCalculateSet();
        }

        return atsAttenceCalculateSet;
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
    @LogEnt(action = "save", module = "oa", submodule = "考勤计算设置")
    public JsonResult save(HttpServletRequest request, @RequestBody @Valid JSONObject json, BindingResult result) {

    	AtsAttenceCalculateSet atsAttenceCalculateSet = new AtsAttenceCalculateSet();
    	String type = json.getString("type");
    	String summary = json.getString("summary");
    	String detail = json.getString("detail");
    	
    	atsAttenceCalculateSet.setType(Short.parseShort(type));
    	atsAttenceCalculateSet.setSummary(toLabel(summary));
    	atsAttenceCalculateSet.setDetail(toLabel(detail));
    	
        if (result.hasFieldErrors()) {
            return new JsonResult(false, getErrorMsg(result));
        }
        String msg = null;
        String msgKey = atsAttenceCalculateSetManager.save(atsAttenceCalculateSet);
         if("created".equals(msgKey)){
         	msg = getMessage("atsAttenceCalculateSet.created", new Object[]{atsAttenceCalculateSet.getIdentifyLabel()}, "[考勤计算设置]成功创建!");
         }else if("updated".equals(msgKey)){
         	msg = getMessage("atsAttenceCalculateSet.updated", new Object[]{atsAttenceCalculateSet.getIdentifyLabel()}, "[考勤计算设置]成功更新!");
         }
        //saveOpMessage(request, msg);
        return new JsonResult(true, msg);
    }
    
    private String toLabel(String str) {
    	if(str==null) {
    		return null;
    	}
    	StringBuffer temp = new StringBuffer();
    	temp.append("[");
    	net.sf.json.JSONArray array = net.sf.json.JSONArray.fromObject(str);
    	for (Object object : array) {
			net.sf.json.JSONObject o = (net.sf.json.JSONObject)object;
			String name = (String) o.get("name");
			String lable = (String) o.get("lable");
			temp.append("{");
			temp.append("name:'"+name+"'").append(",lable:'"+lable+"'");
			temp.append("},");
		}
    	temp.deleteCharAt(temp.length()-1);
    	temp.append("]");
    	return temp.toString();
    }
}

