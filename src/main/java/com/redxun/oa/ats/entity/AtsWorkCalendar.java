



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
 * 描述：工作日历实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_work_calendar")
@TableDefine(title = "工作日历")
public class AtsWorkCalendar extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "编码")
	@Column(name = "CODE")
	protected String code; 
	@FieldDefine(title = "名称")
	@Column(name = "NAME")
	protected String name; 
	@FieldDefine(title = "开始时间")
	@Column(name = "START_TIME")
	protected java.util.Date startTime; 
	@FieldDefine(title = "结束时间")
	@Column(name = "END_TIME")
	protected java.util.Date endTime; 
	@FieldDefine(title = "日历模版")
	@Column(name = "CALENDAR_TEMPL")
	protected String calendarTempl; 
	@FieldDefine(title = "法定假期")
	@Column(name = "LEGAL_HOLIDAY")
	protected String legalHoliday; 
	@FieldDefine(title = "是否默认")
	@Column(name = "IS_DEFAULT")
	protected Short isDefault = 0; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 

	//外键
	protected String calendarTemplName;
	protected String legalHolidayName;
	
	
	public String getCalendarTemplName() {
		return calendarTemplName;
	}

	public void setCalendarTemplName(String calendarTemplName) {
		this.calendarTemplName = calendarTemplName;
	}

	public String getLegalHolidayName() {
		return legalHolidayName;
	}

	public void setLegalHolidayName(String legalHolidayName) {
		this.legalHolidayName = legalHolidayName;
	}

	public AtsWorkCalendar() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsWorkCalendar(String in_id) {
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
	public void setCalendarTempl(String calendarTempl) {
		this.calendarTempl = calendarTempl;
	}
	
	/**
	 * 返回 日历模版
	 * @return
	 */
	public String getCalendarTempl() {
		return this.calendarTempl;
	}
	public void setLegalHoliday(String legalHoliday) {
		this.legalHoliday = legalHoliday;
	}
	
	/**
	 * 返回 法定假期
	 * @return
	 */
	public String getLegalHoliday() {
		return this.legalHoliday;
	}
	public void setIsDefault(Short isDefault) {
		this.isDefault = isDefault;
	}
	
	/**
	 * 返回 是否默认
	 * @return
	 */
	public Short getIsDefault() {
		return this.isDefault;
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
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsWorkCalendar)) {
			return false;
		}
		AtsWorkCalendar rhs = (AtsWorkCalendar) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.startTime, rhs.startTime) 
		.append(this.endTime, rhs.endTime) 
		.append(this.calendarTempl, rhs.calendarTempl) 
		.append(this.legalHoliday, rhs.legalHoliday) 
		.append(this.isDefault, rhs.isDefault) 
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
		.append(this.code) 
		.append(this.name) 
		.append(this.startTime) 
		.append(this.endTime) 
		.append(this.calendarTempl) 
		.append(this.legalHoliday) 
		.append(this.isDefault) 
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
				.append("code", this.code) 
				.append("name", this.name) 
				.append("startTime", this.startTime) 
				.append("endTime", this.endTime) 
				.append("calendarTempl", this.calendarTempl) 
				.append("legalHoliday", this.legalHoliday) 
				.append("isDefault", this.isDefault) 
				.append("memo", this.memo) 
												.toString();
	}

}



