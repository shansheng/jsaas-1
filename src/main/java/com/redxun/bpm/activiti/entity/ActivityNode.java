package com.redxun.bpm.activiti.entity;

/**
 * Activity的流程节点类型
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ActivityNode {
	//当为流程大节点的ID
	public  final static String PROCESS_NODE_ID="_PROCESS"; 
	
	//活动定义的ID
	public String activityId;
	//活动的名称
	public String name;
	//活动节点的类型，如userTask,startEvent,endEvent
	public String type;
	//若为多实例，则显示为并行或串行类型
	public String multiInstance=null;
	
	//节点的描述
	public String document;
	//父节点ID
	public String parentActivitiId;
	
	public String getActivityId() {
		return activityId;
	}
	

	public String getIconCls() {
		if("userTask".equals(type)){
			return "icon-group";
		}else if("startEvent".equals(type)){
			return "icon-startEvent";
		}else if("endEvent".equals(type)){
			return "icon-endEvent";
		}else if("process".equals(type)){
			return "icon-flow";
		}
		
		return "";
		
	}
	
	public ActivityNode() {
		
	}
	/**
	 * 活动节点构造函数
	 * @param activityId
	 * @param name
	 * @param type
	 * @param document
	 */
	public ActivityNode(String activityId,String name,String type,String document){
		this.activityId=activityId;
		this.name=name;
		this.type=type;
		this.document=document;
	}
	
	public ActivityNode(String activityId,String name,String type){
		this.activityId=activityId;
		this.name=name;
		this.type=type;
	}
	
	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getDocument() {
		return document;
	}
	
	public void setDocument(String document) {
		this.document = document;
	}

	public String getParentActivitiId() {
		return parentActivitiId;
	}

	public void setParentActivitiId(String parentActivitiId) {
		this.parentActivitiId = parentActivitiId;
	}

	public String getMultiInstance() {
		return multiInstance;
	}

	public void setMultiInstance(String multiInstance) {
		this.multiInstance = multiInstance;
	}

	
}
