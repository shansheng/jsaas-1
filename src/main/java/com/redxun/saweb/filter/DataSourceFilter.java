package com.redxun.saweb.filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import com.redxun.bpm.activiti.ext.ActivitiDefCache;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.database.datasource.DbContextHolder;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;

public class DataSourceFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		
		ProcessHandleHelper.clearProcessCmd();
		ProcessHandleHelper.clearObjectLocal();
		ProcessHandleHelper.clearFormulaSetting();
		ProcessHandleHelper.clearBackPath();
		ProcessHandleHelper.clearProcessMessage();
		ActivitiDefCache.clearLocal();
		
		String serverName=req.getServerName();
		String dsName=getDsName( serverName);
		
		try {
			DbContextHolder.clearDataSource();
			DbContextHolder.setDataSource(dsName);
//			DbContextHolder.setDataSource(dsName);
			
//			JdbcTemplate template=AppBeanUtil.getBean(JdbcTemplate.class);
//			template.execute("use " + dsName);
			
		}  catch (Exception e) {
			e.printStackTrace();
		}

		chain.doFilter(request, response);
	}
	
	/**
	 * 获取数据源名称。
	 * @param serverName	服务器域名。
	 * @return
	 */
	private String getDsName(String serverName){
		serverName=serverName.toLowerCase();
		List<SysInst> list=SysInstManager.getTenants();
		for(SysInst inst:list){
			String domain=inst.getDomain();
			if(StringUtils.isEmpty(domain)){
				continue;
			}
		
			domain = domain.toLowerCase();
		
			if(serverName.indexOf(domain)!=-1){
				return inst.getDsName();
			}
		}
		return "";
	}

	@Override
	public void destroy() {
	}
	

}
