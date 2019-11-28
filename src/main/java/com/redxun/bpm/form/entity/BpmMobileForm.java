package com.redxun.bpm.form.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：BpmMobileForm实体类定义
 * 手机表单配置表
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_MOBILE_FORM")
@TableDefine(title = "手机表单配置表")
public class BpmMobileForm extends BaseTenantEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3693354335788267509L;
	
	
	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 关联表单ID */
	@FieldDefine(title = "关联表单ID")
	@Column(name = "BO_DEF_ID_")
	@Size(max = 60)
	protected String boDefId;
	/* 手机表单名称 */
	@FieldDefine(title = "手机表单名称")
	@Column(name = "NAME_")
	@Size(max = 50)
	protected String name;
	/* 手机表单名称 */
	@FieldDefine(title = "手机表单名称")
	@Column(name = "ALIAS_")
	@Size(max = 30)
	protected String alias;
	/* 手机表单对应的模版 */
	@FieldDefine(title = "手机表单对应的模版")
	@Column(name = "FORM_HTML")
	@Size(max = 2147483647)
	protected String formHtml;
	/* 分类ID */
	@FieldDefine(title = "分类ID")
	@Column(name = "TREE_ID_")
	@Size(max = 60)
	protected String treeId;
	
	@FieldDefine(title = "BO名称")
	@Size(max = 60)
	protected String boName;
	
	@FieldDefine(title = "对应的BpmSolFv对象")
	protected BpmSolFv bpmSolFv;
	
	@Transient
	protected String oldBodefId=null;

	/**
	 * Default Empty Constructor for class BpmMobileForm
	 */
	public BpmMobileForm() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmMobileForm
	 */
	public BpmMobileForm(String in_id) {
		this.setId(in_id);
	}

	/**
	 * 主键 * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置 主键
	 */
	public void setId(String aValue) {
		this.id = aValue;
	}

	

	/**
	 * 手机表单名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 手机表单名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 手机表单名称 * @return String
	 */
	public String getAlias() {
		return this.alias;
	}

	/**
	 * 设置 手机表单名称
	 */
	public void setAlias(String aValue) {
		this.alias = aValue;
	}

	/**
	 * 手机表单对应的模版 * @return String
	 */
	public String getFormHtml() {
		return this.formHtml;
	}

	/**
	 * 设置 手机表单对应的模版
	 */
	public void setFormHtml(String aValue) {
		this.formHtml = aValue;
	}

	/**
	 * 分类ID * @return String
	 */
	public String getTreeId() {
		return this.treeId;
	}

	/**
	 * 设置 分类ID
	 */
	public void setTreeId(String aValue) {
		this.treeId = aValue;
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

	

	public String getBoName() {
		return boName;
	}

	public void setBoName(String boName) {
		this.boName = boName;
	}

	public String getBoDefId() {
		return boDefId;
	}

	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}

	public BpmSolFv getBpmSolFv() {
		return bpmSolFv;
	}

	public void setBpmSolFv(BpmSolFv bpmSolFv) {
		this.bpmSolFv = bpmSolFv;
	}
	
	

	public String getOldBodefId() {
		return oldBodefId;
	}

	public void setOldBodefId(String oldBodefId) {
		this.oldBodefId = oldBodefId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmMobileForm)) {
			return false;
		}
		BpmMobileForm rhs = (BpmMobileForm) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.getAlias(), rhs.getAlias())
				.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.name)
				.append(this.alias).append(this.formHtml).append(this.tenantId).append(this.treeId)
				.append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime)
				.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("name", this.name)
				.append("alias", this.alias).append("formHtml", this.formHtml).append("tenantId", this.tenantId)
				.append("treeId", this.treeId).append("createBy", this.createBy).append("createTime", this.createTime)
				.append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
