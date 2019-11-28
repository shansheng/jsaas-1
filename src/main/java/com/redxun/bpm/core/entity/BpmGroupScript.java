



package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：人员脚本实体类定义
 * 作者：ray
 * 邮箱: cmc@redxun.com
 * 日期:2017-06-01 11:33:08
 * 版权：广州红迅软件
 * </pre>
 */
@Table(name = "BPM_GROUP_SCRIPT")
@TableDefine(title = "人员脚本")
public class BpmGroupScript extends BaseTenantEntity {

	@FieldDefine(title = "脚本Id")
	@Id
	@Column(name = "SCRIPT_ID_")
	protected String scriptId;

	@FieldDefine(title = "类名")
	@Column(name = "CLASS_NAME_")
	protected String className; 
	@FieldDefine(title = "类实例名")
	@Column(name = "CLASS_INS_NAME_")
	protected String classInsName; 
	@FieldDefine(title = "方法名")
	@Column(name = "METHOD_NAME_")
	protected String methodName; 
	@FieldDefine(title = "方法描述")
	@Column(name = "METHOD_DESC_")
	protected String methodDesc; 
	@FieldDefine(title = "返回类型")
	@Column(name = "RETURN_TYPE_")
	protected String returnType; 
	@FieldDefine(title = "参数")
	@Column(name = "ARGUMENT_")
	protected String argument; 
	
	
	
	
	public BpmGroupScript() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmGroupScript(String in_id) {
		this.setPkId(in_id);
	}
	
	@Override
	public String getIdentifyLabel() {
		return this.scriptId;
	}

	@Override
	public Serializable getPkId() {
		return this.scriptId;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.scriptId = (String) pkId;
	}
	
	public String getScriptId() {
		return this.scriptId;
	}

	
	public void setScriptId(String aValue) {
		this.scriptId = aValue;
	}
	
	public void setClassName(String className) {
		this.className = className;
	}
	
	/**
	 * 返回 类名
	 * @return
	 */
	public String getClassName() {
		return this.className;
	}
	public void setClassInsName(String classInsName) {
		this.classInsName = classInsName;
	}
	
	/**
	 * 返回 类实例名
	 * @return
	 */
	public String getClassInsName() {
		return this.classInsName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	
	/**
	 * 返回 方法名
	 * @return
	 */
	public String getMethodName() {
		return this.methodName;
	}
	public void setMethodDesc(String methodDesc) {
		this.methodDesc = methodDesc;
	}
	
	/**
	 * 返回 方法描述
	 * @return
	 */
	public String getMethodDesc() {
		return this.methodDesc;
	}
	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}
	
	/**
	 * 返回 返回类型
	 * @return
	 */
	public String getReturnType() {
		return this.returnType;
	}
	public void setArgument(String argument) {
		this.argument = argument;
	}
	
	/**
	 * 返回 参数
	 * @return
	 */
	public String getArgument() {
		return this.argument;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmGroupScript)) {
			return false;
		}
		BpmGroupScript rhs = (BpmGroupScript) object;
		return new EqualsBuilder()
		.append(this.scriptId, rhs.scriptId) 
		.append(this.className, rhs.className) 
		.append(this.classInsName, rhs.classInsName) 
		.append(this.methodName, rhs.methodName) 
		.append(this.methodDesc, rhs.methodDesc) 
		.append(this.returnType, rhs.returnType) 
		.append(this.argument, rhs.argument) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.scriptId) 
		.append(this.className) 
		.append(this.classInsName) 
		.append(this.methodName) 
		.append(this.methodDesc) 
		.append(this.returnType) 
		.append(this.argument) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("scriptId", this.scriptId) 
				.append("className", this.className) 
				.append("classInsName", this.classInsName) 
				.append("methodName", this.methodName) 
				.append("methodDesc", this.methodDesc) 
				.append("returnType", this.returnType) 
				.append("argument", this.argument) 
												.toString();
	}

}



