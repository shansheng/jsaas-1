package com.redxun.bpm.activiti.handler;

import com.redxun.bpm.core.entity.BpmInst;

/**
 * 流程结束时的处理
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface ProcessEndHandler {
	
	public void endHandle(BpmInst bpmInst);
}
