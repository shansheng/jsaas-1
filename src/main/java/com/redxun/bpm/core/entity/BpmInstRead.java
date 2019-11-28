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
 * 描述：BpmInstRead实体类定义
 * 
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_INST_READ")
@TableDefine(title = "流程阅读记录")
public class BpmInstRead extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "READ_ID_")
	protected String readId;
	/* userId */
	@FieldDefine(title = "用户Id")
	@Column(name = "USER_ID_")
	@Size(max = 64)
	protected String userId;
	/* state */
	@FieldDefine(title = "流程状态")
	@Column(name = "STATE_")
	@Size(max = 50)
	protected String state;
	/* depId */
	@FieldDefine(title = "部门Id")
	@Column(name = "DEP_ID_")
	@Size(max = 64)
	protected String depId;
	@FieldDefine(title = "")
	//@ManyToOne
	@JoinColumn(name = "INST_ID_")
	protected String instId;

	/**
	 * Default Empty Constructor for class BpmInstRead
	 */
	public BpmInstRead() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmInstRead
	 */
	public BpmInstRead(String in_readId) {
		this.setReadId(in_readId);
	}

	/**
	 * * @return String
	 */
	public String getReadId() {
		return this.readId;
	}

	/**
	 * 设置 readId
	 */
	public void setReadId(String aValue) {
		this.readId = aValue;
	}

	/**
	 * * @return String
	 */
	public String getInstId() {
		return this.instId;
	}

	/**
	 * 设置 instId
	 */
	public void setInstId(String instId) {
		this.readId = instId;
	}

	/**
	 * * @return String
	 */
	public String getUserId() {
		return this.userId;
	}

	/**
	 * 设置 userId
	 */
	public void setUserId(String aValue) {
		this.userId = aValue;
	}

	/**
	 * * @return String
	 */
	public String getState() {
		return this.state;
	}

	/**
	 * 设置 state
	 */
	public void setState(String aValue) {
		this.state = aValue;
	}

	/**
	 * * @return String
	 */
	public String getDepId() {
		return this.depId;
	}

	/**
	 * 设置 depId
	 */
	public void setDepId(String aValue) {
		this.depId = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.readId;
	}

	@Override
	public Serializable getPkId() {
		return this.readId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.readId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstRead)) {
			return false;
		}
		BpmInstRead rhs = (BpmInstRead) object;
		return new EqualsBuilder().append(this.readId, rhs.readId).append(this.userId, rhs.userId).append(this.state, rhs.state).append(this.depId, rhs.depId).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.readId).append(this.userId).append(this.state).append(this.depId).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("readId", this.readId).append("userId", this.userId).append("state", this.state).append("depId", this.depId).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
