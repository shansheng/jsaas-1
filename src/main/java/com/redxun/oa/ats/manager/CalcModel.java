package com.redxun.oa.ats.manager;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 请假.加班.出差模型
 * @author Administrator
 *
 */
public class CalcModel {
	
	// 用户ID
	protected String userId;
	// 档案ID
	protected String fileId;
	// 开始时间
	protected Date startTime;
	// 结束时间
	protected Date endTime;
	// 是否成功
	protected Boolean isSuccess = false;
	// 其他属性
	protected List<Map<String, Object>> mapList;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public Boolean getIsSuccess() {
		return isSuccess;
	}
	public void setIsSuccess(Boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public List<Map<String, Object>> getMapList() {
		return mapList;
	}
	public void setMapList(List<Map<String, Object>> mapList) {
		this.mapList = mapList;
	}
	
}
