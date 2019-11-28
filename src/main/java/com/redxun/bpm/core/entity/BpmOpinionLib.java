package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
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
 * 描述：BpmOpinionLib实体类定义
 * 
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_OPINION_LIB")
@TableDefine(title = "用户审批意见表")
public class BpmOpinionLib extends BaseTenantEntity {

	public static final String PUBLIC_OPINION ="0";
	
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "OP_ID_")
	protected String opId;
	/* userId */
	@FieldDefine(title = "用户Id")
	@Column(name = "USER_ID_")
	@Size(max = 64)
	protected String userId;
	/* opText */
	@FieldDefine(title = "审批意见正文")
	@Column(name = "OP_TEXT_")
	@Size(max = 512)
	protected String opText;

	/**
	 * Default Empty Constructor for class BpmOpinionLib
	 */
	public BpmOpinionLib() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmOpinionLib
	 */
	public BpmOpinionLib(String in_opId) {
		this.setOpId(in_opId);
	}

	/**
	 * * @return String
	 */
	public String getOpId() {
		return this.opId;
	}

	/**
	 * 设置 opId
	 */
	public void setOpId(String aValue) {
		this.opId = aValue;
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
	public String getOpText() {
		return this.opText;
	}

	/**
	 * 设置 opText
	 */
	public void setOpText(String aValue) {
		this.opText = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.opId;
	}

	@Override
	public Serializable getPkId() {
		return this.opId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.opId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmOpinionLib)) {
			return false;
		}
		BpmOpinionLib rhs = (BpmOpinionLib) object;
		return new EqualsBuilder().append(this.opId, rhs.opId).append(this.userId, rhs.userId).append(this.opText, rhs.opText).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.opId).append(this.userId).append(this.opText).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("opId", this.opId).append("userId", this.userId).append("opText", this.opText).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
