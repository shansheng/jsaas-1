package com.redxun.bpm.activiti.event;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.context.ApplicationEvent;

public class NoAssignEvent extends ApplicationEvent{

	public NoAssignEvent(final TaskEntity taskEntity) {
		super(taskEntity);
	}

	/**
	 */
	private static final long serialVersionUID = 3307669030117332677L;

}
