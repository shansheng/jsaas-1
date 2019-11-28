package com.redxun.bpm.activiti.ext;

import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.impl.bpmn.behavior.AbstractBpmnActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.ParallelMultiInstanceBehavior;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.pvm.delegate.ActivityBehavior;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
/**
 * 重写原生类,目标就是为了增加完成会签行为时,实现节点的的人员变量移除
 * @author mansan
 *
 */
public class ParallelMultiInstanceBehaviorExt extends ParallelMultiInstanceBehavior{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public ParallelMultiInstanceBehaviorExt(ActivityImpl activity, AbstractBpmnActivityBehavior originalActivityBehavior) {
		super(activity, originalActivityBehavior);
	}
	
	  /**
	   * Called when the wrapped {@link ActivityBehavior} calls the 
	   * {@link AbstractBpmnActivityBehavior#leave(ActivityExecution)} method.
	   * Handles the completion of one of the parallel instances
	   */
	  public void leave(ActivityExecution execution) {
	    callActivityEndListeners(execution);
	    
	    if (resolveNrOfInstances(execution) == 0) {
	    	// Empty collection, just leave.
	    	super.leave(execution);
	    }
	    
	    int loopCounter = getLoopVariable(execution, getCollectionElementIndexVariable());
	    int nrOfInstances = getLoopVariable(execution, NUMBER_OF_INSTANCES);
	    int nrOfCompletedInstances = getLoopVariable(execution, NUMBER_OF_COMPLETED_INSTANCES) + 1;
	    int nrOfActiveInstances = getLoopVariable(execution, NUMBER_OF_ACTIVE_INSTANCES) - 1;
	    
	    if (isExtraScopeNeeded()) {
	      // In case an extra scope was created, it must be destroyed first before going further
	      ExecutionEntity extraScope = (ExecutionEntity) execution;
	      execution = execution.getParent();
	      extraScope.remove();
	    }
	    
	    if (execution.getParent() != null) { // will be null in case of empty collection
	    	setLoopVariable(execution.getParent(), NUMBER_OF_COMPLETED_INSTANCES, nrOfCompletedInstances);
	    	setLoopVariable(execution.getParent(), NUMBER_OF_ACTIVE_INSTANCES, nrOfActiveInstances);
	    }
	    logLoopDetails(execution, "instance completed", loopCounter, nrOfCompletedInstances, nrOfActiveInstances, nrOfInstances);
	    
	    ExecutionEntity executionEntity = (ExecutionEntity) execution;
	    
	    if (executionEntity.getParent() != null) {
	    
		    executionEntity.inactivate();
		    executionEntity.getParent().forceUpdate();
		    
		    List<ActivityExecution> joinedExecutions = executionEntity.findInactiveConcurrentExecutions(execution.getActivity());
		    //调左右条件
		    if (completionConditionSatisfied(execution) || joinedExecutions.size() >= nrOfInstances ) {
		      // Removing all active child executions (ie because completionCondition is true)
		      List<ExecutionEntity> executionsToRemove = new ArrayList<ExecutionEntity>();
		      for (ActivityExecution childExecution : executionEntity.getParent().getExecutions()) {
		        if (childExecution.isActive()) {
		          executionsToRemove.add((ExecutionEntity) childExecution);
		        }
		      }
		      for (ExecutionEntity executionToRemove : executionsToRemove) {
		        if (LOGGER.isDebugEnabled()) {
		          LOGGER.debug("Execution {} still active, but multi-instance is completed. Removing this execution.", executionToRemove);
		        }
		        executionToRemove.inactivate();
		        executionToRemove.deleteCascade("multi-instance completed");
		      }
		      
		      //当完成后,直接把原来的变量删除
		      executionEntity.getParent().removeVariable("signUserIds_"+execution.getActivity().getId());
		      
		      executionEntity.takeAll(executionEntity.getActivity().getOutgoingTransitions(), joinedExecutions);
		      
		    } 
		    
	    } else {
	    	super.leave(executionEntity);
	    }
	  }

}
