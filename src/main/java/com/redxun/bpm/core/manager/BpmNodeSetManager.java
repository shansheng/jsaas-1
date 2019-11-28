package com.redxun.bpm.core.manager;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.bpm.activiti.entity.ActivityNode;
import com.redxun.bpm.core.dao.BpmNodeSetDao;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmNodeSet;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.config.ActivityConfig;
import com.redxun.bpm.core.entity.config.BpmEventConfig;
import com.redxun.bpm.core.entity.config.ButtonConfig;
import com.redxun.bpm.core.entity.config.ExclusiveGatewayConfig;
import com.redxun.bpm.core.entity.config.MultiTaskConfig;
import com.redxun.bpm.core.entity.config.NodeExecuteScript;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.entity.config.StartEventConfig;
import com.redxun.bpm.core.entity.config.TaskIdentityConfig;
import com.redxun.bpm.core.entity.config.TaskVotePrivConfig;
import com.redxun.bpm.core.entity.config.UserTaskConfig;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.dao.IDao;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;
/**
 * <pre> 
 * 描述：BpmNodeSet业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class BpmNodeSetManager extends BaseManager<BpmNodeSet>{
	@Resource
	private BpmNodeSetDao bpmNodeSetDao;
	@Resource(name="iJson")
	ObjectMapper objectMapper;
	@Resource
	private BpmSolutionDao bpmSolutionDao;
	@Resource
	private SysBoEntManager sysBoEntManager;
	
	@Resource
	BpmDefManager bpmDefManager;
	@Resource
	BpmSolFvManager bpmSolFvManager;
	@Resource
	BpmFormViewManager bpmFormViewManager;
	@Resource
	BpmFormulaMappingManager bpmFormulaMappingManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmNodeSetDao;
	}
	
	 /**
     * 通过流程定义Id获得节点配置列表
     * @param actDefId
     * @return
     */
    public List<BpmNodeSet> getByActDefId(String actDefId){
    	return bpmNodeSetDao.getByActDefId(actDefId);
    }
    
    /**
     * 获得某个解决方案中的流程定义的配置
     * @param solId
     * @param actDefId
     * @return
     */
    public List<BpmNodeSet> getBySolIdActDefId(String solId,String actDefId){
    	return bpmNodeSetDao.getBySolIdActDefId(solId, actDefId);
    }
    
    
    /**
     * 获得流程解决方案对应的节点配置
     * @param solId
     * @param actDefId
     * @param nodeId 流程本身也是一节点信息，其Id为ActivityNode.PROCESS_NODE_ID
     * @return
     */
    public BpmNodeSet getBySolIdActDefIdNodeId(String solId,String actDefId,String nodeId){
		return bpmNodeSetDao.getBySolIdActDefIdNodeId(solId,actDefId, nodeId);
	}
    
      
    public BpmNodeSet getByProcessConfig(String solId,String actDefId){
    	return bpmNodeSetDao.getBySolIdActDefIdNodeId(solId, actDefId,ActivityNode.PROCESS_NODE_ID);
    }
    
    /**
     * 按方案Id及ActDefId删除节点配置
     * @param solId
     * @param actDefId
     */
    public void delBySolIdActDefId(String solId,String actDefId){
    	bpmNodeSetDao.delBySolIdActDefId(solId, actDefId);
    }
    
    /**
     * 按流程解决方案ID删除
     * @param solId
     */
    public void delBySolId(String solId){
    	bpmNodeSetDao.delBySolId(solId);
    }
    
    /**
     * 获得分支节点的配置
     * @param solId
     * @param nodeId
     * @return
     */
    public ExclusiveGatewayConfig getExclusiveGatewayConfig(String solId,String actDefId,String nodeId){
    	BpmNodeSet bpmNodeSet=getBySolIdActDefIdNodeId(solId,actDefId,nodeId);
    	ExclusiveGatewayConfig config=new ExclusiveGatewayConfig();
    	if(bpmNodeSet==null) {
    		return config;
    	}
    	try{
    		JsonNode rootNode=objectMapper.readTree(bpmNodeSet.getSettings());
    		ObjectNode configsNode=(ObjectNode)rootNode.get("configs");
    		JsonNode conditions=configsNode.get("conditions");
    		Iterator<JsonNode> gatewayConfigIt=conditions.elements();
    		while(gatewayConfigIt.hasNext()){
    			JsonNode objNode=gatewayConfigIt.next();
    			NodeExecuteScript condition=objectMapper.readValue(objNode.toString(),NodeExecuteScript.class);
    			config.getConditions().add(condition);
    		}

    		JsonNode events=rootNode.get("events");
    		Iterator<JsonNode> eventIt=events.elements();
    		while(eventIt.hasNext()){
    			JsonNode objNode=eventIt.next();
    			BpmEventConfig eventConfig=objectMapper.readValue(objNode.toString(),BpmEventConfig.class);
    			config.getEvents().add(eventConfig);
    		}
    	}catch(Exception ex){
    		logger.error("solId:"+solId + " nodeId:"+nodeId + " json is error:"+ex.getMessage());
    		logger.error("json is:"+bpmNodeSet.getSettings());
    	}
    	return config;
    }
    
    
    public static String getProcessConfigKey(String solId,String actDefId){
    	String key=ProcessConfig.class.getSimpleName() +"_" + solId +"_"+actDefId;
    	return key;
    }
  
    
    /**
     * 获得流程的信息的配置
     * @param solId
     * @param nodeId
     * @return
     */
    public ProcessConfig getProcessConfig(String solId,String actDefId){
    	String key=getProcessConfigKey( solId ,actDefId);
    	ProcessConfig processConfig= (ProcessConfig) CacheUtil.getCache(key);
    	if(processConfig!=null) return processConfig;
    	
    	
    	String nodeId=ProcessConfig.PROCESS_NODE_ID;
    	BpmNodeSet bpmNodeSet=getBySolIdActDefIdNodeId(solId,actDefId,nodeId);
    	ProcessConfig config=new ProcessConfig();
    	if(bpmNodeSet==null)   return config;
    	try{
    		JsonNode rootNode=objectMapper.readTree(bpmNodeSet.getSettings());
    		ObjectNode configsNode=(ObjectNode)rootNode.get("configs");
    		config.setIsSkipFirst(JSONUtil.getJsonString(configsNode,"isSkipFirst"));
    		config.setIsShowStartUsers(JSONUtil.getJsonString(configsNode,"isShowStartUsers"));
    		config.setSubRule(JSONUtil.getJsonString(configsNode,"subRule"));
    		config.setNoRule(JSONUtil.getJsonString(configsNode,"noRule"));
    		config.setAllowFreeJump(JSONUtil.getJsonString(configsNode,"allowFreeJump"));
    		config.setShowCheckList(JSONUtil.getJsonString(configsNode,"showCheckList"));
    	
       		config.setConfirmStart(JSONUtil.getJsonString(configsNode, "confirmStart"));
       		config.setExtFormUrl(JSONUtil.getJsonString(configsNode, "extFormUrl"));
       		//通知配置。
       		config.setNotices(JSONUtil.getJsonString(configsNode, "notices"));
       		//跳转
       		config.setJumpSetting(JSONUtil.getJsonString(configsNode, "jumpSetting"));
       		//启动时选择执行人。
       		config.setSelectUser(JSONUtil.getJsonString(configsNode, "selectUser"));
       		//设置是否显示执行路径。
       		config.setShowExecPath(JSONUtil.getJsonString(configsNode, "showExecPath"));
       		//意见文字标识。
       		String opinionText="";
       		JsonNode opinionNode =configsNode.get("opinionText");
       		if(opinionNode!=null){
       			opinionText=configsNode.get("opinionText").toString();
       		}
       		config.setOpinionText(opinionText);
       		//需要填写意见。
       		config.setNeedOpinion(JSONUtil.getJsonString(configsNode,"needOpinion"));
       		//设置是否在启动时指定发起人。
       		config.setStartUser(JSONUtil.getJsonString(configsNode,"startUser"));
       		
       		JsonNode buttons=configsNode.get("buttons");
    		if(buttons!=null){
    			Iterator<JsonNode> buttonIt=buttons.elements();
    			while(buttonIt.hasNext()){
        			JsonNode objNode=buttonIt.next();
        			ButtonConfig btnConfig=objectMapper.readValue(objNode.toString(),ButtonConfig.class);
        			config.getButtons().add(btnConfig);
        		}
    		}
       		
       		
    		if(configsNode.get("preHandle")!=null){
    			config.setPreHandle(JSONUtil.getJsonString(configsNode,"preHandle"));
    		}
    		
    		if(configsNode.get("afterHandle")!=null){
    			config.setAfterHandle(JSONUtil.getJsonString(configsNode,"afterHandle"));
    		}
    		
    		if(configsNode.get("processEndHandle")!=null){
    			config.setProcessEndHandle(JSONUtil.getJsonString(configsNode,"processEndHandle"));
    		}
    		
    		String tableRightJson= getTableRightJson(solId,actDefId,nodeId,configsNode);
    		
    		config.setTableRightJson(tableRightJson);
    		
        	JsonNode events=rootNode.get("events");
        	if(events!=null){
        		Iterator<JsonNode> eventIt=events.elements();
        		while(eventIt.hasNext()){
        			JsonNode objNode=eventIt.next();
        			BpmEventConfig eventConfig=objectMapper.readValue(objNode.toString(),BpmEventConfig.class);
        			config.getEvents().add(eventConfig);
        		}
        	}
        	JsonNode globalEventJson= rootNode.get("globalEvent");
        	String globalEvent="{}";
    		if(globalEventJson!=null){
    			globalEvent=globalEventJson.toString();
    		}
        	config.setGlobalEvent(globalEvent);
    		
    	}catch(Exception ex){
    		ex.printStackTrace();
    		logger.error("solId:"+solId + " nodeId:"+nodeId + " json is error:"+ex.getMessage());
    		logger.error("json is:"+bpmNodeSet.getSettings());
    	}
    	CacheUtil.addCache(key, config);
    	return config;
    }
    
    /**
     * 获得开始节点信息的配置
     * @param solId
     * @param nodeId
     * @return
     */
    public StartEventConfig getStartEventConfig(String solId,String actDefId,String nodeId){
    	BpmNodeSet bpmNodeSet=getBySolIdActDefIdNodeId(solId,actDefId,nodeId);
    	StartEventConfig config=new StartEventConfig();
    	if(bpmNodeSet==null) {
    		return config;
    	}
    	try{
    		JsonNode rootNode=objectMapper.readTree(bpmNodeSet.getSettings());
    		ObjectNode configsNode=(ObjectNode)rootNode.get("configs");
    		config.setAllowNextExecutor(JSONUtil.getJsonString(configsNode,"allowNextExecutor"));
    		config.setAllowPathSelect(JSONUtil.getJsonString(configsNode,"allowPathSelect"));
    		if(configsNode.get("preHandle")!=null){
    			config.setPreHandle(JSONUtil.getJsonString(configsNode,"preHandle"));
    		}
    		
    		if(configsNode.get("afterHandle")!=null){
    			config.setAfterHandle(JSONUtil.getJsonString(configsNode,"afterHandle"));
    		}
    		JsonNode events=rootNode.get("events");
    		Iterator<JsonNode> eventIt=events.elements();
    		while(eventIt.hasNext()){
    			JsonNode objNode=eventIt.next();
    			BpmEventConfig eventConfig=objectMapper.readValue(objNode.toString(),BpmEventConfig.class);
    			config.getEvents().add(eventConfig);
    		}

    	}catch(Exception ex){
    		logger.error("solId:"+solId + " nodeId:"+nodeId + " json is error:"+ex.getMessage());
    		logger.error("json is:"+bpmNodeSet.getSettings());
    	}
    	return config;
    }
    
    
    
    public static String getTaskKey(String solId,String actDefId,String nodeId){
    	String key="TaskConfig" +"_" + solId +"_" +actDefId +"_" + nodeId;
    	return key;
    }
    
    /**
     * 获得任务配置
     * @param solId
     * @param nodeId
     * @return
     */
    public UserTaskConfig getTaskConfig(String solId,String actDefId,String nodeId){
    	String key=getTaskKey( solId, actDefId, nodeId);
    	UserTaskConfig taskConfig=(UserTaskConfig) CacheUtil.getCache(key);
    	if(taskConfig!=null) return taskConfig;
    	BpmNodeSet bpmNodeSet=getBySolIdActDefIdNodeId(solId,actDefId,nodeId);
    	UserTaskConfig config=new UserTaskConfig();
    	if(bpmNodeSet==null) {
    		return config;
    	}
    	try{
    		JsonNode rootNode=objectMapper.readTree(bpmNodeSet.getSettings());
    		ObjectNode configsNode=(ObjectNode)rootNode.get("configs");
    		
    		config.setAllowConfigButtons(JSONUtil.getJsonString(configsNode,"allowConfigButtons"));
    		config.setAllowNextExecutor(JSONUtil.getJsonString(configsNode,"allowNextExecutor"));
    		config.setAllowPathSelect(JSONUtil.getJsonString(configsNode,"allowPathSelect"));
    		config.setShowCheckList(JSONUtil.getJsonString(configsNode,"showCheckList"));
    		config.setAllowPrint(JSONUtil.getJsonString(configsNode,"allowPrint"));
    		config.setExtFormUrl(JSONUtil.getJsonString(configsNode, "extFormUrl"));
    		config.setAllowChangePath(JSONUtil.getJsonString(configsNode, "allowChangePath"));
    		
    		
    		String tableRightJson= getTableRightJson(solId,actDefId,nodeId,configsNode);
    		
    		config.setTableRightJson(tableRightJson);
    		
    		
    		JsonNode buttons=configsNode.get("buttons");
    		Iterator<JsonNode> buttonIt=buttons.elements();
    		//加上前后置事件的获取
    		if(configsNode.get("preHandle")!=null){
    			config.setPreHandle(JSONUtil.getJsonString(configsNode,"preHandle"));
    		}
    		if(configsNode.get("afterHandle")!=null){
    			config.setAfterHandle(JSONUtil.getJsonString(configsNode,"afterHandle"));
    		}
    		if(configsNode.get("allowScript")!=null){
    			config.setAllowScript(JSONUtil.getJsonString(configsNode,"allowScript"));
    		}
    		
    		if(configsNode.get("allowTipInfo")!=null){
    			config.setAllowTipInfo(JSONUtil.getJsonString(configsNode,"allowTipInfo"));
    		}
    		
    		if(configsNode.get("allowEmptyExecutor")!=null){
    			config.setAllowEmptyExecutor(JSONUtil.getJsonString(configsNode,"allowEmptyExecutor"));
    		}
    		
    		
    		if(configsNode.get("calSettingId")!=null){
    			config.setCalSettingId(JSONUtil.getJsonString(configsNode,"calSettingId"));
    		}
    		
    		if(configsNode.get("calSettingName")!=null){
    			config.setCalSettingName(JSONUtil.getJsonString(configsNode,"calSettingName"));
    		}
    		
    		if(configsNode.get("overTime")!=null){
    			config.setOverTime(Integer.parseInt(JSONUtil.getJsonString(configsNode,"overTime")));
    		}
    		
    		
    		
    		while(buttonIt.hasNext()){
    			JsonNode objNode=buttonIt.next();
    			ButtonConfig btnConfig=objectMapper.readValue(objNode.toString(),ButtonConfig.class);
    			config.getButtons().add(btnConfig);
    		}
    		
    		JsonNode notices=configsNode.get("notices");
    		config.setNotices(notices.textValue());
    		
    		JsonNode events=rootNode.get("events");
    		Iterator<JsonNode> eventIt=events.elements();
    		while(eventIt.hasNext()){
    			JsonNode objNode=eventIt.next();
    			BpmEventConfig eventConfig=objectMapper.readValue(objNode.toString(),BpmEventConfig.class);
    			config.getEvents().add(eventConfig);
    		}
    		
    		//获得多实例的任务配置
    		JsonNode vrTypeNode=configsNode.get("voteResultType");
    		if(vrTypeNode!=null){
    			MultiTaskConfig mtConfig=objectMapper.readValue(configsNode.toString(), MultiTaskConfig.class);
    			
    			//获得会签特权配置
    			JsonNode votePrivs=configsNode.get("votePrivs");
    			Iterator<JsonNode>vpIt=votePrivs.iterator();
    			while(vpIt.hasNext()){
    				JsonNode jnode=vpIt.next();
    				try{
	    				String identityType=JSONUtil.getJsonString(jnode,"identityType");
	    				String identityIds=JSONUtil.getJsonString(jnode,"identityIds");
	    				String[] ids=identityIds.split("[,]");
	    				TaskVotePrivConfig tvpConfig=new TaskVotePrivConfig();
	    				JsonNode voteNumNode=jnode.get("voteNums");
	    				if(voteNumNode!=null && StringUtils.isNotEmpty(voteNumNode.toString())){
	    					tvpConfig.setVoteNums(new Integer(voteNumNode.toString()));
	    				}else{
	    					tvpConfig.setVoteNums(1);
	    				}
	    				tvpConfig.getIdentityIds().addAll(Arrays.asList(ids));
	    				tvpConfig.setIdentityType(identityType);
	    				mtConfig.getVotePrivConfigs().add(tvpConfig);
    				}catch(Exception e){
    					logger.error(e.getMessage());
    				}
    			}
    			//获得会签节点Id
    			JsonNode addSigns=configsNode.get("addSigns");
    			Iterator<JsonNode>addSignIt=addSigns.iterator();
    			while(addSignIt.hasNext()){
    				JsonNode jnode=addSignIt.next();
    				try{
	    				String identityType=JSONUtil.getJsonString(jnode,"identityType");
	    				String identityIds=JSONUtil.getJsonString(jnode,"identityIds");
	    				String[] ids=identityIds.split("[,]");
	    				TaskIdentityConfig idConfig=new TaskIdentityConfig();
	    				
	    				idConfig.getIdentityIds().addAll(Arrays.asList(ids));
	    				idConfig.setIdentityType(identityType);
	    				mtConfig.getAddSignConfigs().add(idConfig);
    				}catch(Exception e){
    					logger.error(e.getMessage());
    				}
    			}
    			//设置多实例配置
    			config.setMultiTaskConfig(mtConfig);
    		}
    	}catch(Exception ex){
    		logger.error("solId:"+solId + " nodeId:"+nodeId + " json is error:"+ex.getMessage());
    		logger.error("json is:"+bpmNodeSet.getSettings());
    	}
    	CacheUtil.addCache(key, config);
    	return config;
    }
    
    public String getTableRightJson(String solId,String actDefId, String nodeId, ObjectNode configsNode){
    	BpmSolFv solFv=bpmSolFvManager.getBySolIdActDefIdNodeId(solId, actDefId, nodeId);
    	if(solFv==null){
    		return "{}";
    	}
    	String formAlias ="";
    	String CondForms= solFv.getCondForms();
    	JSONArray arr = JSONArray.parseArray(CondForms);
    	JSONObject rtnJson=new JSONObject();
    	if(arr.size()==0){
    		CondForms = bpmSolFvManager.getBySolIdActDefIdNodeId(solId, actDefId, "_PROCESS").getCondForms();
    		arr = JSONArray.parseArray(CondForms);
    	}
    	for(int i=0;i<arr.size();i++){
    		JSONObject ob = arr.getJSONObject(i);
    		formAlias = ob.getString("formAlias");
    		
    		BpmFormView formView= bpmFormViewManager.getLatestByKey(formAlias, solFv.getTenantId());
        	if(formView==null){
        		return "{}";
        	}
        	String boDefId=formView.getBoDefId();
        	
        	if(BeanUtil.isEmpty(boDefId)) return "{}";
        	String rightJson=JSONUtil.getJsonString(configsNode,"tableRightJson");
        	
        	SysBoEnt boEnt= sysBoEntManager.getByBoDefId(boDefId, false);
        	
        	List<SysBoEnt> subList=boEnt.getBoEntList();
        	if(BeanUtil.isEmpty(subList)) return "{}";      	
        	
        	
        	if(StringUtil.isEmpty(rightJson)){
        		rightJson="{}";
        	}
        	JSONObject orginJson=JSONObject.parseObject(rightJson);
        	 
        	for(SysBoEnt ent:subList){
        		String name=ent.getName();
        		if(!orginJson.containsKey(name)){
        			JSONObject typeJson=new JSONObject();
        			typeJson.put("type", "all");
        			typeJson.put("comment", ent.getComment());
        			rtnJson.put(name, typeJson);
        		}
        		else{
        			JSONObject json=orginJson.getJSONObject(name);
        			json.put("comment", ent.getComment());		
        			rtnJson.put(name, json);
        		}
        	}
    	}
    	
    	
    	
    	
    	return rtnJson.toJSONString();
    	
    }
    
    public void saveNodeConfig(String solId,String actDefId,String nodeId,String nodeName,String nodeType,String configJson,String tipText){
    	String processConfigKey=getProcessConfigKey(solId, actDefId);
    	CacheUtil.delCache(processConfigKey);
    	
    	String taskKey=getTaskKey(solId, actDefId, nodeId);
    	CacheUtil.delCache(taskKey);
    	
    	BpmNodeSet bpmNodeSet=this.getBySolIdActDefIdNodeId(solId,actDefId,nodeId);
    	if(bpmNodeSet==null){
    		bpmNodeSet=new BpmNodeSet();
    		bpmNodeSet.setSolId(solId);
    		bpmNodeSet.setNodeId(nodeId);
    		bpmNodeSet.setName(nodeName);
    		bpmNodeSet.setNodeType(nodeType);
    		bpmNodeSet.setActDefId(actDefId);
    		bpmNodeSet.setSettings(configJson);
    		bpmNodeSet.setNodeCheckTip(tipText);
    		bpmNodeSet.setSetId(IdUtil.getId());
    		create(bpmNodeSet);
    	}else{
    		bpmNodeSet.setNodeCheckTip(tipText);
    		bpmNodeSet.setSettings(configJson);
    		bpmNodeSet.setNodeId(nodeId);
    		bpmNodeSet.setName(nodeName);
    		update(bpmNodeSet);
    	}
    	JSONObject jsonObj=JSONObject.parseObject(configJson);
    	JSONObject configs=jsonObj.getJSONObject("configs");
    	if(configs!=null &&  configs.containsKey("formulaId")){
    		String formulaId=configs.getString("formulaId");
        	String formulaName=configs.getString("formulaName");
        	//保存公式。
        	bpmFormulaMappingManager.saveFormulaMapping(solId, actDefId, nodeId, formulaId, formulaName);
    	}
    	
    	
    }
    
    public void saveProcessConfig(String solId,String actDefId,String configJson){
    	saveNodeConfig( solId, actDefId,ActivityNode.PROCESS_NODE_ID,ActivityNode.PROCESS_NODE_ID, "process", configJson,"");
    }
    
    /**
     * 获取超时配置
     * @param solId
     * @param actDefId
     * @param taskDefKey
     * @return
     */
    public JSONObject getOvertimeConfig(String solId,String actDefId,String taskDefKey){
	    	JSONObject rtnObj=new JSONObject();//将要返回的json
	    	List<BpmNodeSet> nodeSets=getBySolIdActDefId(solId, actDefId);
	    	BpmNodeSet currentNode=bpmNodeSetDao.getBySolIdActDefIdNodeId(solId, actDefId, taskDefKey);
	    	for (int i = 0; i < nodeSets.size(); i++) {
	    		BpmNodeSet bpmNodeSet=nodeSets.get(i);
	    		if(taskDefKey.equals(bpmNodeSet.getNodeId())||currentNode==null){
	    			JSONObject jsonObject=(JSONObject.parseObject(bpmNodeSet.getSettings())).getJSONObject("configs");
	    			if(jsonObject.containsKey("monthOvertime")&&currentNode!=null){//当前nodeSet的配置里是否有配置超时
	    				String monthOvertime=jsonObject.getString("monthOvertime");
	    				Integer duringTime=jsonObject.getInteger("duringTime");
	    				if(("false".equals(monthOvertime))&&(duringTime<=0)){//是否空配置
							continue;
	    				}else{
	    					String unionNodeSet=jsonObject.getString("unionNodeSet");
	    					rtnObj.put("exist", "current");
	    					rtnObj.put("monthOvertime", monthOvertime);
	    					rtnObj.put("duringTime", duringTime);
	    					rtnObj.put("unionNodeSet", unionNodeSet);
	    					return rtnObj;
	    				}
	    			}else{//重新遍历寻找前任配置
	    				for (int j = 0; j < nodeSets.size(); j++) {
	    					BpmNodeSet foreachNode=nodeSets.get(j);
	    					if("userTask".equals(foreachNode.getNodeType())){
	    						JSONObject jsonConfig=(JSONObject.parseObject(foreachNode.getSettings())).getJSONObject("configs");
	    						String monthOvertime=jsonConfig.getString("monthOvertime");
	    	    				Integer duringTime=jsonConfig.getInteger("duringTime");
	    	    				String unionNodeSet=jsonConfig.getString("unionNodeSet");
	    	    				if(("false".equals(monthOvertime))&&(duringTime<=0)){//是否空配置
	    							continue;
	    	    				}else if(unionNodeSet!=null&&unionNodeSet.contains(taskDefKey)){
	    	    					rtnObj.put("exist", "before");
	    	    					rtnObj.put("monthOvertime", monthOvertime);
	    	    					rtnObj.put("duringTime", duringTime);
	    	    					rtnObj.put("unionNodeSet", unionNodeSet);
	    	    					return rtnObj;
	    	    				}
	    					}
	    				}
	    			}
	    	}
    	}
    	rtnObj.put("exist", "loseConfig");//如果找不到返回旧版本缺失配置
    	return rtnObj;
    }
}