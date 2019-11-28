package com.redxun.bpm.core.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.json.JsonDateSerializer;

/**
 * <pre>
 * 描述：BpmAgent实体类定义
 * 流程方案代理
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */

@Table(name = "BPM_AGENT")
@TableDefine(title = "流程方案代理")
@JsonIgnoreProperties(value={"bpmAgentSols"})
public class BpmAgent extends BaseTenantEntity {
	//全部代理
	public static final String TYPE_ALL="ALL";
	//部分代理
	public static final String TYPE_PART="PART";
	
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "AGENT_ID_")
	protected String agentId;
	/* 代理简述 */
	@FieldDefine(title = "代理简述")
	@Column(name = "SUBJECT_")
	@Size(max = 100)
	@NotEmpty
	protected String subject;
	/* 代理人ID */
	@FieldDefine(title = "代理人ID")
	@Column(name = "TO_USER_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String toUserId;
	/* 被代理人ID */
	@FieldDefine(title = "被代理人ID")
	@Column(name = "AGENT_USER_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String agentUserId;
	/* 开始时间 */
	@FieldDefine(title = "开始时间")
	@Column(name = "START_TIME_")
	protected java.util.Date startTime;
	/* 结束时间 */
	@FieldDefine(title = "结束时间")
	@Column(name = "END_TIME_")
	protected java.util.Date endTime;
	/* 代理类型 */
	@FieldDefine(title = "代理类型")
	@Column(name = "TYPE_")
	@Size(max = 20)
	@NotEmpty
	protected String type;
	/* 状态 */
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	@Size(max = 20)
	@NotEmpty
	protected String status;
	/* 描述 */
	@FieldDefine(title = "描述")
	@Column(name = "DESCP_")
	@Size(max = 300)
	protected String descp;
	
	protected Collection<BpmAgentSol> bpmAgentSols=new ArrayList<>();
//
//	@FieldDefine(title = "部分代理的流程方案")
//	@OneToMany(cascade = CascadeType.ALL, mappedBy = "bpmAgent", fetch = FetchType.LAZY)
//	protected java.util.Set<BpmAgentSol> bpmAgentSols = new java.util.HashSet<BpmAgentSol>();

	/**
	 * Default Empty Constructor for class BpmAgent
	 */
	public BpmAgent() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmAgent
	 */
	public BpmAgent(String in_agentId) {
		this.setAgentId(in_agentId);
	}

//	public java.util.Set<BpmAgentSol> getBpmAgentSols() {
//		return bpmAgentSols;
//	}
//
//	public void setBpmAgentSols(java.util.Set<BpmAgentSol> in_bpmAgentSols) {
//		this.bpmAgentSols = in_bpmAgentSols;
//	}

	/**
	 * 代理ID * @return String
	 */
	public String getAgentId() {
		return this.agentId;
	}

	/**
	 * 设置 代理ID
	 */
	public void setAgentId(String aValue) {
		this.agentId = aValue;
	}

	/**
	 * 代理简述 * @return String
	 */
	public String getSubject() {
		return this.subject;
	}

	/**
	 * 设置 代理简述
	 */
	public void setSubject(String aValue) {
		this.subject = aValue;
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
	 * 被代理人ID * @return String
	 */
	public String getAgentUserId() {
		return this.agentUserId;
	}

	/**
	 * 设置 被代理人ID
	 */
	public void setAgentUserId(String aValue) {
		this.agentUserId = aValue;
	}

	/**
	 * 开始时间 * @return java.util.Date
	 */
	@JsonSerialize(using=JsonDateSerializer.class)
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
	@JsonSerialize(using=JsonDateSerializer.class)
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
	 * 代理类型 * @return String
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * 设置 代理类型
	 */
	public void setType(String aValue) {
		this.type = aValue;
	}

	/**
	 * 状态 * @return String
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * 设置 状态
	 */
	public void setStatus(String aValue) {
		this.status = aValue;
	}

	/**
	 * 描述 * @return String
	 */
	public String getDescp() {
		return this.descp;
	}

	/**
	 * 设置 描述
	 */
	public void setDescp(String aValue) {
		this.descp = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.subject;
	}

	@Override
	public Serializable getPkId() {
		return this.agentId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.agentId = (String) pkId;
	}
	
	

	public Collection<BpmAgentSol> getBpmAgentSols() {
		return bpmAgentSols;
	}

	public void setBpmAgentSols(Collection<BpmAgentSol> bpmAgentSols) {
		this.bpmAgentSols = bpmAgentSols;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmAgent)) {
			return false;
		}
		BpmAgent rhs = (BpmAgent) object;
		return new EqualsBuilder().append(this.agentId, rhs.agentId).append(this.subject, rhs.subject).append(this.toUserId, rhs.toUserId)
				.append(this.agentUserId, rhs.agentUserId).append(this.startTime, rhs.startTime).append(this.endTime, rhs.endTime).append(this.type, rhs.type)
				.append(this.status, rhs.status).append(this.descp, rhs.descp).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.agentId).append(this.subject).append(this.toUserId).append(this.agentUserId).append(this.startTime)
				.append(this.endTime).append(this.type).append(this.status).append(this.descp).append(this.tenantId).append(this.createBy).append(this.createTime)
				.append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("agentId", this.agentId).append("subject", this.subject).append("toUserId", this.toUserId).append("agentUserId", this.agentUserId)
				.append("startTime", this.startTime).append("endTime", this.endTime).append("type", this.type).append("status", this.status).append("descp", this.descp)
				.append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
