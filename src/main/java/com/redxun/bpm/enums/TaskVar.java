package com.redxun.bpm.enums;

/**
 * 流程常用任务参数变量
 * @author mansan
 *
 */
public enum TaskVar {
	//当前用户相同
	SAME_USER_SET("saveUserSet"),
	//启动用户ID
	START_USER("startUser");
	
	private String varName;

	public String getVarName() {
		return varName;
	}
	
	TaskVar(String varName){
		this.varName=varName;
	}
}
