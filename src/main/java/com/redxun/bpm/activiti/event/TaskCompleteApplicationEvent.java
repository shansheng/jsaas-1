package com.redxun.bpm.activiti.event;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.context.ApplicationEvent;

/**
 * 
 * 
 * <pre>
 * 描述：任务完成监听器
 * 作者：cjx
 * 邮箱:chshxuan@163.com
 * 日期:2016年5月7日-下午2:17:18
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 * </pre>
 */
public class TaskCompleteApplicationEvent extends ApplicationEvent {
	public TaskCompleteApplicationEvent(final TaskEntity taskEntity) {
		super(taskEntity);
	}
}
