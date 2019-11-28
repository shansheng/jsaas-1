package com.redxun.bpm.activiti.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
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
 * 描述：ActReModel实体类定义
 * BPMN流程定义设计模型
 * 构建组：miweb
 * 作者：keitch
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Entity
@Table(name = "ACT_RE_MODEL")
@TableDefine(title = "BPMN流程定义设计模型")
public class ActReModel extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 修正版本 */
	@FieldDefine(title = "修正版本")
	@Column(name = "REV_")
	protected Integer rev;
	/* 名称 */
	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	@Size(max = 255)
	protected String name;
	/* 标识键 */
	@FieldDefine(title = "标识键")
	@Column(name = "KEY_")
	@Size(max = 255)
	protected String key;
	/* 分类 */
	@FieldDefine(title = "分类")
	@Column(name = "CATEGORY_")
	@Size(max = 255)
	protected String category;
	/* 版本 */
	@FieldDefine(title = "版本")
	@Column(name = "VERSION_")
	protected Integer version;
	/*
	@FieldDefine(title = "创建时间")
	@Column(name = "CREATE_TIME_")
	protected Timestamp createTime;
	*/
	@FieldDefine(title = "最后更新时间")
	@Column(name = "LAST_UPDATE_TIME_")
	protected Timestamp lastUpdateTime;
	
	/* 元数据 */
	@FieldDefine(title = "元数据")
	@Column(name = "META_INFO_")
	@Size(max = 4000)
	protected String metaInfo;
	/* 编辑器源资源ID */
	@FieldDefine(title = "编辑器源资源ID")
	@Column(name = "EDITOR_SOURCE_VALUE_ID_")
	@Size(max = 64)
	protected String editorSourceValueId;

	@FieldDefine(title = "发布ID")
	@Column(name = "DEPLOYMENT_ID_")
	@Size(max = 64)
	protected String deploymentId;

	@FieldDefine(title = "编辑器附加资源ID")
	@Column(name = "EDITOR_SOURCE_EXTRA_VALUE_ID_")
	@Size(max = 64)
	protected String editorSourceExtraValueId;

	/**
	 * Default Empty Constructor for class ActReModel
	 */
	public ActReModel() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class ActReModel
	 */
	public ActReModel(String in_id) {
		this.setId(in_id);
	}

	/**
	 * ID * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置 ID
	 */
	public void setId(String aValue) {
		this.id = aValue;
	}

	/**
	 * 修正版本 * @return Integer
	 */
	public Integer getRev() {
		return this.rev;
	}

	/**
	 * 设置 修正版本
	 */
	public void setRev(Integer aValue) {
		this.rev = aValue;
	}

	/**
	 * 名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 标识键 * @return String
	 */
	public String getKey() {
		return this.key;
	}

	/**
	 * 设置 标识键
	 */
	public void setKey(String aValue) {
		this.key = aValue;
	}

	/**
	 * 分类 * @return String
	 */
	public String getCategory() {
		return this.category;
	}

	/**
	 * 设置 分类
	 */
	public void setCategory(String aValue) {
		this.category = aValue;
	}

	/**
	 * 版本 * @return Integer
	 */
	public Integer getVersion() {
		return this.version;
	}

	/**
	 * 设置 版本
	 */
	public void setVersion(Integer aValue) {
		this.version = aValue;
	}

	/**
	 * 元数据 * @return String
	 */
	public String getMetaInfo() {
		return this.metaInfo;
	}

	/**
	 * 设置 元数据
	 */
	public void setMetaInfo(String aValue) {
		this.metaInfo = aValue;
	}

	/**
	 * 编辑器源资源ID * @return String
	 */
	public String getEditorSourceValueId() {
		return this.editorSourceValueId;
	}

	/**
	 * 设置 编辑器源资源ID
	 */
	public void setEditorSourceValueId(String aValue) {
		this.editorSourceValueId = aValue;
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

	public Timestamp getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(Timestamp lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public String getDeploymentId() {
		return deploymentId;
	}

	public void setDeploymentId(String deploymentId) {
		this.deploymentId = deploymentId;
	}

	public String getEditorSourceExtraValueId() {
		return editorSourceExtraValueId;
	}

	public void setEditorSourceExtraValueId(String editorSourceExtraValueId) {
		this.editorSourceExtraValueId = editorSourceExtraValueId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof ActReModel)) {
			return false;
		}
		ActReModel rhs = (ActReModel) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.rev, rhs.rev).append(this.name, rhs.name).append(this.key, rhs.key).append(this.category, rhs.category).append(this.createTime, rhs.createTime).append(this.version, rhs.version).append(this.metaInfo, rhs.metaInfo).append(this.editorSourceValueId, rhs.editorSourceValueId).append(this.tenantId, rhs.tenantId)
				.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.rev).append(this.name).append(this.key).append(this.category).append(this.createTime).append(this.version).append(this.metaInfo).append(this.editorSourceValueId).append(this.tenantId).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("rev", this.rev).append("name", this.name).append("key", this.key).append("category", this.category).append("createTime", this.createTime).append("version", this.version).append("metaInfo", this.metaInfo).append("editorSourceValueId", this.editorSourceValueId).append("tenantId", this.tenantId).toString();
	}

}
