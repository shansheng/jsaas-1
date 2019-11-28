package com.redxun.bpm.activiti.event;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.context.ApplicationEvent;

import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.config.UserTaskConfig;

/**
 * 
 * 
 * <pre>
 * 描述：任务创建监听器
 * 作者：cjx
 * 邮箱:keith@redxun.cn
 * 日期:2016年5月7日-下午2:17:18
 * 版权：广州红迅软件有限公司
 * </pre>
 */
public class TaskCreateApplicationEvent extends ApplicationEvent {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6132554545592656578L;
	
	
	private UserTaskConfig userConfig;
	private BpmInst bpmInst;
	
	public TaskCreateApplicationEvent(final TaskEntity taskEntity) {
		super(taskEntity);
	}
	
	
	public TaskCreateApplicationEvent(final TaskEntity taskEntity,UserTaskConfig userTaskConfig ) {
		super(taskEntity);
		this.userConfig=userTaskConfig;
	}
	
	public void setBpmInst(BpmInst bpmInst){
		this.bpmInst=bpmInst;
	}
	
	public UserTaskConfig getConfig(){
		return this.userConfig;
	}
	
	public BpmInst getBpmInst(){
		return this.bpmInst;
	}
	
	
}
