



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
 * 描述：假期制度明细实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-23 17:08:22
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_holiday_policy_detail")
@TableDefine(title = "假期制度明细")
public class AtsHolidayPolicyDetail extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "假期类型")
	@Column(name = "HOLIDAY_TYPE")
	protected String holidayType; 
	@FieldDefine(title = "假期单位")
	@Column(name = "HOLIDAY_UNIT")
	protected Short holidayUnit; 
	@FieldDefine(title = "启动周期")
	@Column(name = "ENABLE_PERIOD")
	protected Short enablePeriod; 
	@FieldDefine(title = "周期长度")
	@Column(name = "PERIOD_LENGTH")
	protected Double periodLength; 
	@FieldDefine(title = "周期单位")
	@Column(name = "PERIOD_UNIT")
	protected Short periodUnit; 
	@FieldDefine(title = "控制单位额度")
	@Column(name = "ENABLE_MIN_AMT")
	protected Short enableMinAmt; 
	@FieldDefine(title = "单位额度")
	@Column(name = "MIN_AMT")
	protected Double minAmt; 
	@FieldDefine(title = "是否允许补请假")
	@Column(name = "IS_FILL_HOLIDAY")
	protected Short isFillHoliday; 
	@FieldDefine(title = "补请假期限")
	@Column(name = "FILL_HOLIDAY")
	protected Double fillHoliday; 
	@FieldDefine(title = "补请假期限单位")
	@Column(name = "FILL_HOLIDAY_UNIT")
	protected Short fillHolidayUnit; 
	@FieldDefine(title = "是否允许销假")
	@Column(name = "IS_CANCEL_LEAVE")
	protected Short isCancelLeave; 
	@FieldDefine(title = "销假期限")
	@Column(name = "CANCEL_LEAVE")
	protected Double cancelLeave; 
	@FieldDefine(title = "销假期限单位")
	@Column(name = "CANCEL_LEAVE_UNIT")
	protected Short cancelLeaveUnit; 
	@FieldDefine(title = "是否控制假期额度")
	@Column(name = "IS_CTRL_LIMIT")
	protected Short isCtrlLimit; 
	@FieldDefine(title = "假期额度规则")
	@Column(name = "HOLIDAY_RULE")
	protected String holidayRule; 
	@FieldDefine(title = "是否允许超额请假")
	@Column(name = "IS_OVER")
	protected Short isOver; 
	@FieldDefine(title = "超出额度下期扣减")
	@Column(name = "IS_OVER_AUTO_SUB")
	protected Short isOverAutoSub; 
	@FieldDefine(title = "是否允许修改额度")
	@Column(name = "IS_CAN_MODIFY_LIMIT")
	protected Short isCanModifyLimit; 
	@FieldDefine(title = "包括公休日")
	@Column(name = "IS_INCLUDE_REST")
	protected Short isIncludeRest; 
	@FieldDefine(title = "包括法定假日")
	@Column(name = "IS_INCLUDE_LEGAL")
	protected Short isIncludeLegal; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	
	
	@FieldDefine(title = "假期制度")
	@ManyToOne
	@JoinColumn(name = "holiday_id")
	protected  com.redxun.oa.ats.entity.AtsHolidayPolicy atsHolidayPolicy;	
	
	
	public AtsHolidayPolicyDetail() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsHolidayPolicyDetail(String in_id) {
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
	
	public void setHolidayType(String holidayType) {
		this.holidayType = holidayType;
	}
	
	/**
	 * 返回 假期类型
	 * @return
	 */
	public String getHolidayType() {
		return this.holidayType;
	}
	public void setHolidayUnit(Short holidayUnit) {
		this.holidayUnit = holidayUnit;
	}
	
	/**
	 * 返回 假期单位
	 * @return
	 */
	public Short getHolidayUnit() {
		return this.holidayUnit;
	}
	public void setEnablePeriod(Short enablePeriod) {
		this.enablePeriod = enablePeriod;
	}
	
	/**
	 * 返回 启动周期
	 * @return
	 */
	public Short getEnablePeriod() {
		return this.enablePeriod;
	}
	public void setPeriodLength(Double periodLength) {
		this.periodLength = periodLength;
	}
	
	/**
	 * 返回 周期长度
	 * @return
	 */
	public Double getPeriodLength() {
		return this.periodLength;
	}
	public void setPeriodUnit(Short periodUnit) {
		this.periodUnit = periodUnit;
	}
	
	/**
	 * 返回 周期单位
	 * @return
	 */
	public Short getPeriodUnit() {
		return this.periodUnit;
	}
	public void setEnableMinAmt(Short enableMinAmt) {
		this.enableMinAmt = enableMinAmt;
	}
	
	/**
	 * 返回 控制单位额度
	 * @return
	 */
	public Short getEnableMinAmt() {
		return this.enableMinAmt;
	}
	public void setMinAmt(Double minAmt) {
		this.minAmt = minAmt;
	}
	
	/**
	 * 返回 单位额度
	 * @return
	 */
	public Double getMinAmt() {
		return this.minAmt;
	}
	public void setIsFillHoliday(Short isFillHoliday) {
		this.isFillHoliday = isFillHoliday;
	}
	
	/**
	 * 返回 是否允许补请假
	 * @return
	 */
	public Short getIsFillHoliday() {
		return this.isFillHoliday;
	}
	public void setFillHoliday(Double fillHoliday) {
		this.fillHoliday = fillHoliday;
	}
	
	/**
	 * 返回 补请假期限
	 * @return
	 */
	public Double getFillHoliday() {
		return this.fillHoliday;
	}
	public void setFillHolidayUnit(Short fillHolidayUnit) {
		this.fillHolidayUnit = fillHolidayUnit;
	}
	
	/**
	 * 返回 补请假期限单位
	 * @return
	 */
	public Short getFillHolidayUnit() {
		return this.fillHolidayUnit;
	}
	public void setIsCancelLeave(Short isCancelLeave) {
		this.isCancelLeave = isCancelLeave;
	}
	
	/**
	 * 返回 是否允许销假
	 * @return
	 */
	public Short getIsCancelLeave() {
		return this.isCancelLeave;
	}
	public void setCancelLeave(Double cancelLeave) {
		this.cancelLeave = cancelLeave;
	}
	
	/**
	 * 返回 销假期限
	 * @return
	 */
	public Double getCancelLeave() {
		return this.cancelLeave;
	}
	public void setCancelLeaveUnit(Short cancelLeaveUnit) {
		this.cancelLeaveUnit = cancelLeaveUnit;
	}
	
	/**
	 * 返回 销假期限单位
	 * @return
	 */
	public Short getCancelLeaveUnit() {
		return this.cancelLeaveUnit;
	}
	public void setIsCtrlLimit(Short isCtrlLimit) {
		this.isCtrlLimit = isCtrlLimit;
	}
	
	/**
	 * 返回 是否控制假期额度
	 * @return
	 */
	public Short getIsCtrlLimit() {
		return this.isCtrlLimit;
	}
	public void setHolidayRule(String holidayRule) {
		this.holidayRule = holidayRule;
	}
	
	/**
	 * 返回 假期额度规则
	 * @return
	 */
	public String getHolidayRule() {
		return this.holidayRule;
	}
	public void setIsOver(Short isOver) {
		this.isOver = isOver;
	}
	
	/**
	 * 返回 是否允许超额请假
	 * @return
	 */
	public Short getIsOver() {
		return this.isOver;
	}
	public void setIsOverAutoSub(Short isOverAutoSub) {
		this.isOverAutoSub = isOverAutoSub;
	}
	
	/**
	 * 返回 超出额度下期扣减
	 * @return
	 */
	public Short getIsOverAutoSub() {
		return this.isOverAutoSub;
	}
	public void setIsCanModifyLimit(Short isCanModifyLimit) {
		this.isCanModifyLimit = isCanModifyLimit;
	}
	
	/**
	 * 返回 是否允许修改额度
	 * @return
	 */
	public Short getIsCanModifyLimit() {
		return this.isCanModifyLimit;
	}
	public void setIsIncludeRest(Short isIncludeRest) {
		this.isIncludeRest = isIncludeRest;
	}
	
	/**
	 * 返回 包括公休日
	 * @return
	 */
	public Short getIsIncludeRest() {
		return this.isIncludeRest;
	}
	public void setIsIncludeLegal(Short isIncludeLegal) {
		this.isIncludeLegal = isIncludeLegal;
	}
	
	/**
	 * 返回 包括法定假日
	 * @return
	 */
	public Short getIsIncludeLegal() {
		return this.isIncludeLegal;
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
	
	
	
	public com.redxun.oa.ats.entity.AtsHolidayPolicy getAtsHolidayPolicy() {
		return atsHolidayPolicy;
	}

	public void setAtsHolidayPolicy(com.redxun.oa.ats.entity.AtsHolidayPolicy in_atsHolidayPolicy) {
		this.atsHolidayPolicy = in_atsHolidayPolicy;
	}
	
	/**
	 * 外键 
	 * @return String
	 */
	public String getHolidayId() {
		return this.getAtsHolidayPolicy() == null ? null : this.getAtsHolidayPolicy().getId();
	}

	/**
	 * 设置 外键
	 */
	public void setHolidayId(String aValue) {
		if (aValue == null) {
			atsHolidayPolicy = null;
		} else if (atsHolidayPolicy == null) {
			atsHolidayPolicy = new com.redxun.oa.ats.entity.AtsHolidayPolicy(aValue);
		} else {
			atsHolidayPolicy.setId(aValue);
		}
	}
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsHolidayPolicyDetail)) {
			return false;
		}
		AtsHolidayPolicyDetail rhs = (AtsHolidayPolicyDetail) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.holidayType, rhs.holidayType) 
		.append(this.holidayUnit, rhs.holidayUnit) 
		.append(this.enablePeriod, rhs.enablePeriod) 
		.append(this.periodLength, rhs.periodLength) 
		.append(this.periodUnit, rhs.periodUnit) 
		.append(this.enableMinAmt, rhs.enableMinAmt) 
		.append(this.minAmt, rhs.minAmt) 
		.append(this.isFillHoliday, rhs.isFillHoliday) 
		.append(this.fillHoliday, rhs.fillHoliday) 
		.append(this.fillHolidayUnit, rhs.fillHolidayUnit) 
		.append(this.isCancelLeave, rhs.isCancelLeave) 
		.append(this.cancelLeave, rhs.cancelLeave) 
		.append(this.cancelLeaveUnit, rhs.cancelLeaveUnit) 
		.append(this.isCtrlLimit, rhs.isCtrlLimit) 
		.append(this.holidayRule, rhs.holidayRule) 
		.append(this.isOver, rhs.isOver) 
		.append(this.isOverAutoSub, rhs.isOverAutoSub) 
		.append(this.isCanModifyLimit, rhs.isCanModifyLimit) 
		.append(this.isIncludeRest, rhs.isIncludeRest) 
		.append(this.isIncludeLegal, rhs.isIncludeLegal) 
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
		.append(this.holidayType) 
		.append(this.holidayUnit) 
		.append(this.enablePeriod) 
		.append(this.periodLength) 
		.append(this.periodUnit) 
		.append(this.enableMinAmt) 
		.append(this.minAmt) 
		.append(this.isFillHoliday) 
		.append(this.fillHoliday) 
		.append(this.fillHolidayUnit) 
		.append(this.isCancelLeave) 
		.append(this.cancelLeave) 
		.append(this.cancelLeaveUnit) 
		.append(this.isCtrlLimit) 
		.append(this.holidayRule) 
		.append(this.isOver) 
		.append(this.isOverAutoSub) 
		.append(this.isCanModifyLimit) 
		.append(this.isIncludeRest) 
		.append(this.isIncludeLegal) 
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
						.append("holidayType", this.holidayType) 
				.append("holidayUnit", this.holidayUnit) 
				.append("enablePeriod", this.enablePeriod) 
				.append("periodLength", this.periodLength) 
				.append("periodUnit", this.periodUnit) 
				.append("enableMinAmt", this.enableMinAmt) 
				.append("minAmt", this.minAmt) 
				.append("isFillHoliday", this.isFillHoliday) 
				.append("fillHoliday", this.fillHoliday) 
				.append("fillHolidayUnit", this.fillHolidayUnit) 
				.append("isCancelLeave", this.isCancelLeave) 
				.append("cancelLeave", this.cancelLeave) 
				.append("cancelLeaveUnit", this.cancelLeaveUnit) 
				.append("isCtrlLimit", this.isCtrlLimit) 
				.append("holidayRule", this.holidayRule) 
				.append("isOver", this.isOver) 
				.append("isOverAutoSub", this.isOverAutoSub) 
				.append("isCanModifyLimit", this.isCanModifyLimit) 
				.append("isIncludeRest", this.isIncludeRest) 
				.append("isIncludeLegal", this.isIncludeLegal) 
				.append("memo", this.memo) 
												.toString();
	}

}



