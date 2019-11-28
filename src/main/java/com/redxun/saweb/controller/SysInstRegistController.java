package com.redxun.saweb.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.constants.MStatus;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;

/**
 * 
 * @author mansan
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/")
public class SysInstRegistController extends BaseFormController{
	@Resource
	SysInstManager sysInstManager;
	
    /**
     * 注册企业
     * @param request
     * @param sysInst
     * @param result
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult register(HttpServletRequest request,@RequestBody SysInst sysInst, BindingResult result) {
    	//检查验证码
    	String code = (String)request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
    	//String validCode=request.getParameter("validCode");
    	if(code==null || !code.equals(sysInst.getValidCode())){
    		result.rejectValue(null, "valid.code.error","验证码不正确！");
    	}
    	if (result.hasErrors()) {
            return new JsonResult(false, result.getGlobalError().getDefaultMessage());
        }
       
    	sysInst.setStatus(MStatus.INIT.toString());
		String instId=IdUtil.getId();
		sysInst.setInstId(instId);
		if(StringUtils.isNotEmpty(sysInst.getParentId())){
			SysInst pInst=sysInstManager.get(sysInst.getParentId());
			if(pInst!=null){
				sysInst.setPath(pInst.getPath()+ instId+".");
			}else{
				sysInst.setPath("0." + instId+".");
			}
		}else{
			sysInst.setPath("0." + instId+".");
		}
		//TODO 检查用户是否存在
		String nameEn=StringUtil.getPinYinHeadChar(sysInst.getNameCn());
		sysInst.setNameEn(nameEn);
    	sysInst.setDomain(nameEn+".com");
    	
		sysInstManager.create(sysInst);
       String  msg = getMessage("sysInst.created", new Object[]{sysInst.getIdentifyLabel()}, "成功注册企业!");
        
       return new JsonResult(true, msg,sysInst);
    }
}
