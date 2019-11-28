package com.redxun.bpm.core.entity.config;

/**
 * 
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class StartEventConfig extends BaseConfig {
	// 是否允许执行任务时选择下一步的执行路径
	protected String allowPathSelect = "false";
	// 是否允许配置下一步的执行人
	protected String allowNextExecutor = "false";

	public String getAllowPathSelect() {
		return allowPathSelect;
	}

	public void setAllowPathSelect(String allowPathSelect) {
		this.allowPathSelect = allowPathSelect;
	}

	public String getAllowNextExecutor() {
		return allowNextExecutor;
	}

	public void setAllowNextExecutor(String allowNextExecutor) {
		this.allowNextExecutor = allowNextExecutor;
	}

	
}
