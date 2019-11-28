



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
 * 描述：sys_script_libary实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-03-29 18:12:21
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "sys_script_libary")
public class SysScriptLibary extends BaseTenantEntity {

	@FieldDefine(title = "脚本id")
	@Id
	@Column(name = "LIB_ID_")
	protected String libId;

	@FieldDefine(title = "分类ID(表：sys_tree)")
	@Column(name = "TREE_ID_")
	protected String treeId; 
	@FieldDefine(title = "脚本全名")
	@Column(name = "FULL_CLASS_NAME_")
	protected String fullClassName; 
	@FieldDefine(title = "方法名：别名")
	@Column(name = "METHOD_")
	protected String method; 
	@FieldDefine(title = "参数：类型为json json{} ")
	@Column(name = "PARAMS_")
	protected String params; 
	@FieldDefine(title = "返回类型：java class type")
	@Column(name = "RETURN_TYPE_")
	protected String returnType; 
	@FieldDefine(title = "说明方法的详细使用")
	@Column(name = "DOS_")
	protected String dos; 
	@FieldDefine(title = "类名称")
	@Column(name = "BEAN_NAME_")
	protected String beanName;
	@FieldDefine(title = "租户id")
	@Column(name = "TENANT_ID_")
	protected String tenantId;
	@FieldDefine(title = "调用脚本")
	@Column(name = "EXAMPLE_")
	protected String example;


	public String getExample() {
		return example;
	}

	public void setExample(String example) {
		this.example = example;
	}

	public SysScriptLibary() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysScriptLibary(String in_id) {
		this.setPkId(in_id);
	}

	@Override
	public String getTenantId() {
		return tenantId;
	}

	@Override
	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}

	@Override
	public String getIdentifyLabel() {
		return this.libId;
	}

	@Override
	public Serializable getPkId() {
		return this.libId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.libId = (String) pkId;
	}
	
	public String getLibId() {
		return this.libId;
	}

	
	public void setLibId(String aValue) {
		this.libId = aValue;
	}
	
	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}
	
	/**
	 * 返回 分类ID(表：sys_tree)
	 * @return
	 */
	public String getTreeId() {
		return this.treeId;
	}
	public void setFullClassName(String fullClassName) {
		this.fullClassName = fullClassName;
	}
	
	/**
	 * 返回 脚本全名
	 * @return
	 */
	public String getFullClassName() {
		return this.fullClassName;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	
	/**
	 * 返回 方法名：别名
	 * @return
	 */
	public String getMethod() {
		return this.method;
	}
	public void setParams(String params) {
		this.params = params;
	}
	
	/**
	 * 返回 参数：类型为json json{}

	 * @return
	 */
	public String getParams() {
		return this.params;
	}
	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}
	
	/**
	 * 返回 返回类型：java class type
	 * @return
	 */
	public String getReturnType() {
		return this.returnType;
	}
	public void setDos(String dos) {
		this.dos = dos;
	}
	
	/**
	 * 返回 说明方法的详细使用
	 * @return
	 */
	public String getDos() {
		return this.dos;
	}
	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}
	
	/**
	 * 返回 类名称
	 * @return
	 */
	public String getBeanName() {
		return this.beanName;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysScriptLibary)) {
			return false;
		}
		SysScriptLibary rhs = (SysScriptLibary) object;
		return new EqualsBuilder()
		.append(this.libId, rhs.libId) 
		.append(this.treeId, rhs.treeId) 
		.append(this.fullClassName, rhs.fullClassName) 
		.append(this.method, rhs.method) 
		.append(this.params, rhs.params) 
		.append(this.returnType, rhs.returnType) 
		.append(this.dos, rhs.dos) 
		.append(this.beanName, rhs.beanName) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.libId) 
		.append(this.treeId) 
		.append(this.fullClassName) 
		.append(this.method) 
		.append(this.params) 
		.append(this.returnType) 
		.append(this.dos) 
		.append(this.beanName) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("libId", this.libId) 
				.append("treeId", this.treeId) 
				.append("fullClassName", this.fullClassName) 
				.append("method", this.method) 
				.append("params", this.params) 
				.append("returnType", this.returnType) 
				.append("dos", this.dos) 
												.append("beanName", this.beanName) 
				.toString();
	}

}



