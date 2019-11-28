package com.redxun.bpm.integrate.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
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
 * 描述：BpmModuleBind实体类定义
 * 流程模块方案绑定
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Entity
@Table(name = "BPM_MODULE_BIND")
@TableDefine(title = "流程模块方案绑定")
public class BpmModuleBind extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "BIND_ID_")
	protected String bindId;
	/* 模块名称 */
	@FieldDefine(title = "模块名称")
	@Column(name = "MODULE_NAME_")
	@Size(max = 50)
	@NotEmpty
	protected String moduleName;
	/* 模块Key */
	@FieldDefine(title = "模块Key")
	@Column(name = "MODULE_KEY_")
	@Size(max = 80)
	@NotEmpty
	protected String moduleKey;
	/* 流程解决方案ID */
	@FieldDefine(title = "流程解决方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 64)
	protected String solId;
	/* 流程解决方案Key */
	@FieldDefine(title = "流程解决方案Key")
	@Column(name = "SOL_KEY_")
	@Size(max = 60)
	protected String solKey;
	/* 流程解决方案名称 */
	@FieldDefine(title = "流程解决方案名称")
	@Column(name = "SOL_NAME_")
	@Size(max = 100)
	protected String solName;

	/**
	 * Default Empty Constructor for class BpmModuleBind
	 */
	public BpmModuleBind() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmModuleBind
	 */
	public BpmModuleBind(String in_bindId) {
		this.setBindId(in_bindId);
	}

	/**
	 * * @return String
	 */
	public String getBindId() {
		return this.bindId;
	}

	/**
	 * 设置
	 */
	public void setBindId(String aValue) {
		this.bindId = aValue;
	}

	/**
	 * 模块名称 * @return String
	 */
	public String getModuleName() {
		return this.moduleName;
	}

	/**
	 * 设置 模块名称
	 */
	public void setModuleName(String aValue) {
		this.moduleName = aValue;
	}

	/**
	 * 模块Key * @return String
	 */
	public String getModuleKey() {
		return this.moduleKey;
	}

	/**
	 * 设置 模块Key
	 */
	public void setModuleKey(String aValue) {
		this.moduleKey = aValue;
	}

	/**
	 * 流程解决方案ID * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置 流程解决方案ID
	 */
	public void setSolId(String aValue) {
		this.solId = aValue;
	}

	/**
	 * 流程解决方案Key * @return String
	 */
	public String getSolKey() {
		return this.solKey;
	}

	/**
	 * 设置 流程解决方案Key
	 */
	public void setSolKey(String aValue) {
		this.solKey = aValue;
	}

	/**
	 * 流程解决方案名称 * @return String
	 */
	public String getSolName() {
		return this.solName;
	}

	/**
	 * 设置 流程解决方案名称
	 */
	public void setSolName(String aValue) {
		this.solName = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.bindId;
	}

	@Override
	public Serializable getPkId() {
		return this.bindId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.bindId = (String) pkId;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmModuleBind)) {
			return false;
		}
		BpmModuleBind rhs = (BpmModuleBind) object;
		return new EqualsBuilder().append(this.bindId, rhs.bindId).append(this.moduleName, rhs.moduleName).append(this.moduleKey, rhs.moduleKey).append(this.solId, rhs.solId)
				.append(this.solKey, rhs.solKey).append(this.solName, rhs.solName).append(this.tenantId, rhs.tenantId).append(this.createBy, rhs.createBy)
				.append(this.createTime, rhs.createTime).append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.bindId).append(this.moduleName).append(this.moduleKey).append(this.solId).append(this.solKey)
				.append(this.solName).append(this.tenantId).append(this.createBy).append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("bindId", this.bindId).append("moduleName", this.moduleName).append("moduleKey", this.moduleKey).append("solId", this.solId)
				.append("solKey", this.solKey).append("solName", this.solName).append("tenantId", this.tenantId).append("createBy", this.createBy)
				.append("createTime", this.createTime).append("updateBy", this.updateBy).append("updateTime", this.updateTime).toString();
	}

}
