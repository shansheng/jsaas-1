package com.redxun.bpm.activiti.ext;


import java.util.List;

import org.activiti.engine.impl.bpmn.behavior.ParallelGatewayActivityBehavior;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class RxParallelGatewayActivityBehavior extends ParallelGatewayActivityBehavior{
	  private static final long serialVersionUID = 1L;
	  
	  protected static Logger logger=LogManager.getLogger(RxParallelGatewayActivityBehavior.class);

	  public void execute(ActivityExecution execution) throws Exception { 
	    
	    // Join
	    PvmActivity activity = execution.getActivity();
	    List<PvmTransition> outgoingTransitions = execution.getActivity().getOutgoingTransitions();
	    execution.inactivate();
	    lockConcurrentRoot(execution);
	    
	    List<ActivityExecution> joinedExecutions = execution.findInactiveConcurrentExecutions(activity);
	    int nbrOfExecutionsToJoin = execution.getActivity().getIncomingTransitions().size();
	    int nbrOfExecutionsJoined = joinedExecutions.size();
	    Context.getCommandContext().getHistoryManager().recordActivityEnd((ExecutionEntity) execution);
	    
	    
	    
	    if (nbrOfExecutionsJoined==nbrOfExecutionsToJoin) {
	    	//记录路径
	    	ActivitUtil.createPath( execution);
	      // Fork
	      if(logger.isDebugEnabled()) {
	    	  logger.debug("parallel gateway '{}' activates: {} of {} joined", activity.getId(), nbrOfExecutionsJoined, nbrOfExecutionsToJoin);
	      }
	      execution.takeAll(outgoingTransitions, joinedExecutions);
	      
	    } else if (logger.isDebugEnabled()){
	    	logger.debug("parallel gateway '{}' does not activate: {} of {} joined", activity.getId(), nbrOfExecutionsJoined, nbrOfExecutionsToJoin);
	    }
	  }
	  
	  
}
