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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * <pre>
 * 描述：BpmSolUser实体类定义
 * 解决方案关联的人员配置
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_SOL_USER")
@TableDefine(title = "解决方案关联的人员配置")
@JsonIgnoreProperties("bpmSolution")
@XStreamAlias("bpmSolUser")
public class BpmSolUser extends BaseTenantEntity {
	/**
	 * 集合中的逻辑计算-与=AND
	 */
	public static final String LOGIC_AND="AND";
	/**
	 * 集合中的逻辑计算-与=AND
	 */
	public static final String LOGIC_OR="OR";
	/**
	 * 集合中的逻辑计算-与=AND
	 */
	public static final String LOGIC_NOT="NOT";
		
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	
	/* 节点ID */
	@FieldDefine(title = "流程定义Id")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 255)
	@NotEmpty
	protected String nodeId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	@Size(max = 255)
	protected String nodeName;
	/* 用户类型 */
	@FieldDefine(title = "用户类型")
	@Column(name = "USER_TYPE_")
	@Size(max = 50)
	@NotEmpty
	protected String userType;
	/* 用户类型名称 */
	@FieldDefine(title = "用户类型名称")
	@Column(name = "USER_TYPE_NAME_")
	@Size(max = 100)
	protected String userTypeName;
	/* 配置显示信息 */
	@FieldDefine(title = "配置显示信息")
	@Column(name = "CONFIG_DESCP_")
	@Size(max = 512)
	protected String configDescp;
	/* 节点配置 */
	@FieldDefine(title = "节点配置")
	@Column(name = "CONFIG_")
	@Size(max = 512)
	protected String config;
	/* 是否计算用户 */
	@FieldDefine(title = "是否计算用户")
	@Column(name = "IS_CAL_")
	@Size(max = 20)
	@NotEmpty
	protected String isCal;
	/* 集合的人员运算 */
	@FieldDefine(title = "集合的人员运算")
	@Column(name = "CAL_LOGIC_")
	@Size(max = 20)
	@NotEmpty
	protected String calLogic;
	/* 序号 */
	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn;
	//导出时，不进行导出
	@FieldDefine(title = "业务流程方案定义")
	@Column(name = "SOL_ID_")
	protected String solId;
	
	
	@FieldDefine(title = "类别")
	@Column(name = "CATEGORY_")
	protected String category;
	
	@FieldDefine(title = "用户组ID")
	@Column(name = "GROUP_ID_")
	protected String groupId;

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	/**
	 * Default Empty Constructor for class BpmSolUser
	 */
	public BpmSolUser() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmSolUser
	 */
	public BpmSolUser(String in_id) {
		this.setId(in_id);
	}

	public String getSolId() {
		return this.solId;
	}

	public void setSolId(String solId) {
		this.solId = solId;
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
	public String getNodeName() {
		return this.nodeName;
	}

	/**
	 * 设置 节点名称
	 */
	public void setNodeName(String aValue) {
		this.nodeName = aValue;
	}

	/**
	 * 用户类型 * @return String
	 */
	public String getUserType() {
		return this.userType;
	}

	/**
	 * 设置 用户类型
	 */
	public void setUserType(String aValue) {
		this.userType = aValue;
	}

	/**
	 * 用户类型名称 * @return String
	 */
	public String getUserTypeName() {
		return this.userTypeName;
	}

	/**
	 * 设置 用户类型名称
	 */
	public void setUserTypeName(String aValue) {
		this.userTypeName = aValue;
	}

	/**
	 * 配置显示信息 * @return String
	 */
	public String getConfigDescp() {
		return this.configDescp;
	}

	/**
	 * 设置 配置显示信息
	 */
	public void setConfigDescp(String aValue) {
		this.configDescp = aValue;
	}

	/**
	 * 节点配置 * @return String
	 */
	public String getConfig() {
		return this.config;
	}

	/**
	 * 设置 节点配置
	 */
	public void setConfig(String aValue) {
		this.config = aValue;
	}

	/**
	 * 是否计算用户 * @return String
	 */
	public String getIsCal() {
		return this.isCal;
	}

	/**
	 * 设置 是否计算用户
	 */
	public void setIsCal(String aValue) {
		this.isCal = aValue;
	}

	/**
	 * 集合的人员运算 * @return String
	 */
	public String getCalLogic() {
		return this.calLogic;
	}

	/**
	 * 设置 集合的人员运算
	 */
	public void setCalLogic(String aValue) {
		this.calLogic = aValue;
	}

	/**
	 * 序号 * @return Integer
	 */
	public Integer getSn() {
		return this.sn;
	}

	/**
	 * 设置 序号
	 */
	public void setSn(Integer aValue) {
		this.sn = aValue;
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSolUser)) {
			return false;
		}
		BpmSolUser rhs = (BpmSolUser) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.nodeId, rhs.nodeId).append(this.nodeName, rhs.nodeName).append(this.userType, rhs.userType).append(this.userTypeName, rhs.userTypeName).append(this.configDescp, rhs.configDescp).append(this.config, rhs.config).append(this.isCal, rhs.isCal).append(this.calLogic, rhs.calLogic).append(this.sn, rhs.sn)
				.append(this.tenantId, rhs.tenantId).append(this.updateBy, rhs.updateBy).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.nodeId).append(this.nodeName).append(this.userType).append(this.userTypeName).append(this.configDescp).append(this.config).append(this.isCal).append(this.calLogic).append(this.sn).append(this.tenantId).append(this.updateBy).append(this.createBy).append(this.createTime).append(this.updateTime)
				.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("nodeId", this.nodeId).append("nodeName", this.nodeName).append("userType", this.userType).append("userTypeName", this.userTypeName).append("configDescp", this.configDescp).append("config", this.config).append("isCal", this.isCal).append("calLogic", this.calLogic).append("sn", this.sn)
				.append("tenantId", this.tenantId).append("updateBy", this.updateBy).append("createBy", this.createBy).append("createTime", this.createTime).append("updateTime", this.updateTime).toString();
	}

}
