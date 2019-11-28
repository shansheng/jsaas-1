package com.redxun.oa.info.entity;

import java.util.HashMap;
import java.util.Map;

public class InsMsgBoxEntity {
	private String title;
	private int count;
	private String url;
	private String icon;
	private String color;
	private Map<String,Object> boxData = new HashMap<String,Object>();
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public Map<String, Object> getBoxData() {
		return boxData;
	}
	public void setBoxData(Map<String, Object> boxData) {
		this.boxData = boxData;
	}
	
	
	
}
