package com.redxun.bpm.activiti.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

/**
 * Activiti的流程定义
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActProcessDef  implements Serializable {
	//流程定义Id
	private String processDefId;
	//流程定义Key
	private String processKey;
	//流程定义名称
	private String processName;
	
	/**
	 * 发起节点。
	 */
	private String startNodeId="";
	
	private Map<String,ActNodeDef> nodesMap=new HashMap<String,ActNodeDef>();

	public String getProcessDefId() {
		return processDefId;
	}

	public void setProcessDefId(String processDefId) {
		this.processDefId = processDefId;
	}

	public String getProcessKey() {
		return processKey;
	}

	public void setProcessKey(String processKey) {
		this.processKey = processKey;
	}

	public Map<String, ActNodeDef> getNodesMap() {
		return nodesMap;
	}

	public void setNodesMap(Map<String, ActNodeDef> nodesMap) {
		this.nodesMap = nodesMap;
	}
	
	/**
	 * 返回流程定义的所有节点定义
	 * @return
	 */
	public Collection<ActNodeDef> getActNodeDefs(){
		return nodesMap.values();
	}

	public String getProcessName() {
		return processName;
	}

	public void setProcessName(String processName) {
		this.processName = processName;
	}

	public String getStartNodeId() {
		return startNodeId;
	}

	public void setStartNodeId(String startNodeId) {
		this.startNodeId = startNodeId;
	}
	
	
}
