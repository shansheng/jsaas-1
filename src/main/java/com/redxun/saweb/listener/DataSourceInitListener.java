package com.redxun.saweb.listener;

import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.core.Ordered;

import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.sys.core.manager.SysDataSourceManager;

/**
 * 系统启动时添加数据源。
 * @author ray
 *
 */
public class DataSourceInitListener  implements ApplicationListener<ContextRefreshedEvent>,Ordered{

	protected static Logger logger=LogManager.getLogger(DataSourceInitListener.class);

	@Override
	public void onApplicationEvent(ContextRefreshedEvent ev) {
		// 防止重复执行。
		if (ev.getApplicationContext().getParent() != null) return;
		ApplicationContext context = ev.getApplicationContext();
		addDataSource(context);
	}
	
	private void addDataSource(final ApplicationContext context){
		Runnable runnable = new Runnable() {
            public void run() {
            	// 加载数据库中的数据源--->start
        		SysDataSourceManager sysDataSourceManager = (SysDataSourceManager) context.getBean("sysDataSourceManager");
        		// 获取可用的数据源
        		Map<String, DataSource> sysDataSources = sysDataSourceManager.getDataSource();
        		if(BeanUtil.isEmpty(sysDataSources)) return;
        		// 添加数据实例到容器中。
        		for (Map.Entry<String, DataSource> entry : sysDataSources.entrySet()) {
        			try {
        				DataSourceUtil.addDataSource(entry.getKey(), entry.getValue(), false);
        			}catch (Exception e) {
        				logger.debug(e.getMessage());
        			}
        		}
            }
        };
        ScheduledExecutorService service = Executors.newSingleThreadScheduledExecutor();
        service.schedule(runnable, 1, TimeUnit.SECONDS);
	}

	@Override
	public int getOrder() {
		return 0;
	}

}
