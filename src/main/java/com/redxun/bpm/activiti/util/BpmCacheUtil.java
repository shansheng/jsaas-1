package com.redxun.bpm.activiti.util;

import org.activiti.engine.ProcessEngineConfiguration;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;

import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.saweb.util.WebAppUtil;

public class BpmCacheUtil {
	/**
	 * 按流程定义ID清空缓存
	 * @param actDefId
	 */
	public static void clearCache(String actDefId) {
		ActRepService actRepService=(ActRepService)WebAppUtil.getBean(ActRepService.class);	
		
  
		actRepService.clearProcessDefinitionCache(actDefId);
	}
}
