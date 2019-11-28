package com.redxun.bpm.script.config;

import java.util.ArrayList;
import java.util.List;

/**
 * 流程脚本服务配置类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ScriptServiceConfig {
	
	public static List<ScriptServiceClass> serviceClasses=new ArrayList<ScriptServiceClass>();

	public static List<ScriptServiceClass> getServiceClasses() {
		return serviceClasses;
	}

	public static void setServiceClasses(List<ScriptServiceClass> serviceClasses) {
		ScriptServiceConfig.serviceClasses = serviceClasses;
	}
	
}
