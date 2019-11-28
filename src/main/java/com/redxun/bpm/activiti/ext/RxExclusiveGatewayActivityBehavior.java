package com.redxun.bpm.activiti.ext;



import java.util.Iterator;
import java.util.Map;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.impl.bpmn.behavior.ExclusiveGatewayActivityBehavior;
import org.activiti.engine.impl.bpmn.helper.SkipExpressionUtil;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.AbstractExecutionCmd;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.config.ExclusiveGatewayConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;

public class RxExclusiveGatewayActivityBehavior extends ExclusiveGatewayActivityBehavior {
	  
	  private static final long serialVersionUID = 1L;
	  
	  protected static Logger logger=LogManager.getLogger(RxExclusiveGatewayActivityBehavior.class);
	  
	  /**
	   * The default behaviour of BPMN, taking every outgoing sequence flow
	   * (where the condition evaluates to true), is not valid for an exclusive
	   * gateway. 
	   * 
	   * Hence, this behaviour is overriden and replaced by the correct behavior:
	   * selecting the first sequence flow which condition evaluates to true
	   * (or which hasn't got a condition) and leaving the activity through that
	   * sequence flow. 
	   * 
	   * If no sequence flow is selected (ie all conditions evaluate to false),
	   * then the default sequence flow is taken (if defined).
	   */
	  @Override
	  protected void leave(ActivityExecution execution) {
	    
	    if (logger.isDebugEnabled()) {
	      logger.debug("Leaving activity '{}'", execution.getActivity().getId());
	    }
	    
	    String solId=(String)execution.getVariable("solId");
		String nodeId=execution.getActivity().getId();
		
		BpmNodeSetManager bpmNodeSetManager=AppBeanUtil.getBean(BpmNodeSetManager.class);
		BpmSolutionManager bpmSolutionManager=AppBeanUtil.getBean(BpmSolutionManager.class);
		GroovyEngine groovyEngine=AppBeanUtil.getBean(GroovyEngine.class);
		ExclusiveGatewayConfig configs=bpmNodeSetManager.getExclusiveGatewayConfig(solId,execution.getProcessDefinitionId(), nodeId);
		
		Map<String,String> scriptMap=DefUtil. getConditionMap(configs);
	    
	    PvmTransition outgoingSeqFlow = null;
	    String defaultSequenceFlow = (String) execution.getActivity().getProperty("default");
	    Iterator<PvmTransition> transitionIterator = execution.getActivity().getOutgoingTransitions().iterator();
	    while (outgoingSeqFlow == null && transitionIterator.hasNext()) {
	      PvmTransition seqFlow = transitionIterator.next();
	      Expression skipExpression = seqFlow.getSkipExpression();
	      
	      if (!SkipExpressionUtil.isSkipExpressionEnabled(execution, skipExpression)) {
	    	  	String script=scriptMap.get(seqFlow.getDestination().getId());
	        	//脚本为空
	        	if(StringUtil.isEmpty(script)){
	        		 outgoingSeqFlow = seqFlow;
	        	}
	        	//脚本不为空
	        	else{
	        		Map<String,Object> model=ActivitUtil.getContextData(execution);
	        		AbstractExecutionCmd cmd= (AbstractExecutionCmd) model.get("cmd");
	        		Map<String,Object> vars=(Map<String, Object>) model.get("vars");
	        		
	    			if(cmd!=null) {
	    				model.put("cmd", cmd);
	    				//获取表单数据
	    				BpmSolution bpmSolution = bpmSolutionManager.get(solId);
	    				JSONObject data = JSONObject.parseObject(cmd.getJsonData());
	    				Map<String, Object> modelFieldMap =BoDataUtil.getModelFieldsFromBoJsonsBoIds(data,bpmSolution.getBoDefId());
	    				vars.put("jsonData", modelFieldMap);
	    				vars.putAll(cmd.getVars());
	    			}
	        		Object boolVal = groovyEngine.executeScripts(script, model);
	        		if (boolVal instanceof Boolean) {
						if (((Boolean) boolVal)) {// 符合条件
							outgoingSeqFlow = seqFlow;
						}
					}
	        	} 
	      }
	      else if (SkipExpressionUtil.shouldSkipFlowElement(execution, skipExpression)){
	        outgoingSeqFlow = seqFlow;
	      }
	    }
	    
	    if (outgoingSeqFlow != null) {
	      //记录路径
    	  ActivitUtil.createPath(execution);
	      execution.take(outgoingSeqFlow);
	    } else {
	      
	      if (defaultSequenceFlow != null) {
	        PvmTransition defaultTransition = execution.getActivity().findOutgoingTransition(defaultSequenceFlow);
	        if (defaultTransition != null) {
	          //记录路径
	      	  ActivitUtil.createPath(execution);
	          execution.take(defaultTransition);
	        } else {
	          throw new ActivitiException("Default sequence flow '" + defaultSequenceFlow + "' not found");
	        }
	      } else {
	        //No sequence flow could be found, not even a default one
	        throw new ActivitiException("No outgoing sequence flow of the exclusive gateway '"
	              + execution.getActivity().getId() + "' could be selected for continuing the process");
	      }
	    }
	  }
}
