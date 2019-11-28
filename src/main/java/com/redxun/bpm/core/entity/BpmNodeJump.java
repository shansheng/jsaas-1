package com.redxun.bpm.core.entity;

import java.io.Serializable;
import java.text.DecimalFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.redxun.bpm.enums.TaskOptionType;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.json.JsonDateSerializer;
import com.redxun.core.util.StringUtil;

/**
 * <pre>
 * 描述：BpmNodeJump实体类定义
 * 流程流转记录
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_NODE_JUMP")
@TableDefine(title = "流程流转记录")
public class BpmNodeJump extends BaseTenantEntity {
	// 初始化
	public final static String STATUS_INIT = "INIT";
	// 结束
	public final static String STATUS_END = "FINISH";
	//流转
	public final static String JUMP_TYPE_TRANSFER="TRANSFER";
	//尚未处理
	public final static String JUMP_TYPE_UNHANDLE="UNHANDLE";
	
	
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "JUMP_ID_")
	protected String jumpId;
	/* ACT流程定义ID */
	@FieldDefine(title = "ACT流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	/* ACT流程实例ID */
	@FieldDefine(title = "ACT流程实例ID")
	@Column(name = "ACT_INST_ID_")
	@Size(max = 64)
	protected String actInstId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	@Size(max = 255)
	protected String nodeName;
	/* 节点Key */
	@FieldDefine(title = "节点Key")
	@Column(name = "NODE_ID_")
	@Size(max = 255)
	@NotEmpty
	protected String nodeId;
	/* 任务ID */
	@FieldDefine(title = "任务ID")
	@Column(name = "TASK_ID_")
	@Size(max = 64)
	protected String taskId;
	/* 完成时间 */
	@FieldDefine(title = "完成时间")
	@Column(name = "COMPLETE_TIME_")
	protected java.util.Date completeTime;
	/* 持续时长 */
	@FieldDefine(title = "持续时长")
	@Column(name = "DURATION_")
	protected Long duration;
	/* 有效审批时长 */
	@FieldDefine(title = "有效审批时长")
	@Column(name = "DURATION_VAL_")
	protected Integer durationVal;
	/* 处理人ID */
	@FieldDefine(title = "处理人ID")
	@Column(name = "HANDLER_ID_")
	@Size(max = 64)
	protected String handlerId;
	
	@FieldDefine(title="任务所属人ID")
	@Column(name = "OWNER_ID_")
	@Size(max = 64)
	protected String ownerId;

	@FieldDefine(title="任务代理人ID")
	@Column(name = "AGENT_USER_ID_")
	@Size(max = 64)
	protected String agentUserId;

	
	/* 审批状态 */
	@FieldDefine(title = "审批状态")
	@Column(name = "CHECK_STATUS_")
	@Size(max = 50)
	protected String checkStatus;
	/* 跳转类型 */
	@FieldDefine(title = "跳转类型")
	@Column(name = "JUMP_TYPE_")
	@Size(max = 50)
	protected String jumpType;
	/* 意见备注 */
	@FieldDefine(title = "意见备注")
	@Column(name = "REMARK_")
	protected String remark;
	
	@FieldDefine(title = "允许手机")
	@Column(name = "ENABLE_MOBILE_")
	protected Integer enableMobile=0;
	
	/* 发起部门ID */
	@FieldDefine(title = "处理部门ID")
	@Column(name = "HANDLE_DEP_ID_")
	@Size(max = 64)
	protected String handleDepId;
	
	
	/* 发起部门ID */
	@FieldDefine(title = "处理部门全名")
	@Column(name = "HANDLE_DEP_FULL_")
	@Size(max = 300)
	protected String handleDepFull;
	
	@Transient
	protected String subject="";
	
	@Transient
	protected String status="";
	
	//解决方案名称
	@Transient
	protected String name="";
	
	
	@FieldDefine(title = "意见字段名称")
	@Column(name = "OPINION_NAME_")
	protected String opinionName="";
	
	
	@FieldDefine(title = "处理人")
	@Transient
	protected String handler;
	
	@FieldDefine(title = "手机审批历史部门、照片等信息")
	@Transient
	protected JSONObject handlerInfo;
	
	public String getHandleDepId() {
		return handleDepId;
	}

	public void setHandleDepId(String handleDepId) {
		this.handleDepId = handleDepId;
	}

	public String getHandleDepFull() {
		return handleDepFull;
	}

	public void setHandleDepFull(String handleDepFull) {
		this.handleDepFull = handleDepFull;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * 附件数组。
	 */
	@Transient
	protected JSONArray attachments=new JSONArray();
	
	
	public String getCheckStatusText(){
		if(checkStatus!=null){
			try{
				TaskOptionType t=TaskOptionType.valueOf(checkStatus);
				if(t!=null){
					return t.getText();
				}
			}catch(Exception ex){
				
			}
		}
		
		if("UNHANDLE".equals(this.checkStatus)){
			return "未审批";
		}
		
		return this.checkStatus;
	}

	/**
	 * Default Empty Constructor for class BpmNodeJump
	 */
	public BpmNodeJump() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmNodeJump
	 */
	public BpmNodeJump(String in_jumpId) {
		this.setJumpId(in_jumpId);
	}
	
	public BpmNodeJump(BpmTask bpmTask) {
		
		this.setActDefId(bpmTask.getProcDefId());
		this.setActInstId(bpmTask.getProcInstId());
		this.setTaskId(bpmTask.getId());
		this.setCreateTime(bpmTask.getCreateTime());
		this.setOwnerId(bpmTask.getOwner());
		// 获得任务的创建时间
		this.setNodeName(bpmTask.getName());
		this.setNodeId(bpmTask.getTaskDefKey());
		
		this.setCheckStatus(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		this.setJumpType(BpmNodeJump.JUMP_TYPE_UNHANDLE);
		this.setRemark("无");
		this.setEnableMobile(bpmTask.getEnableMobile());
		
	}

	
	/**
	 * * @return String
	 */
	public String getJumpId() {
		return this.jumpId;
	}

	/**
	 * 设置
	 */
	public void setJumpId(String aValue) {
		this.jumpId = aValue;
	}

	
	/**
	 * ACT流程定义ID * @return String
	 */
	public String getActDefId() {
		return this.actDefId;
	}

	/**
	 * 设置 ACT流程定义ID
	 */
	public void setActDefId(String aValue) {
		this.actDefId = aValue;
	}

	

	/**
	 * ACT流程实例ID * @return String
	 */
	public String getActInstId() {
		return this.actInstId;
	}

	/**
	 * 设置 ACT流程实例ID
	 */
	public void setActInstId(String aValue) {
		this.actInstId = aValue;
	}

	/**
	 * 节点名称 * @return String
	 */
	public String getNodeName() {
		return this.nodeName;
	}

	public String getAgentUserId() {
		return agentUserId;
	}

	public void setAgentUserId(String agentUserId) {
		this.agentUserId = agentUserId;
	}

	/**
	 * 设置 节点名称
	 */
	public void setNodeName(String aValue) {
		this.nodeName = aValue;
	}

	/**
	 * 节点Key * @return String
	 */
	public String getNodeId() {
		return this.nodeId;
	}

	/**
	 * 设置 节点Key
	 */
	public void setNodeId(String aValue) {
		this.nodeId = aValue;
	}

	/**
	 * 任务ID * @return String
	 */
	public String getTaskId() {
		return this.taskId;
	}

	/**
	 * 设置 任务ID
	 */
	public void setTaskId(String aValue) {
		this.taskId = aValue;
	}

	public String getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
	}

	/**
	 * 完成时间 * @return java.util.Date
	 */
	@JsonSerialize(using=JsonDateSerializer.class)
	public java.util.Date getCompleteTime() {
		return this.completeTime;
	}

	/**
	 * 设置 完成时间
	 */
	public void setCompleteTime(java.util.Date aValue) {
		this.completeTime = aValue;
	}

	/**
	 * 持续时长 * @return Integer
	 */
	public Long getDuration() {
		return this.duration;
	}

	/**
	 * 设置 持续时长
	 */
	public void setDuration(Long aValue) {
		this.duration = aValue;
	}

	/**
	 * 有效审批时长 * @return Integer
	 */
	public Integer getDurationVal() {
		return this.durationVal;
	}

	/**
	 * 设置 有效审批时长
	 */
	public void setDurationVal(Integer aValue) {
		this.durationVal = aValue;
	}

	/**
	 * 处理人ID * @return String
	 */
	public String getHandlerId() {
		return this.handlerId;
	}

	/**
	 * 设置 处理人ID
	 */
	public void setHandlerId(String aValue) {
		this.handlerId = aValue;
	}

	/**
	 * 审批状态 * @return String
	 */
	public String getCheckStatus() {
		return this.checkStatus;
	}

	/**
	 * 设置 审批状态
	 */
	public void setCheckStatus(String aValue) {
		this.checkStatus = aValue;
	}

	/**
	 * 跳转类型 * @return String
	 */
	public String getJumpType() {
		return this.jumpType;
	}

	/**
	 * 设置 跳转类型
	 */
	public void setJumpType(String aValue) {
		this.jumpType = aValue;
	}

	/**
	 * 意见备注 * @return String
	 */
	public String getRemark() {
		if(StringUtil.isEmpty(this.remark)){
			return "";
		}
		return this.remark;
	}

	/**
	 * 设置 意见备注
	 */
	public void setRemark(String aValue) {
		this.remark = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.jumpId;
	}

	@Override
	public Serializable getPkId() {
		return this.jumpId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.jumpId = (String) pkId;
	}
	
	public String getDurationFormat(){
		if(duration==null){
			return "";
		}
		DecimalFormat df = new DecimalFormat("0.00");
		//TODO 一天多少小时
		if(duration>24*60*60*1000){
			double m=new Double(duration)/(24*60*60*1000);
			return df.format(m)+"天";
		}else if(duration>60*60*1000){
			double m=new Double(duration)/(60*60*1000);
			return df.format(m)+"小时";
		}else if(duration>60*1000){
			double m=new Double(duration)/(60*1000);
			return df.format(m)+"分";
		}else{
			double m=new Double(duration)/1000;
			return df.format(m)+"秒";
		}
	}

	public Integer getEnableMobile() {
		return enableMobile;
	}

	public void setEnableMobile(Integer enableMobile) {
		this.enableMobile = enableMobile;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getOpinionName() {
		return opinionName;
	}

	public void setOpinionName(String opinionName) {
		this.opinionName = opinionName;
	}

	public String getHandler() {
		return handler;
	}

	public void setHandler(String handler) {
		this.handler = handler;
	}
	
	public JSONObject getHandlerInfo() {
		return handlerInfo;
	}

	public void setHandlerInfo(JSONObject handlerInfo) {
		this.handlerInfo = handlerInfo;
	}

	public JSONArray getAttachments() {
		return attachments;
	}

	public void setAttachments(JSONArray attachments) {
		this.attachments = attachments;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmNodeJump)) {
			return false;
		}
		BpmNodeJump rhs = (BpmNodeJump) object;
		return new EqualsBuilder().append(this.jumpId, rhs.jumpId).append(this.actDefId, rhs.actDefId).append(this.actInstId, rhs.actInstId).append(this.nodeName, rhs.nodeName).append(this.nodeId, rhs.nodeId).append(this.taskId, rhs.taskId).append(this.completeTime, rhs.completeTime).append(this.duration, rhs.duration)
				.append(this.durationVal, rhs.durationVal).append(this.handlerId, rhs.handlerId).append(this.checkStatus, rhs.checkStatus).append(this.jumpType, rhs.jumpType).append(this.remark, rhs.remark).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.jumpId).append(this.actDefId).append(this.actInstId).append(this.nodeName).append(this.nodeId).append(this.taskId).append(this.completeTime).append(this.duration).append(this.durationVal).append(this.handlerId).append(this.checkStatus).append(this.jumpType).append(this.remark)
				.append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("jumpId", this.jumpId).append("actDefId", this.actDefId).append("actInstId", this.actInstId).append("nodeName", this.nodeName).append("nodeId", this.nodeId).append("taskId", this.taskId).append("completeTime", this.completeTime).append("duration", this.duration).append("durationVal", this.durationVal)
				.append("handlerId", this.handlerId).append("checkStatus", this.checkStatus).append("jumpType", this.jumpType).append("remark", this.remark).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
