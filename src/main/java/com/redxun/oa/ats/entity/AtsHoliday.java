



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
 * 描述：考勤请假单实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_holiday")
@TableDefine(title = "考勤请假单")
public class AtsHoliday extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "用户ID")
	@Column(name = "USER_ID")
	protected String userId; 
	@FieldDefine(title = "请假类型")
	@Column(name = "HOLIDAY_TYPE")
	protected String holidayType; 
	@FieldDefine(title = "开始时间")
	@Column(name = "START_TIME")
	protected java.util.Date startTime; 
	@FieldDefine(title = "结束时间")
	@Column(name = "END_TIME")
	protected java.util.Date endTime; 
	@FieldDefine(title = "请假时间")
	@Column(name = "HOLIDAY_TIME")
	protected Double holidayTime; 
	@FieldDefine(title = "时间长度")
	@Column(name = "DURATION")
	protected Short duration; 
	@FieldDefine(title = "流程运行ID")
	@Column(name = "RUN_ID")
	protected Long runId; 
	
	
	
	
	public AtsHoliday() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsHoliday(String in_id) {
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
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	/**
	 * 返回 用户ID
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	public void setHolidayType(String holidayType) {
		this.holidayType = holidayType;
	}
	
	/**
	 * 返回 请假类型
	 * @return
	 */
	public String getHolidayType() {
		return this.holidayType;
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
	public void setHolidayTime(Double holidayTime) {
		this.holidayTime = holidayTime;
	}
	
	/**
	 * 返回 请假时间
	 * @return
	 */
	public Double getHolidayTime() {
		return this.holidayTime;
	}
	public void setDuration(Short duration) {
		this.duration = duration;
	}
	
	/**
	 * 返回 时间长度
	 * @return
	 */
	public Short getDuration() {
		return this.duration;
	}
	public void setRunId(Long runId) {
		this.runId = runId;
	}
	
	/**
	 * 返回 流程运行ID
	 * @return
	 */
	public Long getRunId() {
		return this.runId;
	}
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsHoliday)) {
			return false;
		}
		AtsHoliday rhs = (AtsHoliday) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.userId, rhs.userId) 
		.append(this.holidayType, rhs.holidayType) 
		.append(this.startTime, rhs.startTime) 
		.append(this.endTime, rhs.endTime) 
		.append(this.holidayTime, rhs.holidayTime) 
		.append(this.duration, rhs.duration) 
		.append(this.runId, rhs.runId) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.userId) 
		.append(this.holidayType) 
		.append(this.startTime) 
		.append(this.endTime) 
		.append(this.holidayTime) 
		.append(this.duration) 
		.append(this.runId) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("userId", this.userId) 
				.append("holidayType", this.holidayType) 
				.append("startTime", this.startTime) 
				.append("endTime", this.endTime) 
				.append("holidayTime", this.holidayTime) 
				.append("duration", this.duration) 
				.append("runId", this.runId) 
												.toString();
	}

}



