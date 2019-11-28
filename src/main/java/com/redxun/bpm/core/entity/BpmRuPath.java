package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmRuPath实体类定义
 * 流程实例运行路线
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_RU_PATH")
@TableDefine(title = "流程实例运行路线")
public class BpmRuPath extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "PATH_ID_")
	protected String pathId;
	/* 流程实例ID */
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String instId;
	/* Act定义ID */
	@FieldDefine(title = "Act定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String actDefId;
	/* Act实例ID */
	@FieldDefine(title = "Act实例ID")
	@Column(name = "ACT_INST_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String actInstId;
	/* 解决方案ID */
	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String solId;
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 255)
	@NotEmpty
	protected String nodeId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	@Size(max = 255)
	protected String nodeName;
	/* 节点类型 */
	@FieldDefine(title = "节点类型")
	@Column(name = "NODE_TYPE_")
	@Size(max = 50)
	protected String nodeType;
	/* 开始时间 */
	@FieldDefine(title = "开始时间")
	@Column(name = "START_TIME_")
	protected java.util.Date startTime;
	/* 结束时间 */
	@FieldDefine(title = "结束时间")
	@Column(name = "END_TIME_")
	protected java.util.Date endTime;
	/* 持续时长 */
	@FieldDefine(title = "持续时长")
	@Column(name = "DURATION_")
	protected Long duration;
	/* 有效审批时长 */
	@FieldDefine(title = "有效审批时长")
	@Column(name = "DURATION_VAL_")
	protected Long durationVal;
	/* 处理人ID */
	@FieldDefine(title = "处理人ID")
	@Column(name = "ASSIGNEE_")
	@Size(max = 64)
	protected String assignee;
	/* 代理人ID */
	@FieldDefine(title = "代理人ID")
	@Column(name = "TO_USER_ID_")
	@Size(max = 64)
	protected String toUserId;
	/* 是否为多实例 */
	@FieldDefine(title = "是否为多实例")
	@Column(name = "IS_MULTIPLE_")
	@Size(max = 20)
	protected String isMultiple;
	/* 活动执行ID */
	@FieldDefine(title = "活动执行ID")
	@Column(name = "EXECUTION_ID_")
	@Size(max = 64)
	protected String executionId;
	/* 原执行人IDS */
	@FieldDefine(title = "原执行人IDS")
	@Column(name = "USER_IDS_")
	protected String userIds;
	/* 父ID */
	@FieldDefine(title = "父ID")
	@Column(name = "PARENT_ID_")
	@Size(max = 64)
	protected String parentId;
	/* 层次 */
	@FieldDefine(title = "层次")
	@Column(name = "LEVEL_")
	protected Integer level;
	/* 跳出路线ID */
	@FieldDefine(title = "跳出路线ID")
	@Column(name = "OUT_TRAN_ID_")
	@Size(max = 255)
	protected String outTranId;
	/* 路线令牌 */
	@FieldDefine(title = "路线令牌")
	@Column(name = "TOKEN_")
	@Size(max = 255)
	protected String token;
	/* 跳到该节点的方式 */
	@FieldDefine(title = "跳到该节点的方式")
	@Column(name = "JUMP_TYPE_")
	@Size(max = 50)
	protected String jumpType;
	/* 下一步跳转方式 */
	@FieldDefine(title = "下一步跳转方式")
	@Column(name = "NEXT_JUMP_TYPE_")
	@Size(max = 50)
	protected String nextJumpType;
	/* 审批意见 */
	@FieldDefine(title = "审批意见")
	@Column(name = "OPINION_")
	protected String opinion;
	/* 引用路径ID */
	@FieldDefine(title = "引用路径ID")
	@Column(name = "REF_PATH_ID_")
	@Size(max = 64)
	protected String refPathId;
	
	/* 超时状态 0 正常 1 提前 2 超时 */
	@FieldDefine(title = "超时状态")
	@Column(name = "TIMEOUT_STATUS_")
	@Size(max = 20)
	protected String timeoutStatus;

	/**
	 * Default Empty Constructor for class BpmRuPath
	 */
	public BpmRuPath() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmRuPath
	 */
	public BpmRuPath(String in_pathId) {
		this.setPathId(in_pathId);
	}

	/**
	 * * @return String
	 */
	public String getPathId() {
		return this.pathId;
	}

	/**
	 * 设置
	 */
	public void setPathId(String aValue) {
		this.pathId = aValue;
	}

	/**
	 * 流程实例ID * @return String
	 */
	public String getInstId() {
		return this.instId;
	}

	/**
	 * 设置 流程实例ID
	 */
	public void setInstId(String aValue) {
		this.instId = aValue;
	}

	/**
	 * Act定义ID * @return String
	 */
	public String getActDefId() {
		return this.actDefId;
	}

	/**
	 * 设置 Act定义ID
	 */
	public void setActDefId(String aValue) {
		this.actDefId = aValue;
	}

	/**
	 * Act实例ID * @return String
	 */
	public String getActInstId() {
		return this.actInstId;
	}

	/**
	 * 设置 Act实例ID
	 */
	public void setActInstId(String aValue) {
		this.actInstId = aValue;
	}

	/**
	 * 解决方案ID * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置 解决方案ID
	 */
	public void setSolId(String aValue) {
		this.solId = aValue;
	}

	/**
	 * 节点ID * @return String
	 */
	public String getNodeId() {
		return this.nodeId;
	}

	/**
	 * 设置 节点ID
	 */
	public void setNodeId(String aValue) {
		this.nodeId = aValue;
	}

	/**
	 * 节点名称 * @return String
	 */
	public String getNodeName() {
		return this.nodeName;
	}

	/**
	 * 设置 节点名称
	 */
	public void setNodeName(String aValue) {
		this.nodeName = aValue;
	}

	/**
	 * 节点类型 * @return String
	 */
	public String getNodeType() {
		return this.nodeType;
	}

	/**
	 * 设置 节点类型
	 */
	public void setNodeType(String aValue) {
		this.nodeType = aValue;
	}

	/**
	 * 开始时间 * @return java.util.Date
	 */
	public java.util.Date getStartTime() {
		return this.startTime;
	}

	/**
	 * 设置 开始时间
	 */
	public void setStartTime(java.util.Date aValue) {
		this.startTime = aValue;
	}

	/**
	 * 结束时间 * @return java.util.Date
	 */
	public java.util.Date getEndTime() {
		return this.endTime;
	}

	/**
	 * 设置 结束时间
	 */
	public void setEndTime(java.util.Date aValue) {
		this.endTime = aValue;
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
	public Long getDurationVal() {
		return this.durationVal;
	}

	/**
	 * 设置 有效审批时长
	 */
	public void setDurationVal(Long aValue) {
		this.durationVal = aValue;
	}

	/**
	 * 处理人ID * @return String
	 */
	public String getAssignee() {
		return this.assignee;
	}

	/**
	 * 设置 处理人ID
	 */
	public void setAssignee(String aValue) {
		this.assignee = aValue;
	}

	/**
	 * 代理人ID * @return String
	 */
	public String getToUserId() {
		return this.toUserId;
	}

	/**
	 * 设置 代理人ID
	 */
	public void setToUserId(String aValue) {
		this.toUserId = aValue;
	}

	/**
	 * 是否为多实例 * @return String
	 */
	public String getIsMultiple() {
		return this.isMultiple;
	}

	/**
	 * 设置 是否为多实例
	 */
	public void setIsMultiple(String aValue) {
		this.isMultiple = aValue;
	}

	/**
	 * 活动执行ID * @return String
	 */
	public String getExecutionId() {
		return this.executionId;
	}

	/**
	 * 设置 活动执行ID
	 */
	public void setExecutionId(String aValue) {
		this.executionId = aValue;
	}

	/**
	 * 原执行人IDS * @return String
	 */
	public String getUserIds() {
		return this.userIds;
	}

	/**
	 * 设置 原执行人IDS
	 */
	public void setUserIds(String aValue) {
		this.userIds = aValue;
	}

	/**
	 * 父ID * @return String
	 */
	public String getParentId() {
		return this.parentId;
	}

	/**
	 * 设置 父ID
	 */
	public void setParentId(String aValue) {
		this.parentId = aValue;
	}

	/**
	 * 层次 * @return Integer
	 */
	public Integer getLevel() {
		return this.level;
	}

	/**
	 * 设置 层次
	 */
	public void setLevel(Integer aValue) {
		this.level = aValue;
	}

	/**
	 * 跳出路线ID * @return String
	 */
	public String getOutTranId() {
		return this.outTranId;
	}

	/**
	 * 设置 跳出路线ID
	 */
	public void setOutTranId(String aValue) {
		this.outTranId = aValue;
	}

	/**
	 * 路线令牌 * @return String
	 */
	public String getToken() {
		return this.token;
	}

	/**
	 * 设置 路线令牌
	 */
	public void setToken(String aValue) {
		this.token = aValue;
	}

	/**
	 * 跳到该节点的方式 * @return String
	 */
	public String getJumpType() {
		return this.jumpType;
	}

	/**
	 * 设置 跳到该节点的方式
	 */
	public void setJumpType(String aValue) {
		this.jumpType = aValue;
	}

	/**
	 * 下一步跳转方式 * @return String
	 */
	public String getNextJumpType() {
		return this.nextJumpType;
	}

	/**
	 * 设置 下一步跳转方式
	 */
	public void setNextJumpType(String aValue) {
		this.nextJumpType = aValue;
	}

	/**
	 * 审批意见 * @return String
	 */
	public String getOpinion() {
		return this.opinion;
	}

	/**
	 * 设置 审批意见
	 */
	public void setOpinion(String aValue) {
		this.opinion = aValue;
	}

	/**
	 * 引用路径ID * @return String
	 */
	public String getRefPathId() {
		return this.refPathId;
	}

	/**
	 * 设置 引用路径ID
	 */
	public void setRefPathId(String aValue) {
		this.refPathId = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.pathId;
	}

	@Override
	public Serializable getPkId() {
		return this.pathId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.pathId = (String) pkId;
	}

	public String getTimeoutStatus() {
		return timeoutStatus;
	}

	public void setTimeoutStatus(String timeoutStatus) {
		this.timeoutStatus = timeoutStatus;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmRuPath)) {
			return false;
		}
		BpmRuPath rhs = (BpmRuPath) object;
		return new EqualsBuilder().append(this.pathId, rhs.pathId).append(this.instId, rhs.instId).append(this.actDefId, rhs.actDefId).append(this.actInstId, rhs.actInstId)
				.append(this.solId, rhs.solId).append(this.nodeId, rhs.nodeId).append(this.nodeName, rhs.nodeName).append(this.nodeType, rhs.nodeType)
				.append(this.token, rhs.token).append(this.jumpType, rhs.jumpType).append(this.nextJumpType, rhs.nextJumpType).append(this.opinion, rhs.opinion)
				.append(this.refPathId, rhs.refPathId).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.pathId).append(this.instId).append(this.refPathId).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("pathId", this.pathId).append("instId", this.instId).append("actDefId", this.actDefId).append("actInstId", this.actInstId)
				.append("solId", this.solId).append("nodeId", this.nodeId).append("nodeName", this.nodeName).append("nodeType", this.nodeType).append("startTime", this.startTime)
				.append("endTime", this.endTime).append("duration", this.duration).append("durationVal", this.durationVal).append("assignee", this.assignee)
				.append("toUserId", this.toUserId).append("isMultiple", this.isMultiple).append("executionId", this.executionId).append("userIds", this.userIds)
				.append("parentId", this.parentId).append("level", this.level).append("outTranId", this.outTranId).append("token", this.token).append("jumpType", this.jumpType)
				.append("nextJumpType", this.nextJumpType).append("opinion", this.opinion).append("refPathId", this.refPathId).toString();
	}

}
