package com.redxun.bpm.core.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.impl.persistence.entity.TaskEntity;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;

/**
 * 流程启动及执行下一步时的命令参数抽象类
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class AbstractExecutionCmd implements IExecutionCmd{
	//目标节点ID
	protected String destNodeId;
	//目标节点及执行的配置信息，如人员，到期时间
	protected Map<String,BpmDestNode> nodeUserMap=new HashMap<String, BpmDestNode>();
	//业务JSON的数据
	protected String jsonData;
	//业务JSON对象
	protected JSONObject jsonDataObject;
	//流程实例ID
	protected String actInstId;
	//当前节点Id(中间过程会改变)
	protected String nodeId;
	//当前办理的节点Id
	protected String handleNodeId;
	//当前正文Id
	protected String checkFileId;
	//是否忽略跳过的任务集合  true or false
	protected boolean skipHandler=false;
	
	//当前附件Ids
	protected String fileIds;
	
	//跳转类型如同意、反对，值范围有TaskOptionType里的值
	protected String jumpType;
	//意见控件名称。
	protected String opinionName;
	//审批意见
	protected String opinion;
	//审批附件ID
	protected String opFiles;
	//流程变量
	protected Map<String,Object> vars=new HashMap<String,Object>();
	//抄送的用户Id
	protected String ccUserIds;
	//抄送的用户组Ids
	protected String ccGroupIds;
	//实例Id
	protected String bpmInstId;
	//活动节点的运行路径Id,不通过界面传入
	protected String runPathId;
	
	//当前节点的超时状态，直接从task中获取
	protected String timeoutStatus;
	

	
	/**
	 * 临时瞬态变量。
	 */
	protected Map<String,Object> transientVars=new HashMap<String,Object>(); 
	
	
	protected Map<String,JSONObject> boDataMaps=new HashMap<String, JSONObject>();
	
	private List<TaskEntity> taskEntities=new ArrayList<TaskEntity>();
	
	
	public boolean isSkipHandler() {
		return skipHandler;
	}

	public void setSkipHandler(boolean skipHandler) {
		this.skipHandler = skipHandler;
	}

	/**
	 * 获得令牌
	 */
	protected String token;
	
	public String getDestNodeId() {
		return destNodeId;
	}

	public void setDestNodeId(String destNodeId) {
		this.destNodeId = destNodeId;
	}

	public Map<String, BpmDestNode> getNodeUserMap() {
		return nodeUserMap;
	}

	public Map<String, JSONObject> getBoDataMaps() {
		return boDataMaps;
	}

	public void setBoDataMaps(Map<String, JSONObject> boDataMaps) {
		this.boDataMaps = boDataMaps;
	}

	public String getOpFiles() {
		return opFiles;
	}

	public void setOpFiles(String opFileId) {
		this.opFiles = opFileId;
	}

	public void setNodeUserMap(Map<String, BpmDestNode> nodeUserMap) {
		this.nodeUserMap = nodeUserMap;
	}
	
	/**
	 * 设置节点用户。
	 * @param nodeId
	 * @param userIds
	 */
	public void addNodeUsers(String nodeId,String userIds){
		this.nodeUserMap.put(nodeId, new BpmDestNode(nodeId,userIds));
	}

	public String getJsonData() {
		return jsonData;
	}

	public void setJsonData(String jsonData) {
		this.jsonData = jsonData;
		if(StringUtil.isNotEmpty(jsonData)){
			this.jsonDataObject=JSONObject.parseObject(jsonData);
		}
	}
	
	public String getCheckFileId() {
		return checkFileId;
	}

	public void setCheckFileId(String checkFileId) {
		this.checkFileId = checkFileId;
	}

	public String getFileIds() {
		return fileIds;
	}

	public void setFileIds(String fileIds) {
		this.fileIds = fileIds;
	}

	public String getHandleNodeId() {
		return handleNodeId;
	}

	public void setHandleNodeId(String handleNodeId) {
		this.handleNodeId = handleNodeId;
	}

	public String getJumpType() {
		if(StringUtil.isEmpty(this.jumpType)){
			return TaskOptionType.AGREE.name();
		}
		return jumpType;
	}

	public void setJumpType(String jumpType) {
		this.jumpType = jumpType;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public Map<String, Object> getVars() {
		return vars;
	}

	public void setVars(Map<String, Object> vars) {
		if(BeanUtil.isEmpty(vars)) return;
		this.vars = vars;
	}

//	public Map<String, String> getSkipCheckTaskUserIds() {
//		return skipCheckTaskUserIds;
//	}

	public String getCcUserIds() {
		return ccUserIds;
	}

	public void setCcUserIds(String ccUserIds) {
		this.ccUserIds = ccUserIds;
	}

	public String getCcGroupIds() {
		return ccGroupIds;
	}

	public void setCcGroupIds(String ccGroupIds) {
		this.ccGroupIds = ccGroupIds;
	}

	public String getBpmInstId() {
		return bpmInstId;
	}

	public void setBpmInstId(String bpmInstId) {
		this.bpmInstId = bpmInstId;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
	
	@Override
	public String getOpinionName() {
		return opinionName;
	}
	
	public void setOpinionName(String opinionName) {
		this.opinionName = opinionName;
	}

	public String getRunPathId() {
		return runPathId;
	}

	public void setRunPathId(String runPathId) {
		this.runPathId = runPathId;
	}

	public String getTimeoutStatus() {
		return timeoutStatus;
	}

	public void setTimeoutStatus(String timeoutStatus) {
		this.timeoutStatus = timeoutStatus;
	}

	@Override
	public List<TaskEntity> getNewTasks() {
		return taskEntities;
	}

	@Override
	public void addTask(TaskEntity entity) {
		taskEntities.add(entity);
	}

	@Override
	public void cleanTasks() {
		taskEntities.clear();
		
	}

	@Override
	public Map<String, Object> getTransientVars() {
		return this.transientVars;
	}

	@Override
	public void addTransientVar(String name, Object obj) {
		this.transientVars.put(name, obj);
	}

	@Override
	public void clearTransientVars() {
		this.transientVars.clear();
		
	}

	public JSONObject getJsonDataObject() {
		return jsonDataObject;
	}


	
	/**
	 * 目标节点执行人
	 * [{nodeId:"",userIds:"",groupIds:""}]
	 * @param destNodeUsers
	 */
	public void setDestNodeUsers(String destNodeUsers){
		if(StringUtil.isEmpty(destNodeUsers)) return;
		JSONArray ary= JSONArray.parseArray(destNodeUsers);
		for(int i=0;i<ary.size();i++){
			JSONObject obj = ary.getJSONObject(i);
			String nodeId = obj.getString("nodeId");
			String userIds = obj.getString("userIds");
			String groupIds = obj.getString("groupIds");
			BpmDestNode dn = new BpmDestNode(nodeId, userIds,groupIds);
			this.nodeUserMap.put(nodeId, dn);
		}
	}
	

}
