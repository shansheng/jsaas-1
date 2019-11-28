package com.redxun.bpm.core.entity.config;

import java.io.Serializable;

/**
 * 节点执行脚本配置
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class NodeExecuteScript implements Serializable{
	//节点Id
	private String nodeId;
	//条件脚本表达式
	private String condition;
	
	
	public String getNodeId() {
		return nodeId;
	}
	
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	
	public String getCondition() {
		return condition;
	}
	
	public void setCondition(String condition) {
		this.condition = condition;
	}
}
