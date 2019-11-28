package com.redxun.bpm.core.entity;

import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.redxun.core.json.JsonDateSerializer;

public class BpmTaskRead {
	
	String readId ;
	String userName;
	String state;
	String depName;
	Date createTime;
	
	public String getReadId() {
		return readId;
	}
	public void setReadId(String readId) {
		this.readId = readId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getDepName() {
		return depName;
	}
	public void setDepName(String depName) {
		this.depName = depName;
	}
	@JsonSerialize (using=JsonDateSerializer.class)
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	
	
}
