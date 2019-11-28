package com.redxun.bpm.activiti.ext;


import java.util.ArrayList;
import java.util.List;

import org.activiti.engine.impl.bpmn.behavior.InclusiveGatewayActivityBehavior;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.delegate.ActivityExecution;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.bpm.core.entity.config.ExclusiveGatewayConfig;
import com.redxun.bpm.core.entity.config.NodeExecuteScript;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
/**
 * 扩展流程选择条件的网关，让经支持脚本条件外部设置
 * 并根据运行结果来选择跳转的分支处理
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class InclusiveGatewayActivityBehaviorExt extends InclusiveGatewayActivityBehavior {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected static Logger logger=LogManager.getLogger(InclusiveGatewayActivityBehaviorExt.class);



	@Override
	public void execute(ActivityExecution execution) throws Exception {
		String solId = (String) execution.getVariable("solId");
		String nodeId = execution.getActivity().getId();
		
		BpmNodeSetManager bpmNodeSetManager=AppBeanUtil.getBean(BpmNodeSetManager.class);
		GroovyEngine groovyEngine=AppBeanUtil.getBean(GroovyEngine.class);
		
		// 分支网关与条件网关共用一样的配置
		ExclusiveGatewayConfig configs = bpmNodeSetManager.getExclusiveGatewayConfig(solId,execution.getProcessDefinitionId(), nodeId);
		//
		if (StringUtils.isEmpty(solId) || StringUtils.isEmpty(nodeId) || configs==null) {
			super.execute(execution);
		}

		PvmActivity activity = execution.getActivity();
		List<ActivityExecution> joinedExecutions = execution.findInactiveConcurrentExecutions(activity);
		List<PvmTransition> transitionsToTake = new ArrayList<PvmTransition>();

		for (NodeExecuteScript script : configs.getConditions()) {
			String destNodeId = script.getNodeId();
			String condition = script.getCondition();
			logger.debug("dest node:{}, condition is {}", destNodeId, condition);
			try{
				// 执行脚本引擎
				Object boolVal = groovyEngine.executeScripts(condition, execution.getVariables());
				if (boolVal instanceof Boolean) {
					if (((Boolean) boolVal)) {// 符合条件
						for (PvmTransition pt : activity.getOutgoingTransitions()) {
							if (destNodeId.equals(pt.getDestination().getId())) {
								transitionsToTake.add(pt);
								break;
							}
						}
					}
				}
			}catch(Exception ex){
				ProcessHandleHelper.addErrorMsg("节点["+nodeId+"]的判断表达式:\n "+condition+"执行有错误！错误如下："+ex.getMessage());
				throw new RuntimeException("节点["+nodeId+"]的判断表达式:\n "+condition+"执行有错误！错误如下："+ex.getMessage());
			}
		}
		if (!transitionsToTake.isEmpty()) {
			execution.takeAll(transitionsToTake, joinedExecutions);
			return;
		}else{
			ProcessHandleHelper.addErrorMsg("节点分支"+nodeId+"没有满足的配置条件，请联系管理员！");
			throw new RuntimeException("节点分支"+nodeId+"没有满足的配置条件，请联系管理员！");
		}
		//super.execute(execution);
		
	}

}
