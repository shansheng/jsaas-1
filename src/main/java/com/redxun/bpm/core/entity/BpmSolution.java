package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.validator.constraints.NotEmpty;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.util.StringUtil;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamOmitField;

/**
 * <pre>
 * 描述：BpmSolution实体类定义
 * 业务流程方案定义
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_SOLUTION")
@TableDefine(title = "业务流程方案定义")
@XStreamAlias("bpmSolution")
public class BpmSolution extends BaseTenantEntity implements IRightModel {
	/**
	 * 创建=CREATED
	 */
	public final static String STATUS_CREATED="CREATED";

	/**
	 * 发布=DEPLOY
	 */
	public final static String STATUS_DEPLOYED="DEPLOYED";
	
	/**
	 * 正式版本
	 */
	public final static String FORMAL_YES="yes";
	
	/**
	 * 测试版本
	 */
	public final static String FORMAL_NO="no";
	
	/**
	 * 全部授权=0
	 */
	public final static Short GRANT_ALL=new Short("0");
	/**
	 * 部分授权=1
	 */
	public final static Short GRANT_PART=new Short("1");
	
	
	/**
	 * 数据保存方式。
	 * 同时保存在实例表和物理表。
	 */
	public static final String DATA_SAVE_MODE_ALL="all";
	/**
	 * 数据保存到业务表。
	 */
	public static final String DATA_SAVE_MODE_DB="db";
	/**
	 * 数据使用json的方式存到实例表中。
	 */
	public static final String DATA_SAVE_MODE_JSON="json";
	
	/**
	 * 初始的完成步骤
	 */
	public final static int STEP_0=0;
	
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "SOL_ID_")
	protected String solId;
	
	@FieldDefine(title = "流程定义Id")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	/* 解决方案名称 */
	@FieldDefine(title = "解决方案名称")
	@Column(name = "NAME_")
	@Size(max = 100)
	@NotEmpty
	protected String name;
	/* 标识键 */
	@FieldDefine(title = "标识键")
	@Column(name = "KEY_")
	@Size(max = 100)
	@NotEmpty
	protected String key;
	/* 绑定流程KEY */
	@FieldDefine(title = "绑定流程KEY")
	@Column(name = "DEF_KEY_")
	@Size(max = 255)
	protected String defKey;
	/* 解决方案描述 */
	@FieldDefine(title = "解决方案描述")
	@Column(name = "DESCP_")
	@Size(max = 4000)
	protected String descp;
	/* 状态
	 * 是否发布
	 * 
	 */
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	@Size(max = 64)
	@NotEmpty
	protected String status;
	
	
	@FieldDefine(title = "正式")
	@Column(name = "formal_")
	@Size(max = 64)
	protected String formal;
	
	
	/* 状态 */
	@FieldDefine(title = "完成的步骤")
	@Column(name = "STEP_")
	@NotNull
	protected Integer step;
	
	/* 帮助ID */
	@FieldDefine(title = "帮助ID")
	@Column(name = "HELP_ID_")
	@Size(max = 64)
	protected String helpId;
	
	
	@FieldDefine(title = "支持手机")
	@Column(name = "SUPPORT_MOBILE_")
	protected int supportMobile=0;
	
	
	
	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	@FieldDefine(title = "单独使用业务模型")
	@Column(name = "IS_USE_BMODEL_")
	@Size(max = 30)
	protected String isUseBmodel;
	/**
	 * 授权类型，1=全局授权，0=部分授权
	 */
	@FieldDefine(title = "授权类型")
	@Column(name = "GRANT_TYPE_")
	protected Short grantType=new Short("0");
	
	//导出时，不进行导出
	//@XStreamOmitField 
	@FieldDefine(title = "系统分类树")
	@ManyToOne
	@JoinColumn(name = "TREE_ID_")
	protected String treeId;
	@XStreamOmitField 
	@FieldDefine(title = "系统分类路径")
	@Column(name = "TREE_PATH_")
	@Size(max = 512)
	protected String treePath;
	
	@Transient
	protected JSONObject rightJson;

	
	@FieldDefine(title = "业务模型定义")
	@Column(name = "BO_DEF_ID_")
	@Size(max = 1000)
	protected String boDefId;
	@FieldDefine(title = "数据保存类型")
	@Column(name = "DATA_SAVE_MODE_")
	@Size(max = 50)
	protected String dataSaveMode=DATA_SAVE_MODE_DB;
	@FieldDefine(title = "流程方案图标")
	@Column(name = "ICON_")
	@Size(max = 64)
	protected String icon;
	@FieldDefine(title = "流程方案图标颜色")
	@Column(name = "COLOR_")
	@Size(max = 64)
	protected String color;
	
	@Transient
	protected String tableNames;
	/**
	 * Default Empty Constructor for class BpmSolution
	 */
	public BpmSolution() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmSolution
	 */
	public BpmSolution(String in_solId) {
		this.setSolId(in_solId);
	}
	
	public String getColor() {
		return color;
	}
	
	public void setColor(String color) {
		this.color = color;
	}
	
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	public String getIcon() {
		return icon;
	}
	
	public String getTableNames() {
		return tableNames;
	}
	
	public void setTableNames(String tableNames) {
		this.tableNames = tableNames;
	}

	public Integer getStep() {
		return step;
	}

	public void setStep(Integer step) {
		this.step = step;
	}

	/**
	 * * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置
	 */
	public void setSolId(String aValue) {
		this.solId = aValue;
	}

	/**
	 * 分类Id * @return String
	 */
	public String getTreeId() {
		return this.treeId;
	}

	/**
	 * 设置 分类Id
	 */
	public void setTreeId(String aValue) {
		this.treeId=aValue;
	}

	/**
	 * 解决方案名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 解决方案名称
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
	 * 绑定流程KEY * @return String
	 */
	public String getDefKey() {
		return this.defKey;
	}

	/**
	 * 设置 绑定流程KEY
	 */
	public void setDefKey(String aValue) {
		this.defKey = aValue;
	}

	/**
	 * 解决方案描述 * @return String
	 */
	public String getDescp() {
		return this.descp;
	}

	/**
	 * 设置 解决方案描述
	 */
	public void setDescp(String aValue) {
		this.descp = aValue;
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
	 * 帮助ID * @return String
	 */
	public String getHelpId() {
		return this.helpId;
	}

	/**
	 * 设置 帮助ID
	 */
	public void setHelpId(String aValue) {
		this.helpId = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.getName();
	}

	@Override
	public Serializable getPkId() {
		return this.solId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.solId = (String) pkId;
	}

	

	public String getIsUseBmodel() {
		return isUseBmodel;
	}

	public void setIsUseBmodel(String isUseBmodel) {
		this.isUseBmodel = isUseBmodel;
	}

	public Short getGrantType() {
		return grantType;
	}

	public void setGrantType(Short grantType) {
		this.grantType = grantType;
	}

	public String getTreePath() {
		return treePath;
	}

	public void setTreePath(String treePath) {
		this.treePath = treePath;
	}
	
	@Override
	public void setRightJson(JSONObject rightJson) {
		this.rightJson=rightJson;
	}

	@Override
	public JSONObject getRightJson() {
		return this.rightJson;
	}

	public String getFormal() {
		return formal;
	}

	public void setFormal(String formal) {
		this.formal = formal;
	}

	public String getBoDefId() {
		return boDefId;
	}

	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}

	public String getDataSaveMode() {
	
		if(StringUtil.isEmpty(dataSaveMode)){
			return DATA_SAVE_MODE_JSON;
		}
		return dataSaveMode ;
	}

	public void setDataSaveMode(String dataSaveMode) {
		this.dataSaveMode = dataSaveMode;
	}

	public int getSupportMobile() {
		return supportMobile;
	}

	public void setSupportMobile(int supportMobile) {
		this.supportMobile = supportMobile;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSolution)) {
			return false;
		}
		BpmSolution rhs = (BpmSolution) object;
		return new EqualsBuilder().append(this.solId, rhs.solId).append(this.name, rhs.name).append(this.key, rhs.key).append(this.defKey, rhs.defKey).append(this.descp, rhs.descp).append(this.status, rhs.status).append(this.helpId, rhs.helpId).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.solId).append(this.name).append(this.key).append(this.defKey).append(this.descp).append(this.status).append(this.helpId).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("solId", this.solId).append("name", this.name).append("key", this.key).append("defKey", this.defKey).append("descp", this.descp).append("status", this.status).append("helpId", this.helpId).append("tenantId", this.tenantId).append("createBy", this.createBy).append("createTime", this.createTime).append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}

	

}
