package com.redxun.bpm.core.entity.config;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 多任务实例的会签人员配置
 * 
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class MultiTaskConfig implements Serializable{
	//投票通过
	public final static String VOTE_TYPE_PASS="PASS";
	//投票反对
	public final static String VOTE_TYPE_REFUSE="REFUSE";
	//投票直接通过
	public final static String HANDLE_TYPE_DIRECT="DIRECT";
	//投票等待处理
	public final static String HANDLE_TYPE_WAIT_TO="WAIT_TO";
	//投票的计算类型，数字
	public final static String CAL_TYPE_NUMS="NUMS";
	//投票的计算类型，百份比类型
	public final static String CAL_TYPE_PERCENT="PERCENT";
	
	// 投票的类型
	private String voteResultType; // PASS,REFUSE
	// 投票结果类型
	private String handleType;// DIRECT,WAIT
	// 投票的计算类型
	private String calType;// NUMS,PERCENT;
	// 投票的值
	private Integer voteValue;
	// 投票特权的配置
	private List<TaskVotePrivConfig> votePrivConfigs = new ArrayList<TaskVotePrivConfig>();
	// 允许人员加签
	private List<TaskIdentityConfig> addSignConfigs = new ArrayList<TaskIdentityConfig>();

	public String getVoteResultType() {
		return voteResultType;
	}

	public void setVoteResultType(String voteResultType) {
		this.voteResultType = voteResultType;
	}

	public String getHandleType() {
		return handleType;
	}

	public void setHandleType(String handleType) {
		this.handleType = handleType;
	}

	
	public String getCalType() {
		return calType;
	}

	public void setCalType(String calType) {
		this.calType = calType;
	}

	public Integer getVoteValue() {
		return voteValue;
	}

	public void setVoteValue(Integer voteValue) {
		this.voteValue = voteValue;
	}

	public List<TaskVotePrivConfig> getVotePrivConfigs() {
		return votePrivConfigs;
	}

	public void setVotePrivConfigs(List<TaskVotePrivConfig> votePrivConfigs) {
		this.votePrivConfigs = votePrivConfigs;
	}

	public List<TaskIdentityConfig> getAddSignConfigs() {
		return addSignConfigs;
	}

	public void setAddSignConfigs(List<TaskIdentityConfig> addSignConfigs) {
		this.addSignConfigs = addSignConfigs;
	}
	
	public static MultiTaskConfig getDefaultConfig(){
		MultiTaskConfig config=new MultiTaskConfig();
		config.setVoteResultType(VOTE_TYPE_PASS);
		config.setHandleType(HANDLE_TYPE_WAIT_TO);
		config.setCalType(CAL_TYPE_PERCENT);
		config.setVoteValue(100);
		
		return config;
	}

}
