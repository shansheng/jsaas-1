package com.redxun.saweb.listener;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.Ordered;

import com.redxun.sys.core.util.OpenOfficeUtil;

/**
 * 在系统启动时自动启动openoffice 服务。
 * @author cmc
 *
 */
public class OpenofficeListener implements ApplicationListener<ContextRefreshedEvent>,Ordered{
	
	protected Logger logger = LogManager.getLogger(OpenofficeListener.class);

	@Override
	public int getOrder() {
		
		return 10;
	}

	@Override
	public void onApplicationEvent(ContextRefreshedEvent ev) {
		if (ev.getApplicationContext().getParent() != null) return;
		
		logger.debug("正在启动openoffice 服务");
		//自动启动Openoffice服务。
		OpenOfficeUtil.startService();
	}

}
