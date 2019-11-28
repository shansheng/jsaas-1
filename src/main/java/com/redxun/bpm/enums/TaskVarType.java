package com.redxun.bpm.enums;

/**
 * 任务的变量Key或Key前缀
 * @author mansan
 *
 */
public enum TaskVarType {
	SIGN_USER_IDS_("signUserIds_","会签用户Id_NodeId列表变量"),
	EXPIRETIME_("expiretime_","到期时间"),
	TASKID("taskId","任务ID"),
	TASK_ENTITY("taskEntity","任务实体"),
	TASK_VARS("variables","任务变量集合"),
	DB_ALIAS("dbAlias","数据连接别名"),
	JSON_DATA("jsonData","表单JSON数据"),
	PRIORITY_("priority_","优先级");
	
	
	String key;
	String name;
	
	TaskVarType(String key,String name){
		this.key=key;
		this.name=name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
