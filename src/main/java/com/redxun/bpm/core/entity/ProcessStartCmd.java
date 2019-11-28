package com.redxun.bpm.core.entity;

import com.redxun.bpm.activiti.service.CallModel;

/**
 * 流程启动参数设置
 * 
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public class ProcessStartCmd extends AbstractExecutionCmd{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2802240599399283469L;

	// 流程解决方案ID，必传
	private String solId;

	//流程实例ID,在草稿下启动才需要传
	private String bpmInstId;
	

	//数据来自
	private String from;
	//节点人员配置，由发起流程的表单来生成，格式为[{nodeId:'N1',userIds'1,2'},{nodeId:'N2',userIds:'1,23'}]
	private String nodeUserIds=null;
	
	/**
	 * 调用的流程情况。
	 */
	private CallModel callModel=null;
	
	/**
	 * 流程关联的业务主键ID，可不传，若为外部表单时，需要自己传入
	 */
	private String businessKey;

	public String getSolId() {
		return solId;
	}

	public void setSolId(String solId) {
		this.solId = solId;
	}
	

	public String getBpmInstId() {
		return bpmInstId;
	}

	public void setBpmInstId(String bpmInstId) {
		this.bpmInstId = bpmInstId;
	}

	public String getDestNodeId() {
		return destNodeId;
	}

	public void setDestNodeId(String destNodeId) {
		this.destNodeId = destNodeId;
	}


	public String getBusinessKey() {
		return businessKey;
	}

	public void setBusinessKey(String businessKey) {
		this.businessKey = businessKey;
	}

	public String getFrom() {
		if(from==null) return "";
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}


	public String getNodeUserIds() {
		return nodeUserIds;
	}

	public void setNodeUserIds(String nodeUserIds) {
		this.nodeUserIds = nodeUserIds;
	}

	public CallModel getCallModel() {
		return callModel;
	}

	public void setCallModel(CallModel callModel) {
		this.callModel = callModel;
	}
	
	
	
}
