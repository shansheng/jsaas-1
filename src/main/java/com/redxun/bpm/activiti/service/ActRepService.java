package com.redxun.bpm.activiti.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.ProcessEngineConfiguration;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.dao.ActGeByteArrayDao;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.entity.ActProcessDef;
import com.redxun.bpm.activiti.entity.ActivityNode;
import com.redxun.bpm.activiti.ext.ActBpmnModelCache;
import com.redxun.bpm.activiti.ext.ActivitiDefCache;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.enums.ActivityNodeType;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.util.BeanUtil;

/**
 * 流程库服务类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Service
public class ActRepService {
	

	
	private static String ACT_PROCESS_DEF="actProcessDef";

	@Resource
	ActGeByteArrayDao actGeByteArrayDao;
	@Resource
	RepositoryService repositoryService;
	
	@Resource
	ProcessEngineConfiguration processEngineConfiguration;
	
	@Resource
	BpmDefManager bpmDefManager;
	
	//清空流程定义的缓存
	public void clearProcessDefinitionCache(String actDefId){
		CacheUtil.delCache(ACT_PROCESS_DEF +actDefId);
		ActivitiDefCache.clearByDefId(actDefId);
		ActBpmnModelCache.clearByDefId(actDefId);

	}
	
	/**
	 * 获得开始节点后面的节点
	 * @param actDefId
	 * @return
	 */
	public ActNodeDef getNodeAfterStart(String actDefId){
		ActProcessDef processDef=getProcessDef(actDefId);
		for(ActNodeDef nodeDef:processDef.getActNodeDefs()){
			if(nodeDef.getNodeType().equals("startEvent")){
				List<ActNodeDef> outNodeDefs=nodeDef.getOutcomeNodes();
				if(outNodeDefs.size()>0){
					return outNodeDefs.get(0);
				}
			}
		}
		return null;
	}
	
	
	
	/**
	 * 获得Activiti发布的Xml
	 * @param deployId
	 * @return
	 */
	public String getBpmnXmlByDeployId(String deployId){
		return actGeByteArrayDao.getDefXmlByDeployId(deployId);
	}
	/**
	 * 写入流程定义XML
	 * @param deployId
	 * @param defXml
	 */
	public void doWriteXml(String deployId,String defXml){
		actGeByteArrayDao.writeDefXml(deployId, defXml);
	}
	
	/**
	 * 更新流程定义及更新定义缓存
	 * @param actDefId
	 * @param deployId
	 * @param defXml
	 */
	public void doModifyXmlAndClearCache(String actDefId,String deployId,String defXml){
		doWriteXml(deployId,defXml);
		clearProcessDefinitionCache(actDefId);
	}
	
	/**
	 * 获得Model的Json源设置
	 * @param modelId
	 * @return
	 */
	public String getEditorJsonByModelId(String modelId){
		try{
			return new String(repositoryService.getModelEditorSource(modelId),"utf-8");
		}catch(Exception ex){
			ex.fillInStackTrace();
		}
		return "No Setting!";
	}
	
	/**
	 * 通过流程定义ID获得流程任务的定义列表
	 * @param actDefId
	 * @return
	 */
	public Collection<TaskDefinition> getTaskDefs(String actDefId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		Map<String,TaskDefinition> taskMap= entity.getTaskDefinitions();
		return taskMap.values();
	}
	
	/**
	 * 获得带有实例的流程定义
	 * @param actDefId
	 * @param isIncludeProcess 是否包括流程
	 * @return
	 */
	public Collection<ActivityNode> getUserTasks(String actDefId){
		
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		Map<String,TaskDefinition> taskMap= entity.getTaskDefinitions();
		Collection<TaskDefinition> taskDefs=taskMap.values();
		List<ActivityNode> nodes=new ArrayList<ActivityNode>();
		
		
		for(TaskDefinition taskDef:taskDefs){
			String actId=taskDef.getKey();
			String type="userTask";
			String name="";
			if(taskDef.getNameExpression()!=null){
				name=taskDef.getNameExpression().getExpressionText();
			}
			//String document=taskDef.getDescriptionExpression().getExpressionText();
			ActivityNode node=new ActivityNode(actId,name,type,"");
			
			ActivityImpl impl= entity.findActivity(actId);
			//impl.getProperty(arg0)
			if(impl.getProperties().containsKey("multiInstance")){
				node.setMultiInstance((String)impl.getProperty("multiInstance"));
			}
			
			node.setParentActivitiId(ActivityNode.PROCESS_NODE_ID);
			nodes.add(node);
		}
		return nodes;		
	}
	
	public ActNodeDef getSubProcessFirstTaskNodeDef(String actDefId,String subProcessNodeId){
		ProcessDefinitionEntity processDefEntity=(ProcessDefinitionEntity)repositoryService.getProcessDefinition(actDefId);
		ActivityImpl subProcessAct=processDefEntity.findActivity(subProcessNodeId);
		if(subProcessAct==null){
			return null;
		}
		
		for(ActivityImpl act:subProcessAct.getActivities()){
			String type=(String)act.getProperty("type");
			if(!"startEvent".equals(type)){ continue;}
			for(PvmTransition tan:act.getOutgoingTransitions()){
				ActivityImpl tmpAct=(ActivityImpl)tan.getDestination();
				String tmpType=(String)tmpAct.getProperty("type");
				
				if(!"userTask".equals(tmpType)){continue;}
				
				String nodeId=tmpAct.getId();
				String name=(String)tmpAct.getProperty("name");
				ActNodeDef nodeDef=new ActNodeDef(nodeId, name,tmpType);
				return nodeDef;
			}
		}
		return null;
	}
	
	/**
	 * 获得流程定义
	 * @param actDefId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public ActProcessDef getProcessDef(String actDefId){
		//优先从缓存中获取
		ActProcessDef processDef=(ActProcessDef)CacheUtil.getCache(ACT_PROCESS_DEF+ actDefId);
		if(processDef!=null) return processDef;
		//解析流程定义，把节点进行解析，并且生成ActProcessDef
		ProcessDefinitionEntity processDefEntity=(ProcessDefinitionEntity)repositoryService.getProcessDefinition(actDefId);
		
		ActivityImpl startNode= processDefEntity.getInitial();
		
		processDef=new ActProcessDef();
		processDef.setProcessDefId(actDefId);
		processDef.setProcessKey(processDefEntity.getKey());
		processDef.setProcessName(processDefEntity.getName());
		processDef.setStartNodeId(startNode.getId());
		
		List<ActivityImpl> actvities=processDefEntity.getActivities();
		
		for(ActivityImpl actImpl:actvities){			
			genActNodes(actImpl,processDef.getNodesMap());
		}
		CacheUtil.addCache(ACT_PROCESS_DEF + actDefId,processDef);
		return processDef;
	}
	
	/**
	 * 查找流程中的对应的节点的定义
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public ActivityImpl getActivityImplByActDefIdNodeId(String actDefId,String nodeId){
		ProcessDefinitionEntity processDefEntity=(ProcessDefinitionEntity)repositoryService.getProcessDefinition(actDefId);
		return processDefEntity.findActivity(nodeId);
	}
	
	/**
	 * 获得当前任务节点的后续有效的任务节点
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public Collection<ActNodeDef> getTaskOutValidNodes(String actDefId,String nodeId){
		//解析流程定义，把节点进行解析，并且生成ActProcessDef
		ProcessDefinitionEntity processDefEntity=(ProcessDefinitionEntity)repositoryService.getProcessDefinition(actDefId);
		ActivityImpl curAct=processDefEntity.findActivity(nodeId);
		Map<String,ActNodeDef> nodeDefMap=new LinkedHashMap<String,ActNodeDef>();
		if(curAct==null){
			return nodeDefMap.values();
		}
		for(ActivityImpl act:curAct.getActivities()){
			genTaskOutNodes(act,nodeDefMap);
		}
		
		return nodeDefMap.values();
	}
	
	private void genTaskOutNodes(ActivityImpl act,Map<String,ActNodeDef> nodeDefMap){
		if(act==null){
			return;
		}
		String actNodeId=act.getId();
		String nodeType=(String)act.getProperty("type");
		String nodeName=(String)act.getProperty("name");
		String multiInstance=(String)act.getProperty("multiInstance");
		if("exclusiveGateway".equals(nodeType) || "includeGateway".equals(nodeType) || "parallelGateway".equals(nodeType)){
			for(PvmTransition pt:act.getOutgoingTransitions()){
				PvmActivity destAct=pt.getDestination();
				genTaskOutNodes((ActivityImpl)destAct,nodeDefMap);
			}
			
		}else if("subProcess".equals(nodeType)){
			List<ActivityImpl> subActs=act.getActivities();
			for(ActivityImpl subAct:subActs){
				String subNodeType=(String)subAct.getProperty("type");
				if(subNodeType.equals("startEvent")){
					for(PvmTransition startOut:subAct.getOutgoingTransitions()){
						genTaskOutNodes((ActivityImpl)startOut.getDestination(),nodeDefMap);
					}
					break;
				}
			}
		}else if("userTask".equals(nodeType)){
			ActNodeDef nodeDef=new ActNodeDef(actNodeId,nodeName,nodeType);
			nodeDef.setMultiInstance(multiInstance);
			nodeDefMap.put(actNodeId, nodeDef);
		}
	}
	
	
	
	
	/**
	 * 流程定义节点
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public ActNodeDef getActNodeDef(String actDefId,String nodeId){
		ActProcessDef actProcessDef=getProcessDef(actDefId);
		return actProcessDef.getNodesMap().get(nodeId);
	}
	
	private ActNodeDef genActNodes(PvmActivity actImpl,Map<String,ActNodeDef> actNodeDefsMap){
		String nodeId=actImpl.getId();
		
		if(actNodeDefsMap.containsKey(nodeId)){
			return actNodeDefsMap.get(nodeId);
		}
		String nodeName=(String)actImpl.getProperty("name");
		String nodeType=(String)actImpl.getProperty("type");
		//为多实例
		String multiInstance=(String)actImpl.getProperty("multiInstance");
		String tmpId=nodeId;
		if(nodeId.length()>5){
			tmpId=nodeId.substring(nodeId.length()-5);
		}
		if(StringUtils.isEmpty(nodeName)){
			if("startEvent".equals(nodeType)){
				nodeName="开始";
			}else if("endEvent".equals(nodeType)){
				nodeName="结束";
			}else if("exclusiveGateway".equals(nodeType)){
				nodeName="单一选择网关("+tmpId+")";
			}else if("includeGateway".equals(nodeType)){
				nodeName="条件选择网关("+tmpId+")";
			}else if("parallelGateway".equals(nodeType)){
				nodeName="并行("+tmpId+")";
			}else if("subProcess".equals(nodeType)){
				nodeName="子流程("+tmpId+")";
			}
		}
		ActNodeDef nodeDef=new ActNodeDef(nodeId,nodeName,nodeType);
		nodeDef.setMultiInstance(multiInstance);
		actNodeDefsMap.put(nodeId, nodeDef);
		//设置其后置节点
		for(PvmTransition pt:actImpl.getOutgoingTransitions()){
			PvmActivity outAct=pt.getDestination();
			String destNodeType=(String)outAct.getProperty("type");
			//查找子流程里的，同时也还查找其后续的
			if("subProcess".equals(destNodeType)){
				List<PvmActivity> acts=(List<PvmActivity>)outAct.getActivities();
				for(PvmActivity av:acts){
					String subAvType=(String)av.getProperty("type");
					if("startEvent".equals(subAvType)){
						//取开始节点后的后续节点
						for(PvmTransition startOut:av.getOutgoingTransitions()){
							ActivityImpl startOutAct=(ActivityImpl)startOut.getDestination();
							nodeDef.getOutcomeNodes().add(genActNodes(startOutAct, actNodeDefsMap));
						}
						break;
					}
				}
			}else{
				ActNodeDef outNodeDef=genActNodes(outAct, actNodeDefsMap);
				nodeDef.getOutcomeNodes().add(outNodeDef);
			}
			
		}
		return nodeDef;
	}
	
	/**
	 * 获得流程定义中的开始节点
	 * @param actDefId
	 * @return
	 */
	public ActNodeDef getStartNode(String actDefId){
		ActProcessDef processDef=getProcessDef(actDefId);
		for(ActNodeDef actNodeDef:processDef.getActNodeDefs()){
			if(ActivityNodeType.startEvent.name().equals(actNodeDef.getNodeType())){
				return actNodeDef;
			}
		}
		return null;
	}
	
	/**
	 * 获得某个节点的入口节点
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public List<ActNodeDef> getIncomeNodes(String actDefId,String nodeId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		List<ActNodeDef> nodes=new ArrayList<ActNodeDef>();
		if(actImpl==null){
			return nodes;
		}
		for(PvmTransition pt:actImpl.getIncomingTransitions()){
			PvmActivity inAct=pt.getSource();
			String type=(String)inAct.getProperty("type");
			String name=(String) inAct.getProperty("name");
			nodes.add(new ActNodeDef(inAct.getId(), name, type));
		}
		return nodes;
	}
	
	/**
	 * 取得某个节点的后续节点
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public List<ActNodeDef> getOutcomeNodes(String actDefId,String nodeId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		List<ActNodeDef> nodes=new ArrayList<ActNodeDef>();
		if(actImpl==null){
			return nodes;
		}
		for(PvmTransition pt:actImpl.getOutgoingTransitions()){
			PvmActivity outAct=pt.getDestination();
			String type=(String)outAct.getProperty("type");
			String name=(String) outAct.getProperty("name");
			nodes.add(new ActNodeDef(outAct.getId(), name, type));
		}
		return nodes;
	}
	
	/**
	 * 返回流程定义的所有节点信息
	 * @param actDefId
	 * @return
	 */
	public List<ActivityImpl> getActivityNodeImpls(String actDefId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		return entity.getProcessDefinition().getActivities();
	}
	
	/**
	 * 取得流程任务中的所有节点，包括父容器也作为节点展示出来,包含活动节点
	 * @param actDefId
	 * @return
	 */
	public Collection<ActivityNode> getProcessNodes(String actDefId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		Map<String,ActivityNode> nodesMap=new LinkedHashMap<String, ActivityNode>();
		ActivityNode processNode=new ActivityNode(ActivityNode.PROCESS_NODE_ID, entity.getName(), "process", entity.getDescription());
		ActivityNode startNode=new ActivityNode(BpmFormRight.NODE_START, entity.getName(), "start", entity.getDescription());
		ActivityNode detailNode=new ActivityNode(BpmFormRight.NODE_DETAIL, entity.getName(), "detail", entity.getDescription());
		nodesMap.put(entity.getKey(),processNode);
		nodesMap.put(startNode.getActivityId(),startNode);
		nodesMap.put(detailNode.getActivityId(),detailNode);
		List<ActivityImpl> acts= entity.getProcessDefinition().getActivities();
		for(ActivityImpl actImpl:acts){
			String actId=actImpl.getId();
			String type=(String)actImpl.getProperty("type");
			String document=(String)actImpl.getProperty("document");
			String name=(String) actImpl.getProperty("name");
			
			String tmpId=actId;
			if(actId.length()>5){
				tmpId=actId.substring(actId.length()-5);
			}
			
			if(StringUtils.isEmpty(name)){
				if("startEvent".equals(type)){
					name="开始";
				}else if("endEvent".equals(type)){
					name="结束";
				}else if("exclusiveGateway".equals(type)){
					name="单一选择网关("+tmpId+")";
				}else if("inclusiveGateway".equals(type)){
					name="条件选择网关("+tmpId+")";
				}else if("parallelGateway".equals(type)){
					name="并行("+tmpId+")";
				}
			}
			
			ActivityNode node=new ActivityNode(actId,name,type,document);
			//为多实例
			String multiInstance=(String)actImpl.getProperty("multiInstance");
			node.setMultiInstance(multiInstance);
			node.setParentActivitiId(processNode.getActivityId());
			nodesMap.put(actId, node);
			getSubActivities(actImpl,nodesMap);
		}
		return nodesMap.values();
	}
	
	/**
	 * 取得有效的合法的跳转节点
	 * @param actDefId
	 * @param excludeNodeId
	 * @return
	 */
	public Collection<ActNodeDef> getValidNodes(String actDefId,String excludeNodeId){
		ActProcessDef def=getProcessDef(actDefId);
		Collection<ActNodeDef> nodeList=def.getActNodeDefs();
		ArrayList<ActNodeDef> validNodes=new ArrayList<ActNodeDef>();
		for(ActNodeDef nodeDef:nodeList){
			if(ActivityNodeType.startEvent.name().equals(nodeDef.getNodeType())){
				continue;
			}
			
			if(excludeNodeId!=null && excludeNodeId.equals(nodeDef.getNodeId())){
				continue;
			}
			
			validNodes.add(nodeDef);
		}
		return validNodes;
	}
	
	/**
	 * 取得开始节点后续的任务节点
	 * @param actDefId
	 * @param isSkipFirst
	 * @return
	 */
	public List<ActNodeDef> getStartFlowUserNodes(String actDefId,boolean isSkipFirst){
		ActNodeDef startNodeDef=getStartNode(actDefId);
		//取得流程的目标节点信息
		List<ActNodeDef> destNodes=new ArrayList<ActNodeDef>();
		//若设置跳过第一个节点，则下一步的人员选择则需要设置第一个节点的后续节点
		if(!isSkipFirst){
			destNodes=startNodeDef.getOutcomeNodes();
		}else{
			if(startNodeDef.getOutcomeNodes().size()>0){
				ActNodeDef startFlowNode=startNodeDef.getOutcomeNodes().get(0);
				for(ActNodeDef flowNodeDef:startFlowNode.getOutcomeNodes()){
					if(ActivityNodeType.userTask.name().equals(flowNodeDef.getNodeType())){
						destNodes.add(flowNodeDef);
					}else{
						destNodes.addAll(getFlowUserTask(flowNodeDef));
					}
				}
			}
		}
		return destNodes;
	}
	
	private List<ActNodeDef> getFlowUserTask(ActNodeDef nodeDef){
		List<ActNodeDef> list=new ArrayList<ActNodeDef>();
		for(ActNodeDef fNode:nodeDef.getOutcomeNodes()){
			if(ActivityNodeType.userTask.name().equals(fNode.getNodeType())){
				list.add(fNode);
			}else if(fNode.getNodeType()!=null && fNode.getNodeType().indexOf("Gateway")!=-1){
				list.addAll(getFlowUserTask(fNode));
			}
		}
		return list;
	}
	
	/**
	 * 取得流程任务中的所有节点，包括父容器也作为节点展示出来
	 * @param actDefId
	 * @return
	 */
	public Collection<ActivityNode> getActNodes(String actDefId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		Map<String,ActivityNode> nodesMap=new HashMap<String, ActivityNode>();
		List<ActivityImpl> acts= entity.getProcessDefinition().getActivities();
		for(ActivityImpl actImpl:acts){
			String actId=actImpl.getId();
			String type=(String)actImpl.getProperty("type");
			String document=(String)actImpl.getProperty("document");
			String name=(String) actImpl.getProperty("name");
			if(StringUtils.isEmpty(name)){
				name=type;
			}
			ActivityNode node=new ActivityNode(actId,name,type,document);
			nodesMap.put(actId, node);
			getSubActivities(actImpl,nodesMap);
		}
		return nodesMap.values();
	}
	
	/**
	 * 获得流程任务中的任务节点集合
	 * @param actDefId
	 * @return
	 */
	public Collection<ActNodeDef> getTaskNodes(String actDefId){
		ActProcessDef actProcessDef=this.getProcessDef(actDefId);
		List<ActNodeDef> nodes=new ArrayList<ActNodeDef>();
		Collection<ActNodeDef> actNodeDefs=actProcessDef.getNodesMap().values();
		for(ActNodeDef def:actNodeDefs){
			if("userTask".equals(def.getNodeType())){
				nodes.add(def);
			}
		}
		return nodes;
	}
	
	/**
	 * 取得某个节点下的所有子节点
	 * @param act
	 * @param nodesMap
	 */
	public void getSubActivities(ActivityImpl act,Map<String,ActivityNode> nodesMap){
		if(act.getActivities()==null || act.getActivities().size()==0) return;
		String parentActId=act.getId();
		for(ActivityImpl actImpl:act.getActivities()){
			String actId=actImpl.getId();
			String type=(String)actImpl.getProperty("type");
			String document=(String)actImpl.getProperty("document");
			String name=(String) actImpl.getProperty("name");
			if(StringUtils.isEmpty(name)){
				name=type;
			}
			ActivityNode node=new ActivityNode(actId,name,type,document);
			node.setParentActivitiId(parentActId);
			nodesMap.put(actId, node);
			getSubActivities(actImpl,nodesMap);
		}
	}
	
	/**
	 * 根据流程定义和网关出口ID获取对应的入口网关。
	 * <pre>
	 * 实现逻辑
	 * 	1.遍历网关节点的入口，往回查询，构建节点路径。
	 * 	2.记录找到所有的网关。
	 * 	3.遍历网关，如果网关在所有的路径中都存在，则表示
	 * 
	 * </pre>
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public ActNodeDef getCorrespondGateWay(String actDefId,String nodeId,boolean isPre){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		//获取网关节点。
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		
		Set<ActNodeDef> gateWayList=new HashSet<ActNodeDef>();
		//构建路径。
		List<List<ActNodeDef>> pathList=new ArrayList<List<ActNodeDef>>();
		
		List<PvmTransition> incomes=isPre? actImpl.getIncomingTransitions():actImpl.getOutgoingTransitions();
		
		for(PvmTransition transition :incomes){
			List<ActNodeDef> nodePathList=new ArrayList<ActNodeDef>(); 
			PvmActivity pvm=isPre? transition.getSource():transition.getDestination();
			ActNodeDef tmp=getByPvmAct(pvm);
			traverse(tmp, pvm, nodePathList, gateWayList,isPre);
			pathList.add(nodePathList);
		}
		
		for(ActNodeDef node:gateWayList){
			boolean rtn=isExist(pathList, node);
			if(rtn){
				return node;
			}
		}
		
		return null;
		
	}
	
	/**
	 * 获取网关内部的节点。此网关节点时开始节点。
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public Set<ActNodeDef> getOutNodesByGateWay(String actDefId,String nodeId){
		Set<ActNodeDef> nodes=getNodesByGateWay( actDefId, nodeId, false);
		return nodes;
		
	}
	
	/**
	 * 获取网关内部的节点。此网关节点时结束节点。
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public Set<ActNodeDef> getInNodesByGateWay(String actDefId,String nodeId){
		Set<ActNodeDef> nodes=getNodesByGateWay( actDefId, nodeId, true);
		return nodes;
	}
	
	/**
	 * 获取网关之后的节点数据。
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public Set<ActNodeDef> getNodesByGateWay(String actDefId,String nodeId,boolean isPre){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		//获取网关节点。
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		
		Set<ActNodeDef> gateWayList=new HashSet<ActNodeDef>();
		//构建路径。
		List<List<ActNodeDef>> pathList=new ArrayList<List<ActNodeDef>>();
		
		List<PvmTransition> outcomes=isPre?actImpl.getIncomingTransitions(): actImpl.getOutgoingTransitions();
		
		List<ActNodeDef> rootNodes=new ArrayList<ActNodeDef>();
		
		for(PvmTransition transition :outcomes){
			List<ActNodeDef> nodePathList=new ArrayList<ActNodeDef>(); 
			PvmActivity pvm=isPre?transition.getSource(): transition.getDestination();
			ActNodeDef node=getByPvmAct( pvm);
			traverse( node, pvm ,nodePathList, gateWayList,isPre);
			pathList.add(nodePathList);
			rootNodes.add(node);
		}
		ActNodeDef gateWay=null;
		for(ActNodeDef node:gateWayList){
			boolean rtn=isExist(pathList, node);
			if(rtn){
				gateWay=node;
			}
		}
		Set<ActNodeDef> set=new HashSet<ActNodeDef>();
		
		if(gateWay!=null){
			for(ActNodeDef node:rootNodes){
				traverseNode(node,set,gateWay.getNodeId());
			}
		}
		
		return set;
		
	}
	
	private void traverseNode(ActNodeDef node,Set<ActNodeDef> set,String nodeId){
		if(node.getNodeType().indexOf("Gateway")==-1){
			set.add(node);
		}
		if(node.getNodeId().equals(nodeId)) return;
		List<ActNodeDef> defs= node.getOutcomeNodes();
		if(BeanUtil.isEmpty(defs)) return;
		for(ActNodeDef def:defs){
			traverseNode(def,set,nodeId);
		}
		
	}
	
	private boolean isExist(List<List<ActNodeDef>> pathList,ActNodeDef node){
		for(List<ActNodeDef> list:pathList){
			boolean rtn=isExistOnePath(list, node);
			if(!rtn){
				return false;
			}
		}
		return true;
	}
	
	private boolean isExistOnePath(List<ActNodeDef> list,ActNodeDef node){
		for(ActNodeDef def:list){
			if(node.getNodeId().equals(def.getNodeId())){
				return true;
			}
		}
		return false;
	}

	/**
	 * 递归向前查找节点。
	 * @param pvm
	 * @param nodePathList
	 * @param gateWayList
	 */
	private void traverse(ActNodeDef node,PvmActivity pvm,List<ActNodeDef> nodePathList,Set<ActNodeDef> gateWayList,boolean isPre){
		if(nodePathList.contains(node)) return;
		nodePathList.add(node);
		String type=node.getNodeType();
		String event=isPre?"startEvent":"endEvent";
		if(type.equals(event)) return;
		if(gateWayList.contains(node)) 	return;
		
		if(type.indexOf("Gateway")!=-1){
			gateWayList.add(node);
		}
		List<PvmTransition> inList=isPre? pvm.getIncomingTransitions():pvm.getOutgoingTransitions();
		if(inList==null || inList.size()==0) return;
		
		for(PvmTransition trans :inList){
			PvmActivity pv=isPre? trans.getSource(): trans.getDestination();
			ActNodeDef tmp=getByPvmAct(pv);
			node.getOutcomeNodes().add(tmp);
			traverse(tmp,pv, nodePathList,gateWayList,isPre);
		}
	}
	
	
	
	private ActNodeDef getByPvmAct(PvmActivity pvm){
		String type=(String) pvm.getProperty("type");
		String name=(String) pvm.getProperty("name");
		ActNodeDef node=new ActNodeDef(pvm.getId(), name, type);
		return node;
	}
	
	/**
	 * 网关节点时进入还是退出。
	 * <pre>
	 * 1.根据流程定义查找流程定义对象。
	 * 2.根据网关的节点ID获取节点对象。
	 * 3.判定网关的入口数量。
	 * 	如果只有一个入口指向该网关，表示当前节点在网关内部。
	 *  如果网关之前有N条线，表示在网关外部。
	 * 判断依据网关的入口只有一个。
	 * </pre>
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public boolean isInset(String actDefId, String nodeId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		//获取网关节点。
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		return actImpl.getIncomingTransitions().size()==1;
	}
	
	/**
	 * 获取网关节点。
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public ActNodeDef getPreGateway(String actDefId,String nodeId,boolean isIn){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		//获取网关节点。
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		List<PvmTransition> list= actImpl.getIncomingTransitions();
		PvmTransition trans= list.get(0);
		PvmActivity act= trans.getSource();
		ActNodeDef def= getByPvmAct(act);
		if(def.getNodeType().equals("userTask")) return null;
		if(def.getNodeType().indexOf("Gateway")!=-1){
			addNodes( def, act,isIn);
			return def;
		}
		list=act.getIncomingTransitions();
		trans= list.get(0);
		act= trans.getSource();
		def= getByPvmAct(act);
		if(def.getNodeType().indexOf("Gateway")!=-1){
			addNodes( def, act,isIn);
			return def;
		}
		return null;
	}
	
	/**
	 * 在某个节点之前查找任务节点，如果不是任务节点则跳过，继续往前查找。
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public ActNodeDef getPreUserTask(String actDefId,String nodeId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		//获取网关节点。
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		List<PvmTransition> list= actImpl.getIncomingTransitions();
		PvmTransition trans= list.get(0);
		PvmActivity act= trans.getSource();
		ActNodeDef def= getByPvmAct(act);
		String type=def.getNodeType() ;
		if("userTask".equals(type)) return def;
		do{ 
			List<PvmTransition> transitions= act.getIncomingTransitions();
			if(BeanUtil.isEmpty(transitions)) break;
			PvmTransition tran= transitions.get(0);
			act= tran.getSource();
			def= getByPvmAct(act);
			type=def.getNodeType();
		}while(!"userTask".equals(type) && !"startEvent".equals(type));
		return def;
	}
	
	
	/**
	 * 获取节点定义。
	 * @param actDefId
	 * @param nodeId
	 * @return
	 */
	public ActNodeDef getByNode(String actDefId,String nodeId){
		ProcessDefinition processDef=repositoryService.getProcessDefinition(actDefId);
		ProcessDefinitionEntity entity=(ProcessDefinitionEntity)processDef;
		//获取网关节点。
		ActivityImpl actImpl= entity.getProcessDefinition().findActivity(nodeId);
		ActNodeDef actNodeDef=getByPvmAct(actImpl);
		
		addNodes(actNodeDef,actImpl,true);
		addNodes(actNodeDef,actImpl,false);
		
		return actNodeDef;
	}
	
	private void addNodes(ActNodeDef def,PvmActivity act,boolean isIn){
		List<PvmTransition> gateTrans= act.getIncomingTransitions();
		for(PvmTransition gateTran:gateTrans){
			PvmActivity gateAct= gateTran.getSource();
			ActNodeDef gateNodeDef=getByPvmAct(gateAct);
			if(isIn){
				def.getOutcomeNodes().add(gateNodeDef);
			}
			else{
				def.getIncomeNodes().add(gateNodeDef);
			}
		}
	}
}
