



package com.redxun.sys.org.entity;

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
 * 描述：用户类型实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-09-03 14:21:10
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "用户类型")
public class OsUserType extends BaseTenantEntity {

	@FieldDefine(title = "ID_")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "编码")
	@Column(name = "CODE_")
	protected String code; 
	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "描述")
	@Column(name = "DESCP_")
	protected String descp; 
	@FieldDefine(title = "GROUP_ID_")
	@Column(name = "GROUP_ID_")
	protected String groupId; 
	
	
	
	
	
	public OsUserType() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public OsUserType(String in_id) {
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
	
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * 返回 编码
	 * @return
	 */
	public String getCode() {
		return this.code;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回 名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setDescp(String descp) {
		this.descp = descp;
	}
	
	/**
	 * 返回 描述
	 * @return
	 */
	public String getDescp() {
		return this.descp;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	/**
	 * 返回 GROUP_ID_
	 * @return
	 */
	public String getGroupId() {
		return this.groupId;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof OsUserType)) {
			return false;
		}
		OsUserType rhs = (OsUserType) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.descp, rhs.descp) 
		.append(this.groupId, rhs.groupId) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.code) 
		.append(this.name) 
		.append(this.descp) 
		.append(this.groupId) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("code", this.code) 
				.append("name", this.name) 
				.append("descp", this.descp) 
				.append("groupId", this.groupId) 
												.toString();
	}

}



