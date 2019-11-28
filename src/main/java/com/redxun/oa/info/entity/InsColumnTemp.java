



package com.redxun.oa.info.entity;

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
 * 描述：栏目模板管理表实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-08-30 09:50:56
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "栏目模板管理表")
public class InsColumnTemp extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "标识键")
	@Column(name = "KEY_")
	protected String key; 
	@FieldDefine(title = "HTML模板")
	@Column(name = "TEMPLET_")
	protected String templet; 
	@FieldDefine(title = "是否系统预设")
	@Column(name = "IS_SYS_")
	protected String isSys;
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	protected String status;
	
	
	
	
	
	public InsColumnTemp() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public InsColumnTemp(String in_id) {
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
	public void setKey(String key) {
		this.key = key;
	}
	
	/**
	 * 返回 标识键
	 * @return
	 */
	public String getKey() {
		return this.key;
	}
	public void setTemplet(String templet) {
		this.templet = templet;
	}
	
	/**
	 * 返回 HTML模板
	 * @return
	 */
	public String getTemplet() {
		return this.templet;
	}
	public void setIsSys(String isSys) {
		this.isSys = isSys;
	}
	
	/**
	 * 返回 是否系统预设
	 * @return
	 */
	public String getIsSys() {
		return this.isSys;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof InsColumnTemp)) {
			return false;
		}
		InsColumnTemp rhs = (InsColumnTemp) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.key, rhs.key) 
		.append(this.templet, rhs.templet) 
		.append(this.isSys, rhs.isSys) 
		.append(this.status, rhs.status) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.key) 
		.append(this.templet) 
		.append(this.isSys) 
		.append(this.status) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("key", this.key) 
				.append("templet", this.templet) 
				.append("isSys", this.isSys) 
				.append("status", this.status) 
												.toString();
	}

}



