package com.redxun.bpm.activiti.listener.call.handler;

import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.jms.BpmEventCallMessage;
import com.redxun.bpm.activiti.listener.call.BpmEventCallHandler;
import com.redxun.bpm.activiti.listener.call.BpmEventCallSetting;
import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.util.SysUtil;

public class BpmEventCallHandlerSql extends AbstractBpmEventCallHandler{
	
	@Override
	public void handle(BpmEventCallMessage callMessage){
		logger.debug("===============enter BpmEventCallHandlerSql handle method===============");
		BpmEventCallSetting  eventSetting= callMessage.getBpmEventCallSetting();
		String script=eventSetting.getScript();
		if(StringUtil.isEmpty(script)) return;
		script=script.trim();
		String sql="";
		String dbAlias="";
		if(script.startsWith("{")){
			JSONObject jsonObj=JSONObject.parseObject(script);
			sql=jsonObj.getString("sql");
			dbAlias=jsonObj.getString("dbAlias");
		}
		else{
			sql=script;
		}
		if(StringUtils.isEmpty(sql)) return;
		Map<String,Object> vars=getVariables(callMessage);
		sql=SysUtil.parseScript(sql, vars);
		try {
			if(StringUtil.isEmpty(dbAlias)){
				dbAlias=DataSourceUtil.LOCAL;
			}
			if(DataSourceUtil.LOCAL.equals(dbAlias)){
				JdbcTemplate template=AppBeanUtil.getBean(JdbcTemplate.class);
				template.execute(sql);
			}
			else{
				DataSource  dataSource= DataSourceUtil.getDataSourceByAlias(dbAlias);
				JdbcTemplate template=new JdbcTemplate(dataSource);
				template.execute(sql);
			}
			
		} 
		catch (Exception e1) {
			logger.error(ExceptionUtil.getExceptionMessage(e1));
			throw new BpmRunException("执行sql:" + sql + "出错原因："+e1.getCause());
		} 
		
	}

	@Override
	public String getHandlerType() {
		return BpmEventCallHandler.HANDLER_TYPE_SQL;
	}

}
