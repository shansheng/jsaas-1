



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.EqualsBuilder;

/**
 * <pre>
 *  
 * 描述：法定节假日明细实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-22 16:48:34
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_legal_holiday_detail")
@TableDefine(title = "法定节假日明细")
public class AtsLegalHolidayDetail extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "假日名称")
	@Column(name = "NAME")
	protected String name; 
	@FieldDefine(title = "开始时间")
	@Column(name = "START_TIME")
	protected java.util.Date startTime; 
	@FieldDefine(title = "结束时间")
	@Column(name = "END_TIME")
	protected java.util.Date endTime; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	
	
	@FieldDefine(title = "法定节假日")
	@ManyToOne
	@JoinColumn(name = "holiday_id")
	protected  com.redxun.oa.ats.entity.AtsLegalHoliday atsLegalHoliday;	
	
	
	public AtsLegalHolidayDetail() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsLegalHolidayDetail(String in_id) {
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
	 * 返回 假日名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setStartTime(java.util.Date startTime) {
		this.startTime = startTime;
	}
	
	/**
	 * 返回 开始时间
	 * @return
	 */
	public java.util.Date getStartTime() {
		return this.startTime;
	}
	public void setEndTime(java.util.Date endTime) {
		this.endTime = endTime;
	}
	
	/**
	 * 返回 结束时间
	 * @return
	 */
	public java.util.Date getEndTime() {
		return this.endTime;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	/**
	 * 返回 描述
	 * @return
	 */
	public String getMemo() {
		return this.memo;
	}
	
	
	
	public com.redxun.oa.ats.entity.AtsLegalHoliday getAtsLegalHoliday() {
		return atsLegalHoliday;
	}

	public void setAtsLegalHoliday(com.redxun.oa.ats.entity.AtsLegalHoliday in_atsLegalHoliday) {
		this.atsLegalHoliday = in_atsLegalHoliday;
	}
	
	/**
	 * 外键 
	 * @return String
	 */
	public String getHolidayId() {
		return this.getAtsLegalHoliday() == null ? null : this.getAtsLegalHoliday().getId();
	}

	/**
	 * 设置 外键
	 */
	public void setHolidayId(String aValue) {
		if (aValue == null) {
			atsLegalHoliday = null;
		} else if (atsLegalHoliday == null) {
			atsLegalHoliday = new com.redxun.oa.ats.entity.AtsLegalHoliday(aValue);
		} else {
			atsLegalHoliday.setId(aValue);
		}
	}
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsLegalHolidayDetail)) {
			return false;
		}
		AtsLegalHolidayDetail rhs = (AtsLegalHolidayDetail) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.startTime, rhs.startTime) 
		.append(this.endTime, rhs.endTime) 
		.append(this.memo, rhs.memo) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.startTime) 
		.append(this.endTime) 
		.append(this.memo) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
						.append("name", this.name) 
				.append("startTime", this.startTime) 
				.append("endTime", this.endTime) 
				.append("memo", this.memo) 
												.toString();
	}

	
}



