package com.redxun.sys.core.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JsonResult;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.entity.SysProperties;
import com.redxun.sys.core.manager.SysPropertiesManager;
import com.redxun.sys.core.util.OpenOfficeUtil;

@Controller
@RequestMapping("/sys/core/openoffice/")
public class OpenOfficeController {
	
	@Resource
	SysPropertiesManager sysPropertiesManager;
	

	
	@RequestMapping("getConnectStatus")
	@ResponseBody
	public JsonResult<String> getConnectStatus(HttpServletResponse response,HttpServletRequest request){
		return OpenOfficeUtil.getConnectStatus();
	}
	
	/**
	 * openOfficeConfig:
	 * {
	 * 	"installPath":"",
	 * 	"service_ip":"127.0.0.1",
	 * 	"service_port":"8001",
	 * 	"enabled":"NO"
	 * }
	 * @param request
	 * @return
	 */
	@RequestMapping("updateOfficeConfig")
	@ResponseBody
	public JsonResult<String> updateOfficeConfig(HttpServletRequest request){
		JsonResult<String> rtn=new JsonResult<>(true, "设置openoffice成功!");
		try{
			String configJson=RequestUtil.getString(request, "configJson");
			//服务处理
			JSONObject json=JSONObject.parseObject(configJson);
			String enabled=json.getString("enabled");
			if("YES".equals(enabled)){
				JsonResult result=OpenOfficeUtil.getConnectStatus();
				if(!result.getSuccess()){
					String installPath=json.getString(OpenOfficeUtil.INSTALL_PATH);
					String ip=json.getString(OpenOfficeUtil.SERVICE_IP);
					String port=json.getString(OpenOfficeUtil.SERVICE_PORT);
					JsonResult<String> tmp= OpenOfficeUtil.startService(installPath, ip, port);
					if(!tmp.getSuccess()) return tmp;
				}
			}
			
			saveProperties(configJson);
		}
		catch (Exception e) {
			rtn.setSuccess(false);
			rtn.setMessage("设置office失败!");
		}
		return rtn;
	}
	
	@RequestMapping("getOfficeConfig")
	@ResponseBody
	public JsonResult<String> getOfficeConfig(HttpServletRequest request){
		JsonResult<String> rtn=new JsonResult<>(true, "获取配置成功!");
		SysProperties properties=sysPropertiesManager.getPropertiesByName(OpenOfficeUtil.OPEN_OFFICE_CONFIG);
		String config=properties.getValue();
		JSONObject json=JSONObject.parseObject(config);
		if("YES".equals( json.getString("enabled"))){
			JsonResult result=OpenOfficeUtil.getConnectStatus();
			if(!result.getSuccess()){
				JsonResult<String> tmp= OpenOfficeUtil.startService();
				if(!tmp.getSuccess()){
					rtn.setSuccess(false);
					rtn.setMessage("启动openoffice服务失败!");
				}
			}
		}
		rtn.setData(config);
		return rtn;
	}
	
	/**
	 * 保存属性成功。
	 * @param configJson
	 */
	private void saveProperties(String configJson){
		SysProperties properties=sysPropertiesManager.getPropertiesByName(OpenOfficeUtil.OPEN_OFFICE_CONFIG);
		if(properties==null){
			SysProperties sysProperties=new SysProperties();
			sysProperties.setProId(IdUtil.getId());
			sysProperties.setAlias(OpenOfficeUtil.OPEN_OFFICE_CONFIG);
			sysProperties.setName("openoffice服务配置");
			sysProperties.setEncrypt("NO");
			sysProperties.setGlobal("YES");
			sysProperties.setValue(configJson);
			sysProperties.setCategory("系统参数");
			sysProperties.setTenantId(SysInst.ADMIN_TENANT_ID);
			sysPropertiesManager.create(sysProperties);
		}
		else{
			properties.setValue(configJson);
			sysPropertiesManager.update(properties);
		}
	}

}
