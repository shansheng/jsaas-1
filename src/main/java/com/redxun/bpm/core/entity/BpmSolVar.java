package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
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
import com.thoughtworks.xstream.annotations.XStreamOmitField;

/**
 * <pre>
 * 描述：BpmSolVar实体类定义
 * 流程解决方案变量
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_SOL_VAR")
@TableDefine(title = "流程解决方案变量")
@JsonIgnoreProperties("bpmSolution")
@XStreamAlias("bpmSolVar")
public class BpmSolVar extends BaseTenantEntity {
	/**
	 * 作用域：流程范围
	 */
	public final static String SCOPE_PROCESS="_PROCESS";
	
	/**
	 * 对象类型=Object
	 */
	public final static String TYPE_OBJECT="Object";
	/**
	 * 映射=Map
	 */
	public final static String TYPE_MAP="Map";
	/**
	 * 集合=Collection
	 */
	public final static String TYPE_COLLECTION="Collection";
	/**
	 * 日期类型=date
	 */
	public final static String TYPE_DATE="Date";
	/**
	 * 数字类型=number
	 */
	public final static String TYPE_NUMBER="Number";
	/**
	 * 字符串类型=string
	 */
	public final static String TYPE_STRING="String";

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "VAR_ID_")
	protected String varId;
	/* 变量Key */
	@FieldDefine(title = "变量Key")
	@Column(name = "KEY_")
	@Size(max = 255)
	@NotEmpty
	protected String key;
	/* 变量名称 */
	@FieldDefine(title = "变量名称")
	@Column(name = "NAME_")
	@Size(max = 255)
	@NotEmpty
	protected String name;
	/* 类型 */
	@FieldDefine(title = "类型")
	@Column(name = "TYPE_")
	@Size(max = 50)
	@NotEmpty
	protected String type;
	/* 作用域 */
	@FieldDefine(title = "作用域")
	@Column(name = "SCOPE_")
	@Size(max = 128)
	@NotEmpty
	protected String scope;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	@Size(max = 255)
	protected String nodeName;
	/* 缺省值 */
	@FieldDefine(title = "缺省值")
	@Column(name = "DEF_VAL_")
	@Size(max = 100)
	protected String defVal;
	
	/* 是否必填 */
	@FieldDefine(title = "是否必须")
	@Column(name = "IS_REQ_")
	@Size(max = 20)
	protected String isReq;
	
	/* 计算表达式 */
	@FieldDefine(title = "计算表达式")
	@Column(name = "EXPRESS_")
	@Size(max = 512)
	protected String express;
	/* 序号 */
	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn;
	
	/* 节点ID */
	@FieldDefine(title = "流程定义Id")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	//导出时，不进行导出
	@XStreamOmitField
	@FieldDefine(title = "业务流程方案定义")
	@ManyToOne
	@JoinColumn(name = "SOL_ID_")
	protected String solId;
	
	@Transient
	protected String parentId;
	
	@Transient 
	protected String fieldGroup;
	
	@FieldDefine(title = "映射表单字段Key")
	@Column(name = "FORM_FIELD_")
	@Size(max = 100)
	protected String formField;

	/**
	 * Default Empty Constructor for class BpmSolVar
	 */
	public BpmSolVar() {
		super();
	}
	
	public BpmSolVar(String name,String key){
		this.name=name;
		this.key=key;
	}
	
	public BpmSolVar(String name,String key,String fieldGroup){
		this.name=name;
		this.key=key;
		this.fieldGroup=fieldGroup;
	}
	
	public BpmSolVar(String name,String key,String type,String scope){
		this.name=name;
		this.key=key;
		this.type=type;
		this.scope=scope;
	}

	/**
	 * Default Key Fields Constructor for class BpmSolVar
	 */
	public BpmSolVar(String in_varId) {
		this.setVarId(in_varId);
	}

	

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	/**
	 * 变量ID * @return String
	 */
	public String getVarId() {
		return this.varId;
	}

	public String getFormField() {
		return formField;
	}

	public void setFormField(String formField) {
		this.formField = formField;
	}

	/**
	 * 设置 变量ID
	 */
	public void setVarId(String aValue) {
		this.varId = aValue;
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

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	/**
	 * 变量Key * @return String
	 */
	public String getKey() {
		return this.key;
	}

	/**
	 * 设置 变量Key
	 */
	public void setKey(String aValue) {
		this.key = aValue;
	}

	/**
	 * 变量名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 变量名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 类型 * @return String
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * 设置 类型
	 */
	public void setType(String aValue) {
		this.type = aValue;
	}

	/**
	 * 作用域 * @return String
	 */
	public String getScope() {
		return this.scope;
	}

	/**
	 * 设置 作用域
	 */
	public void setScope(String aValue) {
		this.scope = aValue;
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
	 * 缺省值 * @return String
	 */
	public String getDefVal() {
		return this.defVal;
	}

	/**
	 * 设置 缺省值
	 */
	public void setDefVal(String aValue) {
		this.defVal = aValue;
	}

	/**
	 * 计算表达式 * @return String
	 */
	public String getExpress() {
		return this.express;
	}

	/**
	 * 设置 计算表达式
	 */
	public void setExpress(String aValue) {
		this.express = aValue;
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
		return this.varId;
	}

	@Override
	public Serializable getPkId() {
		return this.varId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.varId = (String) pkId;
	}

	public String getIsReq() {
		return isReq;
	}

	public void setIsReq(String isReq) {
		this.isReq = isReq;
	}
	
	

	public String getFieldGroup() {
		return fieldGroup;
	}

	public void setFieldGroup(String fieldGroup) {
		this.fieldGroup = fieldGroup;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSolVar)) {
			return false;
		}
		BpmSolVar rhs = (BpmSolVar) object;
		return new EqualsBuilder().append(this.varId, rhs.varId).append(this.key, rhs.key).append(this.name, rhs.name).append(this.type, rhs.type).append(this.scope, rhs.scope)
				.append(this.nodeName, rhs.nodeName).append(this.defVal, rhs.defVal).append(this.express, rhs.express).append(this.sn, rhs.sn).append(this.tenantId, rhs.tenantId)
				.append(this.updateBy, rhs.updateBy).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.varId).append(this.key).append(this.name).append(this.type).append(this.scope).append(this.nodeName)
				.append(this.defVal).append(this.express).append(this.sn).append(this.tenantId).append(this.updateBy).append(this.createBy).append(this.createTime)
				.append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("varId", this.varId).append("key", this.key).append("name", this.name).append("type", this.type).append("scope", this.scope)
				.append("nodeName", this.nodeName).append("defVal", this.defVal).append("express", this.express).append("sn", this.sn).append("tenantId", this.tenantId)
				.append("updateBy", this.updateBy).append("createBy", this.createBy).append("createTime", this.createTime).append("updateTime", this.updateTime).toString();
	}

}
