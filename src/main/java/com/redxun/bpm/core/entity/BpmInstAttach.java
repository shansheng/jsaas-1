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

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 * 描述：BpmInstAttach实体类定义
 * 
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_INST_ATTACH")
@TableDefine(title = "流程附件关联表")
public class BpmInstAttach extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* fileId */
	@FieldDefine(title = "附件Id")
	@Column(name = "FILE_ID_")
	@Size(max = 64)
	@NotEmpty
	protected String fileId;
	@FieldDefine(title = "流程Id")
	@Column(name = "INST_ID_")
	protected String instId;

	/**
	 * Default Empty Constructor for class BpmInstAttach
	 */
	public BpmInstAttach() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmInstAttach
	 */
	public BpmInstAttach(String in_id) {
		this.setId(in_id);
	}

	/**
	 * * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置 id
	 */
	public void setId(String aValue) {
		this.id = aValue;
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
	public void setInstId(String aValue) {
		this.instId = aValue;
	}

	/**
	 * * @return String
	 */
	public String getFileId() {
		return this.fileId;
	}

	/**
	 * 设置 fileId
	 */
	public void setFileId(String aValue) {
		this.fileId = aValue;
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
		if (!(object instanceof BpmInstAttach)) {
			return false;
		}
		BpmInstAttach rhs = (BpmInstAttach) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.fileId, rhs.fileId).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.fileId).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("fileId", this.fileId).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
