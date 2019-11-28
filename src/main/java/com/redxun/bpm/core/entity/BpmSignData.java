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
 * 描述：BpmSignData实体类定义
 * 任务会签数据
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_SIGN_DATA")
@TableDefine(title = "任务会签数据")
public class BpmSignData extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "DATA_ID_")
	protected String dataId;
	/* 流程定义ID */
	@FieldDefine(title = "流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String actDefId;
	/* 流程实例ID */
	@FieldDefine(title = "流程实例ID")
	@Column(name = "ACT_INST_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String actInstId;
	/* 流程节点Id */
	@FieldDefine(title = "流程节点Id")
	@Column(name = "NODE_ID_")
	@Size(max = 255)
	@NotEmpty
	protected String nodeId;
	/* 投票人ID */
	@FieldDefine(title = "投票人ID")
	@Column(name = "USER_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String userId;
	/* 投票状态 */
	@FieldDefine(title = "投票状态")
	@Column(name = "VOTE_STATUS_")
	@Size(max = 50)
	//@NotEmpty
	protected String voteStatus;

	/**
	 * Default Empty Constructor for class BpmSignData
	 */
	public BpmSignData() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmSignData
	 */
	public BpmSignData(String in_dataId) {
		this.setDataId(in_dataId);
	}

	/**
	 * 主键 * @return String
	 */
	public String getDataId() {
		return this.dataId;
	}

	/**
	 * 设置 主键
	 */
	public void setDataId(String aValue) {
		this.dataId = aValue;
	}

	/**
	 * 流程定义ID * @return String
	 */
	public String getActDefId() {
		return this.actDefId;
	}

	/**
	 * 设置 流程定义ID
	 */
	public void setActDefId(String aValue) {
		this.actDefId = aValue;
	}

	/**
	 * 流程实例ID * @return String
	 */
	public String getActInstId() {
		return this.actInstId;
	}

	/**
	 * 设置 流程实例ID
	 */
	public void setActInstId(String aValue) {
		this.actInstId = aValue;
	}

	/**
	 * 流程节点Id * @return String
	 */
	public String getNodeId() {
		return this.nodeId;
	}

	/**
	 * 设置 流程节点Id
	 */
	public void setNodeId(String aValue) {
		this.nodeId = aValue;
	}

	/**
	 * 投票人ID * @return String
	 */
	public String getUserId() {
		return this.userId;
	}

	/**
	 * 设置 投票人ID
	 */
	public void setUserId(String aValue) {
		this.userId = aValue;
	}

	/**
	 * 投票状态 * @return String
	 */
	public String getVoteStatus() {
		return this.voteStatus;
	}

	/**
	 * 设置 投票状态
	 */
	public void setVoteStatus(String aValue) {
		this.voteStatus = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.dataId;
	}

	@Override
	public Serializable getPkId() {
		return this.dataId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.dataId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSignData)) {
			return false;
		}
		BpmSignData rhs = (BpmSignData) object;
		return new EqualsBuilder().append(this.dataId, rhs.dataId).append(this.actDefId, rhs.actDefId).append(this.actInstId, rhs.actInstId).append(this.nodeId, rhs.nodeId)
				.append(this.userId, rhs.userId).append(this.voteStatus, rhs.voteStatus).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.dataId).append(this.actDefId).append(this.actInstId).append(this.nodeId).append(this.userId)
				.append(this.voteStatus).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("dataId", this.dataId).append("actDefId", this.actDefId).append("actInstId", this.actInstId).append("nodeId", this.nodeId)
				.append("userId", this.userId).append("voteStatus", this.voteStatus).append("tenantId", this.tenantId).append("createBy", this.createBy)
				.append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
