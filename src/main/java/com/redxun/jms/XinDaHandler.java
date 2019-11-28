package com.redxun.jms;

import com.redxun.core.jms.IJmsHandler;
import com.redxun.core.jms.MessageModel;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.util.HttpClientUtil;
import com.redxun.core.util.PropertiesUtil;
import com.redxun.org.api.model.IUser;

public class XinDaHandler  implements IJmsHandler {

	@Override
	public String getType() {
		return "xdsms";
	}

	@Override
	public String getName() {
		return "短信通知";
	}

	@Override
	public void handleMessage(MessageModel messageModel) {
		try {
			String content= MessageUtil.getContent(messageModel, this.getType());
			
			for(IUser receiver:messageModel.getRecieverList()){
				String msgBody="<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
				msgBody+="<msg fromUser=\""+messageModel.getSender().getFullname()+"\" toUser=\""+receiver.getUserId()+"\" ";
				msgBody+= "title=\""+messageModel.getSubject()+"\" content=\""+content+"\" ";
						msgBody+="msgId=\"001\" msgMainType=\"10\" msgChildType=\"001\"/>";
				String 	xinDaUrl=	PropertiesUtil.getProperty("xinDaUrl");
				String postUrl=xinDaUrl + "gsControl/messageCenter.do";
				HttpClientUtil.postJson(postUrl, msgBody);
			}
			
			
		} catch (Exception e1) {	
			e1.printStackTrace();
		}
		
	}

}
