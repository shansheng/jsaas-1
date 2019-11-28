



package com.redxun.sys.org.entity;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * <pre>
 *  
 * 描述：分级管理角色表实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-11-21 16:21:56
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "分级管理角色表")
public class OsGradeRole extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "分级管理员ID")
	@Column(name = "ADMIN_ID_")
	protected String adminId; 
	@FieldDefine(title = "组ID(角色)")
	@Column(name = "GROUP_ID_")
	protected String groupId; 
	@FieldDefine(title = "角色名称")
	@Column(name = "NAME_")
	protected String name; 
	
	
	
	
	public OsGradeRole() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public OsGradeRole(String in_id) {
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
	
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	
	/**
	 * 返回 分级管理员ID
	 * @return
	 */
	public String getAdminId() {
		return this.adminId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	/**
	 * 返回 组ID(角色)
	 * @return
	 */
	public String getGroupId() {
		return this.groupId;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof OsGradeRole)) {
			return false;
		}
		OsGradeRole rhs = (OsGradeRole) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id)
		.append(this.groupId, rhs.groupId)
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id)
		.append(this.groupId)
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
						.append("groupId", this.groupId) 
												.toString();
	}

}



