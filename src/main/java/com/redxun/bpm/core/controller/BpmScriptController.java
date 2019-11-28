package com.redxun.bpm.core.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.redxun.bpm.script.config.ScriptLabel;
import com.redxun.bpm.script.config.ScriptMethod;
import com.redxun.bpm.script.config.ScriptServiceClass;
import com.redxun.bpm.script.config.ScriptServiceConfig;
import com.redxun.saweb.controller.BaseController;
import com.redxun.sys.log.LogEnt;

/**
 * 脚本服务配置类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmScript")
public class BpmScriptController extends BaseController{
	
	/**
	 * 获得脚本配置树
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getConfigTree")
	@ResponseBody
	@LogEnt(action = "del", module = "流程", submodule = "流程脚本配置")
	public List<ScriptLabel> getConfigTree(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 List<ScriptServiceClass> services=ScriptServiceConfig.getServiceClasses();
		 List<ScriptLabel> labels=new ArrayList<ScriptLabel>();
		 for(ScriptServiceClass cls:services){
			 labels.add(cls);
			 for(ScriptMethod method:cls.getMethods()){
				 labels.add(method);
			 }
		 }
		 return labels;
	}
}
