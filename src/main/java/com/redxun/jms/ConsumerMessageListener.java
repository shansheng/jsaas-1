package com.redxun.jms;

import javax.jms.Message;
import javax.jms.MessageListener;

public class ConsumerMessageListener implements MessageListener{

	@Override
	public void onMessage(Message message) {
//		ObjectMessage obj=(ObjectMessage)message;
//		try {
//			OsUser user=(OsUser) obj.getObject();
//			System.out.println(user.getFullname());
//		} catch (JMSException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println("ok");
	}

}
