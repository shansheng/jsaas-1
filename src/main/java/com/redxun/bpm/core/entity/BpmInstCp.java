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

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmInstCp实体类定义
 * 流程抄送人员
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_INST_CP")
@TableDefine(title = "流程抄送人员")
public class BpmInstCp extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 用户ID */
	@FieldDefine(title = "用户ID")
	@Column(name = "USER_ID_")
	@Size(max = 64)
	protected String userId;
	/* 用户组Id */
	@FieldDefine(title = "用户组Id")
	@Column(name = "GROUP_ID_")
	@Size(max = 64)
	protected String groupId;
	/* 是否已读 */
	@FieldDefine(title = "已读与否")
	@Column(name = "IS_READ_")
	@Size(max = 64)
	protected String isRead;
	// com.redxun.bpm.core.entity.BpmInstCc
	@FieldDefine(title = "流程抄送")
	@JoinColumn(name = "CC_ID_")
	protected String ccId;

	/**
	 * Default Empty Constructor for class BpmInstCp
	 */
	public BpmInstCp() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmInstCp
	 */
	public BpmInstCp(String in_id) {
		this.setId(in_id);
	}

	public String getIsRead() {
		return isRead;
	}
	/**
	 * 设置是否已读
	 * @param isRead
	 */
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}

	/**
	 * * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置
	 */
	public void setId(String aValue) {
		this.id = aValue;
	}

	/**
	 * 用户ID * @return String
	 */
	public String getUserId() {
		return this.userId;
	}

	/**
	 * 设置 用户ID
	 */
	public void setUserId(String aValue) {
		this.userId = aValue;
	}

	/**
	 * 用户组Id * @return String
	 */
	public String getGroupId() {
		return this.groupId;
	}

	/**
	 * 设置 用户组Id
	 */
	public void setGroupId(String aValue) {
		this.groupId = aValue;
	}

	/**
	 * 抄送ID * @return String
	 */
	public String getCcId() {
		return this.ccId;
	}

	/**
	 * 设置 抄送ID
	 */
	public void setCcId(String aValue) {
		this.ccId = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.id;
	}

	@Override
	public Serializable getPkId() {
		return this.id;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.id = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstCp)) {
			return false;
		}
		BpmInstCp rhs = (BpmInstCp) object;
		return new EqualsBuilder().append(this.id, rhs.id)
				.append(this.userId, rhs.userId)
				.append(this.groupId, rhs.groupId)
				.append(this.tenantId, rhs.tenantId)
				.append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id)
				.append(this.userId).append(this.groupId).append(this.tenantId)
				.append(this.createBy).append(this.createTime)
				.append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id)
				.append("userId", this.userId).append("groupId", this.groupId)
				.append("tenantId", this.tenantId)
				.append("createBy", this.createBy)
				.append("createTime", this.createTime)
				.append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
