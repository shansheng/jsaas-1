package com.redxun.bpm.activiti.ext;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.impl.bpmn.behavior.ExclusiveGatewayActivityBehavior;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.TransitionImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.ProcessStartCmd;
import com.redxun.bpm.core.entity.config.ExclusiveGatewayConfig;
import com.redxun.bpm.core.entity.config.NodeExecuteScript;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.StringUtil;
/**
 * 对网关的条件判断，优先使用扩展的配置
 * @author keitch
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@SuppressWarnings("serial")
public class ExclusiveGatewayActivityBehaviorExt extends ExclusiveGatewayActivityBehavior{
	
	
	protected static Logger logger=LogManager.getLogger(ExclusiveGatewayActivityBehaviorExt.class);
	
	
	@Override
	protected void leave(ActivityExecution execution) {
		
		logger.debug("enter ExclusiveGatewayActivityBehaviorExt=======================");
		if (logger.isDebugEnabled()) {
			logger.debug("Leaving activity '{}'", execution.getActivity().getId());
		 }
		String solId=(String)execution.getVariable("solId");
		String nodeId=execution.getActivity().getId();
		logger.debug("solid is {} and nodeId is {}",solId,nodeId);
		boolean isTakeCondition=false;
		if(StringUtils.isNotEmpty(solId)&& StringUtils.isNotBlank(nodeId)){
			BpmNodeSetManager bpmNodeSetManager=AppBeanUtil.getBean(BpmNodeSetManager.class);
			GroovyEngine groovyEngine=AppBeanUtil.getBean(GroovyEngine.class);
			
			ExclusiveGatewayConfig configs=bpmNodeSetManager.getExclusiveGatewayConfig(solId,execution.getProcessDefinitionId(), nodeId);
			
			for(NodeExecuteScript script:configs.getConditions()){
				String destNodeId=script.getNodeId();
				String condition=script.getCondition();
				logger.debug("dest node:{}, condition is {}",destNodeId,condition);
				try{
					//执行脚本引擎
					Object boolVal=groovyEngine.executeScripts(condition, execution.getVariables());
					if(boolVal instanceof Boolean){
						Boolean returnVal=(Boolean)boolVal;//符合条件
						if(returnVal==true){
							//找到符合条件的目标节点并且进行跳转
							Iterator<PvmTransition> transitionIterator = execution.getActivity().getOutgoingTransitions().iterator();
							while (transitionIterator.hasNext()) {
							      PvmTransition seqFlow = transitionIterator.next();
							      if(destNodeId.equals(seqFlow.getDestination().getId())){
							    	  execution.take(seqFlow);
							    	  isTakeCondition=true;
							    	  return;
							      }
							}
						}
					}else{
						ProcessHandleHelper.addErrorMsg("表达式: \n "+condition+" \n 返回值不为布尔值(true or false)");
					}
				}catch(Exception ex){
					ProcessHandleHelper.addErrorMsg("节点["+nodeId+"]的判断表达式:\n "+condition+"执行有错误！错误如下：\n"+ex.getMessage());
				}
			}
		}
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		if(!isTakeCondition){
			if(cmd instanceof ProcessStartCmd){
				try{
					boolean rtn=backToOrgNode(execution);
					if(rtn)	return;
				}catch(Exception ex){
					ProcessHandleHelper.addErrorMsg("节点分支["+nodeId+"]没有满足的配置条件，请联系管理员！");
				}
			}
			throw new RuntimeException("节点分支["+nodeId+"]没有满足的配置条件，请联系管理员！");
		}
		
		//执行父类的写法，以使其还是可以支持旧式的在跳出线上写条件的做法  
		//super.leave(execution);
		
	}
	
	/**
	 * 回到原节点上
	 * @param execution
	 * @throws Exception
	 */
	public synchronized boolean backToOrgNode(ActivityExecution execution) throws Exception{
		IExecutionCmd cmd=ProcessHandleHelper.getProcessCmd();
		String handledNodeId=cmd.getHandleNodeId();
		if(StringUtil.isEmpty(handledNodeId)) return false;
		
		//记录原来的后续连接跳转
		ActivityImpl curAct=(ActivityImpl)execution.getActivity();
		List<PvmTransition> oldTransitions=new ArrayList<PvmTransition>();
		oldTransitions.addAll(curAct.getOutgoingTransitions());

		
		RepositoryService repositoryService=AppBeanUtil.getBean(RepositoryService.class);
		ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity)repositoryService.getProcessDefinition(execution.getProcessDefinitionId());
		//找到原来的节点Id
		ActivityImpl orgAct=processDefinition.findActivity(handledNodeId);
		curAct.getOutgoingTransitions().clear();
		TransitionImpl newTran = curAct.createOutgoingTransition();
		newTran.setDestination(orgAct);
		curAct.getOutgoingTransitions().add(newTran);
		try{
			execution.take(newTran);
			return true;
		}catch(Exception ex){
			throw ex;
		}finally{
			curAct.getOutgoingTransitions().clear();
			curAct.getOutgoingTransitions().addAll(oldTransitions);
		}
	}

}
