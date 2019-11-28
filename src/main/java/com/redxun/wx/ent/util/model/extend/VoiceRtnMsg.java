package com.redxun.wx.ent.util.model.extend;

import org.dom4j.Element;

import com.redxun.wx.ent.util.model.BaseRtnMsg;

public class VoiceRtnMsg extends BaseRtnMsg {
	
	private String mediaId="";

	public String getMediaId() {
		return mediaId;
	}

	public void setMediaId(String mediaId) {
		this.mediaId = mediaId;
	}
	
	@Override
	public String getMsgType() {
		return "voice";
	}

	@Override
	protected void extToString(Element root) {
       Element img=root.addElement("Voice");
       Element media= img.addElement("MediaId");
       media.setText(this.mediaId);
	}

}
