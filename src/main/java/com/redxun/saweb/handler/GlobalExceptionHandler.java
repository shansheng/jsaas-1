package com.redxun.saweb.handler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.redxun.core.json.JsonResult;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.StringUtil;

public class GlobalExceptionHandler implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		String ajaxHeader=request.getHeader("X-Requested-With");
		//ajax请求。
		if(StringUtil.isNotEmpty(ajaxHeader) && ajaxHeader.equals("XMLHttpRequest")){
			PrintWriter writer=null;
			try {
				writer = response.getWriter();
				JsonResult<String> result=new JsonResult<>(false, "操作出错,请检查!");
				String msg=ExceptionUtil.getExceptionMessage(ex);
				result.setData(msg);
				writer.write(result.toString());
				writer.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
