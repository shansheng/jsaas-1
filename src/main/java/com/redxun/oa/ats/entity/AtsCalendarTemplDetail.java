



package com.redxun.oa.ats.entity;

import java.io.Serializable;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：日历模版明细实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-22 09:49:46
 * 版权：广州红迅软件
 * </pre>
 */

public class AtsCalendarTemplDetail extends BaseTenantEntity {


	protected String id;


	protected Short week; 

	protected Short dayType; 

	protected String memo; 
	
	protected String calendarId;
	
	
	
	public AtsCalendarTemplDetail() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsCalendarTemplDetail(String in_id) {
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
	
	public void setWeek(Short week) {
		this.week = week;
	}
	
	/**
	 * 返回 星期
	 * @return
	 */
	public Short getWeek() {
		return this.week;
	}
	public void setDayType(Short dayType) {
		this.dayType = dayType;
	}
	
	/**
	 * 返回 日期类型
	 * @return
	 */
	public Short getDayType() {
		return this.dayType;
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
	
	
	
	
	
	/**
	 * 外键 
	 * @return String
	 */
	public String getCalendarId() {
		return this.calendarId;
	}

	/**
	 * 设置 外键
	 */
	public void setCalendarId(String aValue) {
		this.calendarId=aValue;
	}
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsCalendarTemplDetail)) {
			return false;
		}
		AtsCalendarTemplDetail rhs = (AtsCalendarTemplDetail) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.week, rhs.week) 
		.append(this.dayType, rhs.dayType) 
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
		.append(this.week) 
		.append(this.dayType) 
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
						.append("week", this.week) 
				.append("dayType", this.dayType) 
				.append("memo", this.memo) 
												.toString();
	}

}



