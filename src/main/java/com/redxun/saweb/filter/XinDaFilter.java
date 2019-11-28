package com.redxun.saweb.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.HttpClientUtil;
import com.redxun.core.util.HttpClientUtil.HttpRtnModel;
import com.redxun.org.api.model.IUser;
import com.redxun.core.util.PropertiesUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.core.util.SysPropertiesUtil;

/**
 * 改过滤器拦截m.do页面。
 * m.do?action=mobile&token=传入token
 * 如果token合法则跳转到pc 或移动端首页。
 * @author ray
 *
 */
public class XinDaFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		String action=RequestUtil.getString(req, "action","mobile");
		IUser user=ContextUtil.getCurrentUser();
		if(user!=null){
			String url=SysPropertiesUtil.getGlobalProperty("install.host");
			if("mobile".equals(action)){
				url+="/mobile/index.html";
			}
			else{
				url+="/index.do";
			}
			HttpServletResponse res=(HttpServletResponse)response;
			res.sendRedirect(url);
			return ;
		}
		
		
		String token=RequestUtil.getString(req, "token");
		
		String tokenUrl=PropertiesUtil.getProperty("xinDaUrl") +"gsControl/queryUserInfoByToken.do?token=";
		if(StringUtil.isEmpty(token)){
			response.getWriter().print("plase input token");
			return;
		}
		else{
			try{
				tokenUrl+=token;
				HttpRtnModel model= HttpClientUtil.getFromUrlHreader(tokenUrl , null);
				String content= model.getContent();
				System.out.println(content);
				JSONObject jsonObj=JSONObject.parseObject(content);
				int flag=jsonObj.getJSONObject("result").getInteger("flag");
				if(flag!=0){
					response.getWriter().print("token is invalid!");
				}
				else{
					JSONArray list= jsonObj.getJSONArray("list");
					JSONObject json=list.getJSONObject(0);
					String account=json.getString("code") ;
					SecurityUtil.login(req,account, "", true);
					String url=SysPropertiesUtil.getGlobalProperty("install.host");
					if("mobile".equals(action)){
						url+="/mobile/index.html";
					}
					else{
						url+="/index.do";
					}
					HttpServletResponse res=(HttpServletResponse)response;
					res.sendRedirect(url);
				}
					
			}
			catch(Exception ex){
				response.getWriter().print(ExceptionUtil.getExceptionMessage(ex));
			}
		}
		
	}

	@Override
	public void destroy() {
	}

}
