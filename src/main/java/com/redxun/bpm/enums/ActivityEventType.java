package com.redxun.bpm.enums;

/**
 * 流程节点活动事件
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public enum ActivityEventType {
	ACTIVITY_STARTED("节点活动开始"),
	ACTIVITY_COMPLETED("节点活动结束");
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
	
	ActivityEventType(String eventName){
		this.eventName=eventName;
	}
}
