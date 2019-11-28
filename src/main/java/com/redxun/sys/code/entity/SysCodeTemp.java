



package com.redxun.sys.code.entity;

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
 * 描述：模板文件管理表实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-11-01 16:22:39
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "模板文件管理表")
public class SysCodeTemp extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "别名")
	@Column(name = "ALIAS_")
	protected String alias; 
	@FieldDefine(title = "文件路径")
	@Column(name = "PATH_")
	protected String path; 
	@FieldDefine(title = "文件路径")
	@Column(name = "SUFFIX_")
	protected String suffix; 
	
	
	
	
	public SysCodeTemp() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysCodeTemp(String in_id) {
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
	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	/**
	 * 返回 别名
	 * @return
	 */
	public String getAlias() {
		return this.alias;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	/**
	 * 返回 文件路径
	 * @return
	 */
	public String getPath() {
		return this.path;
	}
	
	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysCodeTemp)) {
			return false;
		}
		SysCodeTemp rhs = (SysCodeTemp) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.alias, rhs.alias) 
		.append(this.path, rhs.path) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.alias) 
		.append(this.path) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("alias", this.alias) 
				.append("path", this.path) 
												.toString();
	}

}



