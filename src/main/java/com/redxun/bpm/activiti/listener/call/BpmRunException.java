package com.redxun.bpm.activiti.listener.call;

/**
 * Bpm运行时的异常
 * @author chshx
 *
 */
public class BpmRunException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public BpmRunException() {
		
	}
	
	public BpmRunException(String exception){
		super(exception);
	}
}
