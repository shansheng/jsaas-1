package com.redxun.bpm.core.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.apache.commons.lang.StringUtils;
import org.dom4j.DocumentException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.entity.ActNodeDef;
import com.redxun.bpm.activiti.entity.ActProcessDef;
import com.redxun.bpm.activiti.entity.ActSequenceFlow;
import com.redxun.bpm.activiti.entity.ActivityNode;
import com.redxun.bpm.activiti.service.ActRepService;
import com.redxun.bpm.activiti.service.ServiceTaskFactory;
import com.redxun.bpm.core.entity.BpmDef;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmSolVar;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.config.BpmEventConfig;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BpmDefManager;
import com.redxun.bpm.core.manager.BpmFormulaMappingManager;
import com.redxun.bpm.core.manager.BpmNodeSetManager;
import com.redxun.bpm.core.manager.BpmSolVarManager;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.bpm.enums.ActivityEventType;
import com.redxun.bpm.enums.ProcessEventType;
import com.redxun.bpm.enums.TaskEventType;
import com.redxun.bpm.form.manager.BpmTableFormulaManager;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.controller.BaseListController;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoAttrManager;
import com.redxun.sys.bo.manager.SysBoEntManager;
import com.redxun.sys.log.LogEnt;

/**
 * [BpmNodeSet]管理
 * @author csx
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@Controller
@RequestMapping("/bpm/core/bpmNodeSet/")
public class BpmNodeSetController extends BaseListController{
    @Resource
    BpmNodeSetManager bpmNodeSetManager;
    @Resource
    BpmSolutionManager bpmSolutionManager;
    @Resource
    BpmSolVarManager bpmSolVarManager;
    @Resource
    SysBoAttrManager sysBoAttrManager;
    
    @Resource
    ActRepService actRepService;
    @Resource
    BpmDefManager bpmDefManager;
    
    @Resource(name="iJson")
    ObjectMapper objectMapper;
    
    @Resource
    ContextHandlerFactory contextHandlerFactory;
    @Resource
    ServiceTaskFactory serviceTaskFactory;  
    @Resource
    BpmFormulaMappingManager bpmFormulaMappingManager;
    @Resource
    BpmTableFormulaManager bpmTableFormulaManager;
    @Resource
    SysBoEntManager sysBoEntManager;
    
   
	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}
   
    @RequestMapping("del")
    @ResponseBody
    @LogEnt(action = "del", module = "流程", submodule = "流程定义节点配置")
    public JsonResult del(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String uId=request.getParameter("ids");
        if(StringUtils.isNotEmpty(uId)){
            String[] ids=uId.split(",");
            for(String id:ids){
                bpmNodeSetManager.delete(id);
            }
        }
        return new JsonResult(true,"成功删除！");
    }
    
    /**
     * 查看明细
     * @param request
     * @param response
     * @return
     * @throws Exception 
     */
    @RequestMapping("get")
    public ModelAndView get(HttpServletRequest request,HttpServletResponse response) throws Exception{
        String pkId=request.getParameter("pkId");
        BpmNodeSet bpmNodeSet=null;
        if(StringUtils.isNotEmpty(pkId)){
           bpmNodeSet=bpmNodeSetManager.get(pkId);
        }else{
        	bpmNodeSet=new BpmNodeSet();
        }
        return getPathView(request).addObject("bpmNodeSet",bpmNodeSet);
    }
    
    /**
     * 保存节点配置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("saveNodeConfig")
    @ResponseBody
    @LogEnt(action = "saveNodeConfig", module = "流程", submodule = "流程定义节点配置")
    public JsonResult saveNodeConfig(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	String nodeType=request.getParameter("nodeType");
    	String nodeId=request.getParameter("nodeId");
    	String nodeName=request.getParameter("nodeName");
    	String tipText = request.getParameter("tipText");
    	
    	String configJson=request.getParameter("configJson");
    	//若为流程级别，则设置为流程运行级别
    	if("process".equals(nodeType)){
    		nodeId=ActivityNode.PROCESS_NODE_ID;
    	}
    	
    	bpmNodeSetManager.saveNodeConfig(solId,actDefId, nodeId, nodeName, nodeType, configJson,tipText);
    	
    	return new JsonResult(true,"成功保存！");
    }
    
    @RequestMapping("callConfig{callType}")
    public ModelAndView callConfig(@PathVariable("callType")String callType,HttpServletRequest request,HttpServletResponse response)throws Exception{
    	String solId=request.getParameter("solId");
    	String nodeId=request.getParameter("nodeId");
    	String actDefId=request.getParameter("actDefId");
    	String nodeType=request.getParameter("nodeType");
    	//获得该节点上的所有变量配置
    	List<BpmSolVar> configVars=bpmSolVarManager.getNodeAllVars(solId, actDefId, nodeType,nodeId);
    	ModelAndView mv=getPathView(request);
    	BpmNodeSet set = new BpmNodeSet();
    	set.setSolId(solId);
    	set.setNodeId(nodeId);
    	set.setActDefId(actDefId);
    	set.setNodeType(nodeType);
    	setSetting(mv, set, null, configVars);
    	return mv;
    }
    
    /**
     * 获得节点的变量配置信息
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getVars")
    @ResponseBody
    public List<BpmSolVar> getVars(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String solId=request.getParameter("solId");
    	String nodeId=request.getParameter("nodeId");
    	String actDefId=request.getParameter("actDefId");
    	
    	if(StringUtils.isEmpty(nodeId)){
    		nodeId=BpmSolVar.SCOPE_PROCESS;
    	}
    	//获得该节点上的全局变量配置
    	//List<BpmSolVar> configVars=bpmSolVarManager.getBySolIdActDefIdNodeId(solId,actDefId, nodeId);
    	ActivityImpl actNode= actRepService.getActivityImplByActDefIdNodeId(actDefId, nodeId);
    	//默认为非任务节点，这不是一个好的写法
    	String nodeType="exclusiveGateway";
    	if(actNode!=null){
    		nodeType=(String)actNode.getProperty("type");
    	}
    	List<BpmSolVar> configVars=bpmSolVarManager.getNodeAllVars(solId, actDefId, nodeType,nodeId);

    	return configVars;
    }
    
    private void addVars(JSONArray ary){
    	JSONObject ref=new JSONObject();
    	ref.put("key",SysBoEnt.SQL_FK);
    	ref.put("val","外键字段");
    			
    	
    	JSONObject refState=new JSONObject();
    	
    	refState.put("key",SysBoEnt.SQL_FK_STATEMENT);
    	refState.put("val","外键占位符");
    	
    	ary.add(ref);
    	ary.add(refState);
    	
    }
    
    /**
     * 获取初始事件配置。
     * @param nodeType
     * @return
     */
    private List<BpmEventConfig> getEventConfigs(String nodeType){
    	List<BpmEventConfig> eventConfigs=new ArrayList<BpmEventConfig>();
    	if("process".equals(nodeType)){
    		for(ProcessEventType ev:ProcessEventType.values()){
    			BpmEventConfig evt=new BpmEventConfig(ev.name(),ev.getEventName(),"");
    			eventConfigs.add(evt);
    		}
    	}else if("userTask".equals(nodeType)){
    		for(TaskEventType ev:TaskEventType.values()){
    			BpmEventConfig evt=new BpmEventConfig(ev.name(),ev.getEventName(),"");
    			eventConfigs.add(evt);
    		}
    	}
    	else if("endEvent".equals(nodeType)){
    		BpmEventConfig evt=new BpmEventConfig(ProcessEventType.PROCESS_COMPLETED.name(),ProcessEventType.PROCESS_COMPLETED.getEventName(),"");
			eventConfigs.add(evt);
    	}
    	else if("startEvent".equals(nodeType)){
    		BpmEventConfig evt=new BpmEventConfig(ProcessEventType.PROCESS_STARTED.name(),ProcessEventType.PROCESS_STARTED.getEventName(),"");
			eventConfigs.add(evt);
    	}
    	else {
    		for(ActivityEventType ev:ActivityEventType.values()){
    			BpmEventConfig evt=new BpmEventConfig(ev.name(),ev.getEventName(),"");
    			eventConfigs.add(evt);
    		}
    	}
    	return eventConfigs;
    }
    
    /**
     * 设置事件脚本。
     * @param jsonObject
     * @param eventConfigs
     */
    private void setEventConfig(JsonNode jsonObject,List<BpmEventConfig> eventConfigs){
    	JsonNode eventNode=jsonObject.path("events");
    	if(BeanUtil.isEmpty(eventNode)) return;
		Iterator<JsonNode>  it=eventNode.iterator();
		while(it.hasNext()){
			ObjectNode eventJson=(ObjectNode)it.next();
			String event=eventJson.get("eventKey").textValue();
			String script=eventJson.get("script").textValue();
			for(BpmEventConfig evt:eventConfigs){
				if(evt.getEventKey().equals(event)){
					evt.setScript(script);
					break;
				}
			}
		}
    }

    /**
     * 设置网关条件。
     * @param seqMap
     * @param configsNode
     */
    private void setConditions(Map<String,ActSequenceFlow> seqMap,JsonNode configsNode){
    	JsonNode configs=configsNode.get("conditions");
    	if(BeanUtil.isEmpty(configs)) return;
		Iterator<JsonNode> it=configs.elements();
		while(it.hasNext()){
			ObjectNode config=(ObjectNode)it.next();
			String tmpNodeId=config.get("nodeId").textValue();
			String tmpCondition=config.get("condition").textValue();
			if(seqMap.get(tmpNodeId)!=null){
				seqMap.get(tmpNodeId).setConditionExpression(tmpCondition);
			}
		}
    }
    
    /**
     * 获取常量。
     * @return
     */
    private JSONArray getContextVars(){
    	JSONArray contextVarAry= contextHandlerFactory.getJsonHandlers();
		//添加常量
		addVars(contextVarAry);
		//常量
		return contextVarAry;
    }
    
    /**
     * 获取bpmnodeset数据。
     * @param solId
     * @param actDefId
     * @param nodeId
     * @param nodeType
     * @return
     */
    private BpmNodeSet getBpmNodeSet(String solId,String actDefId,String nodeId,String nodeName,String nodeType){
    	BpmNodeSet bpmNodeSet=bpmNodeSetManager.getBySolIdActDefIdNodeId(solId,actDefId, nodeId);
    	if(bpmNodeSet!=null) return bpmNodeSet;
    	
    	if(nodeType.equals("userTask")){
    		bpmNodeSet=createBpmNodeSet(solId, actDefId, nodeId, nodeName, nodeType);
		}
		else{
			bpmNodeSet=new BpmNodeSet();
			bpmNodeSet.setActDefId(actDefId);
			bpmNodeSet.setNodeType(nodeType);
			bpmNodeSet.setSolId(solId);
			bpmNodeSet.setNodeId(nodeId);
			String configJsonInit="{\"configs\":{\"jumpTypes\":\"BACK,BACK_TO_STARTOR\"}}";
			bpmNodeSet.setSettings(configJsonInit);
			bpmNodeSetManager.saveNodeConfig(solId,actDefId, nodeId,nodeName, nodeType, configJsonInit,"");
	    	bpmNodeSet=bpmNodeSetManager.getBySolIdActDefIdNodeId(solId,actDefId, nodeId);
		}
    	return bpmNodeSet;
    }
    
    /**
     * 设置网关上下文数据。
     * @param mv
     * @param solId
     * @param actDefId
     * @param actNodeDef
     * @param configVars
     * @param seqMap
     */
    private void setGateWay(ModelAndView mv,String solId,String actDefId,
    		ActNodeDef actNodeDef ,List<BpmSolVar> configVars,Map<String,ActSequenceFlow> seqMap){
    	String nodeId=actNodeDef.getNodeId();
    	
    	List<BpmSolVar> preConfigVars=new ArrayList<BpmSolVar>();
		preConfigVars.addAll(configVars);
		List<ActNodeDef> inNodes=actRepService.getIncomeNodes(actDefId, nodeId);
		//取得其前置的节点
		for(ActNodeDef inNodeDef:inNodes){
			List<BpmSolVar> vars=bpmSolVarManager.getBySolIdActDefIdNodeId(solId, actDefId,inNodeDef.getNodeId());
			preConfigVars.addAll(vars);
		}
		mv.addObject("preConfigVars", preConfigVars);
		
		List<ActNodeDef> outNodeDefs=actRepService.getOutcomeNodes(actDefId, nodeId);
		//取得当前分支节点的后续节点
		for(ActNodeDef nodeDef:outNodeDefs){
			ActSequenceFlow flow=new ActSequenceFlow();
			flow.setSourceNodeId(actNodeDef.getNodeId());
			flow.setSourceNodeName(actNodeDef.getNodeName());
			flow.setDestNodeId(nodeDef.getNodeId());
			flow.setDestNodeName(nodeDef.getNodeName());
			seqMap.put(nodeDef.getNodeId(),flow);
		}
		mv.addObject("seqMap", seqMap);
    }
    
    /**
     * 获得节点的配置
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getNodeConfig")
    public ModelAndView getNodeConfig(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String nodeType=request.getParameter("nodeType");
    	String solId=request.getParameter("solId");
    	String actDefId=request.getParameter("actDefId");
    	String nodeId=request.getParameter("nodeId");
    	String nodeName=request.getParameter("nodeName");
    	String key=request.getParameter("key");
    	//获取bpmnodeset
    	BpmNodeSet bpmNodeSet=getBpmNodeSet(solId,actDefId,nodeId,nodeName,nodeType);
    	
    	
    	Map<String,ActSequenceFlow> seqMap=new HashMap<String, ActSequenceFlow>();
    	BpmSolution bpmSolution=bpmSolutionManager.get(solId);
		BpmDef bpmDef=bpmDefManager.getValidBpmDef(actDefId,bpmSolution.getDefKey());
    	ActProcessDef processDef=actRepService.getProcessDef(bpmDef.getActDefId());
		ActNodeDef actNodeDef=processDef.getNodesMap().get(nodeId);
		
		//获得该节点上的所有变量配置
		List<BpmSolVar> configVars=bpmSolVarManager.getNodeAllVars(solId, actDefId, nodeType,nodeId);
		
		ModelAndView mv=null;
    	if("process".equals(nodeType)){
    		mv=new ModelAndView("bpm/core/bpmNodeSetProcess.jsp");
    		KeyValEnt<String> kv= bpmTableFormulaManager.getKvSolIdNode(solId, actDefId, ProcessConfig.PROCESS_NODE_ID);
    		mv.addObject("formulaId", kv.getKey());
    		mv.addObject("formulaName", kv.getVal());
    	}else if("userTask".equals(nodeType)){
    		//是否为多实例任务
    		mv=new ModelAndView("bpm/core/bpmNodeSetUserTask.jsp")
    				.addObject("actNodeDef",actNodeDef);
    		KeyValEnt<String> kv= bpmTableFormulaManager.getKvSolIdNode(solId, actDefId, nodeId);
    		mv.addObject("formulaId", kv.getKey());
    		mv.addObject("formulaName", kv.getVal());
    				
    	}else if("startEvent".equals(nodeType)){
    		mv=new ModelAndView("bpm/core/bpmNodeSetStartEvent.jsp");
    	}else if("inclusiveGateway".equals(nodeType) 
    			|| "exclusiveGateway".equals(nodeType)){
    		mv=new ModelAndView("bpm/core/bpmNodeSetExcGateway.jsp");
    		//设置网关上下文数据。
    		setGateWay( mv, solId, actDefId, actNodeDef ,configVars,seqMap);
    	}
    	else if("endEvent".equals(nodeType)){
    		mv=new ModelAndView("bpm/core/bpmNodeSetEndEvent.jsp");
    	}
    	else if("serviceTask".equals(nodeType)){
    		if(BeanUtil.isEmpty(bpmNodeSet.getSetId()) ){
    			List<KeyValEnt<String>> list= serviceTaskFactory.getTasks();
    			if(StringUtil.isNotEmpty(key)) {
    				Iterator<KeyValEnt<String>> it = list.iterator();
    				while(it.hasNext()) {
    					if(key.equals(it.next().getKey())){
    						String viewName="bpm/core/bpmNodeSet"+key +".jsp";
    	        			mv=new ModelAndView(viewName);
    					}
    				}
    			}
    			else {
	    			if(list.size()==1){
	    				KeyValEnt<String> ent=list.get(0);
	    				String viewName="bpm/core/bpmNodeSet"+ent.getKey() +".jsp";
	        			mv=new ModelAndView(viewName);
	    			}
	    			else{
	    				mv=new ModelAndView("bpm/core/bpmNodeSetServiceTask.jsp");
	    				JSONArray jsonAry=new JSONArray();
	    				for(KeyValEnt<String> ent:list){
	    					JSONObject jsonObj=new JSONObject();
	    					jsonObj.put("id", ent.getKey());
	    					jsonObj.put("text", ent.getVal());
	    					jsonAry.add(jsonObj);
	    				}
	    				mv.addObject("json", jsonAry.toJSONString());
	    			}
    			}
    		}
    		else{
    			JSONObject jsonObj=JSONObject.parseObject(bpmNodeSet.getSettings());
    			String type=jsonObj.getString("type");
    			String viewName="bpm/core/bpmNodeSet"+type +".jsp";
    			mv=new ModelAndView(viewName);
    			mv.addObject("setting", jsonObj);
    			
    		}
    	}
    	else{
    		mv=new ModelAndView("bpm/core/bpmNodeSetActivity.jsp");
    	}
    	//设置 ModelAndView 上下文变量。
    	setSetting(mv,bpmNodeSet,seqMap,configVars);
    	mv.addObject("boDefId",bpmSolution.getBoDefId());
    	SysBoEnt ent = sysBoEntManager.getByBoDefId(bpmSolution.getBoDefId(),false);
		if(BeanUtil.isNotEmpty(ent)) {
			mv.addObject("boName",ent.getName());
		}
    	return mv;
    }
    
    /**
     * 设置 ModelAndView 上下文变量。
     * @param mv
     * @param bpmNodeSet
     * @param seqMap
     * @param configVars
     * @throws JsonProcessingException
     * @throws IOException
     */
    private void setSetting(ModelAndView mv,BpmNodeSet bpmNodeSet,
    		Map<String,ActSequenceFlow> seqMap,List<BpmSolVar> configVars) throws JsonProcessingException, IOException{
    	String nodeType=bpmNodeSet.getNodeType();
    	String solId=bpmNodeSet.getSolId();
    	String actDefId=bpmNodeSet.getActDefId();
    	String nodeId=bpmNodeSet.getNodeId();
    	// 取得事件脚本配置。
    	List<BpmEventConfig> eventConfigs=getEventConfigs(nodeType);
    	if(ProcessConfig.PROCESS_NODE_ID.equals(nodeType)) {
    		BpmNodeSet set = bpmNodeSetManager.getBySolIdActDefIdNodeId(solId, actDefId,ProcessConfig.PROCESS_NODE_ID);
			if(set!=null) {
	    		JsonNode jsonObject=objectMapper.readTree(set.getSettings());
				JsonNode configsNode=jsonObject.get("configs");
				Map<String,Object> configMap=JSONUtil.jsonNode2Map(configsNode);
				JSONArray ary = JSONArray.parseArray((String)configMap.get("bpmDefs"));
				JSONArray temp = new JSONArray();
				if(BeanUtil.isNotEmpty(ary)) {
					for (Object object : ary) {
						JSONObject obj = (JSONObject) object;
						JSONObject tempObj = new JSONObject();
						tempObj.put("name",obj.getString("name"));
						tempObj.put("alias",obj.getString("alias"));
						temp.add(tempObj);
					}
				}
				mv.addObject("subProcess", temp);
			}
    	}
    	if(bpmNodeSet!=null && StringUtils.isNotEmpty(bpmNodeSet.getSettings())){
    		JsonNode jsonObject=objectMapper.readTree(bpmNodeSet.getSettings());
    		JsonNode configsNode=jsonObject.get("configs");
    		if(configsNode!=null){
    			//取得分支条件列表
    			setConditions(seqMap, configsNode);
    			Map<String,Object> configMap=JSONUtil.jsonNode2Map(configsNode);
    			String tableRightJson=bpmNodeSetManager.getTableRightJson(solId,actDefId,nodeId,(ObjectNode) configsNode);
    			//设置子表权限。
    			configMap.put("tableRightJson", tableRightJson);
    			if(checkOverTimeSign(bpmNodeSet)){
    				mv.addObject("removeOverTimeConfig", true);
    			}
    			mv.addAllObjects(configMap);
    		}
    		//设置事件脚本。
    		setEventConfig(jsonObject,eventConfigs);
    		
    		JsonNode globalEventNode=jsonObject.get("globalEvent");
    		String globalEvent="{}";
    		if(globalEventNode!=null){
    			globalEvent=globalEventNode.toString();
    		}
    		mv.addObject("globalEvent", globalEvent);
    		
    	}
    	
		//获取上下文变量。
		JSONArray contextVarAry=getContextVars();
		mv.addObject("contextVars", contextVarAry.toJSONString());
		//流程变量定义
		mv.addObject("configVars",configVars);
		mv.addObject("configVarsJson",JSONArray.toJSON(configVars));
		
		//事件配置
    	mv.addObject("eventConfigs", eventConfigs);
    	//所有事件的Key
    	List<String> eventKeys=new ArrayList<String>();
    	for(BpmEventConfig conf:eventConfigs){
    		eventKeys.add(conf.getEventKey());
    	}
    	//事件key。
    	mv.addObject("eventKeys",iJson.toJson(eventKeys));
    }
    
    /**
     * 检查所有节点是否有设置本节点的超时设置
     * @return
     * @throws IOException 
     * @throws JsonProcessingException 
     */
    private Boolean checkOverTimeSign(BpmNodeSet bpmNodeSet) throws JsonProcessingException, IOException{
    	List<BpmNodeSet> bpmNodeSets=bpmNodeSetManager.getBySolIdActDefId(bpmNodeSet.getSolId(), bpmNodeSet.getActDefId());
    	
    	for (int i = 0; i < bpmNodeSets.size(); i++) {
			BpmNodeSet nodeSet=bpmNodeSets.get(i);
			if(nodeSet.equals(bpmNodeSet)){
				bpmNodeSets.remove(i);
				i--;
				continue;
			}
			if("userTask".equals(nodeSet.getNodeType())){
				JsonNode jsonNode=(objectMapper.readTree(nodeSet.getSettings())).get("configs");
				Map<String,Object> configMap=JSONUtil.jsonNode2Map(jsonNode);
				Object object=configMap.get("unionNodeSet");
				if(object!=null){
					String unionNodes=(String)object ;
					if(unionNodes.contains(bpmNodeSet.getNodeId())){
						return true;
					}	
				}
			}
		}
    	return false;
    }
    
    private BpmNodeSet createBpmNodeSet(String solId,String actDefId,String nodeId,String nodeName,String nodeType){
    	String configJsonInit="{\"configs\":{\"allowConfigButtons\":\"false\",\"allowPathSelect\":\"false\",\"sameUserNext\":\"false\",\"showCheckList\":\"false\",\"allowPrint\":\"false\",\"allowNextExecutor\":\"false\",\"notices\":\"\",\"jumpTypes\":\"\",\"showOpinion\":\"no\",\"tableRightJson\":\"{}\",\"pagesize\":10,\"preHandle\":\"\",\"afterHandle\":\"\",\"checkTip\":\"\",\"notices_name\":\"\",\"pagesize_name\":\"10\",\"buttons\":[]},\"events\":[{\"eventKey\":\"TASK_CREATED\",\"eventName\":\"[任务创建]-事件脚本\",\"script\":\" \"},{\"eventKey\":\"TASK_COMPLETED\",\"eventName\":\"[任务完成]-事件脚本\",\"script\":\"\"},{\"eventKey\":\"ACTIVITY_STARTED\",\"eventName\":\"[节点活动开始]-事件脚本\",\"script\":\"\"},{\"eventKey\":\"ACTIVITY_COMPLETED\",\"eventName\":\"[节点活动结束]-事件脚本\",\"script\":\"\"}]}";
    	bpmNodeSetManager.saveNodeConfig(solId,actDefId, nodeId,nodeName, nodeType, configJsonInit,"");
    	BpmNodeSet bpmNodeSet=bpmNodeSetManager.getBySolIdActDefIdNodeId(solId,actDefId, nodeId);
    	return bpmNodeSet;
    }
    
    @RequestMapping("eventTypes")
    @ResponseBody
    public ArrayNode eventTypes(HttpServletRequest request,HttpServletResponse response) throws Exception{ 
    	String nodeType=request.getParameter("nodeType");
    	ArrayNode arrayNode=objectMapper.createArrayNode();
    	if("process".equals(nodeType)){
    		for(ProcessEventType ev:ProcessEventType.values()){
    			ObjectNode node=objectMapper.createObjectNode();
    			node.put("eventKey",ev.name());
    			node.put("eventName",ev.getEventName());
    			arrayNode.add(node);
    		}
    	}else if("userTask".equals(nodeType)){
    		for(TaskEventType ev:TaskEventType.values()){
    			ObjectNode node=objectMapper.createObjectNode();
    			node.put("eventKey",ev.name());
    			node.put("eventName",ev.getEventName());
    			arrayNode.add(node);
    		}
    	}else {
    		for(ActivityEventType ev:ActivityEventType.values()){
    			ObjectNode node=objectMapper.createObjectNode();
    			node.put("eventKey",ev.name());
    			node.put("eventName",ev.getEventName());
    			arrayNode.add(node);
    		}
    	}
    	return arrayNode;
    }
    
   /**
     * 取得活动节点列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getActivityNodes")
    @ResponseBody
    public Collection<ActivityNode> getActivityNodes(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String actDefId=request.getParameter("actDefId");
    	boolean includeEnd=RequestUtil.getBoolean(request, "end", false);
    	boolean includeStart=RequestUtil.getBoolean(request, "start", false);
    	Collection<ActivityNode> actNodes=actRepService.getProcessNodes(actDefId);
    	Collection<ActivityNode> list=new ArrayList<ActivityNode>();
    	for(ActivityNode node:actNodes){
    		if(node.getType().equals("start") || node.getType().equals("detail")) continue;
    		if(node.getType().equals("endEvent") && !includeEnd) continue;
    		if(node.getType().equals("startEvent") && !includeStart) continue;
    	
    		list.add(node);
    	}
    	
    	return list;
    }
    
    /**
     * 取得活动节点列表
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("getTaskNodes")
    @ResponseBody
    public Collection<ActivityNode> getTaskNodes(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String actDefId=request.getParameter("actDefId");
    	//是否包括流程分类
    	String includeProcess=request.getParameter("includeProcess");
    	Collection<ActivityNode> actNodes=actRepService.getUserTasks(actDefId);
    	if(StringUtils.isNotEmpty(includeProcess)){
			BpmDef bpmDef=bpmDefManager.getByActDefId(actDefId);
			ActivityNode processNode=new ActivityNode(ActivityNode.PROCESS_NODE_ID, bpmDef.getSubject(), "process", "");
			actNodes.add(processNode);
		}
    	return actNodes;
    }
    
    @RequestMapping("getJumpNodes")
    @ResponseBody
    public Collection<ActNodeDef> getJumpNodes(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String excludeNodeId=request.getParameter("excludeNodeId");
    	String actDefId=request.getParameter("actDefId");
    	
    	Collection<ActNodeDef> actNodeDefs=actRepService.getValidNodes(actDefId, excludeNodeId);
    	
    	return actNodeDefs;
    }
    
    @RequestMapping("edit")
    public ModelAndView edit(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	String pkId=request.getParameter("pkId");
    	//复制添加
    	String forCopy=request.getParameter("forCopy");
    	BpmNodeSet bpmNodeSet=null;
    	if(StringUtils.isNotEmpty(pkId)){
    		bpmNodeSet=bpmNodeSetManager.get(pkId);
    		if("true".equals(forCopy)){
    			bpmNodeSet.setSetId(null);
    		}
    	}else{
    		bpmNodeSet=new BpmNodeSet();
    	}
    	return getPathView(request).addObject("bpmNodeSet",bpmNodeSet);
    }

	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return bpmNodeSetManager;
	}
	
	
	
	@RequestMapping("getAllNode")
	@ResponseBody
	public List<JSONObject> getAllNode(HttpServletRequest request,HttpServletResponse response) throws DocumentException{
		String actDefId=RequestUtil.getString(request, "actDefId");
		String nodeId=RequestUtil.getString(request, "nodeId");
		
		BpmDef bpmDef=bpmDefManager.getByActDefId(actDefId);
		String bpmnXml = actRepService.getBpmnXmlByDeployId(bpmDef.getActDepId());
		Document  document=Jsoup.parse(bpmnXml);
		Elements ele=document.children().get(0).children().get(1).child(0).child(0).children();
		List<JSONObject> list=new ArrayList<JSONObject>();
		buildElementTree(list, nodeId, ele,"-1",null,true,null);
		System.out.println(list);
		
		return list;
	}
	
	/**
	 * 构建树结构
	 * @param list
	 * @param nodeId
	 * @param ele
	 */
	private void buildElementTree(List<JSONObject> list,String nodeId,Elements ele,String parentId,String truthId,Boolean findTask,Boolean isTask){
		for (int i = 0; i < ele.size(); i++) {
			Element element=ele.get(i);
			String sid=element.attr("id");
			if(findTask){//找到作为父节点的任务节点,若不是,则跳过找它下一个或者下几个子节点
				if(nodeId.equals(sid)){
					JSONObject tagObj=new JSONObject();
					String tagName=element.tagName();
					if("usertask".equals(tagName)||("servicetask".equals(tagName)||("scripttask".equals(tagName)))){
						String name=element.attr("name");
						tagObj.put("parentId", parentId);
						tagObj.put("name", name);
						tagObj.put("sid", sid);
						if(checkExistNode(list,tagObj)){
							list.add(tagObj);
							buildElementTree(list, sid, ele, sid,sid, false,true);
						}
					}else{
						buildElementTree(list, sid, ele, sid,truthId, false,false);
					}
					
				}
			}else{//如果是找线,则把线的终端(任务节点)加入到递归建树中
				String sourceRef=element.attr("sourceref");
				if(nodeId.equals(sourceRef)){
					String targetRef=element.attr("targetref");
					if(!isTask){
						sourceRef=truthId;
					}
					buildElementTree(list, targetRef, ele, sourceRef,truthId,true,null);
				}	
			}
			
		}
	}
	
	private Boolean checkExistNode(List<JSONObject> elementObj,JSONObject obj){
		for (int i = 0; i < elementObj.size(); i++) {
			JSONObject element= elementObj.get(i);
			if(element.getString("sid").equals(obj.getString("sid"))){
				return false;
			}
		}
		return true;
	}

}
