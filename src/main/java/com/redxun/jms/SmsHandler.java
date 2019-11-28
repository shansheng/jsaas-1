package com.redxun.jms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.redxun.core.jms.IJmsHandler;
import com.redxun.core.jms.MessageModel;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.HttpClientUtil;
import com.redxun.core.util.HttpClientUtil.HttpRtnModel;
import com.redxun.org.api.model.IUser;
import com.redxun.sys.org.entity.OsUser;

public class SmsHandler implements IJmsHandler {

	@Override
	public String getName() {
		return "短信";
	}

	@Override
	public String getType() {
		return "sms";
	}

	@Override
	public void handleMessage(MessageModel model) {
		/*
		 此基于[壹通道]短信接口实现
		   参数名称	            含义	                       说明
		 userid	            企业id	            企业ID
		 account	发送用户帐号	用户帐号，由系统管理员
		 password	发送帐号密码	用户账号对应的密码
		 mobile	            全部被叫号码	发信发送的目的号码.多个号码之间用半角逗号隔开 
		 content	发送内容	            短信的内容，内容需要UTF-8编码
		 sendTime	定时发送时间	为空表示立即发送，定时发送格式2010-10-24 09:08:10
		 action	            发送任务命令	设置为固定的:send
		 extno	            扩展子号	            请先询问配置的通道是否支持扩展子号，如果不支持，请填空。子号只能为数字，且最多10位数。
		 */
		try {
			String content= MessageUtil.getContent(model, this.getType());
			String url="http://120.76.213.253:8888/sms.aspx";
			String account = "";
			String password = "";
			String mobile = getSendUsers(model);
			
			Map<String,String> headerMap = new HashMap<String,String>();
			headerMap.put("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
			
			Map<String,String> params = new HashMap<String,String>();
			params.put("action", "send");
			params.put("userid", "");
			params.put("account", account);
			params.put("password", password);
			params.put("mobile", mobile);
			params.put("content", content);
			params.put("sendTime", "");
			params.put("extno", "");
			
			HttpClientUtil.postFromUrl(url, headerMap, params);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
	}
	
	/**
	 * 
	 * @param model
	 * @return
	 */
	private String getSendUsers(MessageModel model){
		List<IUser> userList=model.getRecieverList();
		if(BeanUtil.isEmpty(userList)) return "";
		String mobiles="";
		for(int i=0;i<userList.size();i++){
			OsUser user=(OsUser)userList.get(i);
			if(i==0){
				mobiles=user.getMobile();
			}
			else{
				mobiles+="," + user.getMobile();
			}
		}
		return mobiles;
	}
	
	public static void main(String[] args) throws Exception {
		String url="http://120.76.213.253:8888/sms.aspx";
		
		Map<String,String> headerMap = new HashMap<String,String>();
		headerMap.put("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		
		Map<String,String> params = new HashMap<String,String>();
		params.put("action", "send");
		params.put("userid", "12");
		params.put("account", "q13047215992");
		params.put("password", "123456");
		params.put("mobile", "13047215992");
		params.put("content", "123");
		params.put("sendTime", "");
		params.put("extno", "");
		
		HttpRtnModel htm = HttpClientUtil.postFromUrl(url, headerMap, params);
		
		System.out.println(htm.getContent());
		
	}

}
