



package com.redxun.oa.ats.entity;

import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;

import java.io.Serializable;
import java.util.Date;

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
 * 描述：考勤制度实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_attence_policy")
@TableDefine(title = "考勤制度")
public class AtsAttencePolicy extends BaseTenantEntity {

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
	@FieldDefine(title = "工作日历")
	@Column(name = "WORK_CALENDAR")
	protected Long workCalendar; 
	@FieldDefine(title = "考勤周期")
	@Column(name = "ATTENCE_CYCLE")
	protected String attenceCycle; 
	@FieldDefine(title = "所属组织")
	@Column(name = "ORG_ID")
	protected String orgId; 
	@FieldDefine(title = "是否默认")
	@Column(name = "IS_DEFAULT")
	protected Short isDefault; 
	@FieldDefine(title = "描述")
	@Column(name = "MEMO")
	protected String memo; 
	@FieldDefine(title = "每周工作时数(小时)")
	@Column(name = "WEEK_HOUR")
	protected Double weekHour; 
	@FieldDefine(title = "每天工作时数(小时)")
	@Column(name = "DAYS_HOUR")
	protected Double daysHour; 
	@FieldDefine(title = "月标准工作天数(天)")
	@Column(name = "MONTH_DAY")
	protected Double monthDay; 
	@FieldDefine(title = "每段早退允许值(分钟)")
	@Column(name = "LEAVE_ALLOW")
	protected Integer leaveAllow; 
	@FieldDefine(title = "每段迟到允许值(分钟)")
	@Column(name = "LATE_ALLOW")
	protected Integer lateAllow; 
	@FieldDefine(title = "旷工起始值(分钟)")
	@Column(name = "ABSENT_ALLOW")
	protected Integer absentAllow; 
	@FieldDefine(title = "加班起始值(分钟)")
	@Column(name = "OT_START")
	protected Integer otStart; 
	@FieldDefine(title = "早退起始值(分钟)")
	@Column(name = "LEAVE_START")
	protected Integer leaveStart; 
	@FieldDefine(title = "班前无需加班单")
	@Column(name = "PRE_NOT_BILL")
	protected Short preNotBill; 
	@FieldDefine(title = "班后无需加班单")
	@Column(name = "AFTER_NOT_BILL")
	protected Short afterNotBill;
	@Column(name = "OFF_LATER")
	@FieldDefine(title = "调休开始时间")
	protected Date offLater;
	@Column(name = "OFF_LATER_ALLOW")
	@FieldDefine(title = "调休间隔(分钟)")
	protected Integer offLaterAllow;
	@Column(name = "ON_LATER")
	@FieldDefine(title = "次日上班时间")
	protected Date onLater;
	
	
	//外键名称
	protected String workCalendarName;
	protected String attenceCycleName;
	protected String orgName;
	
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	public String getOrgName() {
		return orgName;
	}
	
	public String getWorkCalendarName() {
		return workCalendarName;
	}

	public void setWorkCalendarName(String workCalendarName) {
		this.workCalendarName = workCalendarName;
	}

	public String getAttenceCycleName() {
		return attenceCycleName;
	}

	public void setAttenceCycleName(String attenceCycleName) {
		this.attenceCycleName = attenceCycleName;
	}

	public AtsAttencePolicy() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsAttencePolicy(String in_id) {
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
	public void setWorkCalendar(Long workCalendar) {
		this.workCalendar = workCalendar;
	}
	
	/**
	 * 返回 工作日历
	 * @return
	 */
	public Long getWorkCalendar() {
		return this.workCalendar;
	}
	public void setAttenceCycle(String attenceCycle) {
		this.attenceCycle = attenceCycle;
	}
	
	/**
	 * 返回 考勤周期
	 * @return
	 */
	public String getAttenceCycle() {
		return this.attenceCycle;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	
	/**
	 * 返回 所属组织
	 * @return
	 */
	public String getOrgId() {
		return this.orgId;
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
	public void setWeekHour(Double weekHour) {
		this.weekHour = weekHour;
	}
	
	/**
	 * 返回 每周工作时数(小时)
	 * @return
	 */
	public Double getWeekHour() {
		return this.weekHour;
	}
	public void setDaysHour(Double daysHour) {
		this.daysHour = daysHour;
	}
	
	/**
	 * 返回 每天工作时数(小时)
	 * @return
	 */
	public Double getDaysHour() {
		return this.daysHour;
	}
	public void setMonthDay(Double monthDay) {
		this.monthDay = monthDay;
	}
	
	/**
	 * 返回 月标准工作天数(天)
	 * @return
	 */
	public Double getMonthDay() {
		return this.monthDay;
	}
	public void setLeaveAllow(Integer leaveAllow) {
		this.leaveAllow = leaveAllow;
	}
	
	/**
	 * 返回 每段早退允许值(分钟)
	 * @return
	 */
	public Integer getLeaveAllow() {
		return this.leaveAllow;
	}
	public void setLateAllow(Integer lateAllow) {
		this.lateAllow = lateAllow;
	}
	
	/**
	 * 返回 每段迟到允许值(分钟)
	 * @return
	 */
	public Integer getLateAllow() {
		return this.lateAllow;
	}
	public void setAbsentAllow(Integer absentAllow) {
		this.absentAllow = absentAllow;
	}
	
	/**
	 * 返回 旷工起始值(分钟)
	 * @return
	 */
	public Integer getAbsentAllow() {
		return this.absentAllow;
	}
	public void setOtStart(Integer otStart) {
		this.otStart = otStart;
	}
	
	/**
	 * 返回 加班起始值(分钟)
	 * @return
	 */
	public Integer getOtStart() {
		return this.otStart;
	}
	public void setLeaveStart(Integer leaveStart) {
		this.leaveStart = leaveStart;
	}
	
	/**
	 * 返回 早退起始值(分钟)
	 * @return
	 */
	public Integer getLeaveStart() {
		return this.leaveStart;
	}
	public void setPreNotBill(Short preNotBill) {
		this.preNotBill = preNotBill;
	}
	
	/**
	 * 返回 班前无需加班单
	 * @return
	 */
	public Short getPreNotBill() {
		return this.preNotBill;
	}
	public void setAfterNotBill(Short afterNotBill) {
		this.afterNotBill = afterNotBill;
	}
	
	/**
	 * 返回 班后无需加班单
	 * @return
	 */
	public Short getAfterNotBill() {
		return this.afterNotBill;
	}
	
	/**
	 * 返回 调休开始时间
	 * @return
	 */
	public Date getOffLater() {
		return offLater;
	}
	public String getOffLaterTime(){
		if(BeanUtil.isNotEmpty(offLater)){
			return DateUtil.formatDate(offLater, "HH:mm");
		}
		return null;
	}

	public void setOffLater(Date offLater) {
		this.offLater = offLater;
	}
	
	/**
	 * 返回 调休时间间隔(分钟)
	 * @return
	 */
	public Integer getOffLaterAllow() {
		return offLaterAllow;
	}

	public void setOffLaterAllow(Integer offLaterAllow) {
		this.offLaterAllow = offLaterAllow;
	}
	
	/**
	 * 次日上班时间
	 * @return
	 */
	public Date getOnLater() {
		return onLater;
	}
	public String getOnLaterTime(){
		if(BeanUtil.isNotEmpty(onLater)){
			return DateUtil.formatDate(onLater, "HH:mm");
		}
		return null;
	}

	public void setOnLater(Date onLater) {
		this.onLater = onLater;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsAttencePolicy)) {
			return false;
		}
		AtsAttencePolicy rhs = (AtsAttencePolicy) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.code, rhs.code) 
		.append(this.name, rhs.name) 
		.append(this.workCalendar, rhs.workCalendar) 
		.append(this.attenceCycle, rhs.attenceCycle) 
		.append(this.orgId, rhs.orgId) 
		.append(this.isDefault, rhs.isDefault) 
		.append(this.memo, rhs.memo) 
		.append(this.weekHour, rhs.weekHour) 
		.append(this.daysHour, rhs.daysHour) 
		.append(this.monthDay, rhs.monthDay) 
		.append(this.leaveAllow, rhs.leaveAllow) 
		.append(this.lateAllow, rhs.lateAllow) 
		.append(this.absentAllow, rhs.absentAllow) 
		.append(this.otStart, rhs.otStart) 
		.append(this.leaveStart, rhs.leaveStart) 
		.append(this.preNotBill, rhs.preNotBill) 
		.append(this.afterNotBill, rhs.afterNotBill) 
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
		.append(this.workCalendar) 
		.append(this.attenceCycle) 
		.append(this.orgId) 
		.append(this.isDefault) 
		.append(this.memo) 
		.append(this.weekHour) 
		.append(this.daysHour) 
		.append(this.monthDay) 
		.append(this.leaveAllow) 
		.append(this.lateAllow) 
		.append(this.absentAllow) 
		.append(this.otStart) 
		.append(this.leaveStart) 
		.append(this.preNotBill) 
		.append(this.afterNotBill) 
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
				.append("workCalendar", this.workCalendar) 
				.append("attenceCycle", this.attenceCycle) 
				.append("orgId", this.orgId) 
				.append("isDefault", this.isDefault) 
				.append("memo", this.memo) 
				.append("weekHour", this.weekHour) 
				.append("daysHour", this.daysHour) 
				.append("monthDay", this.monthDay) 
				.append("leaveAllow", this.leaveAllow) 
				.append("lateAllow", this.lateAllow) 
				.append("absentAllow", this.absentAllow) 
				.append("otStart", this.otStart) 
				.append("leaveStart", this.leaveStart) 
				.append("preNotBill", this.preNotBill) 
				.append("afterNotBill", this.afterNotBill) 
												.toString();
	}

}



