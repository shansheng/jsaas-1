package com.redxun.bpm.core.entity;

import java.io.Serializable;

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
 *  
 * 描述：BpmAuthSetting实体类定义
 * 流程定义授权
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_AUTH_SETTING")
@TableDefine(title = "流程定义授权")
public class BpmAuthSetting extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 授权名称 */
	@FieldDefine(title = "授权名称")
	@Column(name = "NAME_")
	@Size(max = 50)
	protected String name;
	/* 是否允许 */
	@FieldDefine(title = "是否允许")
	@Column(name = "ENABLE_")
	@Size(max = 10)
	protected String enable;
	/* 类型 */
	@FieldDefine(title = "授权类型")
	@Column(name = "TYPE_")
	@Size(max = 10)
	protected String type;
	/**
	 * Default Empty Constructor for class BpmAuthSetting
	 */
	public BpmAuthSetting() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmAuthSetting
	 */
	public BpmAuthSetting(String in_id) {
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
	 * 授权名称 * @return String
	 */
	public String getName() {
		return this.name;
	}

	/**
	 * 设置 授权名称
	 */
	public void setName(String aValue) {
		this.name = aValue;
	}

	/**
	 * 是否允许 * @return String
	 */
	public String getEnable() {
		return this.enable;
	}

	/**
	 * 设置 是否允许
	 */
	public void setEnable(String aValue) {
		this.enable = aValue;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmAuthSetting)) {
			return false;
		}
		BpmAuthSetting rhs = (BpmAuthSetting) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.name, rhs.name).append(this.enable, rhs.enable)
				.append(this.tenantId, rhs.tenantId).append(this.createTime, rhs.createTime)
				.append(this.updateTime, rhs.updateTime).append(this.createBy, rhs.createBy)
				.append(this.updateBy, rhs.updateBy).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.name).append(this.enable)
				.append(this.tenantId).append(this.createTime).append(this.updateTime).append(this.createBy)
				.append(this.updateBy).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("name", this.name).append("enable", this.enable)
				.append("tenantId", this.tenantId).append("createTime", this.createTime)
				.append("updateTime", this.updateTime).append("createBy", this.createBy)
				.append("updateBy", this.updateBy).toString();
	}

}
