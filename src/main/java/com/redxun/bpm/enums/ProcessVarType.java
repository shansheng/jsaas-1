package com.redxun.bpm.enums;

/**
 * 变量Key
 * @author mansan
 *
 */
public enum ProcessVarType {
	SOL_ID("solId", "流程解决方案ID"),
	SOL_KEY("solKey", "流程解决方案KEY"),
	INST_ID("instId", "流程实例ID"),
	FORM_INST_ID("formInstId","表单实例ID"),
	START_USER_ID("startUserId", "经办人Id"),
	START_DEP_ID("startDepId", "经办部门ID"),
	PROCESS_SUBJECT("processSubject", "事项标题"),
	BUS_KEY("busKey", "业务主键ID"),
	NODE_USER_IDS("nodeUserIds","节点人员ID映射"),
	DB_ALIAS("dbAlias","数据连接别名"),
	PRE_NODE_USERID("preNodeUseId","前一任务审批人"),
	VARIABLES("variables", "流程变量(Map)");
	
	
	String key;
	String name;
	
	ProcessVarType(String key,String name){
		this.key=key;
		this.name=name;
	}

	public String getKey() {
		return key;
	}

	public String getName() {
		return name;
	}

}
