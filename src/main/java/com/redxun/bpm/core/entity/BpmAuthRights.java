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
 * 描述：BpmAuthRights实体类定义
 * 流程定义授权
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Table(name = "BPM_AUTH_RIGHTS")
@TableDefine(title = "流程定义授权")
public class BpmAuthRights extends BaseTenantEntity {

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 设定id */
	@FieldDefine(title = "设定id")
	@Column(name = "SETTING_ID_")
	@Size(max = 50)
	protected String settingId;
	/* 权限类型(def,流程定义,inst,流程实例,task,待办任务,start,发起流程) */
	@FieldDefine(title = "权限类型")
	@Column(name = "RIGHT_TYPE_")
	@Size(max = 50)
	protected String rightType;
	/* 授权类型(all,全部,user,用户,group,用户组) */
	@FieldDefine(title = "授权类型(all,全部,user,用户,group,用户组)")
	@Column(name = "TYPE_")
	@Size(max = 50)
	protected String type;
	/* 授权对象ID */
	@FieldDefine(title = "授权对象ID")
	@Column(name = "AUTH_ID_")
	@Size(max = 50)
	protected String authId;
	/* 授权对象名称 */
	@FieldDefine(title = "授权对象名称")
	@Column(name = "AUTH_NAME_")
	@Size(max = 50)
	protected String authName;

	/**
	 * Default Empty Constructor for class BpmAuthRights
	 */
	public BpmAuthRights() {
		super();
	}

	/**
	 * Default Key Fields Constructor for class BpmAuthRights
	 */
	public BpmAuthRights(String in_id) {
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
	 * 设定id * @return String
	 */
	public String getSettingId() {
		return this.settingId;
	}

	/**
	 * 设置 设定id
	 */
	public void setSettingId(String aValue) {
		this.settingId = aValue;
	}

	/**
	 * 权限类型(def,流程定义,inst,流程实例,task,待办任务,start,发起流程) * @return String
	 */
	public String getRightType() {
		return this.rightType;
	}

	/**
	 * 设置 权限类型(def,流程定义,inst,流程实例,task,待办任务,start,发起流程)
	 */
	public void setRightType(String aValue) {
		this.rightType = aValue;
	}

	/**
	 * 授权类型(all,全部,user,用户,group,用户组) * @return String
	 */
	public String getType() {
		return this.type;
	}

	/**
	 * 设置 授权类型(all,全部,user,用户,group,用户组)
	 */
	public void setType(String aValue) {
		this.type = aValue;
	}

	/**
	 * 授权对象ID * @return String
	 */
	public String getAuthId() {
		return this.authId;
	}

	/**
	 * 设置 授权对象ID
	 */
	public void setAuthId(String aValue) {
		this.authId = aValue;
	}

	/**
	 * 授权对象名称 * @return String
	 */
	public String getAuthName() {
		return this.authName;
	}

	/**
	 * 设置 授权对象名称
	 */
	public void setAuthName(String aValue) {
		this.authName = aValue;
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
		if (!(object instanceof BpmAuthRights)) {
			return false;
		}
		BpmAuthRights rhs = (BpmAuthRights) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.settingId, rhs.settingId)
				.append(this.rightType, rhs.rightType).append(this.type, rhs.type).append(this.authId, rhs.authId)
				.append(this.authName, rhs.authName).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.settingId).append(this.rightType)
				.append(this.type).append(this.authId).append(this.authName).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("settingId", this.settingId)
				.append("rightType", this.rightType).append("type", this.type).append("authId", this.authId)
				.append("authName", this.authName).toString();
	}

}
