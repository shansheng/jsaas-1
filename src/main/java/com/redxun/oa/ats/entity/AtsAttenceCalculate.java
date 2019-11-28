



package com.redxun.oa.ats.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

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
import com.redxun.core.util.DateFormatUtil;

/**
 * <pre>
 *  
 * 描述：考勤计算实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-28 15:47:59
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_attence_calculate")
@TableDefine(title = "考勤计算")
public class AtsAttenceCalculate extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "考勤档案")
	@Column(name = "FILE_ID")
	protected String fileId; 
	@FieldDefine(title = "考勤日期")
	@Column(name = "ATTENCE_TIME")
	protected java.util.Date attenceTime; 
	@FieldDefine(title = "是否排班")
	@Column(name = "IS_SCHEDULE_SHIFT")
	protected Short isScheduleShift; 
	@FieldDefine(title = "日期类型")
	@Column(name = "DATE_TYPE")
	protected Short dateType; 
	@FieldDefine(title = "假期名称")
	@Column(name = "HOLIDAY_NAME")
	protected String holidayName; 
	@FieldDefine(title = "是否有打卡记录")
	@Column(name = "IS_CARD_RECORD")
	protected Short isCardRecord; 
	@FieldDefine(title = "考勤时间")
	@Column(name = "SHIFT_TIME")
	protected String shiftTime; 
	@FieldDefine(title = "应出勤时数")
	@Column(name = "SHOULD_ATTENCE_HOURS")
	protected Double shouldAttenceHours; 
	@FieldDefine(title = "实际出勤时数")
	@Column(name = "ACTUAL_ATTENCE_HOURS")
	protected Double actualAttenceHours; 
	@FieldDefine(title = "有效打卡记录")
	@Column(name = "CARD_RECORD")
	protected String cardRecord; 
	@FieldDefine(title = "旷工次数")
	@Column(name = "ABSENT_NUMBER")
	protected Double absentNumber; 
	@FieldDefine(title = "旷工小时数")
	@Column(name = "ABSENT_TIME")
	protected Double absentTime; 
	@FieldDefine(title = "旷工记录")
	@Column(name = "ABSENT_RECORD")
	protected String absentRecord; 
	@FieldDefine(title = "迟到次数")
	@Column(name = "LATE_NUMBER")
	protected Double lateNumber; 
	@FieldDefine(title = "迟到分钟数")
	@Column(name = "LATE_TIME")
	protected Double lateTime; 
	@FieldDefine(title = "迟到记录")
	@Column(name = "LATE_RECORD")
	protected String lateRecord; 
	@FieldDefine(title = "早退次数")
	@Column(name = "LEAVE_NUMBER")
	protected Double leaveNumber; 
	@FieldDefine(title = "早退分钟数")
	@Column(name = "LEAVE_TIME")
	protected Double leaveTime; 
	@FieldDefine(title = "早退记录")
	@Column(name = "LEAVE_RECORD")
	protected String leaveRecord; 
	@FieldDefine(title = "加班次数")
	@Column(name = "OT_NUMBER")
	protected Double otNumber; 
	@FieldDefine(title = "加班分钟数")
	@Column(name = "OT_TIME")
	protected Double otTime; 
	@FieldDefine(title = "加班记录")
	@Column(name = "OT_RECORD")
	protected String otRecord; 
	@FieldDefine(title = "请假次数")
	@Column(name = "HOLIDAY_NUMBER")
	protected Double holidayNumber; 
	@FieldDefine(title = "请假分钟数")
	@Column(name = "HOLIDAY_TIME")
	protected Double holidayTime; 
	@FieldDefine(title = "请假时间单位")
	@Column(name = "HOLIDAY_UNIT")
	protected Short holidayUnit; 
	@FieldDefine(title = "请假记录")
	@Column(name = "HOLIDAY_RECORD")
	protected String holidayRecord; 
	@FieldDefine(title = "出差次数")
	@Column(name = "TRIP_NUMBER")
	protected Double tripNumber; 
	@FieldDefine(title = "出差分钟数")
	@Column(name = "TRIP_TIME")
	protected Double tripTime; 
	@FieldDefine(title = "出差记录")
	@Column(name = "TRIP_RECORD")
	protected String tripRecord; 
	@FieldDefine(title = "有效打卡记录")
	@Column(name = "VALID_CARD_RECORD")
	protected String validCardRecord; 
	@FieldDefine(title = "考勤类型")
	@Column(name = "ATTENCE_TYPE")
	protected String attenceType; 
	@FieldDefine(title = "班次")
	@Column(name = "SHIFT_ID")
	protected String shiftId; 
	//班次名称
    protected String shiftName;
	@FieldDefine(title = "ABNORMITY")
	@Column(name = "ABNORMITY")
	protected Short abnormity = AbnormityType.normal; 
	
	//用户ID
	protected String userId;
	// 非数据库字段
	protected String userName;
	protected Long orgId;
	protected String orgName;
	protected String account;
	
	protected String shiftTime11;
	protected String shiftTime12;
	protected String shiftTime21;
	protected String shiftTime22;
	protected String shiftTime31;
	protected String shiftTime32;

	protected String absentRecord11;
	protected String absentRecord12;
	protected String absentRecord21;
	protected String absentRecord22;
	protected String absentRecord31;
	protected String absentRecord32;

	protected String unit;
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserId() {
		return userId;
	}
	
	
	public AtsAttenceCalculate() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsAttenceCalculate(String in_id) {
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
	
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	
	/**
	 * 返回 考勤档案
	 * @return
	 */
	public String getFileId() {
		return this.fileId;
	}
	public void setAttenceTime(java.util.Date attenceTime) {
		this.attenceTime = attenceTime;
	}
	
	/**
	 * 返回 考勤日期
	 * @return
	 */
	public java.util.Date getAttenceTime() {
		return this.attenceTime;
	}
	public void setIsScheduleShift(Short isScheduleShift) {
		this.isScheduleShift = isScheduleShift;
	}
	
	/**
	 * 返回 是否排班
	 * @return
	 */
	public Short getIsScheduleShift() {
		return this.isScheduleShift;
	}
	public void setDateType(Short dateType) {
		this.dateType = dateType;
	}
	
	/**
	 * 返回 日期类型
	 * @return
	 */
	public Short getDateType() {
		return this.dateType;
	}
	public void setHolidayName(String holidayName) {
		this.holidayName = holidayName;
	}
	
	/**
	 * 返回 假期名称
	 * @return
	 */
	public String getHolidayName() {
		return this.holidayName;
	}
	public void setIsCardRecord(Short isCardRecord) {
		this.isCardRecord = isCardRecord;
	}
	
	/**
	 * 返回 是否有打卡记录
	 * @return
	 */
	public Short getIsCardRecord() {
		return this.isCardRecord;
	}
	public void setShiftTime(String shiftTime) {
		this.shiftTime = shiftTime;
	}
	
	/**
	 * 返回 考勤时间
	 * @return
	 */
	public String getShiftTime() {
		return this.shiftTime;
	}
	public void setShouldAttenceHours(Double shouldAttenceHours) {
		this.shouldAttenceHours = shouldAttenceHours;
	}
	
	/**
	 * 返回 应出勤时数
	 * @return
	 */
	public Double getShouldAttenceHours() {
		return this.shouldAttenceHours;
	}
	public void setActualAttenceHours(Double actualAttenceHours) {
		this.actualAttenceHours = actualAttenceHours;
	}
	
	/**
	 * 返回 实际出勤时数
	 * @return
	 */
	public Double getActualAttenceHours() {
		return this.actualAttenceHours;
	}
	public void setCardRecord(String cardRecord) {
		this.cardRecord = cardRecord;
	}
	
	public void setCardRecord(Set<Date> cardRecordSet) {
		StringBuffer sb = new StringBuffer();
		for (Date date : cardRecordSet) {
			sb.append(DateFormatUtil.format(date, "yyyy-MM-dd") + "|");
		}
		setCardRecord(sb.toString());
	}
	/**
	 * 返回 有效打卡记录
	 * @return
	 */
	public String getCardRecord() {
		return this.cardRecord;
	}
	public void setAbsentNumber(Double absentNumber) {
		this.absentNumber = absentNumber;
	}
	
	/**
	 * 返回 旷工次数
	 * @return
	 */
	public Double getAbsentNumber() {
		return this.absentNumber;
	}
	public void setAbsentTime(Double absentTime) {
		this.absentTime = absentTime;
	}
	
	/**
	 * 返回 旷工小时数
	 * @return
	 */
	public Double getAbsentTime() {
		return this.absentTime;
	}
	public void setAbsentRecord(String absentRecord) {
		this.absentRecord = absentRecord;
	}
	
	/**
	 * 返回 旷工记录
	 * @return
	 */
	public String getAbsentRecord() {
		return this.absentRecord;
	}
	public void setLateNumber(Double lateNumber) {
		this.lateNumber = lateNumber;
	}
	
	/**
	 * 返回 迟到次数
	 * @return
	 */
	public Double getLateNumber() {
		return this.lateNumber;
	}
	public void setLateTime(Double lateTime) {
		this.lateTime = lateTime;
	}
	
	/**
	 * 返回 迟到分钟数
	 * @return
	 */
	public Double getLateTime() {
		return this.lateTime;
	}
	public void setLateRecord(String lateRecord) {
		this.lateRecord = lateRecord;
	}
	
	/**
	 * 返回 迟到记录
	 * @return
	 */
	public String getLateRecord() {
		return this.lateRecord;
	}
	public void setLeaveNumber(Double leaveNumber) {
		this.leaveNumber = leaveNumber;
	}
	
	/**
	 * 返回 早退次数
	 * @return
	 */
	public Double getLeaveNumber() {
		return this.leaveNumber;
	}
	public void setLeaveTime(Double leaveTime) {
		this.leaveTime = leaveTime;
	}
	
	/**
	 * 返回 早退分钟数
	 * @return
	 */
	public Double getLeaveTime() {
		return this.leaveTime;
	}
	public void setLeaveRecord(String leaveRecord) {
		this.leaveRecord = leaveRecord;
	}
	
	/**
	 * 返回 早退记录
	 * @return
	 */
	public String getLeaveRecord() {
		return this.leaveRecord;
	}
	public void setOtNumber(Double otNumber) {
		this.otNumber = otNumber;
	}
	
	/**
	 * 返回 加班次数
	 * @return
	 */
	public Double getOtNumber() {
		return this.otNumber;
	}
	public void setOtTime(Double otTime) {
		this.otTime = otTime;
	}
	
	/**
	 * 返回 加班分钟数
	 * @return
	 */
	public Double getOtTime() {
		return this.otTime;
	}
	public void setOtRecord(String otRecord) {
		this.otRecord = otRecord;
	}
	
	/**
	 * 返回 加班记录
	 * @return
	 */
	public String getOtRecord() {
		return this.otRecord;
	}
	public void setHolidayNumber(Double holidayNumber) {
		this.holidayNumber = holidayNumber;
	}
	
	/**
	 * 返回 请假次数
	 * @return
	 */
	public Double getHolidayNumber() {
		return this.holidayNumber;
	}
	public void setHolidayTime(Double holidayTime) {
		this.holidayTime = holidayTime;
	}
	
	/**
	 * 返回 请假分钟数
	 * @return
	 */
	public Double getHolidayTime() {
		return this.holidayTime;
	}
	public void setHolidayUnit(Short holidayUnit) {
		this.holidayUnit = holidayUnit;
	}
	
	/**
	 * 返回 请假时间单位
	 * @return
	 */
	public Short getHolidayUnit() {
		return this.holidayUnit;
	}
	public void setHolidayRecord(String holidayRecord) {
		this.holidayRecord = holidayRecord;
	}
	
	/**
	 * 返回 请假记录
	 * @return
	 */
	public String getHolidayRecord() {
		return this.holidayRecord;
	}
	public void setTripNumber(Double tripNumber) {
		this.tripNumber = tripNumber;
	}
	
	/**
	 * 返回 出差次数
	 * @return
	 */
	public Double getTripNumber() {
		return this.tripNumber;
	}
	public void setTripTime(Double tripTime) {
		this.tripTime = tripTime;
	}
	
	/**
	 * 返回 出差分钟数
	 * @return
	 */
	public Double getTripTime() {
		return this.tripTime;
	}
	public void setTripRecord(String tripRecord) {
		this.tripRecord = tripRecord;
	}
	
	/**
	 * 返回 出差记录
	 * @return
	 */
	public String getTripRecord() {
		return this.tripRecord;
	}
	public void setValidCardRecord(String validCardRecord) {
		this.validCardRecord = validCardRecord;
	}
	
	/**
	 * 返回 有效打卡记录
	 * @return
	 */
	public String getValidCardRecord() {
		return this.validCardRecord;
	}
	public void setAttenceType(String attenceType) {
		this.attenceType = attenceType;
	}
	
	/**
	 * 返回 考勤类型
	 * @return
	 */
	public String getAttenceType() {
		return this.attenceType;
	}
	public void setShiftId(String shiftId) {
		this.shiftId = shiftId;
	}
	
	/**
	 * 返回 班次
	 * @return
	 */
	public String getShiftId() {
		return this.shiftId;
	}
	public void setAbnormity(Short abnormity) {
		this.abnormity = abnormity;
	}
	
	public String getShiftName() {
		return shiftName;
	}
	public void setShiftName(String shiftName) {
		this.shiftName = shiftName;
	}
	/**
	 * 返回 ABNORMITY
	 * @return
	 */
	public Short getAbnormity() {
		return this.abnormity;
	}
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getOrgId() {
		return orgId;
	}
	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getShiftTime11() {
		return shiftTime11;
	}
	public void setShiftTime11(String shiftTime11) {
		this.shiftTime11 = shiftTime11;
	}
	public String getShiftTime12() {
		return shiftTime12;
	}
	public void setShiftTime12(String shiftTime12) {
		this.shiftTime12 = shiftTime12;
	}
	public String getShiftTime21() {
		return shiftTime21;
	}
	public void setShiftTime21(String shiftTime21) {
		this.shiftTime21 = shiftTime21;
	}
	public String getShiftTime22() {
		return shiftTime22;
	}
	public void setShiftTime22(String shiftTime22) {
		this.shiftTime22 = shiftTime22;
	}
	public String getShiftTime31() {
		return shiftTime31;
	}
	public void setShiftTime31(String shiftTime31) {
		this.shiftTime31 = shiftTime31;
	}
	public String getShiftTime32() {
		return shiftTime32;
	}
	public void setShiftTime32(String shiftTime32) {
		this.shiftTime32 = shiftTime32;
	}
	public String getAbsentRecord11() {
		return absentRecord11;
	}
	public void setAbsentRecord11(String absentRecord11) {
		this.absentRecord11 = absentRecord11;
	}
	public String getAbsentRecord12() {
		return absentRecord12;
	}
	public void setAbsentRecord12(String absentRecord12) {
		this.absentRecord12 = absentRecord12;
	}
	public String getAbsentRecord21() {
		return absentRecord21;
	}
	public void setAbsentRecord21(String absentRecord21) {
		this.absentRecord21 = absentRecord21;
	}
	public String getAbsentRecord22() {
		return absentRecord22;
	}
	public void setAbsentRecord22(String absentRecord22) {
		this.absentRecord22 = absentRecord22;
	}
	public String getAbsentRecord31() {
		return absentRecord31;
	}
	public void setAbsentRecord31(String absentRecord31) {
		this.absentRecord31 = absentRecord31;
	}
	public String getAbsentRecord32() {
		return absentRecord32;
	}
	public void setAbsentRecord32(String absentRecord32) {
		this.absentRecord32 = absentRecord32;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsAttenceCalculate)) {
			return false;
		}
		AtsAttenceCalculate rhs = (AtsAttenceCalculate) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.fileId, rhs.fileId) 
		.append(this.attenceTime, rhs.attenceTime) 
		.append(this.isScheduleShift, rhs.isScheduleShift) 
		.append(this.dateType, rhs.dateType) 
		.append(this.holidayName, rhs.holidayName) 
		.append(this.isCardRecord, rhs.isCardRecord) 
		.append(this.shiftTime, rhs.shiftTime) 
		.append(this.shouldAttenceHours, rhs.shouldAttenceHours) 
		.append(this.actualAttenceHours, rhs.actualAttenceHours) 
		.append(this.cardRecord, rhs.cardRecord) 
		.append(this.absentNumber, rhs.absentNumber) 
		.append(this.absentTime, rhs.absentTime) 
		.append(this.absentRecord, rhs.absentRecord) 
		.append(this.lateNumber, rhs.lateNumber) 
		.append(this.lateTime, rhs.lateTime) 
		.append(this.lateRecord, rhs.lateRecord) 
		.append(this.leaveNumber, rhs.leaveNumber) 
		.append(this.leaveTime, rhs.leaveTime) 
		.append(this.leaveRecord, rhs.leaveRecord) 
		.append(this.otNumber, rhs.otNumber) 
		.append(this.otTime, rhs.otTime) 
		.append(this.otRecord, rhs.otRecord) 
		.append(this.holidayNumber, rhs.holidayNumber) 
		.append(this.holidayTime, rhs.holidayTime) 
		.append(this.holidayUnit, rhs.holidayUnit) 
		.append(this.holidayRecord, rhs.holidayRecord) 
		.append(this.tripNumber, rhs.tripNumber) 
		.append(this.tripTime, rhs.tripTime) 
		.append(this.tripRecord, rhs.tripRecord) 
		.append(this.validCardRecord, rhs.validCardRecord) 
		.append(this.attenceType, rhs.attenceType) 
		.append(this.shiftId, rhs.shiftId) 
		.append(this.abnormity, rhs.abnormity) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.fileId) 
		.append(this.attenceTime) 
		.append(this.isScheduleShift) 
		.append(this.dateType) 
		.append(this.holidayName) 
		.append(this.isCardRecord) 
		.append(this.shiftTime) 
		.append(this.shouldAttenceHours) 
		.append(this.actualAttenceHours) 
		.append(this.cardRecord) 
		.append(this.absentNumber) 
		.append(this.absentTime) 
		.append(this.absentRecord) 
		.append(this.lateNumber) 
		.append(this.lateTime) 
		.append(this.lateRecord) 
		.append(this.leaveNumber) 
		.append(this.leaveTime) 
		.append(this.leaveRecord) 
		.append(this.otNumber) 
		.append(this.otTime) 
		.append(this.otRecord) 
		.append(this.holidayNumber) 
		.append(this.holidayTime) 
		.append(this.holidayUnit) 
		.append(this.holidayRecord) 
		.append(this.tripNumber) 
		.append(this.tripTime) 
		.append(this.tripRecord) 
		.append(this.validCardRecord) 
		.append(this.attenceType) 
		.append(this.shiftId) 
		.append(this.abnormity) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("fileId", this.fileId) 
				.append("attenceTime", this.attenceTime) 
				.append("isScheduleShift", this.isScheduleShift) 
				.append("dateType", this.dateType) 
				.append("holidayName", this.holidayName) 
				.append("isCardRecord", this.isCardRecord) 
				.append("shiftTime", this.shiftTime) 
				.append("shouldAttenceHours", this.shouldAttenceHours) 
				.append("actualAttenceHours", this.actualAttenceHours) 
				.append("cardRecord", this.cardRecord) 
				.append("absentNumber", this.absentNumber) 
				.append("absentTime", this.absentTime) 
				.append("absentRecord", this.absentRecord) 
				.append("lateNumber", this.lateNumber) 
				.append("lateTime", this.lateTime) 
				.append("lateRecord", this.lateRecord) 
				.append("leaveNumber", this.leaveNumber) 
				.append("leaveTime", this.leaveTime) 
				.append("leaveRecord", this.leaveRecord) 
				.append("otNumber", this.otNumber) 
				.append("otTime", this.otTime) 
				.append("otRecord", this.otRecord) 
				.append("holidayNumber", this.holidayNumber) 
				.append("holidayTime", this.holidayTime) 
				.append("holidayUnit", this.holidayUnit) 
				.append("holidayRecord", this.holidayRecord) 
				.append("tripNumber", this.tripNumber) 
				.append("tripTime", this.tripTime) 
				.append("tripRecord", this.tripRecord) 
				.append("validCardRecord", this.validCardRecord) 
				.append("attenceType", this.attenceType) 
				.append("shiftId", this.shiftId) 
				.append("abnormity", this.abnormity) 
												.toString();
	}

	//异常类型的内部状态类
		public static class AbnormityType {
			/**
			 * 正常 0
			 */
			public static Short normal = 0;
			/**
			 * 异常 -1
			 */
			public static Short abnormity = -1;
		}
}



