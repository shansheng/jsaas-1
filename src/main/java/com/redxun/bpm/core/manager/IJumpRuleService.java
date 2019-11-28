package com.redxun.bpm.core.manager;

import com.redxun.bpm.core.entity.BpmInst;

public interface IJumpRuleService {
	
	/**
	 * 获取目标节点。
	 * @param solId
	 * @param nodeId
	 * @return
	 */
	String getTargetNode(BpmInst bpmInst,String nodeId);

}
