package com.redxun.bpm.enums;

/**
 * 流程事件类型
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public enum ProcessEventType {
	PROCESS_STARTED("流程启动时"),
	PROCESS_COMPLETED("流程完成时");
	//PROCESS_CANCELLED("流程取消删除时");
	
	private String eventName;

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	
	ProcessEventType(String eventName){
		this.eventName=eventName;
	}
	
}
