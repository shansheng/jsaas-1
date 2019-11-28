package com.redxun.bpm.core.entity.config;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 节点或流程的属性配置的基础类
 * @author csx
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BaseConfig implements Serializable{
	/**
	 * 前置处理器
	 */
	protected String preHandle=null;
	/**
	 * 后置处理器
	 */
	protected String afterHandle=null;
	
	protected List<BpmEventConfig> events=new ArrayList<BpmEventConfig>();
	
	public List<BpmEventConfig> getEvents() {
		return events;
	}

	public void setEvents(List<BpmEventConfig> events) {
		this.events = events;
	}

	public String getPreHandle() {
		return preHandle;
	}

	public void setPreHandle(String preHandle) {
		this.preHandle = preHandle;
	}

	public String getAfterHandle() {
		return afterHandle;
	}

	public void setAfterHandle(String afterHandle) {
		this.afterHandle = afterHandle;
	}
}
