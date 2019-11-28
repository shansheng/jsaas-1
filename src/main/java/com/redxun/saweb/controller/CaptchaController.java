package com.redxun.saweb.controller;

import java.awt.image.BufferedImage;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.redxun.core.json.JsonResult;
import com.redxun.core.mail.MailTools;
import com.redxun.core.mail.model.Mail;
import com.redxun.core.util.StringUtil;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 用于生成验证码
 * 
 * @author csx
 * @Email chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用
 */
@Controller
@RequestMapping("/")
public class CaptchaController {
	private Producer captchaProducer = null;
	
	@Resource
	private MailTools mailTools;

	@Resource
	private OsUserManager osUserManager;

	@Autowired
	public void setCaptchaProducer(Producer captchaProducer) {
		this.captchaProducer = captchaProducer;
	}

	@RequestMapping("/captcha-image")
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setDateHeader("Expires", 0);
		// Set standard HTTP/1.1 no-cache headers.
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		// Set IE extended HTTP/1.1 no-cache headers (use addHeader).
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		// Set standard HTTP/1.0 no-cache header.
		response.setHeader("Pragma", "no-cache");
		// return a jpeg
		response.setContentType("image/jpeg");
		// create the text for the image
		String capText = captchaProducer.createText();
		// store the text in the session
		request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);
		// create the image with the text
		BufferedImage bi = captchaProducer.createImage(capText);
		ServletOutputStream out = response.getOutputStream();
		// write the data out
		ImageIO.write(bi, "jpg", out);
		try {
			out.flush();
		} finally {
			out.close();
		}
		return null;
	}
	
	@RequestMapping("/loadValiCode")
	public JsonResult<String> loadValiCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String emailOrAccount = request.getParameter("emailOrAccount");
		String email = null;
		if(!StringUtil.vaildEmail(emailOrAccount)) {
			OsUser user= osUserManager.getByUserName(emailOrAccount);
			
			email = user.getEmail();
    	}else {
    		email = emailOrAccount;
    	}
		Mail mail = new Mail();
		mail.setSubject("【红迅软件】账号安全-找回登录密码");
		mail.setSenderAddress(email);
		// create the text for the image
		String capText = captchaProducer.createText();
		mail.setContent("尊敬的用户,您好：\r\n" + 
				"   您正在进行找回登录密码的重置操作，本次请求的邮件验证码是："+capText);
		request.getSession().setAttribute(Constants.KAPTCHA_SESSION_CONFIG_KEY, capText);
		mail.setReceiverAddresses(email);
		mailTools.send(mail);
		return new JsonResult<String>(true);
	}
	
	
	
}
