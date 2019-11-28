package com.redxun.bpm.enums;

/**
 * 流程任务的事件类型
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public enum TaskEventType {
	TASK_CREATED("任务创建"),
	TASK_COMPLETED("任务完成"),
	SIGN_COMPLETED("会签完成");
	
	/*,
	VARIABLE_CREATED("变量创建"),
	VARIABLE_UPDATED("变量更新"),
	VARIABLE_DELETED("变量删除");
	*/
	private String eventName;
	
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	
	TaskEventType(String eventName){
		this.eventName=eventName;
	}
}
