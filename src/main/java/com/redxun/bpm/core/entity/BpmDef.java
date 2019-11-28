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
import com.redxun.sys.core.entity.SysTree;
import com.thoughtworks.xstream.annotations.XStreamOmitField;

/**
 * <pre>
 * 描述：BpmDef实体类定义
 * 流程定义
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_DEF")
@TableDefine(title = "流程定义")
public class BpmDef extends BaseTenantEntity {
	/**
	 * 初始状态=INIT
	 */
	public static final String STATUS_INIT="INIT";
	/**
	 * 发布状态=DEPLOYED
	 */
	public static final String STATUS_DEPLOY="DEPLOYED";
	
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "DEF_ID_")
	protected String defId;
	/* 标题 */
	@FieldDefine(title = "标题")
	@Column(name = "SUBJECT_")
	@Size(max = 255)
	protected String subject;
	/* 描述 */
	@FieldDefine(title = "描述")
	@Column(name = "DESCP_")
	@Size(max = 1024)
	protected String descp;
	/* 标识Key */
	@FieldDefine(title = "标识Key")
	@Column(name = "KEY_")
	@Size(max = 255)
	protected String key;
	/* Activiti流程定义ID */
	@FieldDefine(title = "Activiti流程定义ID")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 255)
	protected String actDefId;
	/* ACT流程发布ID */
	@FieldDefine(title = "ACT流程发布ID")
	@Column(name = "ACT_DEP_ID_")
	@Size(max = 255)
	protected String actDepId;
	
	/* 状态 */
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	@Size(max = 20)
	@NotEmpty
	protected String status;
	/* 版本号 */
	@FieldDefine(title = "版本号")
	@Column(name = "VERSION_")
	protected Integer version;
	/* 主版本 */
	@FieldDefine(title = "主版本")
	@Column(name = "IS_MAIN_")
	@Size(max = 20)
	protected String isMain;
	/* 定义属性设置 */
	@FieldDefine(title = "定义属性设置")
	@Column(name = "SETTING_")
	@Size(max = 2147483647)
	protected String setting;
	/* 设计模型ID */
	@FieldDefine(title = "设计模型ID")
	@Column(name = "MODEL_ID_")
	@Size(max = 64)
	protected String modelId;
	/* 主定义ID */
	@FieldDefine(title = "主定义ID")
	@Column(name = "MAIN_DEF_ID_")
	@Size(max = 64)
	protected String mainDefId;
	//导出时，不进行导出
	//@XStreamOmitField 
	
	protected String  treeId;

	/**
	 * Default Empty Constructor for class BpmDef
	 */
	public BpmDef() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmDef
	 */
	public BpmDef(String in_defId) {
		this.setDefId(in_defId);
	}

	
	
	
	/**
	 * * @return String
	 */
	public String getDefId() {
		return this.defId;
	}

	/**
	 * 设置
	 */
	public void setDefId(String aValue) {
		this.defId = aValue;
	}

	/**
	 * 标题 * @return String
	 */
	public String getSubject() {
		return this.subject;
	}

	/**
	 * 设置 标题
	 */
	public void setSubject(String aValue) {
		this.subject = aValue;
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

	/**
	 * 标识Key * @return String
	 */
	public String getKey() {
		return this.key;
	}

	/**
	 * 设置 标识Key
	 */
	public void setKey(String aValue) {
		this.key = aValue;
	}

	/**
	 * Activiti流程定义ID * @return String
	 */
	public String getActDefId() {
		return this.actDefId;
	}

	/**
	 * 设置 Activiti流程定义ID
	 */
	public void setActDefId(String aValue) {
		this.actDefId = aValue;
	}

	/**
	 * ACT流程发布ID * @return String
	 */
	public String getActDepId() {
		return this.actDepId;
	}

	/**
	 * 设置 ACT流程发布ID
	 */
	public void setActDepId(String aValue) {
		this.actDepId = aValue;
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
	 * 版本号 * @return Integer
	 */
	public Integer getVersion() {
		return this.version;
	}

	/**
	 * 设置 版本号
	 */
	public void setVersion(Integer aValue) {
		this.version = aValue;
	}

	/**
	 * 主版本 * @return String
	 */
	public String getIsMain() {
		return this.isMain;
	}

	/**
	 * 设置 主版本
	 */
	public void setIsMain(String aValue) {
		this.isMain = aValue;
	}

	/**
	 * 定义属性设置 * @return String
	 */
	public String getSetting() {
		return this.setting;
	}

	/**
	 * 设置 定义属性设置
	 */
	public void setSetting(String aValue) {
		this.setting = aValue;
	}

	/**
	 * 设计模型ID * @return String
	 */
	public String getModelId() {
		return this.modelId;
	}

	/**
	 * 设置 设计模型ID
	 */
	public void setModelId(String aValue) {
		this.modelId = aValue;
	}

	/**
	 * 主定义ID * @return String
	 */
	public String getMainDefId() {
		return this.mainDefId;
	}

	/**
	 * 设置 主定义ID
	 */
	public void setMainDefId(String aValue) {
		this.mainDefId = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.subject;
	}

	@Override
	public Serializable getPkId() {
		return this.defId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.defId = (String) pkId;
	}
	
	

	public String getTreeId() {
		return treeId;
	}

	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmDef)) {
			return false;
		}
		BpmDef rhs = (BpmDef) object;
		return new EqualsBuilder().append(this.defId, rhs.defId).append(this.subject, rhs.subject).append(this.descp, rhs.descp).append(this.key, rhs.key).append(this.actDefId, rhs.actDefId).append(this.actDepId, rhs.actDepId)
				.append(this.status, rhs.status).append(this.version, rhs.version).append(this.isMain, rhs.isMain)
				.append(this.setting, rhs.setting).append(this.modelId, rhs.modelId).append(this.mainDefId, rhs.mainDefId).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.defId).append(this.subject).append(this.descp).append(this.key).append(this.actDefId).append(this.actDepId).append(this.status).append(this.version).append(this.isMain).append(this.setting).append(this.modelId).append(this.mainDefId).append(this.tenantId).append(this.createBy)
				.append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("defId", this.defId).append("subject", this.subject).append("descp", this.descp).append("key", this.key).append("actDefId", this.actDefId).append("actDepId", this.actDepId).append("status", this.status).append("version", this.version).append("isMain", this.isMain).append("setting", this.setting)
				.append("modelId", this.modelId).append("mainDefId", this.mainDefId).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
