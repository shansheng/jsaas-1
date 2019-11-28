package com.redxun.bpm.activiti.ext;

import org.activiti.bpmn.model.ExclusiveGateway;
import org.activiti.bpmn.model.InclusiveGateway;
import org.activiti.bpmn.model.ParallelGateway;
import org.activiti.engine.impl.bpmn.behavior.AbstractBpmnActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.ExclusiveGatewayActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.InclusiveGatewayActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.ParallelGatewayActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.ParallelMultiInstanceBehavior;
import org.activiti.engine.impl.bpmn.behavior.SequentialMultiInstanceBehavior;
import org.activiti.engine.impl.bpmn.parser.factory.DefaultActivityBehaviorFactory;
import org.activiti.engine.impl.pvm.process.ActivityImpl;

/**
 * 扩展缺省的流程节点默认工厂类，实现对Activiti节点的执行的默认行为的更改
 * @author keitch
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActivityBehaviorFactoryExt extends DefaultActivityBehaviorFactory {
	
	private RxExclusiveGatewayActivityBehavior exclusiveGatewayActivityBehaviorExt;
	
	private RxInclusiveGatewayActivityBehavior inclusiveGatewayActivityBehaviorExt;
	
	private RxParallelGatewayActivityBehavior parallelGatewayActivityBehavior;
	
	/**
	 * 通过Spring容器注入新的分支条件行为执行类
	 * @param exclusiveGatewayActivityBehaviorExt
	 */
	public void setExclusiveGatewayActivityBehaviorExt(RxExclusiveGatewayActivityBehavior exclusiveGatewayActivityBehaviorExt) {
		this.exclusiveGatewayActivityBehaviorExt = exclusiveGatewayActivityBehaviorExt;
	}
	
	//重写父类中的分支条件行为执行类
	@Override
	public ExclusiveGatewayActivityBehavior createExclusiveGatewayActivityBehavior(ExclusiveGateway exclusiveGateway) {
		return exclusiveGatewayActivityBehaviorExt;
	}
	
	public ParallelMultiInstanceBehavior createParallelMultiInstanceBehavior(ActivityImpl activity, AbstractBpmnActivityBehavior innerActivityBehavior) {
		 return new ParallelMultiInstanceBehaviorExt(activity, innerActivityBehavior);
	}
	
	public SequentialMultiInstanceBehavior createSequentialMultiInstanceBehavior(ActivityImpl activity, AbstractBpmnActivityBehavior innerActivityBehavior) {
		return new SequentialMultiInstanceBehaviorExt(activity, innerActivityBehavior);
	}


	public void setInclusiveGatewayActivityBehaviorExt(RxInclusiveGatewayActivityBehavior inclusiveGatewayActivityBehaviorExt) {
		this.inclusiveGatewayActivityBehaviorExt = inclusiveGatewayActivityBehaviorExt;
	}
	
	@Override
	public InclusiveGatewayActivityBehavior createInclusiveGatewayActivityBehavior(InclusiveGateway inclusiveGateway) {
		return this.inclusiveGatewayActivityBehaviorExt;
	}

	public void setParallelGatewayActivityBehaviorExt(RxParallelGatewayActivityBehavior parallelGatewayActivityBehavior){
		this.parallelGatewayActivityBehavior=parallelGatewayActivityBehavior;
	}
	
	
	@Override
	public ParallelGatewayActivityBehavior createParallelGatewayActivityBehavior(ParallelGateway parallelGateway) {
		return this.parallelGatewayActivityBehavior;
	}
	

}
