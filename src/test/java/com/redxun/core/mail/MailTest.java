package com.redxun.core.mail;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

import javax.mail.Part;

import org.junit.Before;
import org.junit.Test;

import com.redxun.core.mail.api.AttacheHandler;
import com.redxun.core.mail.model.Mail;
import com.redxun.core.mail.model.MailAttachment;
import com.redxun.core.mail.model.MailConfig;

/**
 * 邮件处理类    --   单元测试
 * @author Administrator
 *
 */
public class MailTest {
	MailTools mailTools;
	@Before
	public void init() throws Exception {
		Properties pro = new Properties();
		pro.load(MailTest.class.getClassLoader().getResourceAsStream("config/app.properties"));
		MailConfig mailSetting = new MailConfig();
		mailSetting.setSendHost(pro.getProperty("mail.host"));
		mailSetting.setSendPort(pro.getProperty("mail.port"));
		mailSetting.setReceiveHost("imap.qq.com");
		mailSetting.setReceivePort("143");
		mailSetting.setSSL(Boolean.valueOf(pro.getProperty("mail.ssl")));
		mailSetting.setProtocal("imap");
		mailSetting.setValidate(true);
		mailSetting.setNickName(pro.getProperty("mail.nickName"));
		mailSetting.setMailAddress(pro.getProperty("mail.username"));
		mailSetting.setPassword(pro.getProperty("mail.password"));
		mailTools = new MailTools(mailSetting);
	}
	
	@Test
	public void sendMail() throws Exception {
		Mail mail = new Mail();
		mail.setSubject("【红迅软件】账号安全-找回登录密码");
		mail.setSenderAddress("994042808@qq.com");
		// create the text for the image
		mail.setContent("尊敬的用户,您好：\r\n" + 
				"   您正在进行找回登录密码的重置操作，本次请求的邮件验证码是："+"22222");
		mail.setReceiverAddresses("994042808@qq.com");
		List<MailAttachment> attach = mail.getMailAttachments();
		InputStream is = new FileInputStream("C:\\Users\\Administrator\\Downloads\\home.html");
		byte[] bytes = new byte[1024];
		is.read(bytes);
		attach.add(new MailAttachment("home.html",bytes));
		try {
			mailTools.send(mail);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void getMail() {
		long start,end;
		start = System.currentTimeMillis();
		List<Mail> list = null;
		try {
			list = mailTools.receive(new AttacheHandler() {
				
				@Override
				public Boolean isDownlad(String messageId) {
					return true;
				}
				
				@Override
				public void handle(Part part, Mail mail) {
					
				}
			});
			end = System.currentTimeMillis(); 
			System.out.println(list.size());
			System.out.println("start time:" + start+ "; end time:" + end+ "; Run Time:" + (end - start) + "(ms)");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
