package com.redxun.bpm.activiti.cmd;

import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
/**
 * 流程实例结束命令
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 *
 */
public class ProcessInstanceEndCmd  implements Command<Void>{
	private String processInstanceId=null;
	
	public ProcessInstanceEndCmd(String processInstanceId){
		this.processInstanceId=processInstanceId;
	}
	
	@Override
	public Void execute(CommandContext cmdContext) {
		ExecutionEntity executionEntity =cmdContext.getExecutionEntityManager().findExecutionById(processInstanceId);
		ExecutionEntity parentEnt= getTopExecution(executionEntity);
		parentEnt.end();
		return null;
	}
	
	private ExecutionEntity getTopExecution(ExecutionEntity executionEntity){
		ExecutionEntity parentEnt= executionEntity.getParent();
		if(parentEnt==null){
			return executionEntity;
		}
		return getTopExecution(parentEnt);
	}

}
