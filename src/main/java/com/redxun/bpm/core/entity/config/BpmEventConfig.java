package com.redxun.bpm.core.entity.config;

import java.io.Serializable;

/**
 * 事件配置信息
 * @author csx
 *@Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class BpmEventConfig implements Serializable{
	//事件Key
	private String eventKey;
	//事件名称
	private String eventName;
	//事件脚本
	private String script;
	
	public BpmEventConfig() {
		
	}
	
	public BpmEventConfig(String eventKey,String eventName,String script){
		this.eventKey=eventKey;
		this.eventName=eventName;
		this.script=script;
	}
	
	public BpmEventConfig(String eventKey,String eventName,String script,String dbAlias){
		this.eventKey=eventKey;
		this.eventName=eventName;
		this.script=script;

	}
	
	public String getEventKey() {
		return eventKey;
	}
	public void setEventKey(String eventKey) {
		this.eventKey = eventKey;
	}
	public String getScript() {
		return script;
	}
	public void setScript(String script) {
		this.script = script;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	
}
