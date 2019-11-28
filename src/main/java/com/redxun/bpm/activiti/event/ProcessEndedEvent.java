package com.redxun.bpm.activiti.event;

import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.springframework.context.ApplicationEvent;

/**
 * 流程结束事件。
 * @author ray
 *
 */
public class ProcessEndedEvent  extends ApplicationEvent {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7048421356102474974L;

	public ProcessEndedEvent(ExecutionEntity ent) {
		super(ent);
	}

}
