package com.redxun.saweb.filter;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.redxun.core.util.StringUtil;
import com.redxun.restApi.sys.controller.AppTokenUtil;
import com.redxun.saweb.security.filter.RegMatchers;

/**
 * 此过滤器功能是过滤需要传入访问token的API。
 * <pre>
 * 1.如果 请求头中没有传入 token 的情况，那么通知客户端没有传入token。
 * 2.如果传入的token不存在或者token过期，则通知token 客户端 token 无效信息。
 * 3.如果没有问题则允许访问指定的API接口。
 * </pre>
 */
public class AppTokenFilter implements Filter {
	
	@Resource(name="appTokenUrl")
	RegMatchers appUrlMatchers;
   
    public AppTokenFilter() {
    }

	
	public void destroy() {
	}


	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		String reqUrl=req.getRequestURI();
		if(!appUrlMatchers.isContainUrl(reqUrl)){
			chain.doFilter(request, response);
		}
		else{
			String token=req.getHeader("token");
			if(StringUtil.isEmpty(token)){
				response.setContentType("application/json;charset=utf-8");
				response.getWriter().print("{success:false,message:\"没有传入TOKEN\",data:-1}");
				return;
			}
			
			boolean rtn=AppTokenUtil.validToken(token);
			if(!rtn){
				response.setContentType("application/json;charset=utf-8");
				response.getWriter().print("{success:false,message:\"token已过期或非法\",data:-2}");
			}
			else{
				chain.doFilter(request, response);
			}
		}
		
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
