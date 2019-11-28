package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
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
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamOmitField;

/**
 * <pre>
 * 描述：BpmNodeSet实体类定义
 * 流程定义节点配置
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_NODE_SET")
@TableDefine(title = "流程定义节点配置")
@XStreamAlias("bpmNodeSet")
public class BpmNodeSet extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "SET_ID_")
	protected String setId;
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 255)
	@NotEmpty
	protected String nodeId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NAME_")
	@Size(max = 255)
	protected String name;
	/* 节点描述 */
	@FieldDefine(title = "节点描述")
	@Column(name = "DESCP_")
	@Size(max = 255)
	protected String descp;

	
	/* 节点ID */
	@FieldDefine(title = "流程定义Id")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	/* 节点类型 */
	@FieldDefine(title = "节点类型")
	@Column(name = "NODE_TYPE_")
	@Size(max = 100)
	@NotEmpty
	protected String nodeType;
	
	/* 节点设置 */
	@FieldDefine(title = "节点设置")
	@Column(name = "SETTINGS_")
	@Size(max = 65535)
	protected String settings;
	
	/* 节点设置 */
	@FieldDefine(title = "流程节点提醒")
	@Column(name = "NODE_CHECK_TIP_")
	@Size(max = 1024)
	protected String nodeCheckTip;
	
	//导出时，不进行导出
	@XStreamOmitField 
	@FieldDefine(title = "业务流程方案定义")
	@ManyToOne
	@JoinColumn(name = "SOL_ID_")
	protected String solId ;

	
	/* 前置处理器 */
	@FieldDefine(title = "前置处理器")
	@Column(name = "PRE_HANDLE_")
	@Size(max = 255)
	@NotEmpty
	protected String preHandle;
	
	/* 后置处理器 */
	@FieldDefine(title = "后置处理器")
	@Column(name = "AFTER_HANDLE_")
	@Size(max = 255)
	@NotEmpty
	protected String afterHandle;
	/**
	 * Default Empty Constructor for class BpmNodeSet
	 */
	public BpmNodeSet() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmNodeSet
	 */
	public BpmNodeSet(String in_setId) {
		this.setSetId(in_setId);
	}

	

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	/**
	 * * @return String
	 */
	public String getSetId() {
		return this.setId;
	}

	/**
	 * 设置
	 */
	public void setSetId(String aValue) {
		this.setId = aValue;
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
		this.solId=aValue;
	}

	/**
	 * 节点ID * @return String
	 */
	public String getNodeId() {
		return this.nodeId;
	}

	/**
	 * 设置 节点ID
	 */
	public void setNodeId(String aValue) {
		this.nodeId = aValue;
	}

	/**
	 * 节点名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 节点名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 节点描述 * @return String
	 */
	public String getDescp() {
		return this.descp;
	}

	/**
	 * 设置 节点描述
	 */
	public void setDescp(String aValue) {
		this.descp = aValue;
	}

	/**
	 * 节点类型 * @return String
	 */
	public String getNodeType() {
		return this.nodeType;
	}

	/**
	 * 设置 节点类型
	 */
	public void setNodeType(String aValue) {
		this.nodeType = aValue;
	}

	/**
	 * 节点设置 * @return String
	 */
	public String getSettings() {
		return this.settings;
	}

	/**
	 * 设置 节点设置
	 */
	public void setSettings(String aValue) {
		this.settings = aValue;
	}
	public String getNodeCheckTip() {
		return nodeCheckTip;
	}

	public void setNodeCheckTip(String nodeCheckTip) {
		this.nodeCheckTip = nodeCheckTip;
	}

	@Override
	public String getIdentifyLabel() {
		return this.setId;
	}

	@Override
	public Serializable getPkId() {
		return this.setId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.setId = (String) pkId;
	}

	public String getPreHandle() {
		return preHandle;
	}

	public void setPreHandle(String preHandle) {
		this.preHandle = preHandle;
	}

	public String getAfterHandle() {
		return afterHandle;
	}

	public void setAfterHandle(String afterHandle) {
		this.afterHandle = afterHandle;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmNodeSet)) {
			return false;
		}
		BpmNodeSet rhs = (BpmNodeSet) object;
		return new EqualsBuilder().append(this.setId, rhs.setId).append(this.nodeId, rhs.nodeId).append(this.name, rhs.name).append(this.descp, rhs.descp).append(this.nodeType, rhs.nodeType).append(this.settings, rhs.settings).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.setId).append(this.nodeId).append(this.name).append(this.descp).append(this.nodeType).append(this.settings).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("setId", this.setId).append("nodeId", this.nodeId).append("name", this.name).append("descp", this.descp).append("nodeType", this.nodeType).append("settings", this.settings).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

}
