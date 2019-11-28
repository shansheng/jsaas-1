package com.redxun.sys.db.manager;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.json.JsonResult;
import com.redxun.core.query.Page;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.sys.db.entity.SysSqlCustomQuery;

public class SysSqlCustomQueryUtil {
	
	protected static Logger logger=LogManager.getLogger(SysSqlCustomQueryUtil.class);
	
	public static JsonResult queryForJson( String alias,String params) throws Exception {
		SysSqlCustomQueryManager sysSqlCustomQueryManager =AppBeanUtil.getBean(SysSqlCustomQueryManager.class);
		if(StringUtils.isEmpty(alias)) return new JsonResult<Void>(false, "请输入别名");
		Map<String,Object> paramsmMap=sysSqlCustomQueryManager.jsonToMap(params);
		
		SysSqlCustomQuery sqlCustomQuery=sysSqlCustomQueryManager.getByKey(alias);
		
		if(sqlCustomQuery==null){
			logger.error("自定义SQL("+ alias + ")不存在！");
			return new JsonResult(false,"自定义SQL（"+ alias + ")不存在！");
		}
		
		String ds=sqlCustomQuery.getDsAlias();
		//切换数据源
		DbContextHolder.setDataSource(ds);
		Page page=null;
		if(sqlCustomQuery.getIsPage()==1){
			Object pageObj= paramsmMap.get("pageIndex");
			if(pageObj!=null){
				page=new Page(Integer.parseInt(pageObj.toString()) ,Integer.parseInt(sqlCustomQuery.getPageSize()));
			}
			if(null==page){
				page=new Page(0,Integer.parseInt(sqlCustomQuery.getPageSize()));
			}
		}
		List result=sysSqlCustomQueryManager.getData(sqlCustomQuery, paramsmMap,page);
		
		DbContextHolder.setDefaultDataSource();
		
		return new JsonResult(true,"",result);
	}

}
