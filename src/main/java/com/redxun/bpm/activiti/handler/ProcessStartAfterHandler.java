package com.redxun.bpm.activiti.handler;

import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.entity.config.ProcessConfig;

/**
 * 流程的后置事件执行处理
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface ProcessStartAfterHandler {
	/**
	 * 后置处理
	 * @param processConfig
	 * @param cmd
	 * @param bpmInst
	 *  cmd的jsonData格式如下
	 * <pre>
	 * {
			"bos": [{
				"boDefId": "2610000001080003",
				"formKey": "LoanCase",
				"data": {
					"ajh": "CN201804130009",
					"ajm": "3333333333333333",
					"ms": "233333"
				}
			}]
		}
		</pre>
	 * @param actInstId		流程实例ID
	 * @return 返回数据的业务主键值
	 */
	String processStartAfterHandle(ProcessConfig processConfig,ProcessStartCmd cmd,BpmInst bpmInst);
}
