package com.redxun.bpm.activiti.ext;



import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.impl.bpmn.behavior.InclusiveGatewayActivityBehavior;
import org.activiti.engine.impl.bpmn.helper.SkipExpressionUtil;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.core.entity.config.ExclusiveGatewayConfig;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;

public class RxInclusiveGatewayActivityBehavior extends InclusiveGatewayActivityBehavior {
	
	private static final long serialVersionUID = 1L;
	  
	  protected static Logger logger=LogManager.getLogger(RxInclusiveGatewayActivityBehavior.class);

	  public void execute(ActivityExecution execution) throws Exception {
		String solId = (String) execution.getVariable("solId");
		String nodeId = execution.getActivity().getId();
		
		BpmNodeSetManager bpmNodeSetManager=AppBeanUtil.getBean(BpmNodeSetManager.class);
		GroovyEngine groovyEngine=AppBeanUtil.getBean(GroovyEngine.class);
		
		// 分支网关与条件网关共用一样的配置
		ExclusiveGatewayConfig configs = bpmNodeSetManager.getExclusiveGatewayConfig(solId,execution.getProcessDefinitionId(), nodeId);
		Map<String,String> scriptMap=DefUtil. getConditionMap(configs);
		  
	    execution.inactivate();
	    lockConcurrentRoot(execution);
	    
	    PvmActivity activity = execution.getActivity();
	    if (!activeConcurrentExecutionsExist(execution)) {

	      if (logger.isDebugEnabled()) {
	    	  logger.debug("inclusive gateway '{}' activates", activity.getId());
	      }

	      List<ActivityExecution> joinedExecutions = execution.findInactiveConcurrentExecutions(activity);
	      String defaultSequenceFlow = (String) execution.getActivity().getProperty("default");
	      List<PvmTransition> transitionsToTake = new ArrayList<PvmTransition>();

	      for (PvmTransition outgoingTransition : execution.getActivity().getOutgoingTransitions()) {
	        Expression skipExpression = outgoingTransition.getSkipExpression();
	        if (!SkipExpressionUtil.isSkipExpressionEnabled(execution, skipExpression)) {
	          if (defaultSequenceFlow == null || !outgoingTransition.getId().equals(defaultSequenceFlow)) {
	        	String script=scriptMap.get(outgoingTransition.getDestination().getId());
	        	//脚本为空
	        	if(StringUtil.isEmpty(script)){
	        		transitionsToTake.add(outgoingTransition);
	        	}
	        	//脚本不为空
	        	else{
	        		Map<String,Object> model=ActivitUtil.getContextData(execution);
	        		Object boolVal = groovyEngine.executeScripts(script, model);
	        		if (boolVal instanceof Boolean) {
						if (((Boolean) boolVal)) {// 符合条件
							 transitionsToTake.add(outgoingTransition);
						}
					}
	        	}
	          }
	        }
	        else if (SkipExpressionUtil.shouldSkipFlowElement(execution, skipExpression)){
	          transitionsToTake.add(outgoingTransition);
	        }
	      }

	      if (!transitionsToTake.isEmpty()) {
	    	  //记录路径
	    	  ActivitUtil.createPath( execution);
	        execution.takeAll(transitionsToTake, joinedExecutions);

	      } else {

	        if (defaultSequenceFlow != null) {
	          PvmTransition defaultTransition = execution.getActivity().findOutgoingTransition(defaultSequenceFlow);
	          if (defaultTransition != null) {
	        	  //记录路径
	        	  ActivitUtil.createPath( execution);
	            execution.take(defaultTransition);
	          } else {
	            throw new ActivitiException("Default sequence flow '"
	                + defaultSequenceFlow + "' could not be not found");
	          }
	        } else {
	          // No sequence flow could be found, not even a default one
	          throw new ActivitiException(
	              "No outgoing sequence flow of the inclusive gateway '"
	                  + execution.getActivity().getId()
	                  + "' could be selected for continuing the process");
	        }
	      }

	    } else {
	      if (logger.isDebugEnabled()) {
	    	  logger.debug("Inclusive gateway '{}' does not activate", activity.getId());
	      }
	    }
	  }

	  List<? extends ActivityExecution> getLeaveExecutions(ActivityExecution parent) {
	    List<ActivityExecution> executionlist = new ArrayList<ActivityExecution>();
	    List<? extends ActivityExecution> subExecutions = parent.getExecutions();
	    if (subExecutions.isEmpty()) {
	      executionlist.add(parent);
	    } else {
	      for (ActivityExecution concurrentExecution : subExecutions) {
	        executionlist.addAll(getLeaveExecutions(concurrentExecution));
	      }
	    }
	    return executionlist;
	  }
	  
	  

	  public boolean activeConcurrentExecutionsExist(ActivityExecution execution) {
	    PvmActivity activity = execution.getActivity();
	    if (execution.isConcurrent()) {
	      for (ActivityExecution concurrentExecution : getLeaveExecutions(execution.getParent())) {
	        if (concurrentExecution.isActive() && concurrentExecution.getId().equals(execution.getId()) == false) {
	          // TODO: when is transitionBeingTaken cleared? Should we clear it?
	          boolean reachable = false;
	          PvmTransition pvmTransition = ((ExecutionEntity) concurrentExecution).getTransitionBeingTaken();
	          if (pvmTransition != null) {
	            reachable = isReachable(pvmTransition.getDestination(), activity, new HashSet<PvmActivity>());
	          } else {
	            reachable = isReachable(concurrentExecution.getActivity(), activity, new HashSet<PvmActivity>());
	          }
	          
	          if (reachable) {
	            if (logger.isDebugEnabled()) {
	            	logger.debug("an active concurrent execution found: '{}'", concurrentExecution.getActivity());
	            }
	            return true;
	          }
	        }
	      }
	    } else if (execution.isActive()) { // is this ever true?
	      if (logger.isDebugEnabled()) {
	    	  logger.debug("an active concurrent execution found: '{}'", execution.getActivity());
	      }
	      return true;
	    }

	    return false;
	  }

	  protected boolean isReachable(PvmActivity srcActivity,
	      PvmActivity targetActivity, Set<PvmActivity> visitedActivities) {

	    // if source has no outputs, it is the end of the process, and its parent process should be checked.
	    if (srcActivity.getOutgoingTransitions().isEmpty()) {
	      visitedActivities.add(srcActivity);
	      if (!(srcActivity.getParent() instanceof PvmActivity)) {
	        return false;
	      }
	      srcActivity = (PvmActivity) srcActivity.getParent();
	    }

	    if (srcActivity.equals(targetActivity)) {
	      return true;
	    }

	    // To avoid infinite looping, we must capture every node we visit
	    // and check before going further in the graph if we have already visitied
	    // the node.
	    visitedActivities.add(srcActivity);

	    List<PvmTransition> transitionList = srcActivity.getOutgoingTransitions();
	    if (transitionList != null && !transitionList.isEmpty()) {
	      for (PvmTransition pvmTransition : transitionList) {
	        PvmActivity destinationActivity = pvmTransition.getDestination();
	        if (destinationActivity != null && !visitedActivities.contains(destinationActivity)) {
	          boolean reachable = isReachable(destinationActivity, targetActivity, visitedActivities);

	          // If false, we should investigate other paths, and not yet return the
	          // result
	          if (reachable) {
	            return true;
	          }

	        }
	      }
	    }
	    return false;
	  }

}
