package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmAgentSol实体类定义
 * 部分代理的流程方案
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_AGENT_SOL")
@TableDefine(title = "部分代理的流程方案")
@JsonIgnoreProperties(value={"bpmSolution","bpmAgent"})
public class BpmAgentSol extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "AS_ID_")
	protected String asId;
	/* 解决方案名称 */
	@FieldDefine(title = "解决方案名称")
	@Column(name = "SOL_NAME_")
	@Size(max = 100)
	@NotEmpty
	protected String solName;
	/* 代理类型 */
	@FieldDefine(title = "代理类型")
	@Column(name = "AGENT_TYPE_")
	@Size(max = 20)
	protected String agentType;
	/* 代理条件 */
	@FieldDefine(title = "代理条件")
	@Column(name = "CONDITION_")
	@Size(max = 65535)
	protected String condition;
	@FieldDefine(title = "流程方案代理")
	@Column(name = "AGENT_ID_")
	protected String agentId;
	@FieldDefine(title = "业务流程方案定义")
	@Column(name = "SOL_ID_")
	protected String solId;

	/**
	 * Default Empty Constructor for class BpmAgentSol
	 */
	public BpmAgentSol() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmAgentSol
	 */
	public BpmAgentSol(String in_asId) {
		this.setAsId(in_asId);
	}

	

	/**
	 * 代理方案ID * @return String
	 */
	public String getAsId() {
		return this.asId;
	}

	/**
	 * 设置 代理方案ID
	 */
	public void setAsId(String aValue) {
		this.asId = aValue;
	}

	
	
	
	public String getAgentId() {
		return agentId;
	}

	public void setAgentId(String agentId) {
		this.agentId = agentId;
	}

	public String getSolId() {
		return solId;
	}

	public void setSolId(String solId) {
		this.solId = solId;
	}

	/**
	 * 解决方案名称 * @return String
	 */
	public String getSolName() {
		return this.solName;
	}

	/**
	 * 设置 解决方案名称
	 */
	public void setSolName(String aValue) {
		this.solName = aValue;
	}

	/**
	 * 代理类型 * @return String
	 */
	public String getAgentType() {
		return this.agentType;
	}

	/**
	 * 设置 代理类型
	 */
	public void setAgentType(String aValue) {
		this.agentType = aValue;
	}

	/**
	 * 代理条件 * @return String
	 */
	public String getCondition() {
		return this.condition;
	}

	/**
	 * 设置 代理条件
	 */
	public void setCondition(String aValue) {
		this.condition = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.asId;
	}

	@Override
	public Serializable getPkId() {
		return this.asId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.asId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmAgentSol)) {
			return false;
		}
		BpmAgentSol rhs = (BpmAgentSol) object;
		return new EqualsBuilder().append(this.asId, rhs.asId).append(this.solName, rhs.solName).append(this.agentType, rhs.agentType).append(this.condition, rhs.condition)
				.append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.asId).append(this.solName).append(this.agentType).append(this.condition).append(this.tenantId)
				.append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("asId", this.asId).append("solName", this.solName).append("agentType", this.agentType).append("condition", this.condition)
				.append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
