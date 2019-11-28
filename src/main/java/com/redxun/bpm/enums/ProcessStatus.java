package com.redxun.bpm.enums;

/**
 * 流程状态
 * @author csx
 *
 */
public enum ProcessStatus {
	RUNNING("运行中"),
	DRAFTED("草稿"),
	SUCCESS_END("成功结束"),
	DISCARD_END("作废"),
	ABORT_END("异常中止结束"),
	PENDING("挂起");
	
	String statusLabel;
	ProcessStatus(String statusLabel){
		this.statusLabel=statusLabel;
	}
	public String getStatusLabel() {
		return statusLabel;
	}
}
