package com.redxun.wx.ent.util.model;

import org.dom4j.Document;
import org.dom4j.Element;

import com.redxun.core.util.Dom4jUtil;

public abstract class BaseRtnMsg {
	
	private String toUserName="";
	private String fromUserName="";
	private Integer createTime=0;
	private String msgType="";
	
	
	public String getToUserName() {
		return toUserName;
	}
	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}
	public String getFromUserName() {
		return fromUserName;
	}
	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}
	public Integer getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Integer createTime) {
		this.createTime = createTime;
	}
	
	public String getMsgType() {
		return "text";
	}
	
	
	protected void add(Element el,String name,String value,boolean isCData){
		if(isCData){
			el.addElement(name).addCDATA(value);
		}
		else{
			el.addElement(name).setText(value);
		}
		
	}
	
	
	
	protected Element getDocRoot(){
		Document doc=Dom4jUtil.stringToDocument("<xml></xml>");
		Element root= doc.getRootElement();
		return root;
	}
	
	protected abstract void  extToString(Element root);
	
	@Override
	public String toString() {
		Element root= getDocRoot();
		
		add(root, "ToUserName", this.getToUserName(),true);
		add(root, "FromUserName",this.getToUserName(),true);
		add(root,"CreateTime", String.valueOf(System.currentTimeMillis()/1000),false);
		add(root, "MsgType",this.getMsgType(),true);
		
		extToString(root);
		
		return root.asXML();
	}
	
}
