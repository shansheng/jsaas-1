



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;

import java.io.Serializable;
import java.util.Date;

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
 * 描述：班次时间设置实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-26 13:55:50
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_shift_time")
@TableDefine(title = "班次时间设置")
public class AtsShiftTime extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "段次")
	@Column(name = "SEGMENT")
	protected Short segment; 
	@FieldDefine(title = "出勤类型")
	@Column(name = "ATTENDANCE_TYPE")
	protected Short attendanceType; 
	@FieldDefine(title = "上班时间")
	@Column(name = "ON_TIME")
	protected Date onTime; 
	@FieldDefine(title = "上班是否打卡")
	@Column(name = "ON_PUNCH_CARD")
	protected Short onPunchCard; 
	@FieldDefine(title = "上班浮动调整值（分）")
	@Column(name = "ON_FLOAT_ADJUST")
	protected Double onFloatAdjust; 
	@FieldDefine(title = "段内休息时间")
	@Column(name = "SEGMENT_REST")
	protected Double segmentRest; 
	@FieldDefine(title = "下班时间")
	@Column(name = "OFF_TIME")
	protected Date offTime; 
	@FieldDefine(title = "下班是否打卡")
	@Column(name = "OFF_PUNCH_CARD")
	protected Short offPunchCard; 
	@FieldDefine(title = "下班浮动调整值（分）")
	@Column(name = "OFF_FLOAT_ADJUST")
	protected Double offFloatAdjust; 
	@FieldDefine(title = "上班类型")
	@Column(name = "ON_TYPE")
	protected Short onType; 
	@FieldDefine(title = "下班类型")
	@Column(name = "OFF_TYPE")
	protected Short offType; 
	
	
	@FieldDefine(title = "班次设置")
	@ManyToOne
	@JoinColumn(name = "shift_id")
	protected  com.redxun.oa.ats.entity.AtsShiftInfo atsShiftInfo;	
	
	
	public AtsShiftTime() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsShiftTime(String in_id) {
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
	
	public void setSegment(Short segment) {
		this.segment = segment;
	}
	
	/**
	 * 返回 段次
	 * @return
	 */
	public Short getSegment() {
		return this.segment;
	}
	public void setAttendanceType(Short attendanceType) {
		this.attendanceType = attendanceType;
	}
	
	/**
	 * 返回 出勤类型
	 * @return
	 */
	public Short getAttendanceType() {
		return this.attendanceType;
	}
	public void setOnTime(Date onTime) {
		this.onTime = onTime;
	}
	
	/**
	 * 返回 上班时间
	 * @return
	 */
	public Date getOnTime() {
		return this.onTime;
	}
	public void setOnPunchCard(Short onPunchCard) {
		this.onPunchCard = onPunchCard;
	}
	
	/**
	 * 返回 上班是否打卡
	 * @return
	 */
	public Short getOnPunchCard() {
		return this.onPunchCard;
	}
	public void setOnFloatAdjust(Double onFloatAdjust) {
		this.onFloatAdjust = onFloatAdjust;
	}
	
	/**
	 * 返回 上班浮动调整值（分）
	 * @return
	 */
	public Double getOnFloatAdjust() {
		return this.onFloatAdjust;
	}
	public void setSegmentRest(Double segmentRest) {
		this.segmentRest = segmentRest;
	}
	
	/**
	 * 返回 段内休息时间
	 * @return
	 */
	public Double getSegmentRest() {
		return this.segmentRest;
	}
	public void setOffTime(Date offTime) {
		this.offTime = offTime;
	}
	
	/**
	 * 返回 下班时间
	 * @return
	 */
	public Date getOffTime() {
		return this.offTime;
	}
	public void setOffPunchCard(Short offPunchCard) {
		this.offPunchCard = offPunchCard;
	}
	
	/**
	 * 返回 下班是否打卡
	 * @return
	 */
	public Short getOffPunchCard() {
		return this.offPunchCard;
	}
	public void setOffFloatAdjust(Double offFloatAdjust) {
		this.offFloatAdjust = offFloatAdjust;
	}
	
	/**
	 * 返回 下班浮动调整值（分）
	 * @return
	 */
	public Double getOffFloatAdjust() {
		return this.offFloatAdjust;
	}
	public void setOnType(Short onType) {
		this.onType = onType;
	}
	
	/**
	 * 返回 上班类型
	 * @return
	 */
	public Short getOnType() {
		return this.onType;
	}
	public void setOffType(Short offType) {
		this.offType = offType;
	}
	
	/**
	 * 返回 下班类型
	 * @return
	 */
	public Short getOffType() {
		return this.offType;
	}
	
	
	
	public com.redxun.oa.ats.entity.AtsShiftInfo getAtsShiftInfo() {
		return atsShiftInfo;
	}

	public void setAtsShiftInfo(com.redxun.oa.ats.entity.AtsShiftInfo in_atsShiftInfo) {
		this.atsShiftInfo = in_atsShiftInfo;
	}
	
	/**
	 * 外键 
	 * @return String
	 */
	public String getShiftId() {
		return this.getAtsShiftInfo() == null ? null : this.getAtsShiftInfo().getId();
	}

	/**
	 * 设置 外键
	 */
	public void setShiftId(String aValue) {
		if (aValue == null) {
			atsShiftInfo = null;
		} else if (atsShiftInfo == null) {
			atsShiftInfo = new com.redxun.oa.ats.entity.AtsShiftInfo(aValue);
		} else {
			atsShiftInfo.setId(aValue);
		}
	}
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsShiftTime)) {
			return false;
		}
		AtsShiftTime rhs = (AtsShiftTime) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.segment, rhs.segment) 
		.append(this.attendanceType, rhs.attendanceType) 
		.append(this.onTime, rhs.onTime) 
		.append(this.onPunchCard, rhs.onPunchCard) 
		.append(this.onFloatAdjust, rhs.onFloatAdjust) 
		.append(this.segmentRest, rhs.segmentRest) 
		.append(this.offTime, rhs.offTime) 
		.append(this.offPunchCard, rhs.offPunchCard) 
		.append(this.offFloatAdjust, rhs.offFloatAdjust) 
		.append(this.onType, rhs.onType) 
		.append(this.offType, rhs.offType) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.segment) 
		.append(this.attendanceType) 
		.append(this.onTime) 
		.append(this.onPunchCard) 
		.append(this.onFloatAdjust) 
		.append(this.segmentRest) 
		.append(this.offTime) 
		.append(this.offPunchCard) 
		.append(this.offFloatAdjust) 
		.append(this.onType) 
		.append(this.offType) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
						.append("segment", this.segment) 
				.append("attendanceType", this.attendanceType) 
				.append("onTime", this.onTime) 
				.append("onPunchCard", this.onPunchCard) 
				.append("onFloatAdjust", this.onFloatAdjust) 
				.append("segmentRest", this.segmentRest) 
				.append("offTime", this.offTime) 
				.append("offPunchCard", this.offPunchCard) 
				.append("offFloatAdjust", this.offFloatAdjust) 
				.append("onType", this.onType) 
				.append("offType", this.offType) 
												.toString();
	}

}



