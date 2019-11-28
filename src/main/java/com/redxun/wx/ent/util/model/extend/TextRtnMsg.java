package com.redxun.wx.ent.util.model.extend;

import org.dom4j.Element;

import com.redxun.wx.ent.util.model.BaseRtnMsg;

public class TextRtnMsg extends BaseRtnMsg {
	
	private String content="";

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String getMsgType() {
		return "text";
	}

	@Override
	protected void extToString(Element root) {
		add(root,"Content",this.getContent(),true);
	}

	
	
	public static void main(String[] args) {
		VoiceRtnMsg rtn=new VoiceRtnMsg();
		rtn.setMediaId("1984484");
		rtn.setFromUserName("zyg");
		rtn.setToUserName("zhouyh");
	
		
		System.err.println(rtn);
	}
	
	
	

}
