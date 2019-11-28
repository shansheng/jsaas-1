package com.redxun.bpm.core.entity.config;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

/**
 * 任务会签投票特权配置
 * 
 * @author mansan
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class TaskVotePrivConfig implements Serializable{
	// 用戶
	public final static String USER = "USER";
	// 用戶組
	public final static String GROUP = "GROUP";

	// 用户类型,USER,GROUP
	private String identityType;

	// 用户或组ID
	private Set<String> identityIds = new HashSet<String>();
	
	// 投票占比数，如特权领导投票等于其他成员的3票，或占总投票的权重50%
	private Integer voteNums;
	
	public TaskVotePrivConfig() {
	
	}

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

	public Integer getVoteNums() {
		return voteNums;
	}

	public void setVoteNums(Integer voteNums) {
		this.voteNums = voteNums;
	}
	
	

}
