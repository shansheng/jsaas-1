package com.redxun.restApi.sys.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.redxun.core.json.JsonResult;

@RestController
@RequestMapping("/restApi/sys/token/")
public class AppTokenController {
	
	@RequestMapping(value = "testToken",method={RequestMethod.POST})
	@ResponseBody
	public JsonResult test(HttpServletRequest request) throws Exception {
		String token=request.getHeader("token");
		String appId=AppTokenUtil.getAppId(token);
		return new JsonResult<>(true, token +"," + appId);
	}

}
