



package com.redxun.oa.info.entity;

import com.redxun.core.entity.BaseTenantEntity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import com.redxun.core.constants.MBoolean;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

import java.util.ArrayList;
import java.util.List;

/**
 * <pre>
 *  
 * 描述：系统对象授权表实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-05-02 09:55:15
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "系统对象授权表")
public class SysObjectAuthPermission extends BaseTenantEntity {
	
	public static final String TYPE_ALL = "everyone";
	public static final String TYPE_USER = "user";
	public static final String TYPE_GROUP = "group";
	public static final String TYPE_SUBGROUP = "subGroup";

	@FieldDefine(title = "ID_")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "消息提醒id")
	@Column(name = "OBJECT_ID_")
	protected String objectId; 
	@FieldDefine(title = "AUTH_TYPE_")
	@Column(name = "AUTH_TYPE_")
	protected String authType; 
	@FieldDefine(title = "类型(org，user，everyone)")
	@Column(name = "TYPE_")
	protected String type;
	@FieldDefine(title = "被授权人ID")
	@Column(name = "AUTH_ID_")
	protected String authId; 
	@FieldDefine(title = "被授权名称")
	@Column(name = "AUTH_NAME_")
	protected String authName; 
	
	
	
	
	
	public SysObjectAuthPermission() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysObjectAuthPermission(String in_id) {
		this.setPkId(in_id);
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
	
	public String getId() {
		return this.id;
	}

	
	public void setId(String aValue) {
		this.id = aValue;
	}
	
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	
	/**
	 * 返回 消息提醒id
	 * @return
	 */
	public String getObjectId() {
		return this.objectId;
	}
	public void setAuthType(String authType) {
		this.authType = authType;
	}
	
	/**
	 * 返回 AUTH_TYPE_
	 * @return
	 */
	public String getAuthType() {
		return this.authType;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 授权类型
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	
	/**
	 * 返回 被授权人ID
	 * @return
	 */
	public String getAuthId() {
		return this.authId;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	
	/**
	 * 返回 被授权名称
	 * @return
	 */
	public String getAuthName() {
		return this.authName;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysObjectAuthPermission)) {
			return false;
		}
		SysObjectAuthPermission rhs = (SysObjectAuthPermission) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.objectId, rhs.objectId) 
		.append(this.authType, rhs.authType) 
		.append(this.type, rhs.type) 
		.append(this.authId, rhs.authId) 
		.append(this.authName, rhs.authName) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.objectId) 
		.append(this.authType) 
		.append(this.type) 
		.append(this.authId) 
		.append(this.authName) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("objectId", this.objectId) 
				.append("authType", this.authType) 
				.append("type", this.type) 
				.append("authId", this.authId) 
				.append("authName", this.authName) 
												.toString();
	}

}



