



package com.redxun.sys.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：执行脚本配置实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2018-10-18 11:06:29
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "执行脚本配置")
public class SysInvokeScript extends BaseTenantEntity {

	@FieldDefine(title = "ID_")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "分类ID")
	@Column(name = "CATEGROY_ID_")
	protected String categroyId; 
	@FieldDefine(title = " 名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "别名")
	@Column(name = "ALIAS_")
	protected String alias; 
	@FieldDefine(title = "脚本内容")
	@Column(name = "CONTENT_")
	protected String content; 
	
	
	
	
	
	public SysInvokeScript() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysInvokeScript(String in_id) {
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
	
	public void setCategroyId(String categroyId) {
		this.categroyId = categroyId;
	}
	
	/**
	 * 返回 分类ID
	 * @return
	 */
	public String getCategroyId() {
		return this.categroyId;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回  名称
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
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * 返回 脚本内容
	 * @return
	 */
	public String getContent() {
		return this.content;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysInvokeScript)) {
			return false;
		}
		SysInvokeScript rhs = (SysInvokeScript) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.categroyId, rhs.categroyId) 
		.append(this.name, rhs.name) 
		.append(this.alias, rhs.alias) 
		.append(this.content, rhs.content) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.categroyId) 
		.append(this.name) 
		.append(this.alias) 
		.append(this.content) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("categroyId", this.categroyId) 
				.append("name", this.name) 
				.append("alias", this.alias) 
				.append("content", this.content) 
												.toString();
	}

}



