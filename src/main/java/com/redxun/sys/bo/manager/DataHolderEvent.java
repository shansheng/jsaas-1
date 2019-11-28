package com.redxun.sys.bo.manager;

import org.springframework.context.ApplicationEvent;

public class DataHolderEvent extends ApplicationEvent {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4306831143182332361L;

	public DataHolderEvent(DataHolder ent) {
		super(ent);
	}

}
