



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
import java.util.ArrayList;
import java.util.List;

/**
 * <pre>
 *  
 * 描述：分级管理员表实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-11-21 16:21:56
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "分级管理员表")
public class OsGradeAdmin extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "组ID(行政维度)")
	@Column(name = "GROUP_ID_")
	protected String groupId; 
	@FieldDefine(title = "用户ID")
	@Column(name = "USER_ID_")
	protected String userId; 
	@FieldDefine(title = "用户名")
	@Column(name = "FULLNAME_")
	protected String fullname; 
	@FieldDefine(title = "父ID")
	@Column(name = "PARENT_ID_")
	protected String parentId = "0"; 
	@FieldDefine(title = "层次")
	@Column(name = "DEPTH_")
	protected Integer depth = 1; 
	@FieldDefine(title = "路径")
	@Column(name = "PATH_")
	protected String path; 
	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn = 1; 
	@FieldDefine(title = "子节点")
	@Column(name = "CHILDS_")
	protected Integer childs = 0; 
	
	@FieldDefine(title = "分级管理角色表")
	protected List<OsGradeRole> osGradeRoles = new ArrayList<OsGradeRole>();

	@FieldDefine(title = "角色名称")
	@Column(name = "ROLENAME_")
	protected String roleName;




	public OsGradeAdmin() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public OsGradeAdmin(String in_id) {
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
	
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	/**
	 * 返回 组ID(行政维度)
	 * @return
	 */
	public String getGroupId() {
		return this.groupId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**
	 * 返回 用户ID
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	
	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	/**
	 * 返回 父ID
	 * @return
	 */
	public String getParentId() {
		return this.parentId;
	}
	public void setDepth(Integer depth) {
		this.depth = depth;
	}
	
	/**
	 * 返回 层次
	 * @return
	 */
	public Integer getDepth() {
		return this.depth;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	/**
	 * 返回 路径
	 * @return
	 */
	public String getPath() {
		return this.path;
	}
	public void setSn(Integer sn) {
		this.sn = sn;
	}
	
	/**
	 * 返回 序号
	 * @return
	 */
	public Integer getSn() {
		return this.sn;
	}
	public void setChilds(Integer childs) {
		this.childs = childs;
	}
	
	/**
	 * 返回 子节点
	 * @return
	 */
	public Integer getChilds() {
		return this.childs;
	}
	
	public List<OsGradeRole> getOsGradeRoles() {
		return osGradeRoles;
	}

	public void setOsGradeRoles(List<OsGradeRole> in_osGradeRole) {
		this.osGradeRoles = in_osGradeRole;
	}


	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof OsGradeAdmin)) {
			return false;
		}
		OsGradeAdmin rhs = (OsGradeAdmin) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id)
		.append(this.groupId, rhs.groupId)
		.append(this.userId, rhs.userId)
		.append(this.parentId, rhs.parentId)
		.append(this.depth, rhs.depth)
		.append(this.path, rhs.path)
		.append(this.sn, rhs.sn)
		.append(this.childs, rhs.childs)
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id)
		.append(this.groupId)
		.append(this.userId)
		.append(this.parentId)
		.append(this.depth)
		.append(this.path)
		.append(this.sn)
		.append(this.childs)
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("groupId", this.groupId) 
				.append("userId", this.userId) 
				.append("parentId", this.parentId) 
				.append("depth", this.depth) 
				.append("path", this.path) 
				.append("sn", this.sn) 
				.append("childs", this.childs) 
												.toString();
	}

}



