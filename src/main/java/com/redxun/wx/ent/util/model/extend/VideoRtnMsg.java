package com.redxun.wx.ent.util.model.extend;

import org.dom4j.Element;

import com.redxun.wx.ent.util.model.BaseRtnMsg;

public class VideoRtnMsg extends BaseRtnMsg{
	
	private String mediaId="";
	private String title="";
	private String description="";
	
	
	public String getMediaId() {
		return mediaId;
	}

	public void setMediaId(String mediaId) {
		this.mediaId = mediaId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Override
	public String getMsgType() {
		return "video";
	}
	

	@Override
	protected void extToString(Element root) {
		Element el= root.addElement("Video");
		el.addElement("MediaId").addCDATA(this.getMediaId());
		el.addElement("Title").addCDATA(this.getTitle());
		el.addElement("Description").addCDATA(this.getDescription());
		
	}

	

	

}
