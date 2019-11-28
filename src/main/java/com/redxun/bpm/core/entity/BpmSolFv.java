package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
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
import com.redxun.core.util.StringUtil;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamOmitField;

/**
 * <pre>
 * 描述：BpmSolFv实体类定义
 * 解决方案关联的表单视图
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Table(name = "BPM_SOL_FV")
@TableDefine(title = "解决方案关联的表单视图")
@JsonIgnoreProperties(value={"bpmSolution"})
@XStreamAlias("bpmSolFv")
public class BpmSolFv extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 255)
	@NotEmpty
	protected String nodeId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_TEXT_")
	@Size(max = 255)
	protected String nodeText;
	/* 表单类型 */
	@FieldDefine(title = "表单类型")
	@Column(name = "FORM_TYPE_")
	@Size(max = 30)
	protected String formType;
	/* 表单地址 */
	@FieldDefine(title = "表单地址")
	@Column(name = "FORM_URI_")
	@Size(max = 255)
	protected String formUri;
	
	/* 表单名称 */
	@FieldDefine(title = "表单名称")
	@Column(name = "FORM_NAME_")
	@Size(max = 255)
	protected String formName;
	
	
	/* 打印表单 */
	@FieldDefine(title = "打印表单")
	@Column(name = "PRINT_URI_")
	@Size(max = 255)
	protected String printUri;
	
	/* 打印名称 */
	@FieldDefine(title = "表单名称")
	@Column(name = "PRINT_NAME_")
	@Size(max = 255)
	protected String printName;
	
	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn;
	
	
	@FieldDefine(title = "手机表单别名")
	@Column(name = "MOBILE_ALIAS_")
	@Size(max = 255)
	protected String mobileAlias="";
	
	
	@FieldDefine(title = "手机表单名称")
	@Column(name = "MOBILE_NAME_")
	@Size(max = 255)
	protected String mobileName="";
	
	@FieldDefine(title = "tab权限")
	@Column(name = "TAB_RIGHTS_")
	@Size(max = 65535)
	protected String tabRights="";
	/* 节点ID */
	@FieldDefine(title = "流程定义Id")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	@FieldDefine(title = "是否使用条件表单")
	@Column(name = "IS_USE_CFORM_")
	@Size(max = 20)
	protected String isUseCform;
	
	/**
	 * 格式：
	 * 
	 * <pre>
	 * {
			initScript:'xxx',
			saveScript:'xxxxxxxxx',
			boAttSettings:
			[{
				"init": {
					"multipleProcessForm": {
						"sx": {
							"val": "[CURDATE]",
							"valType": "constant",
							"val_name": "[CURDATE]"
						},
						"bm": {
							"val": "[CURDATE]",
							"valType": "constant",
							"val_name": "[CURDATE]"
						}
					},
					"mxx": {
						"f1": {
							"val": "[CURDATE]",
							"valType": "constant",
							"val_name": "[USERID]"
						}
					}
				},
				"save": {
					"multipleProcessForm": {
						"sx": {
							"val": "[CURDATE]",
							"valType": "constant",
							"val_name": "[CURDATE]"
						},
						"bm": {
							"field": "bm"
						}
					}
				},
				"boDefId": "2400000002501009"
			}]
		}
	</pre>
	 */
	@FieldDefine(title="表单数据展示配置")
	@Column(name="DATA_CONFS_")
	protected String dataConfs;
	
	/**
	 * [
	    {
	        "formName": "frmDate",
	        "userIds": "240000004178000,240000004178004",
	        "startUser": "true",
	        "isAll": "true",
	        "userNames": "郑鸿宇,曾伟杰",
	        "formAlias": "frmDate",
	        "attendUsers": "true"
	    }
	]
	 */
	@FieldDefine(title = "手机条件表单配置")
	@Column(name = "MOBILE_FORMS_")
	@Size(max = 65535)
	protected String mobileForms;
	
	@FieldDefine(title = "打印条件表单配置")
	@Column(name = "PRINT_FORMS_")
	@Size(max = 65535)
	protected String printForms;
	
	/**
	 * 不同的人员参与的表单配置的模板不一样
	 * [{
	 * formAlias:'xxx',
	 * formRights:{
	 *      userIds:'1,2',
	 *      groupIds:'3,4',
	 *      startUser:true,//代表发起用户
	 *      attendUser:true//代表参与用户
	 * }
	 * }]
	 */
	@FieldDefine(title = "条件表单配置")
	@Column(name = "COND_FORMS_")
	@Size(max = 65535)
	protected String condForms;
	
	
	
	//导出时，不进行导出
	@XStreamOmitField 
	@FieldDefine(title = "业务流程方案定义")
	protected String solId="";
	

	
	@Transient
	protected String tabTitle="";
	
	/**
	 * 用于前端的排序分组
	 */
	@Transient
	protected String groupTitle=null;
	
	

	public String getDataConfs() {
		return dataConfs;
	}

	public void setDataConfs(String dataConfs) {
		this.dataConfs = dataConfs;
	}

	public String getGroupTitle() {
		return groupTitle;
	}

	public void setGroupTitle(String groupTitle) {
		this.groupTitle = groupTitle;
	}
	
	public String getPrintUri() {
		return printUri;
	}

	public void setPrintUri(String printUri) {
		this.printUri = printUri;
	}

	public String getPrintName() {
		return printName;
	}

	public void setPrintName(String printName) {
		this.printName = printName;
	}

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	public String getIsUseCform() {
		return isUseCform;
	}

	public void setIsUseCform(String isUseCform) {
		this.isUseCform = isUseCform;
	}

	public String getCondForms() {
		if(StringUtil.isEmpty(condForms)){
			return "[]";
		}
		return condForms;
	}

	public void setCondForms(String condForms) {
		this.condForms = condForms;
	}

	/**
	 * Default Empty Constructor for class BpmSolFv
	 */
	public BpmSolFv() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmSolFv
	 */
	public BpmSolFv(String in_id) {
		this.setId(in_id);
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
	public String getNodeText() {
		return this.nodeText;
	}

	/**
	 * 设置 节点名称
	 */
	public void setNodeText(String aValue) {
		this.nodeText = aValue;
	}

	/**
	 * 表单类型 * @return String
	 */
	public String getFormType() {
		return this.formType;
	}

	/**
	 * 设置 表单类型
	 */
	public void setFormType(String aValue) {
		this.formType = aValue;
	}

	/**
	 * 表单地址 * @return String
	 */
	public String getFormUri() {
		return this.formUri;
	}

	/**
	 * 设置 表单地址
	 */
	public void setFormUri(String aValue) {
		this.formUri = aValue;
	}

	public String getTabRights() {
		return tabRights;
	}

	public void setTabRights(String tabRights) {
		this.tabRights = tabRights;
	}

	public Integer getSn() {
		return sn;
	}

	public void setSn(Integer sn) {
		this.sn = sn;
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

	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

	public String getMobileAlias() {
		return mobileAlias;
	}

	public void setMobileAlias(String mobileAlias) {
		this.mobileAlias = mobileAlias;
	}

	public String getMobileName() {
		return mobileName;
	}

	public void setMobileName(String mobileName) {
		this.mobileName = mobileName;
	}

	public String getTabTitle() {
		return tabTitle;
	}

	public void setTabTitle(String tabTitle) {
		this.tabTitle = tabTitle;
	}

	
	public String getMobileForms() {
		if(StringUtil.isEmpty(mobileForms)){
			return "[]";
		}
		return mobileForms;
	}

	public void setMobileForms(String mobileForms) {
		this.mobileForms = mobileForms;
	}

	public String getPrintForms() {
		if(StringUtil.isEmpty(printForms)){
			return "[]";
		}
		return printForms;
	}

	public void setPrintForms(String printForms) {
		this.printForms = printForms;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSolFv)) {
			return false;
		}
		BpmSolFv rhs = (BpmSolFv) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.nodeId, rhs.nodeId).append(this.nodeText, rhs.nodeText).append(this.formType, rhs.formType).append(this.formUri, rhs.formUri).append(this.tenantId, rhs.tenantId).append(this.updateBy, rhs.updateBy).append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime)
				.append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.nodeId).append(this.nodeText).append(this.formType).append(this.formUri).append(this.tenantId).append(this.updateBy).append(this.createBy).append(this.createTime).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("nodeId", this.nodeId).append("nodeText", this.nodeText).append("formType", this.formType).append("formUri", this.formUri).append("tenantId", this.tenantId).append("updateBy", this.updateBy).append("createBy", this.createBy).append("createTime", this.createTime).append("updateTime", this.updateTime)
				.toString();
	}

}
