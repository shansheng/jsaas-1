package com.redxun.bpm.core.entity.config;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * 任务人员配置
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class TaskIdentityConfig implements Serializable{
	public final static String All_USER="SIGN_USER";
	
	//用戶
	public final static String USER="USER";
	//用戶組
	public final static String GROUP="GROUP";
	
	//用户类型,USER,GROUP
	private String identityType;
	
	//用户或组ID
	private Set<String> identityIds=new HashSet<String>();

	public String getIdentityType() {
		return identityType;
	}

	public void setIdentityType(String identityType) {
		this.identityType = identityType;
	}

	public Set<String> getIdentityIds() {
		return identityIds;
	}

	public void setIdentityIds(Set<String> identityIds) {
		this.identityIds = identityIds;
	}

	public TaskIdentityConfig() {
		
	}
	
}
