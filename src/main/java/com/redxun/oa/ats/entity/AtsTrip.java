



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
 * 描述：考勤出差单实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_trip")
@TableDefine(title = "考勤出差单")
public class AtsTrip extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "用户ID")
	@Column(name = "USER_ID")
	protected String userId; 
	@FieldDefine(title = "出差类型")
	@Column(name = "TRIP_TYPE")
	protected String tripType; 
	@FieldDefine(title = "开始时间")
	@Column(name = "START_TIME")
	protected java.util.Date startTime; 
	@FieldDefine(title = "结束时间")
	@Column(name = "END_TIME")
	protected java.util.Date endTime; 
	@FieldDefine(title = "出差时间")
	@Column(name = "TRIP_TIME")
	protected Double tripTime; 
	@FieldDefine(title = "流程运行ID")
	@Column(name = "RUN_ID")
	protected Long runId; 
	
	
	
	
	public AtsTrip() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsTrip(String in_id) {
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
	public void setTripType(String tripType) {
		this.tripType = tripType;
	}
	
	/**
	 * 返回 出差类型
	 * @return
	 */
	public String getTripType() {
		return this.tripType;
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
	public void setTripTime(Double tripTime) {
		this.tripTime = tripTime;
	}
	
	/**
	 * 返回 出差时间
	 * @return
	 */
	public Double getTripTime() {
		return this.tripTime;
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
		if (!(object instanceof AtsTrip)) {
			return false;
		}
		AtsTrip rhs = (AtsTrip) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.userId, rhs.userId) 
		.append(this.tripType, rhs.tripType) 
		.append(this.startTime, rhs.startTime) 
		.append(this.endTime, rhs.endTime) 
		.append(this.tripTime, rhs.tripTime) 
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
		.append(this.tripType) 
		.append(this.startTime) 
		.append(this.endTime) 
		.append(this.tripTime) 
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
				.append("tripType", this.tripType) 
				.append("startTime", this.startTime) 
				.append("endTime", this.endTime) 
				.append("tripTime", this.tripTime) 
				.append("runId", this.runId) 
												.toString();
	}

}



