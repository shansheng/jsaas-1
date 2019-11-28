



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

/**
 * <pre>
 *  
 * 描述：考勤计算设置实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_attence_calculate_set")
@TableDefine(title = "考勤计算设置")
public class AtsAttenceCalculateSet extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "汇总设置")
	@Column(name = "SUMMARY")
	protected String summary; 
	@FieldDefine(title = "明细设置")
	@Column(name = "DETAIL")
	protected String detail; 
	
	protected Short type;
	
	
	public AtsAttenceCalculateSet() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsAttenceCalculateSet(String in_id) {
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
	
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	/**
	 * 返回 汇总设置
	 * @return
	 */
	public String getSummary() {
		return this.summary;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	/**
	 * 返回 明细设置
	 * @return
	 */
	public String getDetail() {
		return this.detail;
	}
	
		

	public Short getType() {
		return type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsAttenceCalculateSet)) {
			return false;
		}
		AtsAttenceCalculateSet rhs = (AtsAttenceCalculateSet) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.summary, rhs.summary) 
		.append(this.detail, rhs.detail) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.summary) 
		.append(this.detail) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("summary", this.summary) 
				.append("detail", this.detail) 
												.toString();
	}

}



