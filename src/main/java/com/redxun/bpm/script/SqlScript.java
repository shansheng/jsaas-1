package com.redxun.bpm.script;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;

import com.redxun.bpm.activiti.listener.call.BpmRunException;
import com.redxun.core.annotion.cls.ClassDefine;
import com.redxun.core.annotion.cls.MethodDefine;
import com.redxun.core.annotion.cls.ParamDefine;
import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.script.GroovyScript;
import com.redxun.core.util.SqlParseUtil;

@ClassDefine(title = "SQL脚本基础服务类")
public class SqlScript  implements GroovyScript {

	protected Logger logger=LogManager.getLogger(ProcessScript.class);
	
	@Resource FreemarkEngine freemarkEngine;
	@Resource JdbcTemplate jdbcTemplate;
	
	/**
	 * 通过SQL保存执行实例的多个变量
	 * @Description:
	 * @Title: executeSql as insert into demo(t1,t2)values(#{t1},#{t2})
	 * @param @param sql
	 * @param @param variables 参数说明
	 * @return void 返回类型
	 * @throws
	 */
	@MethodDefine(title = "执行SQL",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql"), @ParamDefine(title = "变量", varName = "variables"),@ParamDefine(title = "数据源别名", varName = "dbAlias")})
	public void doExecuteSql(String sql, Map<String, Object> variables,String dbAlias) {
		String targetSql="";
		try{
			targetSql= freemarkEngine.parseByStringTemplate(variables, sql);
			Map<String,Object> newParams=new HashMap<String,Object>();
			targetSql=SqlParseUtil.parseSql(targetSql, variables, newParams);
			logger.info("targetSql==================:"+ targetSql);
			//使用了配置的数据源
			Object[] params=newParams.values().toArray();
		if(StringUtils.isNotEmpty(dbAlias)) {
				DataSource datasource=DataSourceUtil.getDataSourceByAlias(dbAlias);
				JdbcTemplate  jtemplate=new JdbcTemplate(datasource);
				
				jtemplate.update(targetSql,params);
			}else{
				jdbcTemplate.update(targetSql,params);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new BpmRunException("执行SQL出错:" +targetSql);
		}

	}
	
	/**
	 * 通过SQL保存执行实例的多个变量
	 * @Description:
	 * @Title: executeSql
	 * @param @param sql
	 * @param @param variables 参数说明
	 * @return void 返回类型
	 * @throws
	 */
	@MethodDefine(title = "执行SQL",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql"), @ParamDefine(title = "变量", varName = "variables")})
	public void doExecuteSql(String sql, Map<String, Object> variables)  throws Exception {
	
		String targetSql= freemarkEngine.parseByStringTemplate(variables, sql);
		Map<String,Object> newParams=new HashMap<String,Object>();
		targetSql=SqlParseUtil.parseSql(targetSql, variables, newParams);
		logger.info("targetSql==================:"+ targetSql);
		Object[] params=newParams.values().toArray();
		jdbcTemplate.update(targetSql,params);
			
		
	}
	
	@MethodDefine(title = "执行SQL",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql")})
	public void doExecuteSql(String sql)  throws Exception {
		jdbcTemplate.execute(sql);
	}
	
	public void doExecuteSql(final String sql,final List<Object> params) throws Exception {
		try{
			jdbcTemplate.execute(sql,new PreparedStatementCallback(){
				@Override
				public Object doInPreparedStatement(PreparedStatement ps) throws SQLException, DataAccessException {
					int i=1;
					for(Object param:params){
						ps.setObject(i++, param);
					}
					return ps.execute(sql);
				}
			});
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}
	}
	
	/**
	 * 查询单个值。
	 * @param sql
	 * @return
	 */
	@MethodDefine(title = "执行SQL,返回单个字符串",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql")})
	public String queryForString(String sql)  {
		return jdbcTemplate.queryForObject(sql,String.class);
	}
	
	/**
	 * 查询长整形结果。
	 * @param sql
	 * @return
	 */
	@MethodDefine(title = "执行SQL,返回长整形",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql")})
	public Long queryForLong(String sql)  {
		return jdbcTemplate.queryForObject(sql,Long.class);
	}
	
	/**
	 * 查询整形结果。
	 * @param sql
	 * @return
	 */
	@MethodDefine(title = "执行SQL,返回整形",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql")})
	public Integer queryForInt(String sql)  {
		return jdbcTemplate.queryForObject(sql,Integer.class);
	}
	
	/**
	 * 查询列表数据。
	 * @param sql
	 * @return
	 */
	@MethodDefine(title = "执行SQL,返回列表",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql")})
	public List<Map<String,Object>> queryForList(String sql)  {
		return jdbcTemplate.queryForList(sql);
	}
	
	/**
	 * 通过SQL保存执行实例的多个变量
	 * @Description:
	 * @Title: executeSql
	 * @param @param sql
	 * @param @param variables 参数说明
	 * @return void 返回类型
	 * @throws
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@MethodDefine(title = "执行存储过程",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql"), @ParamDefine(title = "变量", varName = "variables")})
	public void doExecuteProcedureSql(String sql, Map<String, Object> variables) throws Exception {
		
			String targetSql= freemarkEngine.parseByStringTemplate(variables, sql);
			final Map<String,Object> newParams=new HashMap<String,Object>();
			targetSql=SqlParseUtil.parseSql(targetSql, variables, newParams);
			
			jdbcTemplate.execute(targetSql,new CallableStatementCallback() {
				@Override
				public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException {
					int i=1;
					for(Object val:newParams.values()){
						cs.setObject(i++, val);
					}
					cs.execute();
					return null;
				}
			});
		
	}
	
	/**
	 * 通过SQL保存执行实例的多个变量
	 * @Description:
	 * @Title: executeSql
	 * @param @param sql
	 * @param @param variables 参数说明
	 * @return void 返回类型
	 * @throws
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@MethodDefine(title = "执行存储过程",category="SQL脚本", params = {@ParamDefine(title = "sql", varName = "sql"), @ParamDefine(title = "变量", varName = "variables"),@ParamDefine(title = "数据源别名", varName = "dbAlias")})
	public void doExecuteProcedureSql(String sql, Map<String, Object> variables,String dbAlias) throws Exception {			
			String targetSql= freemarkEngine.parseByStringTemplate(variables, sql);
			final Map<String,Object> newParams=new HashMap<String,Object>();
			targetSql=SqlParseUtil.parseSql(targetSql, variables, newParams);
			DataSource datasource=DataSourceUtil.getDataSourceByAlias(dbAlias);
			JdbcTemplate  jtemplate=new JdbcTemplate(datasource);
			
			jtemplate.execute(targetSql,new CallableStatementCallback() {
				@Override
				public Object doInCallableStatement(CallableStatement cs) throws SQLException, DataAccessException {
					cs.execute();
					return null;
				}
			});
	}
}
