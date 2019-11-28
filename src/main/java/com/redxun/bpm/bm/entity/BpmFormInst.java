package com.redxun.bpm.bm.entity;

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
 * 描述：BpmFormInst实体类定义
 * 流程数据模型实例
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_FORM_INST")
@TableDefine(title = "流程数据模型实例")
public class BpmFormInst extends BaseTenantEntity {
	//创建
	public static final String STATUS_CREATED="CREATED";
	//归档
	public static final String STATUS_ARCHIVED="ARCHIVED";
	//草稿
	public static final String STATUS_DRAFTED="DRAFTED";

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "FORM_INST_ID_")
	protected String formInstId;
	/* 实例标题 */
	@FieldDefine(title = "实例标题")
	@Column(name = "SUBJECT_")
	@Size(max = 550)
	protected String subject;
	/* 流程实例ID */
	@FieldDefine(title = "流程实例ID")
	@Column(name = "INST_ID_")
	@Size(max = 64)
	protected String instId;
	/* ACT实例ID */
	@FieldDefine(title = "ACT实例ID")
	@Column(name = "ACT_INST_ID_")
	@Size(max = 64)
	protected String actInstId;
	/* ACT定义ID */
	@FieldDefine(title = "ACT定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	/* 流程定义ID */
	@FieldDefine(title = "流程定义ID")
	@Column(name = "DEF_ID_")
	@Size(max = 64)
	protected String defId;
	/* 解决方案ID */
	@FieldDefine(title = "解决方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 64)
	protected String solId;
	/* 数据模型ID */
	@FieldDefine(title = "数据模型ID")
	@Column(name = "FM_ID_")
	@Size(max = 64)
	protected String fmId;
	/* 表单视图ID */
	@FieldDefine(title = "表单视图ID")
	@Column(name = "FM_VIEW_ID_")
	@Size(max = 64)
	protected String fmViewId;
	/* 状态 */
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	@Size(max = 20)
	protected String status;
	/* 数据JSON */
	@FieldDefine(title = "数据JSON")
	@Column(name = "JSON_DATA_")
	@Size(max = 2147483647)
	protected String jsonData;
	/* 是否持久化 */
	@FieldDefine(title = "是否持久化")
	@Column(name = "IS_PERSIST_")
	@Size(max = 20)
	protected String isPersist;

	/**
	 * Default Empty Constructor for class BpmFormInst
	 */
	public BpmFormInst() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmFormInst
	 */
	public BpmFormInst(String in_formInstId) {
		this.setFormInstId(in_formInstId);
	}

	/**
	 * * @return String
	 */
	public String getFormInstId() {
		return this.formInstId;
	}

	/**
	 * 设置
	 */
	public void setFormInstId(String aValue) {
		this.formInstId = aValue;
	}

	/**
	 * 实例标题 * @return String
	 */
	public String getSubject() {
		return this.subject;
	}

	/**
	 * 设置 实例标题
	 */
	public void setSubject(String aValue) {
		this.subject = aValue;
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
	 * ACT实例ID * @return String
	 */
	public String getActInstId() {
		return this.actInstId;
	}

	/**
	 * 设置 ACT实例ID
	 */
	public void setActInstId(String aValue) {
		this.actInstId = aValue;
	}

	/**
	 * ACT定义ID * @return String
	 */
	public String getActDefId() {
		return this.actDefId;
	}

	/**
	 * 设置 ACT定义ID
	 */
	public void setActDefId(String aValue) {
		this.actDefId = aValue;
	}

	/**
	 * 流程定义ID * @return String
	 */
	public String getDefId() {
		return this.defId;
	}

	/**
	 * 设置 流程定义ID
	 */
	public void setDefId(String aValue) {
		this.defId = aValue;
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
	 * 数据模型ID * @return String
	 */
	public String getFmId() {
		return this.fmId;
	}

	/**
	 * 设置 数据模型ID
	 */
	public void setFmId(String aValue) {
		this.fmId = aValue;
	}

	/**
	 * 表单视图ID * @return String
	 */
	public String getFmViewId() {
		return this.fmViewId;
	}

	/**
	 * 设置 表单视图ID
	 */
	public void setFmViewId(String aValue) {
		this.fmViewId = aValue;
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
	 * 数据JSON * @return String
	 */
	public String getJsonData() {
		return this.jsonData;
	}

	/**
	 * 设置 数据JSON
	 */
	public void setJsonData(String aValue) {
		this.jsonData = aValue;
	}

	/**
	 * 是否持久化 * @return String
	 */
	public String getIsPersist() {
		return this.isPersist;
	}

	/**
	 * 设置 是否持久化
	 */
	public void setIsPersist(String aValue) {
		this.isPersist = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.formInstId;
	}

	@Override
	public Serializable getPkId() {
		return this.formInstId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.formInstId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmFormInst)) {
			return false;
		}
		BpmFormInst rhs = (BpmFormInst) object;
		return new EqualsBuilder().append(this.formInstId, rhs.formInstId)
				.append(this.subject, rhs.subject)
				.append(this.instId, rhs.instId)
				.append(this.actInstId, rhs.actInstId)
				.append(this.actDefId, rhs.actDefId)
				.append(this.defId, rhs.defId).append(this.solId, rhs.solId)
				.append(this.fmId, rhs.fmId)
				.append(this.fmViewId, rhs.fmViewId)
				.append(this.status, rhs.status)
				.append(this.jsonData, rhs.jsonData)
				.append(this.isPersist, rhs.isPersist)
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
		return new HashCodeBuilder(-82280557, -700257973)
				.append(this.formInstId).append(this.subject)
				.append(this.instId).append(this.actInstId)
				.append(this.actDefId).append(this.defId).append(this.solId)
				.append(this.fmId).append(this.fmViewId).append(this.status)
				.append(this.jsonData).append(this.isPersist)
				.append(this.tenantId).append(this.createBy)
				.append(this.createTime).append(this.updateBy)
				.append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("formInstId", this.formInstId)
				.append("subject", this.subject).append("instId", this.instId)
				.append("actInstId", this.actInstId)
				.append("actDefId", this.actDefId).append("defId", this.defId)
				.append("solId", this.solId).append("fmId", this.fmId)
				.append("fmViewId", this.fmViewId)
				.append("status", this.status)
				.append("jsonData", this.jsonData)
				.append("isPersist", this.isPersist)
				.append("tenantId", this.tenantId)
				.append("createBy", this.createBy)
				.append("createTime", this.createTime)
				.append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
