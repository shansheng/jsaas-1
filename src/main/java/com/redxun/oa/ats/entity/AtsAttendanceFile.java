



package com.redxun.oa.ats.entity;

import java.io.Serializable;

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

/**
 * <pre>
 *  
 * 描述：考勤档案实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Entity
@Table(name = "ats_attendance_file")
@TableDefine(title = "考勤档案")
public class AtsAttendanceFile extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID")
	protected String id;

	@FieldDefine(title = "用户")
	@Column(name = "USER_ID")
	protected String userId; 
	@FieldDefine(title = "考勤卡号")
	@Column(name = "CARD_NUMBER")
	protected String cardNumber; 
	@FieldDefine(title = "是否参与考勤")
	@Column(name = "IS_ATTENDANCE")
	protected Short isAttendance; 
	@FieldDefine(title = "考勤制度")
	@Column(name = "ATTENCE_POLICY")
	protected String attencePolicy; 
	@FieldDefine(title = "假期制度")
	@Column(name = "HOLIDAY_POLICY")
	protected String holidayPolicy; 
	@FieldDefine(title = "默认班次")
	@Column(name = "DEFAULT_SHIFT")
	protected String defaultShift; 
	@FieldDefine(title = "状态")
	@Column(name = "STATUS")
	protected Short status; 
	
	//考勤制度名称
	protected String attencePolicyName;
	//假期制度名称
	protected String holidayPolicyName;
	//班次名称
	protected String defaultShiftName;
	//所属组织
	protected String orgName;
	//用户姓名
	protected String userName;
	//用户编号
	protected String userNo;
	//登录账号
	protected String loginName;
	
	public AtsAttendanceFile() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public AtsAttendanceFile(String in_id) {
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
	 * 返回 用户
	 * @return
	 */
	public String getUserId() {
		return this.userId;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	
	/**
	 * 返回 考勤卡号
	 * @return
	 */
	public String getCardNumber() {
		return this.cardNumber;
	}
	public void setIsAttendance(Short isAttendance) {
		this.isAttendance = isAttendance;
	}
	
	/**
	 * 返回 是否参与考勤
	 * @return
	 */
	public Short getIsAttendance() {
		return this.isAttendance;
	}
	public void setAttencePolicy(String attencePolicy) {
		this.attencePolicy = attencePolicy;
	}
	
	public void setAttencePolicy(AtsAttencePolicy atsAttencePolicy){
		if(atsAttencePolicy != null){
			setAttencePolicy(atsAttencePolicy.getId());
			setAttencePolicyName(atsAttencePolicy.getName());
		}
	}
	
	/**
	 * 返回 考勤制度
	 * @return
	 */
	public String getAttencePolicy() {
		return this.attencePolicy;
	}
	public void setHolidayPolicy(String holidayPolicy) {
		this.holidayPolicy = holidayPolicy;
	}
	
	public void setHolidayPolicy(AtsHolidayPolicy atsHolidayPolicy){
		if(atsHolidayPolicy != null){
			setHolidayPolicy(atsHolidayPolicy.getId());
			setHolidayPolicyName(atsHolidayPolicy.getName());
		}
	}
	
	/**
	 * 返回 假期制度
	 * @return
	 */
	public String getHolidayPolicy() {
		return this.holidayPolicy;
	}
	public void setDefaultShift(String defaultShift) {
		this.defaultShift = defaultShift;
	}
	
	public void setDefaultShift(AtsShiftInfo atsShiftInfo){
		if(atsShiftInfo != null){
			setDefaultShift(atsShiftInfo.getId());
			setDefaultShiftName(atsShiftInfo.getName());
		}
	}
	
	/**
	 * 返回 默认班次
	 * @return
	 */
	public String getDefaultShift() {
		return this.defaultShift;
	}
	public void setStatus(Short status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public Short getStatus() {
		return this.status;
	}
	
	
	public String getAttencePolicyName() {
		return attencePolicyName;
	}

	public void setAttencePolicyName(String attencePolicyName) {
		this.attencePolicyName = attencePolicyName;
	}

	public String getHolidayPolicyName() {
		return holidayPolicyName;
	}

	public void setHolidayPolicyName(String holidayPolicyName) {
		this.holidayPolicyName = holidayPolicyName;
	}

	public String getDefaultShiftName() {
		return defaultShiftName;
	}

	public void setDefaultShiftName(String defaultShiftName) {
		this.defaultShiftName = defaultShiftName;
	}
	
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof AtsAttendanceFile)) {
			return false;
		}
		AtsAttendanceFile rhs = (AtsAttendanceFile) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.userId, rhs.userId) 
		.append(this.cardNumber, rhs.cardNumber) 
		.append(this.isAttendance, rhs.isAttendance) 
		.append(this.attencePolicy, rhs.attencePolicy) 
		.append(this.holidayPolicy, rhs.holidayPolicy) 
		.append(this.defaultShift, rhs.defaultShift) 
		.append(this.status, rhs.status) 
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
		.append(this.cardNumber) 
		.append(this.isAttendance) 
		.append(this.attencePolicy) 
		.append(this.holidayPolicy) 
		.append(this.defaultShift) 
		.append(this.status) 
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
				.append("cardNumber", this.cardNumber) 
				.append("isAttendance", this.isAttendance) 
				.append("attencePolicy", this.attencePolicy) 
				.append("holidayPolicy", this.holidayPolicy) 
				.append("defaultShift", this.defaultShift) 
				.append("status", this.status) 
												.toString();
	}

}



