package com.redxun.bpm.activiti.ext;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.delegate.BpmnError;
import org.activiti.engine.impl.bpmn.behavior.AbstractBpmnActivityBehavior;
import org.activiti.engine.impl.bpmn.behavior.SequentialMultiInstanceBehavior;
import org.activiti.engine.impl.pvm.delegate.ActivityBehavior;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.activiti.engine.impl.pvm.process.ActivityImpl;

public class SequentialMultiInstanceBehaviorExt extends SequentialMultiInstanceBehavior{
	
	 public SequentialMultiInstanceBehaviorExt(ActivityImpl activity, AbstractBpmnActivityBehavior innerActivityBehavior) {
		    super(activity, innerActivityBehavior);
	}
	/**
	   * Called when the wrapped {@link ActivityBehavior} calls the 
	   * {@link AbstractBpmnActivityBehavior#leave(ActivityExecution)} method.
	   * Handles the completion of one instance, and executes the logic for the sequential behavior.    
	   */
	  public void leave(ActivityExecution execution) {
	    int loopCounter = getLoopVariable(execution, getCollectionElementIndexVariable()) + 1;
	    int nrOfInstances = getLoopVariable(execution, NUMBER_OF_INSTANCES);
	    int nrOfCompletedInstances = getLoopVariable(execution, NUMBER_OF_COMPLETED_INSTANCES) + 1;
	    int nrOfActiveInstances = getLoopVariable(execution, NUMBER_OF_ACTIVE_INSTANCES);
	    
	    if (loopCounter != nrOfInstances && !completionConditionSatisfied(execution)) {
	      callActivityEndListeners(execution);
	    }
	    
	    setLoopVariable(execution, getCollectionElementIndexVariable(), loopCounter);
	    setLoopVariable(execution, NUMBER_OF_COMPLETED_INSTANCES, nrOfCompletedInstances);
	    logLoopDetails(execution, "instance completed", loopCounter, nrOfCompletedInstances, nrOfActiveInstances, nrOfInstances);
	    
	    if (loopCounter >= nrOfInstances || completionConditionSatisfied(execution)) {
	      super.leave(execution);
	    } else {
	      try {
	        executeOriginalBehavior(execution, loopCounter);
	      } catch (BpmnError error) {
	        // re-throw business fault so that it can be caught by an Error Intermediate Event or Error Event Sub-Process in the process
	        throw error;
	      } catch (Exception e) {
	        throw new ActivitiException("Could not execute inner activity behavior of multi instance behavior", e);
	      }
	    }
	  }
}
