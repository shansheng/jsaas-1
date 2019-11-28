package com.redxun.restApi.sys.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.redxun.core.cache.CacheUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.entity.Subsystem;
import com.redxun.sys.core.manager.SubsystemManager;

@RestController
@RequestMapping("/restApi/token")
public class TokenController {
	
	@Resource
	SubsystemManager subsystemManager;
	
	
	/**
	 * 生成token。
	 * @param appId	应用ID
	 * @param secret	密钥
	 * @return
	 */
	@RequestMapping(value = "genToken",method={RequestMethod.POST})
	public JsonResult<String> getToken(@RequestParam(value="appId") String appId,
			@RequestParam(value="secret") String secret){
		if(StringUtil.isEmpty(appId) || StringUtil.isEmpty(secret) ){
			return new JsonResult<>(false,"APPID和密钥不能为空");
		}
		
		JsonResult<String> rtn=new JsonResult<>(true);
		
		Subsystem subsystem= subsystemManager.get(appId);
		if(subsystem==null){
			return  new JsonResult<>(false,"应用不存在");
		}
		if(subsystem.getSecret().equals(secret)){
			String token=subsystemManager.genSecret();
			rtn.setData(token);
			String key=AppTokenUtil.getTokenKey(token);
			CacheUtil.addCache(key, appId, 7200);
		}
		else{
			rtn.setMessage("输入的APPID或密钥不对");
		}
		
		return rtn;
	}
	
	
}
