package com.redxun.bpm.core.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
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
 * 描述：关联关系实体类定义
 * 作者：mansan
 * 邮箱: ray@redxun.com
 * 日期:2017-06-29 09:59:32
 * 版权：广州红迅软件
 * </pre>
 */
@Table(name = "BPM_INST_DATA")
@TableDefine(title = "关联关系")
public class BpmInstData extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "业务对象ID")
	@Column(name = "BO_DEF_ID_")
	protected String boDefId; 
	@FieldDefine(title = "实例ID_")
	@Column(name = "INST_ID_")
	protected String instId; 
	@FieldDefine(title = "业务表主键")
	@Column(name = "PK_")
	protected String pk; 

	
	public BpmInstData() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmInstData(String in_id) {
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
	
	public void setBoDefId(String boDefId) {
		this.boDefId = boDefId;
	}
	
	/**
	 * 返回 业务对象ID
	 * @return
	 */
	public String getBoDefId() {
		return this.boDefId;
	}
	public void setInstId(String instId) {
		this.instId = instId;
	}
	
	/**
	 * 返回 实例ID_
	 * @return
	 */
	public String getInstId() {
		return this.instId;
	}
	public void setPk(String pk) {
		this.pk = pk;
	}
	
	/**
	 * 返回 业务表主键
	 * @return
	 */
	public String getPk() {
		return this.pk;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmInstData)) {
			return false;
		}
		BpmInstData rhs = (BpmInstData) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.boDefId, rhs.boDefId) 
		.append(this.instId, rhs.instId) 
		.append(this.pk, rhs.pk) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.boDefId) 
		.append(this.instId) 
		.append(this.pk) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("boDefId", this.boDefId) 
				.append("instId", this.instId) 
				.append("pk", this.pk) 
												.toString();
	}

}



